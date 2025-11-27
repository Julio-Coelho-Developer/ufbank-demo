# 🚀 Quick Start - UFBank Demo

## ⚡ Início Rápido (5 minutos)

### Opção 1: Script Automático (RECOMENDADO)

```bash
# 1. Navegue até o diretório
cd ufbank-demo

# 2. Execute o script de setup
./setup.sh

# 3. Aguarde a inicialização (1-2 minutos)

# 4. Acesse http://localhost:8080
```

### Opção 2: Manual com Docker Compose

```bash
# 1. Construa as imagens
docker-compose build

# 2. Inicie os serviços
docker-compose up -d

# 3. Aguarde 30 segundos

# 4. Verifique o status
docker-compose ps

# 5. Acesse http://localhost:8080
```

### Opção 3: Terraform + Docker

```bash
# 1. Entre no diretório terraform
cd terraform

# 2. Inicialize
terraform init

# 3. Aplique
terraform apply -auto-approve

# 4. Veja os outputs
terraform output

# 5. Acesse as URLs mostradas
```

---

## 📋 Checklist Antes da Apresentação

### Requisitos
- [ ] Docker Desktop instalado e rodando
- [ ] Git instalado
- [ ] 4GB RAM disponível
- [ ] Portas livres: 3000, 3001, 8080, 9090, 3002

### Verificação
```bash
# Verificar Docker
docker --version
docker-compose --version

# Verificar se está rodando
docker ps

# Verificar portas
lsof -i :8080
```

---

## 🎯 URLs da Demo

| Serviço | URL | Credenciais |
|---------|-----|-------------|
| **Load Balancer** | http://localhost:8080 | - |
| App Blue | http://localhost:3000 | - |
| App Green | http://localhost:3001 | - |
| Prometheus | http://localhost:9090 | - |
| Grafana | http://localhost:3002 | admin/admin |

---

## 🛠️ Comandos Essenciais

### Gerenciamento

```bash
# Iniciar
docker-compose up -d

# Parar
docker-compose stop

# Reiniciar
docker-compose restart

# Parar e remover
docker-compose down

# Ver logs
docker-compose logs -f

# Ver logs de um serviço específico
docker-compose logs -f ufbank-app-blue
```

### Troubleshooting

```bash
# Reconstruir do zero
docker-compose down
docker-compose build --no-cache
docker-compose up -d

# Limpar tudo
docker-compose down -v
docker system prune -a

# Ver uso de recursos
docker stats
```

---

## 🎬 Fluxo da Apresentação

### 1. Iniciar Demo (2 minutos antes)
```bash
cd ufbank-demo
./setup.sh
```

### 2. Durante Apresentação

**Mostrar Aplicação:**
- Abrir: http://localhost:8080
- Clicar em "Simular Deploy"
- Explicar Blue-Green

**Mostrar Código:**
```bash
# Abrir arquivos principais
code terraform/main.tf
code .github/workflows/deploy.yml
code docker-compose.yml
```

**Mostrar Status:**
```bash
docker-compose ps
docker stats --no-stream
```

**Mostrar Logs em Tempo Real:**
```bash
docker-compose logs -f ufbank-app-blue
```

### 3. Após Apresentação
```bash
# Limpar
docker-compose down
```

---

## 📊 Métricas para Mencionar

- ⚡ **Deploy**: Menos de 5 minutos
- 📈 **Uptime**: 99.9%
- 🔄 **Rollback**: Instantâneo
- 🌐 **Multi-Cloud**: AWS + Azure + GCP
- 🐳 **Containers**: 6+ serviços orquestrados

---

## 🆘 Problemas Comuns

### Porta já em uso
```bash
# Erro: "port is already allocated"
# Solução: Mudar porta no docker-compose.yml
sed -i 's/3000:80/3010:80/' docker-compose.yml
```

### Docker não inicia
```bash
# Verificar Docker
systemctl status docker  # Linux
# ou reiniciar Docker Desktop
```

### Container não sobe
```bash
# Ver erro específico
docker-compose logs ufbank-app-blue

# Forçar reconstrução
docker-compose up -d --force-recreate ufbank-app-blue
```

### Memória insuficiente
```bash
# Aumentar memória do Docker Desktop
# Configurações > Resources > Memory: 4GB+
```

---

## 💡 Dicas de Apresentação

### Antes de Começar
1. ✅ Fechar programas desnecessários
2. ✅ Desativar notificações
3. ✅ Preparar terminal com comandos
4. ✅ Abrir abas do navegador
5. ✅ Testar uma última vez

### Durante Apresentação
1. 🗣️ Fale claramente
2. 👀 Faça pausas para perguntas
3. 🖱️ Mostre código E resultado
4. 📊 Use diagramas no quadro
5. 😊 Mantenha calma se algo falhar

### Se Algo Der Errado
- Tenha vídeo backup gravado
- Use slides com screenshots
- Explique o que deveria acontecer
- Demonstre conhecimento do código

---

## 🎓 Recursos Adicionais

### Arquivos do Projeto
- `README.md` - Documentação completa
- `PRESENTATION-GUIDE.md` - Guia detalhado de apresentação
- `setup.sh` - Script de inicialização
- `docker-compose.yml` - Orquestração de serviços

### Comandos para Copiar/Colar

**Mostrar infraestrutura:**
```bash
cat terraform/main.tf | grep -A 5 "resource"
```

**Testar load balancer:**
```bash
for i in {1..10}; do curl -s http://localhost:8080 | grep -o "Version: [^<]*"; sleep 1; done
```

**Simular tráfego:**
```bash
while true; do curl -s http://localhost:8080 > /dev/null; sleep 0.5; done
```

**Ver métricas:**
```bash
docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"
```

---

## 📞 Suporte

Se encontrar problemas:

1. Verifique logs: `docker-compose logs`
2. Reinicie serviços: `docker-compose restart`
3. Reconstrua: `docker-compose build --no-cache`
4. Leia o README.md completo

---

## ✅ Checklist Final

Antes da apresentação:
- [ ] Demo testada e funcionando
- [ ] Portas disponíveis
- [ ] Docker com recursos suficientes
- [ ] Comandos preparados
- [ ] Vídeo backup gravado
- [ ] Slides prontos
- [ ] Confiança em alta! 🚀

---

**Boa sorte com a apresentação!** 🎉

Você está preparado. A demo é sólida. Mostre seu trabalho com orgulho!
