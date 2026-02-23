
if (Test-Path ".\allure-report\history") {
    Copy-Item -Recurse -Force ".\allure-report\history\*" ".\allure-results\history\"
}


$historyPath = ".\allure-results\history"

if (Test-Path $historyPath) {
    Get-ChildItem $historyPath -Filter "*-trend.json" | ForEach-Object {
        $json = Get-Content $_.FullName | ConvertFrom-Json
        if ($json.Count -gt 5) {
            $json | Select-Object -Last 5 | ConvertTo-Json -Depth 10 | Set-Content $_.FullName
        }
    }
    Write-Host "Trend history trimmed to last 5 runs."
}


allure generate allure-results --clean -o allure-report

allure open allure-report