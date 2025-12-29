# Script de Setup para Projeto Viper
# Este script verifica e ajuda a instalar as dependências necessárias

Write-Host "=== Verificação de Dependências do Projeto Viper ===" -ForegroundColor Cyan
Write-Host ""

# Verificar PHP
Write-Host "Verificando PHP..." -ForegroundColor Yellow
try {
    $phpVersion = php --version 2>&1 | Select-Object -First 1
    Write-Host "✓ PHP encontrado: $phpVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ PHP não encontrado!" -ForegroundColor Red
    Write-Host "  Por favor, instale o PHP 8.1+ de: https://windows.php.net/download/" -ForegroundColor Yellow
    Write-Host "  E adicione ao PATH do sistema." -ForegroundColor Yellow
}

Write-Host ""

# Verificar Composer
Write-Host "Verificando Composer..." -ForegroundColor Yellow
try {
    $composerVersion = composer --version 2>&1 | Select-Object -First 1
    Write-Host "✓ Composer encontrado: $composerVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ Composer não encontrado!" -ForegroundColor Red
    Write-Host "  Por favor, instale o Composer de: https://getcomposer.org/download/" -ForegroundColor Yellow
}

Write-Host ""

# Verificar Node.js
Write-Host "Verificando Node.js..." -ForegroundColor Yellow
try {
    $nodeVersion = node --version 2>&1
    Write-Host "✓ Node.js encontrado: $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ Node.js não encontrado!" -ForegroundColor Red
    Write-Host "  Por favor, instale o Node.js de: https://nodejs.org/" -ForegroundColor Yellow
}

Write-Host ""

# Verificar NPM
Write-Host "Verificando NPM..." -ForegroundColor Yellow
try {
    $npmVersion = npm --version 2>&1
    Write-Host "✓ NPM encontrado: v$npmVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ NPM não encontrado!" -ForegroundColor Red
}

Write-Host ""

# Verificar arquivo .env
Write-Host "Verificando arquivo .env..." -ForegroundColor Yellow
if (Test-Path ".env") {
    Write-Host "✓ Arquivo .env encontrado" -ForegroundColor Green
} else {
    Write-Host "✗ Arquivo .env não encontrado!" -ForegroundColor Red
    Write-Host "  Por favor, crie o arquivo .env baseado no GUIA_INSTALACAO.md" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "=== Verificação Concluída ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "Se todas as dependências estiverem instaladas, execute os seguintes comandos:" -ForegroundColor Yellow
Write-Host "  1. composer install" -ForegroundColor White
Write-Host "  2. npm install" -ForegroundColor White
Write-Host "  3. php artisan key:generate" -ForegroundColor White
Write-Host "  4. Configure o banco de dados no .env e importe sql/viper.sql" -ForegroundColor White
Write-Host "  5. php artisan serve (em um terminal)" -ForegroundColor White
Write-Host "  6. npm run dev (em outro terminal)" -ForegroundColor White
Write-Host ""

