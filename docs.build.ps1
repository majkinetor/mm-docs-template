<# .SYNOPSIS 
    Invoke-Build build script
#>
param (
    # Version of mm-docs image to use, by default 'latest'
    [string] $aVersion  = (property MM_DOCS_VERSION 'latest'),

    # Registry and path to use to get mm-docs image, by default majkinetor from Docker Hub
    [string] $aRegistry = (property MM_DOCS_REGISTRY_PATH 'majkinetor'),

    # Port to use when serving on localhost, by default 8000
    [int]    $aPort     = (property MM_DOCS_PORT 8000),

    # Do not pass proxy environment variables to the docker container
    [switch] $aNoProxy
)

Enter-Build { 
    Write-Host "If you are behind the proxy use http(s)_proxy environment variables"
    $script:ImageName     = "$aRegistry/mm-docs"
    $script:ImageFullName = if (!$aVersion) { $ImageName } else { "${ImageName}:$aVersion" }
    $script:ServeAddress  = "0.0.0.0:$aPort" 
    $script:ProjectName   = (Split-Path -Leaf $BuildFile).Replace('.build.ps1','')
    $script:ProjectRoot   = git rev-parse --show-toplevel
    $script:ContainerName = $ProjectName
}

task . Build

# Synopsis: Serve documentation site on localhost
task Serve Stop, {
    $ContainerName = "$ContainerName-$aPort"
    docker-run mkdocs serve --dev-addr $ServeAddress -Detach -Expose 

    $url = "http://localhost:$aPort"

    $retryLimit = 20
    Write-Host "Waiting for development server to start (timeout: $retryLimit): $url "
    1..$retryLimit | % { 
        try { $status = Invoke-WebRequest $url -Method Head -UseBasicParsing | % StatusCode } catch {}
        if ($status -eq 200) { 
            Write-Host "Serving from container now!"; break
        }
        elseif ($status -is [int]) {
            Write-Warning "Server responded with invalid status '$status'"; break
        }
        elseif ($_ -eq $retryLimit) { 
            Write-Warning "Server is not responding, it either failed or needs more then 10 seconds to start"; break
        }
        sleep 1
    }   
}

# Synopsis: Build documentation into static site
task Build { 
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
    $dir = 'source/docs'
    $out = "$dir/revision.md"

"# Revisions
    
**Build Date**: $((get-date -format s).Replace('T',' '))

|Date|Path|Comment|
|---|---|---|" | Out-File -Encoding utf8 $out

    Get-GitRevisionDates -Path 'source/docs' -Ext '.md' -Skip '*.templates/*', '*/revision.md' | % {        
        $fileSitePath = $_.File.Replace("$ProjectName/$dir/", "").Replace('.md','').Replace('index','')
        $title = $fileSitePath.Replace('/', ' --> ')
        if ($_.File.EndsWith('index.md')) {$title += 'index'}
        
        $comment = if (!(Test-Path (Join-Path $ProjectRoot $_.File))) { "(re)moved" }

        "| {0} | [{1}](../{2}) |{3}|" -f $_.Date, $title, $fileSitePath, $comment
    } | Out-File -Encoding utf8 -Append $out

    Get-Content $out    
}

function docker-run( [switch] $Interactive, [switch] $Detach, [switch] $Expose) {
    $params = @(
        'run'
        '--rm'
        '-v', "${pwd}:/docs"
        '--name', $ContainerName

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

function Get-GitRevisionDates($Path='.', $Ext, $Skip)
{
    [array] $log = git --no-pager log --format=format:%ai --name-only $Path
    
    $date_re = "^\d{4}-\d\d-\d\d \d\d:\d\d:\d\d .\d{4}$"
    [array] $dates = $log | Select-String $date_re | select LineNumber, Line

    $files = $log -notmatch "^$date_re$" | ? {
        if (!$_.EndsWith($Ext)) { return }
        foreach ($s in $Skip) { if ($_ -like $s) { return } }
        $_
    } | sort -unique

    $res = @()
    foreach ($file in $files) {
        $iFile = $log.IndexOf($file) + 1
        $fDate = $dates | ? LineNumber -lt $iFile | select -Last 1
        $res += [PSCustomObject]@{ File = $file; Date = $fDate.Line }
    }

    $res | sort Date -Desc
}
