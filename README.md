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

# Testar aplicação Blue
curl http://localhost:3000

# Testar aplicação Green
curl http://localhost:3001

# Testar Load Balancer
curl http://localhost:8080

# Teste de carga
ab -n 1000 -c 10 http://localhost:8080/
```

-
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

## 📖 Documentação Adicional

- [Terraform Documentation](https://www.terraform.io/docs)
- [Docker Documentation](https://docs.docker.com)
- [GitHub Actions](https://docs.github.com/actions)
- [Nginx Documentation](https://nginx.org/en/docs/)

---


<div align="center">

**Desenvolvido com ❤️ para demonstração acadêmica de IaC e CI/CD**

![UFBank](https://img.shields.io/badge/UFBank-2024-6366f1?style=for-the-badge)

</div>
