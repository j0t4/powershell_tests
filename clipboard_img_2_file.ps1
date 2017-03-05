#Add-Type -Assembly PresentationCore
$img = [Windows.Clipboard]::GetImage()
if ($img -eq $null) {
    Write-Host "Imagen no encontrada."
    Exit
}
Write-Host ("Imagen encontrada. {0}x{1} Pixels." -f $img.PixelWidth,$img.PixelHeight)

$fcb = new-object Windows.Media.Imaging.FormatConvertedBitmap($img, [Windows.Media.PixelFormats]::Rgb24, $null, 0)

$encoder = New-Object Windows.Media.Imaging.PngBitmapEncoder
$encoder.Frames.Add([Windows.Media.Imaging.BitmapFrame]::Create($fcb))

#  a través de un archivo en disco.....
#$path = "{0}\Clipboard-{1}.png" -f [System.Environment]::GetFolderPath('MyPictures'),((Get-Date -f s) -replace '[-T:]','')
#$stream = [IO.File]::Open($path, "OpenOrCreate")
#$encoder.Save($stream)
#$stream.Dispose()
#[convert]::ToBase64String((get-content $path -encoding byte))


# a través de memoria : memorystream
$mi_stream=New-Object System.IO.MemoryStream 
$encoder.Save($mi_stream)
$IMG_BASE64 = [convert]::ToBase64String($mi_stream.GetBuffer())
$mi_stream.Dispose()

