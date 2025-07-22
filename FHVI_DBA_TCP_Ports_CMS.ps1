# Import the dbatools module
##Import-Module dbatools SQUASQL61

# Define the CMS name
$cmsName = SQUASQL61\SAMPLE2017

# Get the list of registered instances from the CMS
$registeredInstances = Get-DbaRegisteredServer -SqlInstance SQUASQL61\SAMPLE2017 -Group PROD 

# Loop through each registered instance and retrieve the TCP port information
foreach ($instance in $registeredInstances) {
    $instanceName = $instance.Name
    $tcpPort = (Get-DbaTcpPort -SqlInstance $instanceName).Port

    Write-Host "Instance Name: $instanceName"
    Write-Host "TCP Port: $tcpPort"
    Write-Host
}
