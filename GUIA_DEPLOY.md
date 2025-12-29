# Guia de Deploy - Projeto Viper

## ⚠️ Importante: Vercel e Laravel

**O Vercel NÃO suporta aplicações Laravel (PHP) nativamente.** O Vercel é otimizado para:
- Aplicações serverless (Node.js, Next.js, etc.)
- Funções serverless
- Aplicações estáticas

Laravel é uma aplicação PHP que precisa de um servidor PHP tradicional com suporte a:
- Processos persistentes
- Sessões
- Filas (queues)
- Cache
- Storage persistente

## ✅ Alternativas Recomendadas para Laravel

### 1. **Railway** (Recomendado - Mais Fácil)
- ✅ Suporta PHP/Laravel nativamente
- ✅ Integração fácil com PostgreSQL (Supabase)
- ✅ Deploy automático via GitHub
- ✅ Plano gratuito disponível
- 🔗 https://railway.app

### 2. **Render**
- ✅ Suporta PHP/Laravel
- ✅ Integração com PostgreSQL
- ✅ Deploy automático via GitHub
- ✅ Plano gratuito (com limitações)
- 🔗 https://render.com

### 3. **Fly.io**
- ✅ Suporta PHP/Laravel
- ✅ Boa performance
- ✅ Plano gratuito disponível
- 🔗 https://fly.io

### 4. **Laravel Vapor** (Oficial Laravel)
- ✅ Criado especificamente para Laravel
- ✅ Serverless na AWS
- ⚠️ Pago (mas muito otimizado)
- 🔗 https://vapor.laravel.com

### 5. **DigitalOcean App Platform**
- ✅ Suporta PHP/Laravel
- ✅ Fácil configuração
- ⚠️ Pago (mas preços acessíveis)
- 🔗 https://www.digitalocean.com/products/app-platform

## 🗄️ Usando Supabase como Banco de Dados

O **Supabase usa PostgreSQL**, então você precisará fazer algumas adaptações:

### Passos para Configurar Supabase:

1. **Criar projeto no Supabase**
   - Acesse: https://supabase.com
   - Crie uma conta e um novo projeto
   - Anote as credenciais de conexão

2. **Configurar o Laravel para PostgreSQL**

   No arquivo `.env`, altere:
   ```env
   DB_CONNECTION=pgsql
   DB_HOST=db.xxxxx.supabase.co
   DB_PORT=5432
   DB_DATABASE=postgres
   DB_USERNAME=postgres
   DB_PASSWORD=sua_senha_aqui
   ```

3. **Converter o banco MySQL para PostgreSQL**

   O arquivo `sql/viper.sql` está em formato MySQL. Você precisará:
   
   - **Opção A**: Usar uma ferramenta de conversão online
   - **Opção B**: Executar as migrations do Laravel (recomendado)
   - **Opção C**: Converter manualmente o SQL

4. **Executar as migrations**

   ```bash
   php artisan migrate
   ```

5. **Importar dados iniciais (se necessário)**

   ```bash
   php artisan db:seed
   ```

### Diferenças MySQL vs PostgreSQL

Algumas queries podem precisar de ajustes:
- `LIMIT` e `OFFSET` funcionam igual
- Tipos de dados podem variar
- Funções de data/hora podem ser diferentes
- Auto-increment: MySQL usa `AUTO_INCREMENT`, PostgreSQL usa `SERIAL` ou `GENERATED ALWAYS AS IDENTITY`

## 🚀 Guia de Deploy no Railway (Recomendado)

### Passo 1: Preparar o Projeto

1. Certifique-se de que o `.env` está configurado para PostgreSQL
2. Adicione um arquivo `Procfile` na raiz do projeto:

   ```
   web: vendor/bin/heroku-php-apache2 public/
   ```

3. Adicione um arquivo `railway.json` (opcional):

   ```json
   {
     "$schema": "https://railway.app/railway.schema.json",
     "build": {
       "builder": "NIXPACKS"
     },
     "deploy": {
       "startCommand": "php artisan serve --host=0.0.0.0 --port=$PORT",
       "restartPolicyType": "ON_FAILURE",
       "restartPolicyMaxRetries": 10
     }
   }
   ```

### Passo 2: Deploy no Railway

1. Acesse https://railway.app
2. Faça login com GitHub
3. Clique em "New Project"
4. Selecione "Deploy from GitHub repo"
5. Escolha o repositório `viperbet`
6. Railway detectará automaticamente que é Laravel
7. Adicione as variáveis de ambiente no painel do Railway
8. Conecte o banco Supabase ou crie um PostgreSQL no Railway

### Variáveis de Ambiente Necessárias

```env
APP_NAME=Viper
APP_ENV=production
APP_KEY=base64:... (gere com: php artisan key:generate)
APP_DEBUG=false
APP_URL=https://seu-projeto.railway.app

DB_CONNECTION=pgsql
DB_HOST=db.xxxxx.supabase.co
DB_PORT=5432
DB_DATABASE=postgres
DB_USERNAME=postgres
DB_PASSWORD=sua_senha

SESSION_DRIVER=database
CACHE_DRIVER=database
QUEUE_CONNECTION=database
```

## 🔧 Configurações Adicionais Necessárias

### Storage

Para produção, você precisará configurar storage em nuvem:
- **AWS S3** (recomendado)
- **DigitalOcean Spaces**
- **Cloudflare R2**

No `.env`:
```env
FILESYSTEM_DISK=s3
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_DEFAULT_REGION=
AWS_BUCKET=
AWS_USE_PATH_STYLE_ENDPOINT=false
```

### Cache e Sessões

Para melhor performance em produção:
```env
CACHE_DRIVER=redis
SESSION_DRIVER=redis
REDIS_HOST=
REDIS_PASSWORD=
REDIS_PORT=6379
```

## 📝 Checklist de Deploy

- [ ] Configurar banco PostgreSQL (Supabase)
- [ ] Converter/adaptar migrations para PostgreSQL
- [ ] Configurar variáveis de ambiente
- [ ] Configurar storage em nuvem (S3, etc.)
- [ ] Configurar domínio personalizado (opcional)
- [ ] Configurar SSL/HTTPS
- [ ] Testar todas as funcionalidades
- [ ] Configurar backups do banco de dados
- [ ] Configurar monitoramento e logs

## 🆘 Problemas Comuns

### Erro de conexão com banco
- Verifique as credenciais do Supabase
- Certifique-se de que o IP está liberado no Supabase (Settings > Database > Connection Pooling)

### Erro de storage
- Configure um storage em nuvem (S3)
- Ou use storage local (não recomendado para produção)

### Erro de sessão
- Configure `SESSION_DRIVER=database` ou `redis`
- Execute `php artisan session:table` se usar database

## 📚 Recursos Úteis

- [Documentação Railway](https://docs.railway.app)
- [Documentação Supabase](https://supabase.com/docs)
- [Laravel Deployment](https://laravel.com/docs/10.x/deployment)
- [PostgreSQL no Laravel](https://laravel.com/docs/10.x/database#postgresql)

