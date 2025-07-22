# Define the query to retrieve data and log file sizes
$query = @"
DECLARE @TotalDataSizeGB FLOAT;
DECLARE @TotalLogSizeGB FLOAT;

-- Calculate the total size of data files
SELECT @TotalDataSizeGB = SUM(size * 8.0 / (1024 * 1024))
FROM sys.sysfiles;

-- Calculate the total size of log files
SELECT @TotalLogSizeGB = SUM(size * 8.0 / (1024 * 1024))
FROM sys.sysfiles
WHERE status & 0x40 = 0x40;

-- Return the total sizes in gigabytes
SELECT 'Total Data File Size: ' + CAST(@TotalDataSizeGB AS VARCHAR(20)) + ' GB' AS DataFileSize,
       'Total Log File Size: ' + CAST(@TotalLogSizeGB AS VARCHAR(20)) + ' GB' AS LogFileSize;
"@

# Get the list of registered instances in CMS
$cmsInstances = Get-DbaRegisteredServer -SqlInstance SQUASQL61\SAMPLE2017 

# Loop through each registered instance and execute the query
foreach ($instance in $cmsInstances) {
    $instanceName = $instance.Name

    Write-Host "Instance: $instanceName"
    Write-Host "--------------------------------------"

    # Execute the query against the instance
    $results = Invoke-DbaQuery -SqlInstance $instanceName -Query $query

    # Output the results
    $results | Format-Table -AutoSize
    Write-Host
}
