ForEach ($Instance in $InstanceList){
     Out-Log -Message "Patching instance $($Instance.InstanceName)" -LogFile $LogFile
        
    $connection = Test-DBAConnection -SqlInstance $instance.InstanceName -WarningVariable warningvar;
    Add-Warning -Warning $Warningvar;
    If ($connection -and $connection.ConnectSuccess) {
        Out-Log -Message "Connection to instance $($Instance.InstanceName) succeeded" -LogFile $LogFile

        #Update the instance build which is used by the cmdlet Update-DbaInstance
        Out-Log -Message "Update the build of the instance $($Instance.InstanceName)" -LogFile $LogFile
        Get-DbaBuildReference -SqlInstance $instance.InstanceName -Update -WarningVariable warningvar;
        Add-Warning -Warning $Warningvar;

        Out-Log -Message "Start patching of the instance $Instance.InstanceName" -LogFile $LogFile
        try {
            $res = Update-DbaInstance -ComputerName $Instance.ComputerName -InstanceName $Instance.InstanceName -credential $OScred -Version CU16 -Path \\Thor90\sources\SQL2019 -Restart -Confirm:$false -WarningVariable warningvar;
            Add-Warning -Warning $Warningvar;
        }
        catch {
            Add-Error -Message "Patching of the instance $instance$Instance.InstanceName not possible, Exception: $($error[0].Exception.Message)";
        }

    }
    Else {
        Add-Error -Message "Impossible to connect to the instance $instance$Instance.InstanceName.";
    }
}