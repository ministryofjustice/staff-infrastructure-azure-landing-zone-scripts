# Connect-Bastion

Connect-Bastion is a Powershell script that makes connecting to servers in ALZ via the Bastion service easier. Target servers (the servers that you actually wish to connect to) are stored in a JSON file. Connect-Bastion then makes the connection via the Azure CLI using the details stored in this file. For further ALZ Bastion documentation see the staff-infrastructure-azure-landing-zone repository.


## Pre-requisites
- Windows or Linux
- Powershell (5.1 or greater)
- AzureCLI


## Usage

- Clone this Git repository (Or download as a zip and extract)


- In the cloned/unzipped directory, navigate to the `connect-bastion` folder and populate the `config\server_list.json` file as required with the details of the servers that you wish to connect to using the Bastion service. Some example entries are included in this file that you can replace with your own. Each server entry consists of an ID and an environment.

For example:

```
{
    "vmjump001-dev": {
        "id" : "/subscriptions/c5551d23-f465-4e90-9f4d-ef19eecff6a0/resourceGroups/RG-HUB-MANAGEMENT-001/providers/Microsoft.Compute/virtualMachines/vmjump001",
        "environment" : "dev"
    }
}
```
The ID is the fully qualified resource ID as seen in the Azure Portal. You can find and copy this from the "Properties" blade when viewing a VM in the Azure Portal. The environment refers to the tenant the VM subscription is located in. It should be one of either "dev", "prep" or "prod" as appropriate.
  

- Open a Powershell session and change into the cloned/unzipped directory:

```
PS C:\Users\uwz81o> cd C:\Users\uwz81o\Downloads\staff-infrastructure-azure-landing-zone-scripts\connect-bastion\
```

- Execute the script, passing in the VM names as you defined in `config\server_list.json`

```
PS C:\Users\uwz81o> .\Connect-Bastion.ps1 -targetserver vmjump001-dev
```

- Authenticate with the appropriate account when prompted in your web browser. Bear in mind that this should be the account that matches the environment of the server that you're connecting to. For example, if you're connecting to a server that you've specified as being in the 'dev' environment, you should use your dev account.

- An RDP session will start, from here log in and continue as normal. The Powershell window will continue running the script until you log off or disconnect from the server. If you wish to start additional sessions, you'll need to launch new Powershell windows for each and repeat the steps above.