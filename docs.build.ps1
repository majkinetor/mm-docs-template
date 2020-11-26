<# .SYNOPSIS
    Invoke-Build build script
#>
param (
    # Version/tag of the mm-docs image to use
    [string] $aVersion   = (property MM_DOCS_VERSION 'latest'),

    # Registry and name to use to get mm-docs image
    [string] $aImageName = (property MM_DOCS_IMAGE_NAME 'majkinetor/mm-docs'),

    # Port to use when serving on localhost
    [int]    $aPort      = (property MM_DOCS_PORT 8000),

    # Do not pass proxy environment variables to the docker container
    [switch] $aNoProxy
)

Enter-Build {
    Write-Host "If you are behind the proxy use http(s)_proxy environment variables"

    $script:ImageFullName = if (!$aVersion) { $aImageName } else { "${aImageName}:$aVersion" }
    $script:ServeAddress  = "0.0.0.0:$aPort"
    $script:ProjectName   = (Split-Path -Leaf $BuildFile).Replace('.build.ps1','')
    $script:ProjectRoot   = git rev-parse --show-toplevel
    $script:ContainerName = $ProjectName

    $script:DocsDir = 'source/docs/'
    $script:RevisionPathToRemove  = "$DocsDir"
}

task . Build

# Synopsis: Serve documentation site on localhost
task Run Stop, GitRevisionDates, {
    $ContainerName = "$ContainerName-$aPort"
    docker-run mkdocs serve --dev-addr $ServeAddress -Detach -Expose
    Wait-For "http://localhost:$aPort"
}

# Synopsis: Build documentation into static site
task Build GitRevisionDates, {
    $ContainerName = "$ContainerName-build"
    docker-run mkdocs build
}

# Synopsis: Stop docker documentation container that serves documentation
task Stop {
    $docs = docker ps --format '{{json .}}' | ConvertFrom-Json | ? Names -eq "${ContainerName}-$aPort"
    if ($docs) {
        Write-Host "Stopping running container:" $docs.Names
        docker stop $docs.Names
    } else { Write-Host "No documentation container found serving content" }
}

# Synopsis: Clean generated documentation files (not docker images)
task Clean { remove source\site, source\__pycache__ }


# Synopsis: Get the last revision date for all files in the documentation
task GitRevisionDates {
    $mdRevisionPath = "$DocsDir/revision.md"

"# Revisions

**Build Date**: $((get-date -format s).Replace('T',' '))

[View revision.json](../revision.json)

|Date|Path|
|---|---|" | Out-File -Encoding utf8 $mdRevisionPath

    $revisions = Get-GitRevisionDates -Path $DocsDir -Ext '.md'
    $revisions | ConvertTo-Json | Out-File $DocsDir/revision.json
    $revisions.GetEnumerator() | % { "|{0}|{1}" -f $_.Value.Date, $_.Key } | Out-File -Encoding utf8 -Append $mdRevisionPath
    Get-Item $mdRevisionPath
}

function docker-run( [switch] $Interactive, [switch] $Detach, [switch] $Expose) {
    $params = @(
        'run'
        '--rm'
        '-v',    "${pwd}:/docs"
        '--name', $ContainerName
        '--env', 'MM_DOCS_ENABLE_PDF_EXPORT'
        '--env', 'MM_DOCS_URL_PREFIX'

        if ($IsLinux)     { '--user {0}:{1}' -f $(id -u), $(id -g)  }
        if ($Interactive) { '--interactive --tty' }
        if ($Detach)      { '--detach' }
        if ($Expose)      { '-p', "${aPort}:${aPort}" }
        if (!$aNoProxy -and $Env:HTTP_PROXY) { '--env', "http_proxy",'--env', "https_proxy" }

        $ImageFullName
    )

    $cmd = "`ndocker $params $args`n"
    Write-Host $cmd -ForegroundColor yellow
    exec { Invoke-Expression $cmd }
}

# NOTE: This doesn't work correctly with shallow clones:
# https://stackoverflow.com/questions/60868897/git-log-dates-incorrect-in-a-github-action
function Get-GitRevisionDates($Path='.', $Ext)
{
    [array] $gitlog = git --no-pager log --format=format:%ai --name-only $Path

    $res = @{}
    $date = Get-Date
    foreach ($line in $gitlog) {
        if ([DateTime]::TryParse($line, [ref]$date)) { $lastdate = $date; continue }
        if (!$line.StartsWith($RevisionPathToRemove)) { continue }
        if (!$line.Trim().EndsWith($Ext)) { continue }
        $line = $line.Replace($RevisionPathToRemove, '')
        if ($line.StartsWith('files')) { continue }
        $res.$line = @{ Date = $lastdate.ToString('yyyy-MM-dd HH:mm:ss') }
    }
    $res
}

function Wait-For ([string]$url, [int]$Timeout=20) {
    Write-Host "Waiting for server response: $url"
    1..$Timeout | % {
        try { $status = Invoke-WebRequest $url -Method Head -UseBasicParsing | % StatusCode } catch {}
        if ($status -eq 200) {
            Write-Host "Server responded OK !"; break
        }
        elseif ($status -is [int]) {
            Write-Warning "Server responded with invalid status '$status'"; break
        }
        elseif ($_ -eq $Timeout) {
            Write-Warning "Server is NOT responding"; break
        }
        Start-Sleep 1
    }
}
