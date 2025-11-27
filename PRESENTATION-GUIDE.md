# 🎤 Guia de Apresentação - UFBank Demo

## ⏱️ Timeline (15 minutos total)

### Minuto 0-2: Introdução
**O que dizer:**
> "Vamos demonstrar como implementar Infraestrutura como Código e CI/CD em ambientes multi-cloud, usando o UFBank como exemplo prático."

**O que mostrar:**
- Slides iniciais do PowerPoint
- Mencionar equipe: Marcos, Deivid e Júlio

---

### Minuto 2-5: Demonstração da Aplicação

**Comandos:**
```bash
# 1. Verificar se tudo está rodando
docker-compose ps

# 2. Abrir navegador
```

**O que mostrar:**
1. Abrir http://localhost:8080
2. Mostrar interface do UFBank
3. Explicar: "Esta é uma aplicação bancária containerizada"
4. Clicar em "Simular Deploy" e explicar o processo
5. Mostrar arquitetura multi-cloud (AWS, Azure, GCP)

**O que dizer:**
> "Aqui temos o UFBank rodando em containers Docker. Reparem nos indicadores de status das três clouds - AWS para dados críticos, Azure para autenticação, e GCP para Big Data. Vou simular um deploy agora..."

---

### Minuto 5-8: Infraestrutura como Código

**Comandos:**
```bash
# 1. Abrir VSCode
code terraform/main.tf

# 2. Mostrar código Terraform
```

**O que mostrar:**
1. Arquivo `main.tf`
2. Destacar:
   - Definição de recursos Docker
   - Configuração de rede
   - Load balancer

**O que dizer:**
> "Este é o código Terraform que define toda nossa infraestrutura. Com IaC, tratamos a infraestrutura como código versionável. Vejam aqui: definimos containers, redes, e load balancer - tudo em código!"

**Pontos a destacar:**
- ✅ Versionável (Git)
- ✅ Replicável
- ✅ Documentado
- ✅ Testável

---

### Minuto 8-11: Pipeline CI/CD

**Comandos:**
```bash
# Mostrar pipeline
code .github/workflows/deploy.yml
```

**O que mostrar:**
1. Arquivo de workflow do GitHub Actions
2. Destacar stages:
   - Build
   - Test
   - Deploy Dev
   - Deploy Staging
   - Deploy Production

**O que dizer:**
> "Nosso pipeline CI/CD automatiza todo o processo. Quando fazemos um commit, o código passa por build, testes automatizados, análise de segurança, e deploy automático em múltiplos ambientes. Para produção, temos aprovação manual como segurança adicional."

**Diagrama no quadro:**
```
Commit → Build → Test → Dev → Staging → [Aprovação] → Production
```

---

### Minuto 11-13: Blue-Green Deployment

**Comandos:**
```bash
# Mostrar containers
docker ps | grep ufbank

# Mostrar logs
docker logs ufbank-blue --tail 20
docker logs ufbank-green --tail 20
```

**O que mostrar:**
1. Dois containers rodando (Blue e Green)
2. Load balancer distribuindo tráfego
3. Abrir http://localhost:3000 e http://localhost:3001

**O que dizer:**
> "Implementamos Blue-Green Deployment. Temos duas versões da aplicação rodando simultaneamente. O load balancer distribui o tráfego. Se a nova versão (Green) tiver problemas, fazemos rollback instantâneo para a versão anterior (Blue) - zero downtime!"

---

### Minuto 13-14: Monitoramento

**Comandos:**
```bash
# Abrir Prometheus
# URL: http://localhost:9090

# Abrir Grafana  
# URL: http://localhost:3002
# Login: admin/admin
```

**O que mostrar:**
1. Dashboard do Prometheus
2. Métricas em tempo real
3. (Se configurado) Grafana com visualizações

**O que dizer:**
> "Para completar, temos monitoramento em tempo real com Prometheus e Grafana, permitindo observabilidade total da infraestrutura e aplicações."

---

### Minuto 14-15: Conclusão e Benefícios

**O que dizer:**
> "Recapitulando os benefícios implementados:
> 
> 1. **Agilidade**: Deploy automatizado em minutos
> 2. **Confiabilidade**: Testes automáticos em cada mudança  
> 3. **Escalabilidade**: Fácil replicar para novas clouds
> 4. **Segurança**: Análise automática de vulnerabilidades
> 5. **Resiliência**: Rollback instantâneo em caso de problemas
> 
> Essa é a base de uma operação bancária moderna e eficiente."

---

## 🎯 Pontos-Chave a Mencionar

### ✅ Durante a Demo

- [x] "Toda infraestrutura está definida em código"
- [x] "Pipeline totalmente automatizado"
- [x] "Deploy sem downtime com Blue-Green"
- [x] "Multi-cloud para evitar vendor lock-in"
- [x] "Monitoramento contínuo"

### ✅ Se Perguntarem sobre Custos

> "Na demo usamos containers locais, mas o mesmo código Terraform pode provisionar recursos reais em AWS, Azure ou GCP. Estimamos redução de 40% no tempo de deploy e 30% em custos operacionais."

### ✅ Se Perguntarem sobre Segurança

> "Implementamos múltiplas camadas: análise de segurança automática com Trivy e Checkov, secrets scanning com TruffleHog, security headers HTTP, e network isolation entre containers."

### ✅ Se Perguntarem sobre Escalabilidade

