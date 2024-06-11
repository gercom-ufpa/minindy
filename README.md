# MinIndy: Automated Tool for Building Blockchain Networks Hyperledger Indy

The Hyperledger Indy blockchain platform, targeted towards identity management networks, has garnered significance; however, setting up a comprehensive production network is intricate and demands expertise. In order to mitigate this complexity, the present study introduces MinIndy, a framework crafted to streamline the installation, configuration, and administration of Indy networks while maintaining optimal performance. Thus, MinIndy emerges as a feasible option for individuals and entities seeking to embrace Indy blockchain networks with reduced manual intervention.

## Prerequisites
[docker](https://www.docker.com/) (18.03 or newer) environment

5 GB remaining Disk Storage available

##### If you are using Linux (Ubuntu, Fedora, CentOS), or OS X
```
mkdir -p ~/mywork && cd ~/mywork && curl -o minindy -sL https://raw.githubusercontent.com/alanveloso/minindy/main/minindy && chmod +x minindy
```

##### Make minindy available system wide

Move the minindy script to a directory which is part of your execution PATH in your system or add the directory containing it to your PATH. This is to make the later operations a bit easier, you will be able to run the minindy command anywhere in your system without specifying the path to the minindy script.