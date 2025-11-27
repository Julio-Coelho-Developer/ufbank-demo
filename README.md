# 🏦 UFBank - Multi-Cloud Infrastructure Demo

![UFBank Logo](https://img.shields.io/badge/UFBank-Multi--Cloud-6366f1?style=for-the-badge)
![IaC](https://img.shields.io/badge/IaC-Terraform-7B42BC?style=for-the-badge&logo=terraform)
![CI/CD](https://img.shields.io/badge/CI%2FCD-GitHub%20Actions-2088FF?style=for-the-badge&logo=github-actions)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)

## 📋 Sobre o Projeto

Demonstração prática de **Infraestrutura como Código (IaC)** e **CI/CD** em ambientes multi-cloud aplicado ao UFBank - um banco digital fictício criado para fins acadêmicos.

### 👥 Equipe

- **Marcos Pimentel**
- **Deivid Garcia Schitine**
- **Júlio César**

---

## 🎯 Objetivos da Demo

✅ Demonstrar provisionamento automático de infraestrutura com Terraform  
✅ Implementar pipeline CI/CD completo com GitHub Actions  
✅ Aplicar estratégias de deploy Blue-Green  
✅ Containerizar aplicações com Docker  
✅ Orquestrar múltiplos serviços com Docker Compose  
✅ Monitorar infraestrutura em tempo real  

---

## 🏗️ Arquitetura

```
┌─────────────────────────────────────────────────────────────┐
│                      UFBank Architecture                     │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐                  │
│  │   AWS    │  │  Azure   │  │   GCP    │  ← Multi-Cloud   │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘                  │
│       │             │             │                          │
│       └─────────────┴─────────────┘                          │
│                     │                                         │
│              ┌──────┴──────┐                                 │
│              │  Terraform  │  ← Infrastructure as Code       │
│              └──────┬──────┘                                 │
│                     │                                         │
│       ┌─────────────┴─────────────┐                         │
│       │                           │                          │
│  ┌────┴────┐              ┌──────┴──────┐                  │
│  │  Blue   │◄────────────►│   Green     │  ← Blue-Green    │
│  │ Version │              │  Version    │     Deployment    │
│  └────┬────┘              └──────┬──────┘                  │
│       │                           │                          │
│       └───────────┬───────────────┘                         │
│                   │                                          │
│            ┌──────┴──────┐                                  │
│            │Load Balancer│  ← Nginx                         │
│            └──────┬──────┘                                  │
│                   │                                          │
│         ┌─────────┴─────────┐                               │
│         │   Monitoring      │  ← Prometheus + Grafana       │
│         └───────────────────┘                               │
└─────────────────────────────────────────────────────────────┘
```

---

## 🚀 Quick Start

### Pré-requisitos

- Docker Desktop instalado
- Git
- (Opcional) Terraform CLI
- (Opcional) Conta AWS/Azure/GCP

### Opção 1: Demo Rápida com Docker Compose (RECOMENDADO)

```bash
# 1. Clone o repositório
git clone https://github.com/seu-usuario/ufbank-demo.git
cd ufbank-demo

# 2. Inicie todos os serviços
docker-compose up -d

# 3. Aguarde os containers iniciarem (30 segundos)
docker-compose ps

# 4. Acesse as aplicações
```

**URLs de Acesso:**
- 🌐 **Aplicação Blue:** http://localhost:3000
- 🌐 **Aplicação Green:** http://localhost:3001
- ⚖️ **Load Balancer:** http://localhost:8080
- 📊 **Prometheus:** http://localhost:9090
- 📈 **Grafana:** http://localhost:3002 (admin/admin)

### Opção 2: Deploy com Terraform

```bash
# 1. Entre no diretório terraform
cd terraform

# 2. Inicialize o Terraform
terraform init

# 3. Valide a configuração
terraform validate

# 4. Visualize o plano de execução
terraform plan

# 5. Aplique a infraestrutura
terraform apply -auto-approve

# 6. Veja os outputs
terraform output
```

---

## 🎬 Demonstração na Apresentação

### Roteiro de Apresentação (10-15 minutos)

#### **Parte 1: Introdução (2 min)**
1. Mostrar slides conceituais
2. Explicar objetivo da demo

#### **Parte 2: Demo Ao Vivo (8 min)**

**Passo 1: Mostrar a Aplicação**
```bash
# Abrir navegador em http://localhost:8080
# Mostrar interface do UFBank
# Explicar funcionalidades
```

**Passo 2: Demonstrar Blue-Green Deployment**
```bash
# Simular deploy clicando no botão "Simular Deploy"
# Explicar o processo de deploy sem downtime
```

**Passo 3: Mostrar Infraestrutura como Código**
```bash
# Abrir VSCode
code terraform/main.tf
# Explicar recursos definidos
```

**Passo 4: Demonstrar CI/CD**
```bash
# Mostrar arquivo .github/workflows/deploy.yml
# Explicar etapas do pipeline
# Se possível, fazer um commit e mostrar pipeline executando
```

**Passo 5: Monitoramento**
```bash
# Abrir Prometheus: http://localhost:9090
# Abrir Grafana: http://localhost:3002
# Mostrar métricas em tempo real
```

#### **Parte 3: Perguntas (5 min)**

---

## 📁 Estrutura do Projeto

```
ufbank-demo/
├── app/                          # Aplicação Web
│   ├── index.html               # Frontend
│   ├── style.css                # Estilos
│   ├── script.js                # JavaScript
│   └── Dockerfile               # Container da aplicação
├── terraform/                    # Infrastructure as Code
│   ├── main.tf                  # Recursos principais
│   ├── variables.tf             # Variáveis
│   ├── outputs.tf               # Outputs
│   └── nginx.conf.tpl           # Template Nginx
├── .github/
│   └── workflows/
│       └── deploy.yml           # Pipeline CI/CD
├── docker-compose.yml           # Orquestração local
├── nginx-lb.conf               # Config Load Balancer
├── prometheus.yml              # Config Monitoramento
└── README.md                   # Esta documentação
```

---

## 🔧 Comandos Úteis

### Docker

```bash
# Ver containers rodando
docker ps

# Ver logs
docker logs ufbank-blue -f

# Parar todos os serviços
docker-compose down

# Reconstruir imagens
docker-compose build --no-cache

# Ver estatísticas de uso
docker stats
```

### Terraform

```bash
# Formatar código
terraform fmt

# Validar sintaxe
terraform validate

# Ver estado atual
terraform show

# Destruir infraestrutura
terraform destroy
```

### Testes

```bash
# Testar aplicação Blue
curl http://localhost:3000

# Testar aplicação Green
curl http://localhost:3001

# Testar Load Balancer
curl http://localhost:8080

# Teste de carga
ab -n 1000 -c 10 http://localhost:8080/
```

---

## 📊 Monitoramento

### Prometheus Queries Úteis

```promql
# Taxa de requisições
rate(http_requests_total[5m])

# Uso de CPU
container_cpu_usage_seconds_total

# Uso de memória
container_memory_usage_bytes
```

### Métricas Importantes

- **Uptime:** 99.9%+
- **Response Time:** <200ms
- **Error Rate:** <0.1%
- **Throughput:** 1000+ req/s

---

## 🎯 Recursos Demonstrados

### ✅ Infraestrutura como Código (IaC)
- [x] Provisionamento automático
- [x] Versionamento de infraestrutura
- [x] Replicabilidade entre ambientes
- [x] Documentação como código

### ✅ CI/CD Pipeline
- [x] Build automatizado
- [x] Testes automatizados
- [x] Deploy automático
- [x] Rollback automático
- [x] Aprovação manual para produção

### ✅ Containerização
- [x] Docker para aplicações
- [x] Docker Compose para orquestração
- [x] Health checks
- [x] Resource limits

### ✅ Estratégias de Deploy
- [x] Blue-Green Deployment
- [x] Zero Downtime
- [x] Rollback instantâneo

### ✅ Observabilidade
- [x] Logs centralizados
- [x] Métricas em tempo real
- [x] Dashboards
- [x] Alertas

---

## 🌩️ Multi-Cloud (Configuração Avançada)

### AWS

```hcl
# Descomente no main.tf para habilitar recursos AWS
# - VPC
# - EC2
# - S3
# - RDS
```

### Azure

```bash
# Adicionar provider Azure
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}
```

### GCP

```bash
# Adicionar provider GCP
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}
```

---

## 🔐 Segurança

### Práticas Implementadas

- ✅ Container security scanning (Trivy)
- ✅ Infrastructure security (Checkov)
- ✅ Secrets scanning (TruffleHog)
- ✅ Security headers
- ✅ Network isolation
- ✅ Least privilege access

---

## 📚 Tecnologias Utilizadas

| Tecnologia | Versão | Uso |
|------------|--------|-----|
| Terraform | 1.6+ | IaC |
| Docker | 24.0+ | Containerização |
| GitHub Actions | - | CI/CD |
| Nginx | alpine | Load Balancer |
| Prometheus | latest | Monitoramento |
| Grafana | latest | Visualização |
| PostgreSQL | 15 | Database |
| Redis | alpine | Cache |

---

## 🐛 Troubleshooting

### Porta já em uso
```bash
# Mudar porta no docker-compose.yml
ports:
  - "3010:80"  # Usar porta diferente
```

### Container não inicia
```bash
# Ver logs detalhados
docker logs <container-name> --tail 100

# Reconstruir imagem
docker-compose build --no-cache <service-name>
```

### Terraform erro
```bash
# Reinicializar
terraform init -upgrade

# Limpar estado (CUIDADO!)
rm -rf .terraform terraform.tfstate*
```

---

## 📖 Documentação Adicional

- [Terraform Documentation](https://www.terraform.io/docs)
- [Docker Documentation](https://docs.docker.com)
- [GitHub Actions](https://docs.github.com/actions)
- [Nginx Documentation](https://nginx.org/en/docs/)

---

## 🎓 Materiais de Apoio

### Para a Apresentação

1. **Slides:** Incluídos no projeto original
2. **Script de Demo:** Ver seção "Demonstração"
3. **Vídeo Backup:** Gravar demo antes da apresentação
4. **Cheat Sheet:** Comandos prontos para copiar/colar

### Extras

- Diagrama de arquitetura (Draw.io)
- Fluxogramas de CI/CD
- Comparativo IaC tools
- Benchmarks de performance

---

## 🤝 Contribuindo

Este é um projeto acadêmico, mas sugestões são bem-vindas!

```bash
# Fork o projeto
# Crie uma branch
git checkout -b feature/nova-funcionalidade

# Commit suas mudanças
git commit -m "Add: nova funcionalidade"

# Push para o GitHub
git push origin feature/nova-funcionalidade

# Abra um Pull Request
```

---

## 📄 Licença

Este projeto é apenas para fins educacionais.

---

## 🙏 Agradecimentos

- Universidade Federal
- Professores orientadores
- Comunidade Open Source

---

## 📞 Contato

Para dúvidas sobre a apresentação:

- **Marcos Pimentel:** marcos@example.com
- **Deivid Garcia Schitine:** deivid@example.com
- **Júlio César:** julio@example.com

---

<div align="center">

**Desenvolvido com ❤️ para demonstração acadêmica de IaC e CI/CD**

![UFBank](https://img.shields.io/badge/UFBank-2024-6366f1?style=for-the-badge)

</div>
