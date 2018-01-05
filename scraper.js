copy(JSON.stringify({
    Name: document.querySelectorAll('.linkstd > font')[2].innerText.substr(6),
    Artist: document.querySelectorAll('.linkstd a')[1].innerText,
    Tracks: Array.from(document.querySelectorAll('.tdsong a')).map((element, i) => ({
        Name: element.innerText,
        TrackNumber: i + 1,
        DownloadLink: element.href.replace("play", "save")
    }))
}, null, 4))