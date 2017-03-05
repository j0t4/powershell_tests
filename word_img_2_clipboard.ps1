$Word = New-Object -ComObject Word.Application
$Document=$Word.documents.open("c:\tmp\worddoc.docx")

$paras = $Document.Paragraphs
write-host $paras.count

foreach ($para in $paras) 
{ 
     Write-Host ("-"+$para.Range.Text+"-")
     if ($para.Range.inlineshapes.count -gt 0){
          write-host  $para.Range.InlineShapes[1].Width
         $para.Range.InlineShapes[1].Width = 600
         #$para.Range.InlineShapes[1].ScaleHeight =100

         $para.Range.InlineShapes[1].Range.Copy()
     }
}

$document.close()
$word.quit()