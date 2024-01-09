Super Mario é um jogo clássico amado por muitos. Neste guia, exploraremos como implantar um jogo Super Mario no Elastic Kubernetes Service (EKS) da Amazon. Utilizando o Kubernetes, podemos orquestrar a implantação do jogo no AWS EKS, permitindo escalabilidade, confiabilidade e fácil gerenciamento.
![mario](https://github.com/thadeuguimaraes/mario-game-eks/assets/52017205/1af3d16a-5944-4db4-8c17-b85d32f91ab3)

## Pré-requisitos:


1. Uma instância EC2 Ubuntu 
 
2. IAM Role (Access Control)
 
3. O Terraform deve ser instalado na instância 
 
4. AWS CLI e KUBECTL na instância 
 
5. Docker
   
**STEP 1: Inicie a instância do Ubuntu**

1. Faça login no Console AWS: Faça login no Console de gerenciamento AWS.
2. Navegue até o Painel EC2: Vá para o Painel EC2 selecionando “Serviços” no menu superior e escolhendo “EC2” na seção Computação.
3. Iniciar Instância: Clique no botão “Iniciar Instância” para iniciar o processo de criação da instância.
4. Escolha uma imagem de máquina da Amazon (AMI): selecione uma AMI apropriada para sua instância. Por exemplo, você pode escolher a imagem do Ubuntu.
5. Configurar detalhes da instância:
6. Para "Número de instâncias", defina-o como 1 (a menos que você precise de várias instâncias).
7. Defina configurações adicionais como rede, sub-redes, função IAM, etc., se necessário.
8. Para “Armazenamento”, clique em “Adicionar novo volume” e defina o tamanho para 12 GB.
9.Clique em “Avançar: Adicionar tags” quando terminar.
10. Adicionar tags (opcional): adicione as tags desejadas à sua instância. - Esta etapa é opcional, mas auxilia na organização das instâncias.
11. Configurar grupo de segurança:
    - Escolha um grupo de segurança existente ou crie um novo.
    - Certifique-se de que o grupo de segurança tenha as regras de entrada/saída necessárias para permitir o acesso conforme necessário.
12. Revise e inicie: revise os detalhes da configuração. Certifique-se de que tudo esteja configurado conforme desejado.
13. Selecione par de chaves:
    - Selecione "Escolher um par de chaves existente" e escolha o par de chaves no menu suspenso.
    - Reconheça que você tem acesso ao arquivo de chave privada selecionado.
 11.  Acesse a instância EC2: Depois que a instância for iniciada, você poderá acessá-la usando o par de chaves e o IP ou DNS público da instância.
    
Certifique-se de ter as permissões necessárias e seguir as práticas recomendadas ao configurar grupos de segurança e pares de chaves para manter a segurança de sua instância do EC2.

- Pesquise IAM na barra de pesquisa da AWS e clique em funções.
- Clique em Create Role.
- Selecione o tipo de entidade como serviço AWS
- Use o case como EC2 e clique em Next.
- Para política de permissão, selecione Administrator Access  (apenas para fins de aprendizagem), clique em Next
- Forneça um nome para a função e clique em Create Role.
- Verifique se a Role foi criada.

Agora anexe esta função à instância Ec2 que criamos anteriormente, para que possamos provisionar o cluster dessa instância.

Vá para o painel EC2 e selecione a instância.

- Click on Actions --> Security --> Modify IAM role.
- Selecione a função criada anteriormente e clique em Update IAM role.
- Conecte a instância ao Mobaxtreme ou Putty

**STEP 3: Criando Cluster EKS**

Agora clone este repositório dentro da instância do EC2.
```sh
git clone https://github.com/thadeuguimaraes/mario-game-eks.git
```
Mude o diretório:
```sh
cd mario-game-eks
```
Forneça a permissão executável para o arquivo script.sh e execute-o.
```sh
sh script.sh
```
Este script instalará o Terraform, AWS cli, Kubectl, Docker.

Verfique as versões:
```sh
docker --version
aws --version
kubectl version --client
terraform --version
```
Agora mude o diretório para terraform

Inicie o Terraform init
NOTA: Não se esqueça de alterar o nome do bucket s3 no arquivo backend.tf
```sh
cd terraform
terraform init
```
Agora execute terraform validate e terraform plan
```sh
terraform validate
terraform plan
```
Agora execute terraform apply para provisionar cluster.
```sh
terraform apply --auto-approve
```
Atualize a configuração do Kubernetes

Certifique-se de alterar a região desejada.
```sh
aws eks update-kubeconfig --name <> --region <>
```
Agora mude o diretório de volta para k8s.
```sh
cd ..
```
```sh
cd k8s
```
Vamos aplicar a implantação e o serviço.

Deployment
```sh
kubectl apply -f deployment.yaml
```
Para checar o deployment.
```sh
kubectl get all
```
Agora vamos descrever o serviço e copiar o LoadBalancer Ingress.
```sh
kubectl describe service mario-service
```
Cole o link de entrada em um navegador e você verá o jogo Mario.

Vamos voltar a 1985 e jogar como crianças S2 =).

Deletando os rescursos:
```sh
kubectl get all
kubectl delete service mario-service
kubectl delete deployment mario-deployment
```
Vamos destruir o cluster:
```sh
terraform destroy --auto-approve
```
