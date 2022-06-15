[CmdletBinding(PositionalBinding=$false)] # allow named parameters only
Param(
	[Parameter(Mandatory=$True)]
	[string]$targetServer
)

# Expected config files
$serverListJson = "$($PSScriptRoot)/config/server_list.json"
$configJson = "$($PSScriptRoot)/config/config.json"

# Import the configs
$serverList = Get-Content -Raw -Path $serverListJson | ConvertFrom-Json
$config = Get-Content -Raw -Path $configJson | ConvertFrom-Json

# Get the relevant values based on the inputs
$targetEnv = $serverList.$targetServer.environment
$targetID = $serverList.$targetServer.id
$targetBastion = $config.environments.$targetEnv.bastion
$targetBastionRg = $config.environments.$targetEnv.bastion_rg
$targetBastionSub = $config.environments.$targetEnv.subscription


if ($targetID) {
    # az cli for heavy lifting
    az login --output none
    az account set --subscription $targetBastionSub

    Write-Output "Attempting connection to $($targetID)"
    az network bastion rdp --name $targetBastion `
    --resource-group $targetBastionRg `
    --target-resource-id $targetID `
    --only-show-errors
    
} else {
    Write-Error "Could not find server $($targetServer) in $($serverListJson)"
}
