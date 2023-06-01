## Instanciar um SGBD PostgreSQL na GCP gratuitamente.

O objetivo é disponibilizarar um servidor de banco de dados PostgreSQL pronto para uso na GCP (Google Cloud Platform) gratuitamente e em poucos passos.

Para isso utilizo basicamente Terraform, para automatizar a configuração dos recursos cloud, um shell script para instalar o Docker na vm e por fim subir um container PostgreSQL.  

A utilzação dos recursos GCP sem custos só é possivel dentro das limitações impostas pelo [plano gratuito](https://cloud.google.com/free/docs/gcp-free-tier#always-free) da GCP. Na prática, significava que essa (pequena) infraestrutura não é adequada para qualquer uso em produção, porém, é perfeita para POCs e experimentos, backend de aplicações simples, pipelines de engenharia de dados, etc.

Contudo, os scripts disponibilizados podem ser facilmente alterados ou integrados para criar uma infraestrutura mais robusta e adequada para qualquer outro fim. Ou ainda, apenas para configurar outro SGBD como MySQL, por exemplo.

## Prerequisitos

- Conta na GCP ativa com permissão de gerador de token de acesso.
- Conta de serviço com permissão de editor de recursos GCP.
- Projeto GCP com essas contas vinculadas.
- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) instalado na máquina local.
- [goocle-cloud-sdk](https://cloud.google.com/sdk/docs/install?hl=pt-br) instalado na máquina local.

> NOTA: Nesse script utilizo o método de autenticação por representação de conta de serviço por ser uma boa prática de segurança que gosto de usar. Mas claro que voce pode só usar sua conta pessoal com privilégios, autenticação por chaves de acesso em um .json ou qualquer outro meio que preferir, a alteração é simples.

## Configuração

Assumindo que já tenha o terraform e o google-cloud-sdk devidamente instalados na maquina dev e um projeto GCP definido, o resto da configuração é tão simples quanto colocar o **project-id** e a **impersonation-service-account-email** (ou chave de acesso) no arquivo `variables.tf`

```bash 
    variable "GCP_Project_Params" {
    description = "a map of commomly used project params"
    type        = map(string)
    default = {
        "project_id"                = "<project-id>"
        "project_region"            = "us-central1"
        "project_zone"              = "us-central1-a"
        "impersonation_service_acc" = "<impersonation-service-account-email>"
    }
}
````
Todo o resto já esta configurado para funcionar de acordo com o objetivo inicial.
## Uso

Para utilizar os scripts e provisionar os recursos basta executar os seguintes comandos em um terminal e dentro pasta terraform do projeto:

```bash
    terraform init
    terraform plan
    terraform apply
```

Caso nao tenha nenhuma experiencia com o fluxo de operação do terraform ou "o que cada comando esta fazendo", recomendo fortemente a leitura da documentação oficial que é bem simples e direta. Contudo, resumidamente, esses comandos vão: criar uma vm GCE, instalar o docker e iniciar um container com postgresql rodando na porta 5432. 

**Acesso:** Para acessar o banco de dados você vai precisar do `ip externo` da vm (endereço do server) que pode ser obtido de várias formas, a mais simples e direta é no console GCP, na tela do compute engine, na lista de instancias de vm. 
E claro, vai precisar também da senha postgres definida no script de inicialização. 

> NOTA: Lembre-se que você pode alterar a senha genérica `admin` definida no script de inicialização antes ou depois de provisionar os recursos.

Com isso em mãos, basta utilizar qualquer cliente de banco de dados para se conectar ao servidor. Gosto do [DBeaver](https://dbeaver.io/) por ser multiplataforma, mas claro que você pode usar qualquer outro como o próprio pgAdmin, ou biblotecas python como psycopg2, pandas + sqlalchemy, etc.

## Proximos passos
- extrair o ip externo da vm com o terraform e disponibilizar como output.
- criar um segundo script para subir um docker compose com postgresql + pgadmin.

> Este é um projeto pessoal em que automatizo uma tarefa relativamente simples mas bastante comum, em particular, para engenharia de dados/backend/dataops. Se você tem alguma sugestão ou quer melhorar, fique a vontade para abrir uma issue ou um pull request. Se foi tão útil para você quanto é para mim, deixe uma estrela. Obrigado!