# Nom du programme : Mise à jour Windows via PowerShell 7
# Version du logiciel : 0.2.0
# Dernière modification : 03/05/2023 13:35
##################################################

$start = Get-Date
Write-Host [(Get-Date).ToLongTimeString()] "Time start of program" 

$dossier = "C:\users\manipulator\Desktop\Script_PS\PWS_v7"
#importation de la fonction TestConnection
Write-Host [(Get-Date).ToLongTimeString()] "Test internet connection" 
$rstConnection = pwsh -command "& {. $dossier\TestConnection.ps1;TestConnection }"  

#Test de la connection
Write-Host [(Get-Date).ToLongTimeString()]  (($rstConnection -eq "True") ? "Connection succeeded with internet" : "Connection failed - enable to update")

#Si connection réussi - mettre à jour
switch($rstConnection)
{
    $True {
    pwsh -command "& {. $dossier\Update_v7.ps1;Update }"

    }
    $False{
        Write-Host [(Get-Date).ToLongTimeString()]  "Internet connection impossible - update failed"
    }
}
$end = Get-Date
Write-Host [(Get-Date).ToLongTimeString()]  "End time of program"
$total = $end - $start
Write-Warning ("--- " + $total.Hours.ToString()+" h "+$total.Minutes.ToString()+" m "+$total.Seconds.ToString()+" s ")