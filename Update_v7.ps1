function Update
{
	$update = Get-WindowsUpdate
	$nbUpdateToDo = $update.count

	if ($nbUpdateToDo -gt 0)
	{ 
		Write-Warning "Update is running..."
		foreach ($items in $update) 
		{
			try 
			{
				Write-Warning "---Start installation ---" 
				Write-Warning ($items | Select-Object -Property KB, Title)
				Install-WindowsUpdate -AcceptAll -install
				Write-Warning ("--- Installation finished : " + ($items | Select-Object -Property KB))    
				Write-Warning ($nbUpdateToDo -eq 1) ? "--- Update is finished ---" : "--- Update are finished ---"
			}
			catch 
			{
				Write-Error $_.Exception.Message
			}
		}
    
		$status = Get-WURebootStatus
			if ($status.RebootRequired -eq 1) 
			{
				Write-Error "Restart in progress"
				shutdown.exe /r /t 60 
			}
			else
			{ 
				Write-Warning "--- Not necessary to restart computer"; 
			}   
	}
	else 
	{ 
		Write-Warning "--- No update ---" 
	}
}