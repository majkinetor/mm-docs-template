// Requires: npm i --save puppeteer
// Use print-site-plugin-ignore css class to skip rendering HTML elements in PDF output

const puppeteer = require('puppeteer');
const path = require('path');
var args = process.argv.slice(2);
var url = args[0];
var pdfPath = args[1];
var title = args[2];

console.log('Saving', url, 'to', pdfPath);

// date ...  formatted print date
// title ... document title
// url  ... document location
// pageNumber ... current page number
// totalPages ... total pages in the document
headerHtml = `
<div style="font-size: 10px; padding-right: 1em; text-align: right; width: 100%;">
    <span>${title}</span>  <span class="pageNumber"></span> / <span class="totalPages"></span>
</div>`;

footerHtml = ` `;


(async() => {
    const browser = await puppeteer.launch({
        headless: true,
        executablePath: process.env.CHROME_BIN || null,
        args: ['--no-sandbox', '--headless', '--disable-gpu', '--disable-dev-shm-usage'],
        env: {
            CHROME_CONFIG_HOME: path.resolve(__dirname, 'storage/app/chrome/.config')
        }
    });

    const page = await browser.newPage();
    // await page.setViewport({ width: 794, height: 1122, deviceScaleFactor: 2 });
    await page.goto(url, { waitUntil: 'networkidle2' });
    await page.pdf({
        timeout: 300000,
        path: pdfPath, // path to save pdf file
        format: 'A4', // page format
        displayHeaderFooter: true, // display header and footer (in this example, required!)
        printBackground: true, // print background
        landscape: false, // use horizontal page layout
        headerTemplate: headerHtml, // indicate html template for header
        footerTemplate: footerHtml,
        scale: 1, //Scale amount must be between 0.1 and 2
        margin: { // increase margins (in this example, required!)
            top: 80,
            bottom: 80,
            left: 30,
            right: 30
        }
    });

    await browser.close();
})();