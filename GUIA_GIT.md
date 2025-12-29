# Guia para Fazer Push do Projeto para GitHub

## Pré-requisito: Instalar Git

Se o Git não estiver instalado, baixe e instale de:
- **Download**: https://git-scm.com/download/win
- Durante a instalação, certifique-se de selecionar a opção "Add Git to PATH"

Após instalar, **reinicie o terminal** para que o Git seja reconhecido.

## Passos para Fazer Push

### 1. Verificar se o Git está instalado
```powershell
git --version
```

### 2. Configurar o Git (se ainda não configurou)
```powershell
git config --global user.name "Seu Nome"
git config --global user.email "seu.email@example.com"
```

### 3. Inicializar o repositório Git (se ainda não foi inicializado)
```powershell
git init
```

### 4. Adicionar o repositório remoto
```powershell
git remote add origin https://github.com/Esamwell/viperbet.git
```

Se já existir um remote, você pode atualizá-lo:
```powershell
git remote set-url origin https://github.com/Esamwell/viperbet.git
```

### 5. Verificar o status dos arquivos
```powershell
git status
```

### 6. Adicionar todos os arquivos ao staging
```powershell
git add .
```

**Nota**: O arquivo `.env` será ignorado automaticamente pelo `.gitignore` (não será enviado, o que é correto por segurança).

### 7. Fazer commit das alterações
```powershell
git commit -m "Initial commit - Projeto Viper"
```

Ou com uma mensagem mais descritiva:
```powershell
git commit -m "Initial commit: Projeto Viper - Plataforma de cassino online com Laravel e Filament"
```

### 8. Verificar a branch atual
```powershell
git branch
```

### 9. Renomear a branch para main (se necessário)
```powershell
git branch -M main
```

### 10. Fazer push para o GitHub
```powershell
git push -u origin main
```

**Importante**: Na primeira vez, o GitHub pode solicitar autenticação. Você pode:
- Usar um Personal Access Token (recomendado)
- Ou usar GitHub CLI (`gh auth login`)

### 11. Se precisar autenticar com token

1. Vá em: https://github.com/settings/tokens
2. Clique em "Generate new token (classic)"
3. Dê um nome ao token
4. Selecione as permissões: `repo` (acesso completo aos repositórios)
5. Copie o token gerado
6. Quando o Git pedir senha, use o token no lugar da senha

Ou configure o token no URL:
```powershell
git remote set-url origin https://SEU_TOKEN@github.com/Esamwell/viperbet.git
```

## Comandos Úteis

### Verificar remotes configurados
```powershell
git remote -v
```

### Ver histórico de commits
```powershell
git log --oneline
```

### Ver diferenças antes de commitar
```powershell
git diff
```

### Desfazer alterações não commitadas
```powershell
git restore .
```

## Solução de Problemas

### Erro: "fatal: not a git repository"
Execute: `git init`

### Erro: "remote origin already exists"
Execute: `git remote set-url origin https://github.com/Esamwell/viperbet.git`

### Erro: "failed to push some refs"
Se o repositório no GitHub já tiver conteúdo:
```powershell
git pull origin main --allow-unrelated-histories
git push -u origin main
```

### Erro de autenticação
Use um Personal Access Token em vez de senha.

## Script Automatizado

Você também pode usar o script `push-to-github.ps1` que criei para automatizar o processo.



