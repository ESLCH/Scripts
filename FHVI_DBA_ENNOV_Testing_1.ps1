# Install dbatools module si pas encore installé
# Install-Module dbatools

# Importer le module dbatools
Import-Module dbatools

# Spécification du server et de l'instance
$ServerInstance = "SFHVSQLADMIN\SQLADMIN"

# Spécifier le lecteur réseau
$BackupPath = "\\nasdbsqlbackup.adi.adies.lan\SQL_backup_prd$\MIGRATION\ENNOV\"

# Lister les fichiers de sauvegarde
$BackupFiles = Get-ChildItem $BackupPath -Filter "*.bak"

# Faire une boucle et renommer
foreach ($BackupFile in $BackupFiles) {
    $DatabaseName = $BackupFile.BaseName -replace "_CopyOnlyBackup$"

    # Restaurer en écrasant les bases existances si besoin
    Restore-DbaDatabase -SqlInstance $ServerInstance -Path $BackupFile.FullName -DatabaseName $DatabaseName -ReplaceDbNameInFile -WithReplace
}
