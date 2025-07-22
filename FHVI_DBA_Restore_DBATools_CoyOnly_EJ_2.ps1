# Define the shared backup path and the SQL Server instance
$sharedBackupPath = "\\nasdbsqlbackup.adi.adies.lan\SQL_backup_prd$\SERVICE_REQUESTS\S0108354\"  # Replace with your actual shared path
$serverInstance = "SDEVSQLSIG\SIGHR"        # Replace with your SQL Server instance name

# Import the dbatools module
Import-Module dbatools

# Get a list of backup files in the shared path
$backupFiles = Get-DbaBackupInformation -Path $sharedBackupPath

# Loop through the backup files and restore them to the SQL Server
foreach ($backupFile in $backupFiles) {
    $databaseName = $backupFile.Database
    $backupFileFullPath = $backupFile.FullName

    # Construct the restore command
    $restoreCommand = @{
        SqlInstance = $serverInstance
        Path = $backupFileFullPath
        Database = $databaseName
        WithReplace = $true
    }

    # Perform the restore operation
    Restore-DbaDatabase @restoreCommand

    Write-Host "Restored database $databaseName from $backupFileFullPath"
}
