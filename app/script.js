function animateCounter(id, target, duration = 2000) {
    const element = document.getElementById(id);
    const start = 0;
    const increment = target / (duration / 16);
    let current = start;

    const timer = setInterval(() => {
        current += increment;
        if (current >= target) {
            element.textContent = target.toLocaleString('pt-BR');
            clearInterval(timer);
        } else {
            element.textContent = Math.floor(current).toLocaleString('pt-BR');
        }
    }, 16);
}

window.addEventListener('load', () => {
    animateCounter('customers', 125430, 2000);
    animateCounter('transactions', 1250000, 2500);
    
    const cards = document.querySelectorAll('.tech-card, .provider, .stat-card');
    cards.forEach((card, index) => {
        setTimeout(() => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(20px)';
            card.style.transition = 'all 0.5s ease';
            
            setTimeout(() => {
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }, 100);
        }, index * 100);
    });
});

document.getElementById('simulateDeployBtn').addEventListener('click', function() {
    const steps = document.querySelectorAll('.pipeline-step');
    const button = this;
    
    button.disabled = true;
    button.textContent = 'Deploy em Andamento...';
    
    steps.forEach(step => {
        step.classList.remove('active');
        step.querySelector('.step-status').textContent = '○';
        step.querySelector('.step-status').style.color = '#9ca3af';
    });
    
    steps.forEach((step, index) => {
        setTimeout(() => {
            step.classList.add('active');
            
            setTimeout(() => {
                step.classList.remove('active');
                step.querySelector('.step-status').textContent = '✓';
                step.querySelector('.step-status').style.color = '#10b981';
                
                if (index === steps.length - 1) {
                    setTimeout(() => {
                        button.disabled = false;
                        button.textContent = 'Deploy Completo! ✓';
                        button.style.background = 'linear-gradient(135deg, #10b981 0%, #059669 100%)';
                        
                        setTimeout(() => {
                            button.textContent = 'Simular Deploy';
                            button.style.background = 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)';
                        }, 2000);
                    }, 500);
                }
            }, 1500);
        }, index * 2000);
    });
});

function updateCloudStatus() {
    const providers = document.querySelectorAll('.provider');
    providers.forEach(provider => {
        const status = provider.querySelector('.status');
        const random = Math.random();
        
        if (random > 0.95) {
            status.textContent = '● Maintenance';
            status.className = 'status maintenance';
            status.style.color = '#f59e0b';
            
            setTimeout(() => {
                status.textContent = '● Online';
                status.className = 'status online';
                status.style.color = '#10b981';
            }, 3000);
        }
    });
}

setInterval(updateCloudStatus, 10000);

document.querySelectorAll('nav a').forEach(anchor => {
    anchor.addEventListener('click', function(e) {
        e.preventDefault();
        const targetId = this.getAttribute('href');
        if (targetId !== '#home') {
            document.querySelector(targetId)?.scrollIntoView({
                behavior: 'smooth'
            });
        } else {
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }
    });
});

window.addEventListener('scroll', () => {
    const hero = document.querySelector('.hero');
    const scrolled = window.pageYOffset;
    hero.style.transform = `translateY(${scrolled * 0.3}px)`;
    hero.style.opacity = 1 - scrolled / 500;
});

console.log('%c🏦 UFBank Multi-Cloud Demo', 'color: #6366f1; font-size: 20px; font-weight: bold;');
console.log('%cInfraestrutura como Código + CI/CD', 'color: #8b5cf6; font-size: 14px;');
console.log('%cDesenvolvido para demonstração acadêmica', 'color: #6b7280; font-size: 12px;');

const systemInfo = {
    version: '1.0.0',
    environment: 'Production',
    deployment: 'Multi-Cloud',
    iac: 'Terraform',
    cicd: 'GitHub Actions',
    containers: 'Docker + Kubernetes'
};

console.table(systemInfo);
