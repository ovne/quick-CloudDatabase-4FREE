## Instanciar um SGDB PostgreSQL na GCP gratuitamente.

O objetivo é disponibilizarar um servidor de banco de dados PostgreSQL pronto para uso na GCP (Google Cloud Platform) gratuitamente e em poucos passos.

Para isso utilizo basicamente Terraform, para automatizar a configuração dos recursos cloud, e um shell script para instalar o Docker na vm e por fim subir um container PostgreSQL.  

A utilzação dos recursos GCP sem custos só é possivel dentro das limitações impostas pelo [plano gratuito](https://cloud.google.com/free/docs/gcp-free-tier#always-free) da GCP. Na prática, significava que essa (pequena) infraestrutura não é adequada para qualquer uso em produção, porém, é perfeita para POCs e experimentos, backend de aplicações simples, pipelines de dados, etc.

Contudo, os scripts disponibilizados podem ser facilmente alterados para criar uma infraestrutura mais robusta e adequada para qualquer outro fim, ou ainda, utilizar outro SGDB, como MySQL, por exemplo.

## Prerequisitos

- Conta na GCP ativa com permissão de gerador de token de acesso.
- Conta de serviço com permissão de editor de recursos GCP.
- Projeto GCP com essas contas vinculadas.
> Nota: Nesse script utilizo o método de autenticação por representação de conta de serviço por ser uma boa prática de segurança que gosto de utilizar. Mas claro que voce pode só usar sua conta pessoal com privilégios, autenticação por chave de acesso ou qualquer outro meio que preferir, a alteração é simples.
- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) instalado na máquina local.
- [goocle-cloud-sdk](https://cloud.google.com/sdk/docs/install?hl=pt-br) instalado na máquina local.

## Configuração

Assumindo que já tenha o terraform e o google-cloud-sdk devidamente instalados na maquina dev e um projeto GCP definido, o resto da configuração é tão simples quanto colocar o **project-id** e a **impersonatio-service-account-email** (ou chave de acesso) no arquivo `variables.tf`

```bash 
    variable "GCP_Project_Params" {
    description = "a map of commomly used project params"
    type        = map(string)
    default = {
        "project_id"                = "<project-id>"
        "project_region"            = "us-central1"
        "project_zone"              = "us-central1-a"
        "impersonation_service_acc" = "<impersonatio-service-account-email>"
    }
}
````
Todo o resto já esta configurado para funcionar de acordo com o objetivo inicial.
## Uso
