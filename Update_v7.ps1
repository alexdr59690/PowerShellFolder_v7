function Update
{
	Write-Host [(Get-Date).ToLongTimeString()] "Reasearch update"
	
	$update = Get-WindowsUpdate
	$nbUpdateToDo = $update.count

	Write-Host [(Get-Date).ToLongTimeString()] "Number of update found : " $nbUpdateToDo
	if ($nbUpdateToDo -gt 0)
	{ 
		Write-Host [(Get-Date).ToLongTimeString()] "Update is running"
		foreach ($items in $update) 
		{
			Write-Host [(Get-Date).ToLongTimeString()] "Start time"
			try 
			{
				Write-Host [(Get-Date).ToLongTimeString()] "Start installation" 
				Write-Host [(Get-Date).ToLongTimeString()] ($items | Select-Object -Property KB, Title)
				Install-WindowsUpdate -AcceptAll -install
				Write-Host [(Get-Date).ToLongTimeString()] ("Installation finished : " + ($items | Select-Object -Property KB))    
				Write-Host [(Get-Date).ToLongTimeString()] (($nbUpdateToDo -eq 1) ? "Update is finished" : "Update are finished")
			}
			catch 
			{
				Write-Error $_.Exception.Message
			}
			Write-Host [(Get-Date).ToLongTimeString()] "End time"
		}
    
		$status = Get-WURebootStatus
			if ($status.RebootRequired -eq 1) 
			{
				Write-Error "Restart in progress"
				shutdown.exe /r /t 60 
			}
			else
			{ 
				Write-Host [(Get-Date).ToLongTimeString()] "Not necessary to restart computer"; 
			}   
	}
	else 
	{ 
		Write-Host [(Get-Date).ToLongTimeString()] "No update" 
		Write-Host [(Get-Date).ToLongTimeString()] "End time "
	}
}