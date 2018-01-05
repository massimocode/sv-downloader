# SV Downloader
## What is it?
A pair of scripts for downloading and tagging albums from a well known media website, which I've abbreviated to SV.

## What do I need?
A web browser (tested with Google Chrome) and PowerShell

## How do I use it?
1. Clone/download this repository to a folder somewhere on your computer.
1. Using your browser, view the album you want to download. The URL will look something like `http://[sv-website-url].com/cat-7284`.
1. Open your developer tools so you can see the JavaScript console.
1. Copy and paste the code from `scraper.js` into your browser's JavaScript console and run it.
1. You should see the output `undefined`. The album's metadata will have been copied to your clipboard.
1. Open the `albums.json` file and paste the album metadata as an item in the empty array. Continue to do this for other albums if you want.
1. Open a PowerShell window and navigate to the the root of this repository.
1. Run the script `download.ps1`. You may need to trust the script. You can google how to do this.
1. Watch as the script downloads all the media files and tags them appropriately for you. You can customise the tagging process by editing the `download.ps1` file if you like.
1. Sometimes the requests to download files will time-out or fail. The script will continue attempting to download the remaining files. You can simply re-run the script once it's done and it will re-do the files that it could not download, skipping the successful ones. If a download fails halfway through (internet connection cuts off or you cancel the download mid-way), then you'll need to delete the partially downloaded file and re-run the script.
1. Move the albums to wherever you want them.

## How does it work?
`scraper.js` is a javascript file containing a piece of code that will scrape an Album's metadata from the album page when viewed in your browser. It uses document.querySelector and document.querySelectorAll to scrape the relevant data from the DOM, and the copy() and JSON.stringify() functions to copy a JSON representation to your clipboard.

`albums.json` is a file to contain the metadata of the albums you want to download.

`download.ps1` reads the `albums.json` file to find the metadata for the albums you want to download. It creates a folder for each album. It downloads the tracks for each album by making a  POST request with a hardcoded body, needed to look like a genuine click. It then tags each track appropriately using [taglib-sharp](https://github.com/mono/taglib-sharp) so that smart phones, MP3 players, etc will display the relevant information and group the files as expected. I've included a copy of taglib-sharp for convenience, but if you don't trust it you can download your own copy from Nuget or even build it from source.