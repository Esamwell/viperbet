# Configuração do Railway - Projeto Viper

## 🚀 Passo a Passo Completo

### Passo 1: Criar o Banco de Dados MySQL no Railway

1. Acesse seu projeto no Railway
2. Clique no botão **"+ New"** (canto superior direito)
3. Selecione **"Database"**
4. Escolha **"MySQL"**
5. O Railway criará automaticamente um serviço MySQL para você
6. Aguarde alguns segundos até o MySQL estar pronto

### Passo 2: Obter as Credenciais do MySQL

Após criar o MySQL, você verá as variáveis de ambiente automaticamente:

1. Clique no serviço MySQL que acabou de criar
2. Vá na aba **"Variables"**
3. Você verá as seguintes variáveis (anote os valores):
   - `MYSQLHOST` - Host do banco
   - `MYSQLPORT` - Porta (geralmente 3306)
   - `MYSQLDATABASE` - Nome do banco
   - `MYSQLUSER` - Usuário
   - `MYSQLPASSWORD` - Senha

### Passo 3: Configurar Variáveis de Ambiente na Aplicação

1. No seu projeto Railway, clique no serviço da **aplicação Laravel** (não no MySQL)
2. Vá na aba **"Variables"**
3. Clique em **"New Variable"** e adicione uma por uma:

#### Variáveis Obrigatórias da Aplicação

```env
APP_NAME=Viper
APP_ENV=production
APP_KEY=base64:SUA_CHAVE_AQUI
APP_DEBUG=false
APP_URL=https://seu-dominio.up.railway.app
```

#### Variáveis do Banco de Dados (use os valores do Passo 2)

```env
DB_CONNECTION=mysql
DB_HOST=[valor de MYSQLHOST]
DB_PORT=[valor de MYSQLPORT]
DB_DATABASE=[valor de MYSQLDATABASE]
DB_USERNAME=[valor de MYSQLUSER]
DB_PASSWORD=[valor de MYSQLPASSWORD]
```

#### Variáveis de Sessão e Cache

```env
SESSION_DRIVER=database
CACHE_STORE=database
QUEUE_CONNECTION=database
```

### Passo 4: Gerar APP_KEY

Execute localmente no seu computador:

```bash
php artisan key:generate --show
```

Copie a chave gerada (começa com `base64:`) e adicione como variável `APP_KEY` no Railway.

### Gerar APP_KEY

Execute localmente:
```bash
php artisan key:generate --show
```

Copie a chave gerada e cole no Railway como `APP_KEY`.

## Configuração no Railway

### Passo 5: Conectar a Aplicação ao MySQL

O Railway pode conectar automaticamente os serviços. Para garantir:

1. No serviço da aplicação, vá em **"Settings"**
2. Na seção **"Service Connections"**, certifique-se de que o MySQL está conectado
3. Se não estiver, clique em **"Connect"** e selecione o serviço MySQL

### Passo 6: Fazer Deploy

1. Após configurar todas as variáveis, o Railway fará um novo deploy automaticamente
2. Aguarde o deploy completar
3. Verifique os logs para garantir que não há erros

### Passo 7: Executar Migrações

Após o deploy bem-sucedido:

1. No Railway, vá para o serviço da aplicação
2. Clique na aba **"Deployments"**
3. Clique no deploy mais recente
4. Clique em **"View Logs"** ou abra o **Terminal**
5. Execute:
```bash
php artisan migrate --force
```

**OU** execute via terminal do Railway:
1. No serviço da aplicação, clique em **"Terminal"**
2. Execute: `php artisan migrate --force`

## ⚠️ Importante: Aplicação Inicia Sem Banco

A aplicação foi configurada para iniciar mesmo sem banco de dados configurado. Isso significa que:

- ✅ A aplicação pode fazer deploy sem banco
- ✅ Você pode configurar o banco depois
- ⚠️ Algumas funcionalidades não funcionarão até o banco estar configurado
- ⚠️ Migrações falharão se o banco não estiver configurado (isso é normal)

## Desabilitar Migrações Automáticas (Opcional)

Se você não quiser que o Railway execute migrações automaticamente durante o deploy, você pode:

1. Remover qualquer script de deploy que execute `php artisan migrate`
2. Executar migrações manualmente quando necessário

## Verificação

Após configurar tudo:

1. Verifique os logs do deploy
2. A aplicação deve iniciar sem erros
3. Acesse a URL fornecida pelo Railway

## Troubleshooting

### Erro: "Connection refused"
- Verifique se as variáveis `DB_HOST`, `DB_PORT`, `DB_DATABASE`, `DB_USERNAME`, `DB_PASSWORD` estão corretas
- Certifique-se de que o serviço MySQL está rodando

### Erro: "APP_KEY is required"
- Gere uma chave: `php artisan key:generate --show`
- Adicione como variável de ambiente no Railway

### Erro durante migrações
- Execute manualmente: `php artisan migrate --force`
- Verifique se o banco de dados está acessível

