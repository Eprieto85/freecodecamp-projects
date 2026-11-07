# Descarga las imagenes de animales colombianos para la galeria
$baseDir = "G:\Mi unidad\10 - CURSOS EPG\freeCodeCamp-projects\08-photo-gallery"
New-Item -ItemType Directory -Force -Path "$baseDir\images" | Out-Null

$headers = @{
    "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
    "Referer"    = "https://en.wikipedia.org/"
}

# Usando archivos originales (sin /thumb/) — evita la restriccion de tamanos de Wikimedia
$images = [ordered]@{
    "condor.jpg"    = "https://upload.wikimedia.org/wikipedia/commons/9/9e/Vultur_gryphus_%28Vaxholm%29.jpg"
    "jaguar.jpg"    = "https://upload.wikimedia.org/wikipedia/commons/0/0a/Standing_jaguar.jpg"
    "oso.jpg"       = "https://upload.wikimedia.org/wikipedia/commons/8/8c/Spectacled_bear.jpg"
    "titi.jpg"      = "https://upload.wikimedia.org/wikipedia/commons/7/70/Saguinus_oedipus_1.jpg"
    "delfin.jpg"    = "https://upload.wikimedia.org/wikipedia/commons/f/fe/Boutu_edit1.jpg"
    "morpho.jpg"    = "https://upload.wikimedia.org/wikipedia/commons/5/5d/Morpho_didius_Male_Dos_Pilas.jpg"
    "guacamaya.jpg" = "https://upload.wikimedia.org/wikipedia/commons/f/f4/Ara_macao.jpg"
    "colibri.jpg"   = "https://upload.wikimedia.org/wikipedia/commons/1/15/White-necked_Jacobin_%28Florisuga_mellivora%29_male_RWD2.jpg"
    "rana.jpg"      = "https://upload.wikimedia.org/wikipedia/commons/f/f4/Atelopus_varius_2.jpg"
}

foreach ($name in $images.Keys) {
    $url   = $images[$name]
    $path  = "$baseDir\images\$name"
    try {
        Invoke-WebRequest -Uri $url -OutFile $path -Headers $headers -TimeoutSec 30
        $size = (Get-Item $path).Length
        Write-Host "OK  $name  ($size bytes)"
    } catch {
        Write-Host "ERR $name  $_"
    }
}

Write-Host ""
Write-Host "Listo. Ahora ejecuta en PowerShell:"
Write-Host "  cd '$baseDir'"
Write-Host "  cd .."
Write-Host "  git add 08-photo-gallery/images/"
Write-Host "  git commit -m 'Add local animal images'"
Write-Host "  git push origin main"
