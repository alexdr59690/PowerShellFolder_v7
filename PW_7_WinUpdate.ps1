# Nom du programme : Mise à jour Windows via PowerShell 7
# Version du logiciel : 0.2.0
# Dernière modification : 03/05/2023 13:35
# Auteur : ADRUT
##################################################
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