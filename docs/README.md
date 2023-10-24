# MinIndy
MinIndy is a tool to let you setup a Indy network and expand your network.

It currently provides the following functions:

1. Deploy a Indy network based on this [spec](https://github.com/hyperledger-labs/minifabric/blob/main/spec.yaml) or [your own spec](#Setup-a-network-using-a-different-spec)
2. Tear down the deployed Indy network

The table of the content
========================
1. [Prerequisites](#prerequisites)
2. [Working directory](#working-directory)
3. [Stand up a Indy network](#stand-up-a-fabric-network)
4. [Tear down the Indy network](#tear-down-the-fabric-network)
5. [The normal process of working with Hyperledger Fabric](#the-normal-process-of-working-with-hyperledger-fabric)
6. [Setup a network using a different spec](#setup-a-network-using-a-different-spec)
12. [Add a new organization to your Indy network](#add-a-new-organization-to-your-fabric-network)
19. [Build MinIndy locally](#build-minifabric-locally)


### Prerequisites
This tool requires **docker CE 18.03** or newer, MinIndy supports Linux

### Get the script and make it available system wide
##### Run the following command for Linux or OS X
```
mkdir -p ~/mywork && cd ~/mywork && curl -o minindy -sL https://raw.githubusercontent.com/alanveloso/minindy/main/minindy && chmod +x minindy
```

##### Make minifab available system wide
Move the `minindy` script you just downloaded to a directory which is part of your execution PATH in your system or add the directory containing it to your PATH. This is to make MinIndy executions a bit easier, you will be able to run the `minindy` command anywhere in your system without specify the path to the script. When the term `MinIndy` is used, it refers to the tool, when the term `minindy` is used, it refers to the MinIndy command which is the only command MinIndy has.

### Working directory
A working directory is a directory where all MinIndy commands should run from. It can be any directory in your system, MinIndy will create running scripts, templates, intermediate files in a subdirectory named vars in this working directory. This is the directory that you can always go to to see how MinIndy gets things done. Create a directory with any name you prefer and change to that directory when you start running MinIndy commands. In all MinIndy documentation, we use `~/mywork` as the working directory however, it does not mean you have to use that directory as your working directory. If you use a different directory, simply replace any reference to this directory with your own.

### Stand up a Indy network

Before you start this process, you’ll need to gather a couple of things and make a few decisions. 

As you proceed through these steps, you will be generating data that will be needed later. As you follow the instructions and obtain the following, store them for later use:

- Assign Network Trustees 
  - Initial Trustees (3 preferred) must create and submit a Trustee DID and Verkey so that the domain genesis file can be built.

  - Each trustee has to [instal the `indy-cli`](./CLIInstall.md) and [create a Trustee DID](./CreateDID.md).

  - Once the Trustees have created their DID and Verkey give the Trustees access to a spreadsheet like [this one](https://docs.google.com/spreadsheets/d/1LDduIeZp7pansd9deXeVSqGgdf0VdAHNMc7xYli3QAY/edit#gid=0) and have them fill out their own row of the Trustees sheet.  The completed sheet will be used to generate the genesis transaction files for the network.
- Genesis Stewards 
  -  A Steward is an organization responsible for running a Node on the Network

  - Exactly 4 “Genesis” Stewards are needed to establish the network, more Stewards can be added later.

  - Each Genesis Steward’s node information will be included in the Genesis Pool file, so they should be willing to install and maintain a Node on the new Network for an extended period of time.

  - Once the Stewards have created their DID and Verkey, and performed the initial setup of they node, give the Stewards access to a spreadsheet like [this one](https://docs.google.com/spreadsheets/d/1LDduIeZp7pansd9deXeVSqGgdf0VdAHNMc7xYli3QAY/edit#gid=0) and have them fill out their own row of the Stewards sheet.  The completed sheet will be used to generate the genesis transaction files for the network.   


For the sake of simplicity this walkthrough runs all of the nodes on the local machine.  

To initilize a Indy network, start run the `minifab init` command in your working directory. When the command finishes, for **each validator node**, should have to print in red the info like below 

> [!IMPORTANT]  
> Crucial information, save these.

```bash
    INDY_NETWORK_NAME=sandbox
    INDY_NODE_NAME=validator.org0.example.com
    INDY_NODE_IP=0.0.0.0
    INDY_NODE_PORT=9701
    INDY_CLIENT_IP=0.0.0.0
    INDY_CLIENT_PORT=9702
    INDY_NODE_SEED=[0 characters]
    [...]        No keys found. Running Indy Node Init...
    Node-stack name is validator.org0.example.com
    Client-stack name is validator.org0.example.comC
    Generating keys for random seed b'e0ef9C54B2A35b3d9C1AB92Fe4ED67CE'
    Init local keys for client-stack
    Public key is 14gJe37ZagBdpF5sZVJHahFH8vH2isXH8gHPWcehHH3Z
    Verification key is Anaqdg544sRYCWrWt9FRvuQV4c925TB6PtigPwiWTw1c
    Init local keys for node-stack
    Public key is 14gJe37ZagBdpF5sZVJHahFH8vH2isXH8gHPWcehHH3Z
    Verification key is Anaqdg544sRYCWrWt9FRvuQV4c925TB6PtigPwiWTw1c
    BLS Public key is 4L9Kx2iVxqnky2bsEwcUsKXmSbhoU826CDGFUybtCsesQ95MCxc2taVjt7Wcydt5WhrDrozuTiMYcs7M4JB3vaDsvWjt1F7KPpYrY3HJRWv4VgZVV7KUsUVpA3FTk7Z1qHB923sCJ8FNEaBoAz124FXHTqGi6o93dK41ojups8kAqmY
    Proof of possession for BLS key is Qqbo4EdNe9RjmJ5sGcU5dLz3ZT5CBPiuVsApquUCsRxHPmKb1KzucqM1eXNFA9uaGZYiT6YyU9YnVex7QBdYMZr5ox41C49A7yqMFZHajAji6ENcmyaFFL6W3aSmr7J1e3NZNPHWC675mUy2agwBD25z6U4catAnntoKCBDGomLWMm
    [OK]         Init complete
    [...]        Setting directory owner to indy
    
...
    
```

Once that have created the info of each validator node, they will be used to fill in a spreadsheet like [this one](https://docs.google.com/spreadsheets/d/1LDduIeZp7pansd9deXeVSqGgdf0VdAHNMc7xYli3QAY/edit#gid=0). The completed sheet will be used to generate the genesis transaction files for the network.

Save the sheets filled out by the Trustees and Stewards as separate files in csv format, and use the [genesis_from_files.py](https://github.com/sovrin-foundation/steward-tools/tree/master/create_genesis) script to generate the `pool_transactions_genesis` and `domain_transactions_genesis` files for the network.

   >Tip: The `generategenesisfiles` in `von-network` provides a convenient wrapper around the `genesis_from_files.py` and runs it in a container including all of the dependencies.  For more information refer to [Generate Genesis Files](https://github.com/bcgov/von-network/blob/main/docs/Indy-CLI.md#generate-genesis-files).

Copy `pool_transactions_genesis` and `domain_transactions_genesis` to `~/mywork/vars`. To stand up a Indy network, simply run the `minindy start` command in your working directory. When the command finishes, you should have a Indy network running on your machine.

### Tear down the Fabric network

You can use one of the two commands below to shut down the Fabric network.
```
minifab stop
minifab clean
```
The first command simply removes all the containers which make up the Indy network, it will NOT remove any certificates or ledger data, you can run `minifab start` later to restart the whole thing including chaincode containers if there are any. The second command, in addition to removing all the containers, it cleans the working directory.

### The normal process of working with Hyperledger Fabric

The below list is to show you the normal process of working with Indy.

    1. Create Trustees credentials
    2. Create Stewards credentials
    3. Install [Validator nodes](https://github.com/hyperledger/indy-node/)
    4. Create credentials to the Validator nodes
    5. Genarete the genesis files
    6. Stand up a Indy network
    
If you successfully complete each of the tasks in the list, you basically have verified that your Indy network is working correctly. If you have created Indy networks, you can even use the minindy to join its together.

### Setup a network using a different spec

When you simply do `minindy init`, MinIndy uses the network spec file `spec.yaml` in the working directory to stand up a Indy network. In many cases, you probably want to use different organization names, node names, number of organizations, number of nodes etc, to layout your own Indy network, 

> If you already have a Indy network running on this machine, you will need to remove the running Indy network to avoid any naming conflicts.

When you have your own network spec file, you can further customize your node by utilizing the setting
section of network spec file. 


```
indy:
  validators:
    ...

  netname: ...

```

- **Organization Name** for each node is the part of the domain name after the first dot (.)
- **mspid** for each Organization is the translated Organization Name by substituting every dot (.) with a dash (-)
- host **port** is generated as incremental sequences of starting port number (supplied in -e 1079)
    - The second port(`9702`) of peer will be mapped to host port of [1000 + mapped host port number of its first port(`9701`)]

For example, following is the result for default spec.yaml with `-e 1079`

> validator.org0.example.com --> mspid = org0-example-com, organization name = org0.example.com, hostPort=1079, 2079
> validator.org1.example.com --> mspid = org1-example-com, organization name = org1.example.com, hostPort=1080, 2080
> validator.org2.example.com --> mspid = org2-example-com, organization name = org2.example.com, hostPort=1081, 2081
> validator.org3.example.com --> mspid = org3-example-com, organization name = org3.example.com, hostPort=1082, 2082


In default, **docker network** is automatically generated based on the working directory. This ensures that two different working directories will result in two different docker networks. This allows you to setup multiple sites on the same machine to mimic multiple organizations across multiple machines.
You can assign specific docker network name in spec.yaml file. This allows you to setup fabric capability on the existing docker network easily. If you have multiple sites on same machine, it will be necessary to have different name for each site to avoid network conflict.

```yaml
  netname: "sandbox"
```

You can add options for starting containers by uncomment bellow line in spec.yaml file. you can specify any option which supported by 'docker run' command.
Note that the value specified by container_options will be added when minindy starts all node type containers without distinction.
```yaml
  container_options: "--restart=always --log-opt max-size=10m --log-opt max-file=3"
```

### Add a new node to your Indy network
To add a new organization to your network please follow the below steps:

1. Add `pool_transactions_genesis` and `domain_transactions_genesis` files from a running node to.
2. Initialize keys, aliases and ports on the new node using `minindy init` script. Example: `minindy init -e 1079`.
3.  When the node starts for the first time, it reads the content of genesis `pool_transactions_sandbox` and `domain_transactions_sandbox` files and adds it to the ledger. The Node reads genesis transactions only once during the first start-up, so make sure the genesis files are correct before starting.
4. As Trustee add another Steward if needed (only Steward can add a new Validator Node; a Steward can add one and only one Validator Node).
5. Using Indy CLI, run the following command as Steward:
```
ledger node target=6G9QhQa3HWjRKeRmEvEkLbWWf2t7cw6KLtafzi494G4G client_port=9702 client_ip=10.255.255.255 alias=NewNode node_ip=10.0.0.10.255.255.255 node_port=9701 services=VALIDATOR blskey=zi65fRHZjK2R8wdJfDzeWVgcf9imXUsMSEY64LQ4HyhDMsSn3Br1vhnwXHE7NyGjxVnwx4FGPqxpzY8HrQ2PnrL9tu4uD34rjgPEnFXnsGAp8aF68R4CcfsmUXfuU51hogE7dZCvaF9GPou86EWrTKpW5ow3ifq16Swpn5nKMXHTKj blskey_pop=RaY9xGLbQbrBh8np5gWWQAWisaxd96FtvbxKjyzBj4fUYyPq4pkyCHTYvQzjehmUK5pNfnyhwWqGg1ahPwtWopenuRjAeCbib6sVq68cTBXQfXv5vTDhWs6AmdQBcYVELFpyGba9G6CfqQ5jnkDiaAm2PyBswJxpu6AZTxKADhtSrj
```

- `alias` specifies unique Node name
- `blskey` specifies BLS key from `init_indy_node` script
- `blskey_pop` specifies Proof of possession for BLS key from `init_indy_node` script
- `target` specifies base58 of the node public key ('Verification key' field in output of `init_indy_node`)

**Example:**  
Verification key is `ab78300b3a3eca0a1679e72dd1656075de9638ae79dc6469a3093ce1cc8b424f`  
In order to get base58 of the verkey execute in your shell (you should have `indy-plenum` installed):  
`python3 -c "from plenum.common.test_network_setup import TestNetworkSetup; print(TestNetworkSetup.getNymFromVerkey(str.encode(‘ab78300b3a3eca0a1679e72dd1656075de9638ae79dc6469a3093ce1cc8b424f’)))"`  
**Output:**
> 4Tn3wZMNCvhSTXPcLinQDnHyj56DTLQtL61ki4jo2Loc

6. Do `minindy restart` and verify that node completed catch-up successfully.

### Build MinIndy locally
MinIndy when installed onto your system is really just a short script. After you run at least one minindy command, a docker image named alanveloso/minindy:latest will be automatically pulled down from Docker Hub. Throughout the life cycle of MinIndy, your system should only have this script and the Docker image. To remove MinIndy, you only need to remove the script and the Docker image. If you would like to build the Docker image yourself, please follow the steps below, the process applies to Linux:

```
git clone https://github.com/hyperledger-labs/minifabric.git
cd minindy
docker build -t alanveloso/minifab:latest .
```