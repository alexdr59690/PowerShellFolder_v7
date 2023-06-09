function Update
{
	Write-Warning "--- Reasearch update...."
	Write-Warning ("--- Start time " + (Get-Date).ToLongTimeString())
	$update = Get-WindowsUpdate
	$nbUpdateToDo = $update.count

	Write-Warning ("Number of update found : " + $nbUpdateToDo)
	if ($nbUpdateToDo -gt 0)
	{ 
		Write-Warning "Update is running..."
		foreach ($items in $update) 
		{
			Write-Warning ("--- Start time " + (Get-Date).ToLongTimeString())
			try 
			{
				Write-Warning "---Start installation ---" 
				Write-Warning ($items | Select-Object -Property KB, Title)
				Install-WindowsUpdate -AcceptAll -install
				Write-Warning ("--- Installation finished : " + ($items | Select-Object -Property KB))    
				Write-Warning (($nbUpdateToDo -eq 1) ? "--- Update is finished ---" : "--- Update are finished ---")
			}
			catch 
			{
				Write-Error $_.Exception.Message
			}
			Write-Warning ("--- End time " + (Get-Date).ToLongTimeString())
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
		Write-Warning ("--- End time " + (Get-Date).ToLongTimeString())
	}
}