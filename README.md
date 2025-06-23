# data-science-academy

Este projeto foi criado para fins de estudos e compartilhamento de portifolio.

## Introducao
Este guia vai servir de referencia para criacao e execucao do projeto de banco de dados + Power BI, fazendo uso de docker para simulacao do banco de dados em postgres.

## Sobre o(s) projeto(s)

Inicialmente esta sendo compartilhado o projeto de nome: `Vendas`


## Estrutura de arquivos

```bash
.
├── README.md                # Importante!
└── dsa-vendas
    └── scripts
        └── migrations
           └── functions        
           └── inserts        
           └── tables
```

# Preparando o Ambiente de Trabalho

Postgres Docker localmente [referencia](https://www.docker.com/blog/how-to-use-the-postgres-docker-official-image/)
```
$ docker run --name dsadw -p 5439:5432 -e POSTGRES_USER=dsa -e POSTGRES_PASSWORD=dsa1010 -e POSTGRES_DB=dsadb -d postgres:16.1
```

# Instale o pgAdmin

Obs: Quando acessar o pgAdmin pela primeira vez crie uma senha master, por exemplo: dsa1010

criacao do schema de banco de dados
```
$ CREATE SCHEMA dw AUTHORIZATION dsa;
```

Executar os arquivos:
```
* tables
* inserts
* functions
```

# Na pasta outputs encontram-se os exemplos dos dashaboards gerados atraves do Power Bi



