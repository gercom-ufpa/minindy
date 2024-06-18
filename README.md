# MinIndy: Ferramenta Automatizada para Construção de Redes Blockchain Hyperledger Indy

A plataforma Hyperledger Indy, focada em redes de gestão de identidade baseadas em blockchain, vem ganhando destaque, porém a implementação de uma rede completa em ambiente de produção é desafiadora e requer habilidades especializadas. Com o intuito de simplificar esse processo, este artigo apresenta o MinIndy, uma ferramenta desenvolvido para automatizar a instalação, configuração e administração de redes Indy. Portanto, o MinIndy surge como uma solução viável para indivíduos e organizações que desejam adotar redes blockchain Indy com menos intervenção manual e maior eficiência.

## Pré-requisitos

* [Docker](https://www.docker.com/) versão >= 18.03.

## Instalação

> [!IMPORTANT]
> Você precisará de pelo menos 4 GB de RAM e 5 GB de armazenamento em disco restantes disponíveis para executar o MinIndy na máquina local.

No Linux (Ubuntu, Fedora, CentOS): 
```
mkdir -p ~/mywork && cd ~/mywork && curl -o minindy -sL https://raw.githubusercontent.com/alanveloso/minindy/main/minindy && chmod +x minindy
```

> [!TIP]
> Para disponibilizar o minindy em todo o sistema: `sudo mv minindy /usr/local/bin`

## Começando

Este tutorial instaciará uma rede Hyperledger Indy mínima para funcionamento em 3 Trustees, 4 Stewards e 4 Validators (1 para cada Stewards). 

> [!CAUTION]
> Usaremos de chave criptográficas padrão para os Trustees e Stewards, mas é obriatório que cada Trustees e Stewards gerem suas próprias chaves e as mantenham seguras.

Dentrao do diretório de trabalho `~/mywork`, o comando a seguir inicializará os validoradores da rede Hyperledger Indy, mas sem executa-los ainda.

```
minindy init -e 1079
```

Faça um cópia e preencha a [planilha](https://docs.google.com/spreadsheets/d/1K7y4GAIWTqpMy-4VnXnpwfwruPuI0d5gh_fiBZj__tE/edit?usp=sharing) com o **endereço IP** do computador em todas as linhas das colunas **Node IP address** e **Client IP address**.

> [!IMPORTANT]
> Não é necessário preencher as informações que já estão preennchidas, essas são informações cripográficas padrão utilizadas apenas para demontração.

Com o resutado do comando anterior, para as linhas dos respectivos validadores, preencha as linhas as colunas **Validator verkey**, **Validator BLS key** e **Validator BLS POP** com as informações **Verification key**, **BLS Public key** e **Proof of possession for BLS key**. Um fragmento da saída do comando anterior é apresentado abaixo, representando as informações do `validator.org0.example.com`. 

> [!IMPORTANT]
> Para preencher a tabela, deve-se copiar as informações de chave de cada um dos validadores: `validator.org0.example.com`, `validator.org1.example.com`, `validator.org2.example.com` e `validator.org3.example.com`.

```
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
Generating keys for random seed [Omitido]
Init local keys for client-stack
Public key is [Omitido]
Verification key is [Omitido]
Init local keys for node-stack
Public key is [Omitido]
Verification key is [Omitido]
BLS Public key is
[Omitido]
Proof of possession for BLS key is [Omitido]
[OK]         Init complete
[...]        Setting directory owner to indy
```

Como as informações da planilha já preenchidas, serão gerados os arquivos gênesis necessários para iniciar a rede. Para isso, siga com o seguinte comando, que instalará a ferramenta que gerará os arquivos.

```
cd ~ && git clone https://github.com/bcgov/von-network.git && cd von-network/ && ./manage build
```

Salve as planilhas no diretório `~/von-network/tmp` as abas **trustees** e **stewards** da planilha anteior em CSV com os seguintes nomes **trustees.csv** e **stewards.csv**, respectivamente. Execute o comando a seguir no diretório `~/von-network`.

```
./manage generategenesisfiles trustees.csv stewards.csv && mv tmp/*_genesis ~/mywork/vars/ && cd ~/mywork && minindy start
```

A rede já está em funcionamento e pode ser conferida utilizando o comando `docker ps`. Também é possível usar uma interface web para visualizar a rede em funcionamento, basta executar os seguintes comandos.

```
cd ~
git clone https://github.com/hyperledger/indy-node-container.git && cd indy-node-container/test/ && mkdir -p lib_indy/sandbox
cp ~/mywork/vars/*_genesis lib_indy/sandbox/
INDY_NETWORK_NAME=sandbox docker-compose up webserver
```

A interface web estará diponível em [http://localhost:9000/](http://localhost:9000/). A interface web será similar a abaixo.

![MinIndy - Interface Web](./docs/images/minindy-web-interface.png "Interface web do MinIndy")