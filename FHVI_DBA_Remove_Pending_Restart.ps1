# Prompt for the server name
$remoteComputer = Read-Host "Enter the remote server name"

# Define the registry path and value to rename
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager"
$registryValue = "PendingFileRenameOperations"

# Connect to the remote server registry
$reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $remoteComputer)

# Check if the registry value exists
if ($reg.GetValue($registryValue) -ne $null) {
    # Rename the registry value
    $reg.RenameValue($registryPath, $registryValue, "PendingFileRenameOperationsBackup")

    Write-Host "Registry value renamed successfully."
} else {
    Write-Host "Registry value does not exist on the remote server."
}

# Close the registry connection
$reg.Close()
