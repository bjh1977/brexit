
$FilePath = join-path $psscriptroot 'petition.csv'

if (-not (Test-Path $FilePath)) {
    Set-Content -Path $FilePath -Value 'Date, Count'
    $Count = 0
}
else {
    $Count = (Get-Content $FilePath -Tail 2)[0] -split ','
}


while ($true) {
    $LineValue = $null
    $Count = (Invoke-WebRequest 'https://petition.parliament.uk/petitions/241584/count.json').Content | ConvertFrom-Json |Select-Object -ExpandProperty signature_count

    $LineValue = "$((Get-Date).ToString() ),$Count"

    $LineValue 

    Add-Content -Path $FilePath -Value $LineValue 

    git add .
    git commit  -m "Updated stats"
    git push

    Start-Sleep -Seconds 10

}









