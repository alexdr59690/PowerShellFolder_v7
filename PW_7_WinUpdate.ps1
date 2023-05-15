# Nom du programme : Mise à jour Windows via PowerShell 7
# Version du logiciel : 0.2.0
# Dernière modification : 03/05/2023 13:35
# Auteur : ADRUT
##################################################

$start = Get-Date
Write-Warning ("--- Time start of program : " + $start.ToLongTimeString()) 

$dossier = "C:\users\manipulator\Desktop\Script_PS\PWS_v7"
#importation de la fonction TestConnection
$rstConnection = pwsh -command "& {. $dossier\TestConnection.ps1;TestConnection }"  


#Test de la connection

($rstConnection) ? "Connection succeeded with internet" : "Connection failed - enable to update"

#Si connection réussi - mettre à jour
switch($rstConnection)
{
    $True {
    pwsh -command "& {. $dossier\Update_v7.ps1;Update }"

    }
    $False{
        Write-Error "Internet connection impossible - update failed"
    }
}
$end = Get-Date
Write-Warning ("--- End time of program: " + $end.ToLongTimeString())
$total = $end - $start
Write-Warning ("--- " + $total.Hours.ToString()+" h "+$total.Minutes.ToString()+" m "+$total.Seconds.ToString()+" s ")