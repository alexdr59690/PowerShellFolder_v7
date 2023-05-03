function TestConnection
{
    $TestConnection = Test-NetConnection -TraceRoute www.google.fr
    return $TestConnection.PingSucceeded
}