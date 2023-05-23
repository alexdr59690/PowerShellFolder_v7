function TestConnection
{
    $TestConnection = Test-NetConnection -Hops 2 -TraceRoute www.google.fr
    return $TestConnection.PingSucceeded
}