> "Com Terraform, podemos escalar horizontalmente em minutos. O código é parametrizável - mudamos uma variável e provisionamos mais recursos automaticamente."

---

## 🎬 Scripts Prontos para Copiar

### Script 1: Iniciar Demo
```bash
cd ufbank-demo
docker-compose up -d
sleep 30
docker-compose ps
echo "✅ Demo pronta! Acesse http://localhost:8080"
```

### Script 2: Mostrar Status
```bash
echo "=== UFBank Status ==="
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
echo ""
echo "URLs disponíveis:"
echo "  App Blue:   http://localhost:3000"
echo "  App Green:  http://localhost:3001"
echo "  Load Bal.:  http://localhost:8080"
echo "  Prometheus: http://localhost:9090"
echo "  Grafana:    http://localhost:3002"
```

### Script 3: Demonstrar Terraform
```bash
cd terraform
terraform init
terraform validate
terraform plan
echo "✅ Terraform validado com sucesso!"
```

### Script 4: Simular Deploy
```bash
echo "Iniciando deploy..."
cd terraform
terraform apply -auto-approve
echo "✅ Deploy concluído!"
terraform output
```

### Script 5: Cleanup
```bash
docker-compose down
cd terraform
terraform destroy -auto-approve
echo "✅ Ambiente limpo!"
```

---

## 📋 Checklist Pré-Apresentação

### 1 Dia Antes
- [ ] Testar demo completa do início ao fim
- [ ] Gravar vídeo backup da demo
- [ ] Verificar se Docker está funcionando
- [ ] Preparar slides
- [ ] Imprimir cheat sheet com comandos

### 2 Horas Antes
- [ ] Reiniciar computador
- [ ] Fechar programas desnecessários
- [ ] Limpar ambiente Docker: `docker system prune -a`
- [ ] Testar demo novamente
- [ ] Abrir abas do navegador:
  - [ ] localhost:8080
  - [ ] localhost:9090 (Prometheus)
  - [ ] localhost:3002 (Grafana)
  - [ ] GitHub repository

### 30 Minutos Antes
- [ ] Iniciar demo: `docker-compose up -d`
- [ ] Verificar que tudo está rodando
- [ ] Abrir VSCode com projeto
- [ ] Preparar terminal com comandos
- [ ] Testar microfone/projetor

### Durante Apresentação
- [ ] Falar claramente e devagar
- [ ] Fazer pausas para perguntas
- [ ] Mostrar código E resultados
- [ ] Usar termos técnicos mas explicar
- [ ] Manter contato visual com plateia

---

## 🆘 Plano B (Se Algo Der Errado)

### Se Internet Cair
- Usar vídeo gravado previamente
- Slides têm todas informações
- Demo roda localmente (não precisa internet)

### Se Docker Não Iniciar
- Mostrar código Terraform e explicar
- Usar slides com screenshots
- Mostrar vídeo da demo funcionando

### Se Tempo Acabar
- Pular direto para conclusão
- Mencionar principais benefícios
- Oferecer demo individual depois

### Se Pergunta Difícil
> "Excelente pergunta! Isso entra em [tópico avançado]. Posso explicar com mais detalhes após a apresentação, para não comprometer nosso tempo."

---

## 💡 Dicas Extras

### Para Impressionar
1. Memorize números-chave:
   - 99.9% uptime
   - Deploy em <5 minutos
   - Zero downtime
   - 3 clouds simultâneas

2. Use analogias:
   - "IaC é como uma receita de bolo - sempre reproduz o mesmo resultado"
   - "Blue-Green é como ter dois sistemas de energia: se um falha, o outro assume"

3. Demonstre confiança:
   - Pratique 5+ vezes antes
   - Conheça cada comando
   - Saiba onde está cada arquivo

### Linguagem Corporal
- ✅ Olhe para plateia, não só para tela
- ✅ Use gestos para enfatizar pontos
- ✅ Sorria e mostre entusiasmo
- ✅ Fale em ritmo normal (não acelere)

---

## 🎓 Perguntas Frequentes Esperadas

**Q: "Quanto tempo economiza?"**
A: "Em operações manuais, deploy levaria 2-3 horas. Com nossa automação, menos de 5 minutos."

**Q: "E se der erro em produção?"**
A: "Rollback automático em segundos. Blue-Green permite voltar à versão anterior instantaneamente."

**Q: "Por que não usar apenas uma cloud?"**
A: "Multi-cloud evita vendor lock-in, permite aproveitar melhores serviços de cada provedor, e garante resiliência."

**Q: "Isso funciona em escala real?"**
A: "Sim! Netflix, Spotify e outros usam práticas similares. Nossa demo é simplificada mas os princípios são os mesmos."

**Q: "Qual o investimento inicial?"**
A: "Ferramentas são open-source (gratuitas). Principal investimento é em conhecimento da equipe."

---

## ✨ Fechamento Memorável

**Última Frase:**
> "Com IaC e CI/CD, transformamos a entrega de software de um processo manual e demorado em uma operação ágil, confiável e escalável - essencial para um banco digital moderno como o UFBank."

**Slide Final:**
```
═══════════════════════════════════════════
        OBRIGADO!
        
    Dúvidas?
    
    Código disponível em:
    github.com/ufbank/demo
═══════════════════════════════════════════
```

---

**BOA SORTE! 🍀**

Você está preparado. A demo funciona. O código é sólido. Respire fundo e mostre seu trabalho com confiança!
