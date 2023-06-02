function Update
{
	Write-Host [(Get-Date).ToLongTimeString()] "Reasearch update"
	
	$update = Get-WindowsUpdate
	$nbUpdateToDo = $update.count

	Write-Host [(Get-Date).ToLongTimeString()] "Number of update found : " $nbUpdateToDo
	if ($nbUpdateToDo -gt 0)
	{ 
		foreach ($items in $update) 
		{
			try 
			{
				Write-Host [(Get-Date).ToLongTimeString()] "Start installation" 
				Write-Host [(Get-Date).ToLongTimeString()] ($items | Select-Object -Property Title)
				$install = Install-WindowsUpdate -AcceptAll -install -KB $items.KB
				if($install[2].result -eq "Installed")
				{
				Write-Host [(Get-Date).ToLongTimeString()] ("Installation finished : " + ($items | Select-Object -Property KB)) 
				
				$status = Get-WURebootStatus
				if ($status.RebootRequired -eq 1) 
				{
					Write-Error "Restart in progress"
					shutdown.exe /r /t 60 
					return
				}
				else
				{ 
					Write-Host [(Get-Date).ToLongTimeString()] " Not necessary to restart computer"; 
				}   

				
				
				}
				else
				{
					Write-Host [(Get-Date).ToLongTimeString()] ("Installation failed : " + ($items | Select-Object -Property KB))    
				}
			}
			catch 
			{
				Write-Error $_.Exception.Message
			}
			Write-Host [(Get-Date).ToLongTimeString()] "End time"
		}
		
		write-host [(Get-Date).ToLongTimeString()] (($nbUpdateToDo -eq 1) ? "Update is finished" : "Update are finished")
		
	}
	else 
	{ 
		Write-Host [(Get-Date).ToLongTimeString()] "No update" 
		Write-Host [(Get-Date).ToLongTimeString()] "End time "
	}
}