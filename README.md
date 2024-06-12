# MinIndy: Automated Tool for Building Blockchain Networks Hyperledger Indy

The Hyperledger Indy blockchain platform, targeted towards identity management networks, has garnered significance; however, setting up a comprehensive production network is intricate and demands expertise. In order to mitigate this complexity, the present study introduces MinIndy, a framework crafted to streamline the installation, configuration, and administration of Indy networks while maintaining optimal performance. Thus, MinIndy emerges as a feasible option for individuals and entities seeking to embrace Indy blockchain networks with reduced manual intervention.

## Prerequisites

* [Docker](https://www.docker.com/) version >= 18.03.

## Installing

> [!IMPORTANT]
> You will need at least 4GB RAM and 5GB remaining Disk Storage available to run MinIndy on local machine.

In Linux (Ubuntu, Fedora, CentOS): 
```
mkdir -p ~/mywork && cd ~/mywork && curl -o minindy -sL https://raw.githubusercontent.com/alanveloso/minindy/main/minindy && chmod +x minindy
```

> [!TIP]
> To make minindy available system wide: `sudo mv minindy /usr/local/bin`

## Getting started

Este tutorial instaciará uma rede Hyperledger Indy mínima para funcionamento em 3 Trustees, 4 Stewards e 4 Validators (1 para cada Stewards). 

> [!CAUTION]
> Usaremos de chave criptográficas padrão para os Trustees e Stewards, mas é obriatório que cada Trustees e Stewards gerem suas próprias chaves e as mantem seguras.

```
minindy init -e 1079
```

Faça um cópia e preencha a [planilha](https://docs.google.com/spreadsheets/d/1K7y4GAIWTqpMy-4VnXnpwfwruPuI0d5gh_fiBZj__tE/edit?usp=sharing) com o **endereço IP** do computador todas as linhas das colunas **Node IP address** e **Client IP address**. Com o resutado do comando anterior, para as linhas dos respectivos validadores, preencha as linhas as colunas **Validator verkey**, **Validator BLS key** e **Validator BLS POP** com as informações **Verification key**, **BLS Public key** e **Proof of possession for BLS key**.

```
cd ~ && git clone https://github.com/bcgov/von-network.git && cd von-network/ && ./manage build
```

Salve no diretório `~/von-network/tmp` as abas **trustees** e **stewards** da planilha anteior em CSV com os seguintes nomes **trustees.csv** e **stewards.csv**, respectivamente.

```
./manage generategenesisfiles trustees.csv stewards.csv && mv tmp/*_genesis ~/mywork/vars/ && cd ~/mywork && minindy start
```

A rede já está em funcionamento e pode ser conferida utilizando o comando `docker ps`. Também é possível usar uma interface web para visualizar a rede em funcionamento, basta executar os seguintes comandos.

```
cd ~
git clone https://github.com/hyperledger/indy-node-container.git && cd indy-node-container/test/ && mkdir -p lib_indy/sandbox
cp ~/mywork/vars/*_genesis lib_indy/sandbox/
INDY_NETWORK_NAME=sandbox docker compose up webserver
```

A interface web estará diponível em [http://localhost:9000/](http://localhost:9000/). A interface web será similar a abaixo.

![MinIndy - Interface Web](./docs/images/minindy-web-interface.png "Interface web do MinIndy")