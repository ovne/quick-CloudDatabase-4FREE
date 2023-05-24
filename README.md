## Instanciar um SGDB PostgreSQL na GCP gratuitamente.
---
O objetivo é disponibilizarar um servidor com uma instancia PostgreSQL pronta para uso na GCP (Google Cloud Platform) gratuitamente e em poucos passos. Para isso utilizo basicamente Terraform, para automatizar a configuração dos recursos cloud, e um shell script para instalar Docker na vm e por fim subir um container PostgreSQL.  

A utilzação dos recursos GCP sem custos só é possivel devido as limitações impostas pelo plano gratuito da GCP (link abaixo). Na prática, significava que essa (pequena) infraestrutura não é adequada para qualquer uso em produção, porém, é perfeita para POCs e experimentos, backend de aplicações simples, pipelines de dados, etc.

Contudo, os scripts disponibilizados podem ser facilmente alterados para criar uma infraestrutura mais robusta e adequada para qualquer outro fim, ou ainda, utilizar outro SGDB, como MySQL, por exemplo.

## Prerequisitos
---
- Conta na GCP ativa com permissão de gerador de token de acesso.
- Conta de serviço com permissão de editor de recursos GCP.
> Nota: Nesse script utilizo o método de autenticação por representação de conta de serviço por ser uma boa prática de segurança que gosto de utilizar. Mas claro que voce pode só usar sua conta pessoal com privilégios, autenticação por chave de acesso ou qualquer outro meio que preferir, a alteração é simples.
- Terraform instalado na máquina local.
- goocle-cloud-sdk instalado na máquina local.

## Configuração
---


## Uso
---