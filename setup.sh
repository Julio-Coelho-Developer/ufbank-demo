#!/bin/bash

# ============================================
# UFBank Demo - Setup Script
# ============================================

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions
print_header() {
    echo -e "${BLUE}"
    echo "═══════════════════════════════════════════════════════════════"
    echo "                    UFBank Demo Setup"
    echo "          Infrastructure as Code & CI/CD Demo"
    echo "═══════════════════════════════════════════════════════════════"
    echo -e "${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${YELLOW}ℹ $1${NC}"
}

check_prerequisites() {
    print_info "Verificando pré-requisitos..."
    
    # Check Docker
    if ! command -v docker &> /dev/null; then
        print_error "Docker não encontrado. Por favor, instale o Docker."
        exit 1
    fi
    print_success "Docker instalado"
    
    # Check Docker Compose
    if ! command -v docker-compose &> /dev/null; then
        print_error "Docker Compose não encontrado. Por favor, instale o Docker Compose."
        exit 1
    fi
    print_success "Docker Compose instalado"
    
    # Check if Docker is running
    if ! docker info &> /dev/null; then
        print_error "Docker não está rodando. Por favor, inicie o Docker."
        exit 1
    fi
    print_success "Docker está rodando"
    
    # Check Terraform (optional)
    if command -v terraform &> /dev/null; then
        print_success "Terraform instalado ($(terraform version -json | grep -o '"terraform_version":"[^"]*' | cut -d'"' -f4))"
    else
        print_info "Terraform não instalado (opcional para esta demo)"
    fi
    
    echo ""
}

cleanup_old_containers() {
    print_info "Limpando containers antigos..."
    
    # Stop and remove old containers
    docker-compose down 2>/dev/null || true
    
    # Remove old images (optional)
    # docker rmi ufbank-app:latest 2>/dev/null || true
    
    print_success "Limpeza concluída"
    echo ""
}

build_and_start() {
    print_info "Construindo e iniciando serviços..."
    
    # Build images
    print_info "Construindo imagens Docker..."
    docker-compose build --no-cache
    
    # Start services
    print_info "Iniciando containers..."
    docker-compose up -d
    
    print_success "Serviços iniciados"
    echo ""
}

wait_for_services() {
    print_info "Aguardando serviços ficarem prontos..."
    
    max_attempts=30
    attempt=0
    
    while [ $attempt -lt $max_attempts ]; do
        if curl -s http://localhost:8080 > /dev/null 2>&1; then
            print_success "Serviços prontos!"
            return 0
        fi
        
        echo -n "."
        sleep 2
        attempt=$((attempt + 1))
    done
    
    print_error "Timeout esperando serviços iniciarem"
    return 1
}

show_status() {
    echo ""
    print_info "Status dos containers:"
    docker-compose ps
    echo ""
}

show_urls() {
    echo -e "${GREEN}"
    echo "═══════════════════════════════════════════════════════════════"
    echo "               🎉 UFBank Demo Pronto!"
    echo "═══════════════════════════════════════════════════════════════"
    echo ""
    echo "📍 URLs de Acesso:"
    echo ""
    echo "   🌐 Aplicação Blue:"
    echo "      http://localhost:3000"
    echo ""
    echo "   🌐 Aplicação Green:"
    echo "      http://localhost:3001"
    echo ""
    echo "   ⚖️  Load Balancer (PRINCIPAL):"
    echo "      http://localhost:8080"
    echo ""
    echo "   📊 Prometheus (Monitoramento):"
    echo "      http://localhost:9090"
    echo ""
    echo "   📈 Grafana (Dashboards):"
    echo "      http://localhost:3002"
    echo "      Usuário: admin | Senha: admin"
    echo ""
    echo "═══════════════════════════════════════════════════════════════"
    echo ""
    echo "🔍 Comandos Úteis:"
    echo ""
    echo "   Ver logs:           docker-compose logs -f"
    echo "   Ver status:         docker-compose ps"
    echo "   Parar serviços:     docker-compose stop"
    echo "   Reiniciar:          docker-compose restart"
    echo "   Parar e limpar:     docker-compose down"
    echo ""
    echo "═══════════════════════════════════════════════════════════════"
    echo -e "${NC}"
}

run_health_checks() {
    print_info "Executando verificações de saúde..."
    
    # Check Blue
    if curl -s -f http://localhost:3000 > /dev/null; then
        print_success "Blue environment: OK"
    else
        print_error "Blue environment: FALHOU"
    fi
    
    # Check Green
    if curl -s -f http://localhost:3001 > /dev/null; then
        print_success "Green environment: OK"
    else
        print_error "Green environment: FALHOU"
    fi
    
    # Check Load Balancer
    if curl -s -f http://localhost:8080 > /dev/null; then
        print_success "Load Balancer: OK"
    else
        print_error "Load Balancer: FALHOU"
    fi
    
    # Check Prometheus
    if curl -s -f http://localhost:9090 > /dev/null; then
        print_success "Prometheus: OK"
    else
        print_error "Prometheus: FALHOU"
    fi
    
    # Check Grafana
    if curl -s -f http://localhost:3002 > /dev/null; then
        print_success "Grafana: OK"
    else
        print_error "Grafana: FALHOU"
    fi
    
    echo ""
}

# Main execution
main() {
    print_header
    
    check_prerequisites
    
    cleanup_old_containers
    
    build_and_start
    
    wait_for_services
    
    show_status
    
    run_health_checks
    
    show_urls
    
    # Open browser (optional)
    read -p "Deseja abrir o navegador automaticamente? (s/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Ss]$ ]]; then
        print_info "Abrindo navegador..."
        
        # Detect OS and open browser
        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS
            open http://localhost:8080
        elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
            # Linux
            xdg-open http://localhost:8080 2>/dev/null || sensible-browser http://localhost:8080 2>/dev/null
        elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
            # Windows
            start http://localhost:8080
        fi
    fi
    
    print_success "Setup concluído!"
    print_info "A demo está pronta para apresentação!"
}

# Run main function
main
