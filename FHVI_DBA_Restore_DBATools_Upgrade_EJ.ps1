# Install dbatools module si pas encore installé
# Install-Module dbatools

# Importer le module dbatools
Import-Module dbatools

# Définition de l'instance
$sqlInstance = "SFHVSQLADMIN\SQLADMIN"

# Lister les bases en excluant la base de maintenance
$databases = Get-DbaDatabase -SqlInstance $sqlInstance | Where-Object { $_.Name -ne 'DbaTools' }

# Boucle et exécution de commande
foreach ($database in $databases) {
    # Configuration du owner
    Set-DbaDbOwner -SqlInstance $sqlInstance -Database $database.Name -Owner "new_owner"

    # Configuration du compatibility level
    Set-DbaDbCompatibility -SqlInstance $sqlInstance -Database $database.Name -CompatibilityLevel 150
}