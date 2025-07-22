# Define the SQL Server instance name and paths
$InstanceName = "MSSQLSERVER"  # Change this to your instance name if not the default instance
$SqlBinPath = "C:\Program Files\Microsoft SQL Server\MSSQL16.SQLADMIN\MSSQL"

# Define the flags to be added
$FlagsToAdd = "174;7745;3226;7752"

# Get the current startup parameters
$CurrentStartupParams = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL.$InstanceName\MSSQLServer\Parameters")."SQLArg0"

# Combine existing parameters with new flags
$NewStartupParams = "-s$InstanceName -dMASTER -mSQLCMD -T$FlagsToAdd"  # Adjust if necessary

# Set the updated startup parameters
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL.$InstanceName\MSSQLServer\Parameters" -Name "SQLArg0" -Value $NewStartupParams

# Restart the SQL Server service
Restart-Service "MSSQL`$$InstanceName"

Write-Host "SQL Server startup parameters have been updated and the service has been restarted."
