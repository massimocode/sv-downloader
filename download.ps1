[Reflection.Assembly]::LoadFrom((Resolve-Path "./taglib-sharp.dll"))

(ConvertFrom-Json (Get-Content -Raw -Encoding UTF8 "./albums.json")) | ForEach-Object {
    $Album = $_

    if (-not (Test-Path $Album.Name)) {
        Write-Output "Creating folder $($Album.Name)"
        mkdir $Album.Name
    }

    $_.Tracks | ForEach-Object {
        $Track = $_
    
        $PathToMp3 = "$($Album.Name)/$($Track.Name).mp3"
        if (-not (Test-Path $PathToMp3)) {
            Write-Output "Downloading $($Track.Name) to $PathToMp3"
            Invoke-WebRequest -Uri $Track.DownloadLink -Method POST -Body @{ submit = "+%CA%CD%E3%ED%E1+" } -OutFile $PathToMp3
        }

        $mediaFile = [TagLib.File]::Create((Resolve-Path $PathToMp3))
        $mediaFile.Tag.Album = $Album.Name
        $mediaFile.Tag.Year = $null
        $mediaFile.Tag.Genres = $null
        $mediaFile.Tag.Title = $Track.Name
        $mediaFile.Tag.Track = $Track.TrackNumber
        $mediaFile.Tag.AlbumArtists = $Album.Artist
        $mediaFile.Tag.Performers = @( $Album.Artist )
        $mediaFile.Save()
    }
}