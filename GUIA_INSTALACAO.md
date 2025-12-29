# Guia de Instalação - Projeto Viper

## Pré-requisitos

Para executar este projeto Laravel, você precisa instalar as seguintes ferramentas:

### 1. PHP 8.1 ou superior
- **Download**: https://windows.php.net/download/
- **Instruções**: 
  - Baixe a versão Thread Safe (TS) x64
  - Extraia em `C:\php`
  - Adicione `C:\php` ao PATH do sistema
  - Renomeie `php.ini-development` para `php.ini`
  - Descomente a extensão `extension=mysqli` e `extension=pdo_mysql` no php.ini

### 2. Composer
- **Download**: https://getcomposer.org/download/
- **Instruções**: 
  - Baixe o instalador do Composer
  - Execute o instalador e siga as instruções
  - O Composer será adicionado ao PATH automaticamente

### 3. Node.js e NPM
- **Download**: https://nodejs.org/
- **Instruções**: 
  - Baixe a versão LTS
  - Execute o instalador
  - Node.js e NPM serão instalados automaticamente

### 4. MySQL/MariaDB
- **MySQL**: https://dev.mysql.com/downloads/installer/
- **MariaDB**: https://mariadb.org/download/
- **Ou use XAMPP**: https://www.apachefriends.org/ (inclui MySQL)

## Passos de Instalação

### 1. Criar arquivo .env
Crie um arquivo `.env` na raiz do projeto com o seguinte conteúdo:

```env
APP_NAME=Viper
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_TIMEZONE=UTC
APP_URL=http://localhost:8000
APP_LOCALE=pt_BR
APP_FALLBACK_LOCALE=pt_BR
APP_FAKER_LOCALE=pt_BR

APP_MAINTENANCE_DRIVER=file
APP_MAINTENANCE_STORE=database

BCRYPT_ROUNDS=12

LOG_CHANNEL=stack
LOG_STACK=single
LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=debug

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=viper
DB_USERNAME=root
DB_PASSWORD=

SESSION_DRIVER=database
SESSION_LIFETIME=120
SESSION_ENCRYPT=false
SESSION_PATH=/
SESSION_DOMAIN=null

BROADCAST_CONNECTION=log
FILESYSTEM_DISK=local
QUEUE_CONNECTION=database

CACHE_STORE=database
CACHE_PREFIX=

MEMCACHED_HOST=127.0.0.1

REDIS_CLIENT=phpredis
REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379

MAIL_MAILER=log
MAIL_HOST=127.0.0.1
MAIL_PORT=2525
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS="hello@example.com"
MAIL_FROM_NAME="${APP_NAME}"
```

**Importante**: Ajuste as configurações do banco de dados (`DB_DATABASE`, `DB_USERNAME`, `DB_PASSWORD`) conforme sua instalação do MySQL.

### 2. Instalar dependências do Composer
```bash
composer install
```

### 3. Instalar dependências do NPM
```bash
npm install
```

### 4. Criar banco de dados
Crie um banco de dados MySQL chamado `viper` (ou o nome que você configurou no .env).

### 5. Importar banco de dados
Importe o arquivo `sql/viper.sql` no seu banco de dados usando phpMyAdmin ou linha de comando:
```bash
mysql -u root -p viper < sql/viper.sql
```

### 6. Gerar chave da aplicação
```bash
php artisan key:generate
```

### 7. Criar link simbólico para storage
```bash
php artisan storage:link
```

### 8. Limpar e otimizar cache
```bash
php artisan config:clear
php artisan cache:clear
php artisan route:clear
php artisan view:clear
```

### 9. Executar migrações (se necessário)
```bash
php artisan migrate
```

### 10. Iniciar o servidor

**Terminal 1 - Servidor Laravel:**
```bash
php artisan serve
```

**Terminal 2 - Vite (para assets frontend):**
```bash
npm run dev
```

### 11. Acessar o projeto
Abra seu navegador e acesse: `http://localhost:8000`

## Solução de Problemas

### Erro: "PHP não é reconhecido"
- Verifique se o PHP está no PATH do sistema
- Reinicie o terminal após adicionar ao PATH

### Erro: "Composer não é reconhecido"
- Verifique se o Composer foi instalado corretamente
- Reinicie o terminal

### Erro de conexão com banco de dados
- Verifique se o MySQL está rodando
- Confirme as credenciais no arquivo .env
- Verifique se o banco de dados foi criado

### Erro: "Class not found"
- Execute: `composer dump-autoload`
- Execute: `php artisan optimize:clear`

## Estrutura do Projeto

- **Painel Admin**: Acesse `/admin` após configurar um usuário administrador
- **Banco de dados**: O arquivo SQL está em `sql/viper.sql`
- **Configurações**: Arquivos de configuração estão em `config/`


