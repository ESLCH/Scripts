Function Out-Log() {
param(
[ValidateSet('INFO','WARNING','ERROR')]
[String] $Type = 'INFO',
[String] $Message
)

If ($LogTo -match 'Table') {
# To replace single quote in the message
$oldstr = [char]39; # single quote
$newstr = [char]34; # double quote
$Message = $Message -replace $oldstr, $newstr;

$query = "insert into log.LogInventaire values ('" + $Type + "','" + (Get-Date -f 'yyyy-MM-dd HH:mm:ss') + "','" + $Message + "')";
Invoke-DbaQuery -SqlInstance $DestinationInstance -Database $DBDestination -Query $query;
}
Else {
'['+(Get-Date -f 'yyyy-MM-dd HH:mm:ss') +'] ' + ' - [' + $Type + '] - ' + $Message | Out-File -FilePath $LogFile -Append;
}
}

Function Add-Warning() {
param(
[String] $Warning
)
If ($Warning) {
Out-Log -Type WARNING -Message $Warning;
}
}

Function Add-Error() {
param(
[String] $Message
)
Out-Log -Type ERROR -Message $Message;
}