# Script de Inicialização Rápida do Projeto Viper
# Este script inicia o servidor Laravel e o Vite

Write-Host "=== Iniciando Projeto Viper ===" -ForegroundColor Cyan
Write-Host ""

# Verificar se o .env existe
if (-not (Test-Path ".env")) {
    Write-Host "✗ Erro: Arquivo .env não encontrado!" -ForegroundColor Red
    Write-Host "  Por favor, crie o arquivo .env primeiro. Veja GUIA_INSTALACAO.md" -ForegroundColor Yellow
    exit 1
}

# Verificar se a chave APP_KEY está configurada
$envContent = Get-Content ".env" -Raw
if ($envContent -notmatch "APP_KEY=base64:") {
    Write-Host "⚠ Aviso: APP_KEY não está configurada. Executando key:generate..." -ForegroundColor Yellow
    php artisan key:generate
    Write-Host ""
}

Write-Host "Iniciando servidor Laravel na porta 8000..." -ForegroundColor Green
Write-Host "Iniciando Vite para assets frontend..." -ForegroundColor Green
Write-Host ""
Write-Host "Acesse: http://localhost:8000" -ForegroundColor Cyan
Write-Host ""
Write-Host "Pressione Ctrl+C para parar os servidores" -ForegroundColor Yellow
Write-Host ""

# Iniciar Vite em background
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PWD'; npm run dev"

# Aguardar um pouco para o Vite iniciar
Start-Sleep -Seconds 2

# Iniciar servidor Laravel (este comando mantém o terminal aberto)
php artisan serve




