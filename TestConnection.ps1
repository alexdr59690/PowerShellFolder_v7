function TestConnection
{
    Write-Host [(Get-Date).ToLongTimeString()]
    $TestConnection = Test-NetConnection -TraceRoute www.google.fr
    Write-Host [(Get-Date).ToLongTimeString()]
    return $TestConnection.PingSucceeded
}
