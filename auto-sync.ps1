
$projectPath = "C:\Users\julio.cesar\Documents\ufbank-demo"
$checkInterval = 60

Write-Host "=== UFBank Auto-Sync Iniciado ===" -ForegroundColor Cyan
Write-Host "Projeto: $projectPath" -ForegroundColor Yellow
Write-Host "Verificando a cada $checkInterval segundos..." -ForegroundColor Yellow
Write-Host ""

while ($true) {
    $timestamp = Get-Date -Format "HH:mm:ss"
    Write-Host "[$timestamp] Verificando atualizações..." -ForegroundColor Gray
    
    Set-Location $projectPath
    
    git fetch origin main 2>&1 | Out-Null
    
    $local = git rev-parse HEAD
    $remote = git rev-parse origin/main
    
    if ($local -ne $remote) {
        Write-Host "[$timestamp] ✓ NOVA VERSÃO DETECTADA!" -ForegroundColor Green
        Write-Host "[$timestamp] Baixando mudanças..." -ForegroundColor Yellow
        
        git pull origin main
        
        Write-Host "[$timestamp] Reconstruindo containers..." -ForegroundColor Yellow
        
        docker-compose down -v
        
        $ports = @(3000, 3001, 8080, 9090, 3002, 5432, 6379)
        foreach ($port in $ports) {
            $process = Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue
            if ($process) {
                Write-Host "[$timestamp] Liberando porta $port..." -ForegroundColor Yellow
                Stop-Process -Id $process.OwningProcess -Force -ErrorAction SilentlyContinue
            }
        }
        
        Start-Sleep -Seconds 2
        
        # Reconstruir
        docker-compose build --no-cache
        
        # Iniciar
        docker-compose up -d
        
        Write-Host "[$timestamp] Aguardando containers iniciarem..." -ForegroundColor Yellow
        Start-Sleep -Seconds 15
        
        $status = docker-compose ps
        
        Write-Host "[$timestamp] ✓ DEPLOY LOCAL COMPLETO!" -ForegroundColor Green
        Write-Host "[$timestamp] Acesse: http://localhost:8080" -ForegroundColor Cyan
        Write-Host ""
        
        try {
            Add-Type -AssemblyName System.Windows.Forms
            $notification = New-Object System.Windows.Forms.NotifyIcon
            $notification.Icon = [System.Drawing.SystemIcons]::Information
            $notification.BalloonTipTitle = "UFBank Atualizado!"
            $notification.BalloonTipText = "Nova versão deployada com sucesso!"
            $notification.Visible = $true
            $notification.ShowBalloonTip(5000)
        } catch {
            Add-Type -AssemblyName System.Windows.Forms
            $notification = New-Object System.Windows.Forms.NotifyIcon
            $notification.Icon = [System.Drawing.SystemIcons]::Information
            $notification.BalloonTipTitle = "UFBank Erro!"
            $notification.BalloonTipText = "Ocorreu erro erro no deploy local."
            $notification.Visible = $true
            $notification.ShowBalloonTip(5000)
        }
        
    } else {
        Write-Host "[$timestamp] Nenhuma mudança" -ForegroundColor Gray
    }
    
    Start-Sleep -Seconds $checkInterval
}