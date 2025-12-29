# Script para fazer push do projeto para GitHub
# Repositório: https://github.com/Esamwell/viperbet.git

Write-Host "=== Push para GitHub - Projeto Viper ===" -ForegroundColor Cyan
Write-Host ""

# Verificar se o Git está instalado
Write-Host "Verificando Git..." -ForegroundColor Yellow
try {
    $gitVersion = git --version 2>&1
    Write-Host "✓ $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ Git não encontrado!" -ForegroundColor Red
    Write-Host "  Por favor, instale o Git de: https://git-scm.com/download/win" -ForegroundColor Yellow
    Write-Host "  E reinicie o terminal após a instalação." -ForegroundColor Yellow
    exit 1
}

Write-Host ""

# Verificar se já é um repositório Git
if (-not (Test-Path ".git")) {
    Write-Host "Inicializando repositório Git..." -ForegroundColor Yellow
    git init
    Write-Host "✓ Repositório inicializado" -ForegroundColor Green
    Write-Host ""
}

# Verificar e configurar remote
Write-Host "Configurando repositório remoto..." -ForegroundColor Yellow
$remoteUrl = "https://github.com/Esamwell/viperbet.git"
$existingRemote = git remote get-url origin 2>&1

if ($LASTEXITCODE -eq 0) {
    if ($existingRemote -ne $remoteUrl) {
        Write-Host "Atualizando remote origin..." -ForegroundColor Yellow
        git remote set-url origin $remoteUrl
        Write-Host "✓ Remote atualizado" -ForegroundColor Green
    } else {
        Write-Host "✓ Remote já configurado corretamente" -ForegroundColor Green
    }
} else {
    Write-Host "Adicionando remote origin..." -ForegroundColor Yellow
    git remote add origin $remoteUrl
    Write-Host "✓ Remote adicionado" -ForegroundColor Green
}

Write-Host ""

# Verificar status
Write-Host "Verificando status dos arquivos..." -ForegroundColor Yellow
git status --short
Write-Host ""

# Perguntar se deseja continuar
$response = Read-Host "Deseja adicionar todos os arquivos e fazer commit? (S/N)"
if ($response -ne "S" -and $response -ne "s" -and $response -ne "Y" -and $response -ne "y") {
    Write-Host "Operação cancelada." -ForegroundColor Yellow
    exit 0
}

# Adicionar arquivos
Write-Host ""
Write-Host "Adicionando arquivos ao staging..." -ForegroundColor Yellow
git add .
Write-Host "✓ Arquivos adicionados" -ForegroundColor Green

# Fazer commit
Write-Host ""
$commitMessage = Read-Host "Digite a mensagem do commit (ou pressione Enter para usar a mensagem padrão)"
if ([string]::IsNullOrWhiteSpace($commitMessage)) {
    $commitMessage = "Initial commit - Projeto Viper"
}

Write-Host "Fazendo commit..." -ForegroundColor Yellow
git commit -m $commitMessage

if ($LASTEXITCODE -ne 0) {
    Write-Host "⚠ Nenhuma alteração para commitar ou commit cancelado." -ForegroundColor Yellow
    Write-Host ""
    $continue = Read-Host "Deseja continuar com o push mesmo assim? (S/N)"
    if ($continue -ne "S" -and $continue -ne "s" -and $continue -ne "Y" -and $continue -ne "y") {
        exit 0
    }
} else {
    Write-Host "✓ Commit realizado" -ForegroundColor Green
}

Write-Host ""

# Verificar branch
$currentBranch = git branch --show-current 2>&1
if ($currentBranch -notmatch "main|master") {
    Write-Host "Renomeando branch para 'main'..." -ForegroundColor Yellow
    git branch -M main
    Write-Host "✓ Branch renomeada" -ForegroundColor Green
    Write-Host ""
}

# Fazer push
Write-Host "Fazendo push para GitHub..." -ForegroundColor Yellow
Write-Host "⚠ Se solicitado, use seu Personal Access Token como senha" -ForegroundColor Yellow
Write-Host "  Token pode ser gerado em: https://github.com/settings/tokens" -ForegroundColor Yellow
Write-Host ""

git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✓ Push realizado com sucesso!" -ForegroundColor Green
    Write-Host "  Repositório: https://github.com/Esamwell/viperbet" -ForegroundColor Cyan
} else {
    Write-Host ""
    Write-Host "✗ Erro ao fazer push." -ForegroundColor Red
    Write-Host ""
    Write-Host "Possíveis soluções:" -ForegroundColor Yellow
    Write-Host "  1. Verifique suas credenciais do GitHub" -ForegroundColor White
    Write-Host "  2. Use um Personal Access Token em vez de senha" -ForegroundColor White
    Write-Host "  3. Se o repositório já tem conteúdo, execute:" -ForegroundColor White
    Write-Host "     git pull origin main --allow-unrelated-histories" -ForegroundColor Cyan
    Write-Host "     git push -u origin main" -ForegroundColor Cyan
}

Write-Host ""


