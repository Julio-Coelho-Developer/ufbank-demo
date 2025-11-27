# 📦 Como Instalar e Usar o UFBank Demo

## 🎯 Você Recebeu Este Arquivo

Se você está lendo isto, provavelmente baixou o arquivo `ufbank-demo.tar.gz`.

---

## 📥 Passo 1: Extrair o Projeto

### No Linux/Mac:
```bash
# Navegar até onde o arquivo foi baixado
cd ~/Downloads

# Extrair
tar -xzf ufbank-demo.tar.gz

# Entrar no diretório
cd ufbank-demo
```

### No Windows:
1. Usar o 7-Zip ou WinRAR para extrair
2. Ou usar WSL (Windows Subsystem for Linux)
3. Abrir PowerShell e executar:
```powershell
tar -xzf ufbank-demo.tar.gz
cd ufbank-demo
```

---

## ⚡ Passo 2: Iniciar a Demo

### Opção 1: Automática (Recomendado)

```bash
# Tornar script executável (só precisa fazer uma vez)
chmod +x setup.sh

# Executar setup
./setup.sh
```

### Opção 2: Manual

```bash
# Verificar se Docker está instalado
docker --version
docker-compose --version

# Iniciar serviços
docker-compose up -d

# Aguardar 30 segundos

# Verificar status
docker-compose ps

# Acessar http://localhost:8080
```

---

## 📚 Passo 3: Ler Documentação

### Ordem Recomendada:

1. **INDEX.md** ← Índice de todos os arquivos
2. **QUICKSTART.md** ← Guia rápido (5 min)
3. **PRESENTATION-GUIDE.md** ← Para apresentação
4. **README.md** ← Documentação completa

---

## 🖥️ Passo 4: Acessar as URLs

Após iniciar com sucesso:

- 🌐 **Principal:** http://localhost:8080
- 📊 **Prometheus:** http://localhost:9090
- 📈 **Grafana:** http://localhost:3002 (admin/admin)
- 🔵 **Blue:** http://localhost:3000
- 🟢 **Green:** http://localhost:3001

---

## 🎯 Estrutura do Projeto Extraído

```
ufbank-demo/
├── INDEX.md                     ← Comece aqui!
├── QUICKSTART.md                ← Guia rápido
├── PRESENTATION-GUIDE.md        ← Roteiro de apresentação
├── README.md                    ← Doc completa
├── EXECUTIVE-SUMMARY.md         ← Resumo executivo
├── setup.sh                     ← Script de inicialização
├── docker-compose.yml           ← Orquestração
├── app/                         ← Aplicação web
├── terraform/                   ← Infrastructure as Code
└── .github/workflows/           ← Pipeline CI/CD
```

---

## ✅ Verificação de Sucesso

Você saberá que está funcionando quando:

1. ✅ `docker-compose ps` mostra containers rodando
2. ✅ http://localhost:8080 carrega a página
3. ✅ Consegue clicar em "Simular Deploy"

---

## 🆘 Problemas Comuns

### Docker não instalado
```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install docker.io docker-compose

# Mac
brew install docker docker-compose
```

### Portas ocupadas
```bash
# Ver o que está usando a porta
lsof -i :8080

# Matar processo se necessário
kill -9 <PID>
```

### Permissão negada
```bash
# Dar permissão ao script
chmod +x setup.sh

# Ou executar como root (não recomendado)
sudo ./setup.sh
```

---

## 📞 Próximos Passos

1. ✅ Extraiu o projeto
2. ✅ Iniciou a demo
3. ✅ Acessou as URLs
4. 📖 Agora leia **INDEX.md** para saber por onde continuar!

---

## 🎓 Para Apresentação

Se você vai apresentar este projeto:

1. Leia **PRESENTATION-GUIDE.md** completo
2. Pratique a demo 2-3 vezes
3. Prepare vídeo backup (grave a demo funcionando)
4. Tenha comandos prontos para copiar/colar

---

## 💡 Dica Final

**Não sabe por onde começar?**

```bash
# Entre no diretório
cd ufbank-demo

# Abra o índice
cat INDEX.md

# Ou use um editor
code INDEX.md  # VS Code
nano INDEX.md  # Terminal
```

O arquivo INDEX.md tem o mapa completo do projeto!

---

<div align="center">

**Boa sorte com o projeto! 🚀**

Se tiver dúvidas, leia a documentação incluída.  
Tudo está documentado! 📚

</div>
