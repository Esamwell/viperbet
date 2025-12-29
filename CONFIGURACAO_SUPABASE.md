# Configuração do Supabase para o Projeto Viper

## 📋 Passo a Passo

### 1. Criar Projeto no Supabase

1. Acesse https://supabase.com
2. Faça login ou crie uma conta
3. Clique em "New Project"
4. Preencha:
   - **Name**: viperbet (ou o nome que preferir)
   - **Database Password**: Crie uma senha forte e anote
   - **Region**: Escolha a região mais próxima
5. Aguarde a criação do projeto (pode levar alguns minutos)

### 2. Obter Credenciais de Conexão

1. No painel do Supabase, vá em **Settings** > **Database**
2. Role até a seção **Connection string**
3. Escolha **URI** ou **Connection pooling**
4. Você verá algo como:
   ```
   postgresql://postgres:[YOUR-PASSWORD]@db.xxxxx.supabase.co:5432/postgres
   ```

### 3. Configurar o .env

Atualize seu arquivo `.env` com as seguintes configurações:

```env
# Banco de Dados Supabase (PostgreSQL)
DB_CONNECTION=pgsql
DB_HOST=db.xxxxx.supabase.co
DB_PORT=5432
DB_DATABASE=postgres
DB_USERNAME=postgres
DB_PASSWORD=sua_senha_aqui
```

**Exemplo completo:**
```env
APP_NAME=Viper
APP_ENV=production
APP_KEY=base64:... (gere com: php artisan key:generate)
APP_DEBUG=false
APP_URL=https://seu-dominio.com

DB_CONNECTION=pgsql
DB_HOST=db.abcdefghijklmnop.supabase.co
DB_PORT=5432
DB_DATABASE=postgres
DB_USERNAME=postgres
DB_PASSWORD=MinhaSenh@Segura123

SESSION_DRIVER=database
CACHE_DRIVER=database
QUEUE_CONNECTION=database
```

### 4. Converter o Banco MySQL para PostgreSQL

O arquivo `sql/viper.sql` está em formato MySQL. Você tem algumas opções:

#### Opção A: Usar as Migrations do Laravel (Recomendado)

1. As migrations já estão no projeto em `database/migrations/`
2. Execute:
   ```bash
   php artisan migrate
   ```
3. Isso criará todas as tabelas no formato PostgreSQL

#### Opção B: Converter o SQL Manualmente

1. Use uma ferramenta online como:
   - https://www.sqlines.com/online
   - https://github.com/dumblob/mysql2postgresql
2. Ou use o pgloader (ferramenta de linha de comando)

#### Opção C: Importar via Supabase SQL Editor

1. No Supabase, vá em **SQL Editor**
2. Converta manualmente as principais diferenças:
   - `AUTO_INCREMENT` → `SERIAL` ou `GENERATED ALWAYS AS IDENTITY`
   - `ENGINE = MyISAM` → Remover (PostgreSQL não usa)
   - `CHARACTER SET utf8mb4` → Remover ou usar `ENCODING 'UTF8'`
   - `COLLATE utf8mb4_unicode_ci` → Remover ou usar `COLLATE "C"`
   - Tipos `tinyint(4)` → `SMALLINT` ou `BOOLEAN`
   - `timestamp NULL DEFAULT NULL` → `TIMESTAMP NULL`

### 5. Principais Diferenças MySQL → PostgreSQL

| MySQL | PostgreSQL |
|-------|------------|
| `AUTO_INCREMENT` | `SERIAL` ou `GENERATED ALWAYS AS IDENTITY` |
| `TINYINT(1)` | `BOOLEAN` |
| `TINYINT(4)` | `SMALLINT` |
| `ENGINE = InnoDB` | Remover (não aplicável) |
| `ENGINE = MyISAM` | Remover (não aplicável) |
| `CHARACTER SET utf8mb4` | `ENCODING 'UTF8'` |
| `COLLATE utf8mb4_unicode_ci` | `COLLATE "C"` ou remover |
| `UNSIGNED` | Remover (PostgreSQL não tem unsigned) |
| `ON UPDATE CURRENT_TIMESTAMP` | Usar triggers ou lógica na aplicação |

### 6. Testar a Conexão

```bash
php artisan migrate:status
```

Se funcionar, você verá a lista de migrations.

### 7. Executar Migrations e Seeders

```bash
# Executar migrations
php artisan migrate

# Executar seeders (dados iniciais)
php artisan db:seed
```

### 8. Configurar Connection Pooling (Opcional mas Recomendado)

Para melhor performance, use Connection Pooling do Supabase:

1. No Supabase, vá em **Settings** > **Database**
2. Role até **Connection pooling**
3. Use o modo **Session** para Laravel
4. Atualize o `DB_HOST` no `.env`:
   ```env
   DB_HOST=db.xxxxx.supabase.co
   DB_PORT=6543  # Porta do pooler (não 5432)
   ```

## 🔒 Segurança

### Liberar IPs no Supabase

1. No Supabase, vá em **Settings** > **Database**
2. Role até **Network restrictions**
3. Adicione os IPs que precisam acessar:
   - IP do servidor de produção
   - Seu IP de desenvolvimento (se necessário)

### Usar Variáveis de Ambiente

**NUNCA** commite o arquivo `.env` com senhas reais!

Use variáveis de ambiente no servidor de produção.

## 🚀 Para Deploy em Produção

### Railway

1. No painel do Railway, vá em **Variables**
2. Adicione todas as variáveis do `.env`
3. Especialmente:
   - `DB_CONNECTION=pgsql`
   - `DB_HOST=db.xxxxx.supabase.co`
   - `DB_PASSWORD=sua_senha`

### Render

1. No painel do Render, vá em **Environment**
2. Adicione as variáveis de ambiente
3. Configure o mesmo que no Railway

## ✅ Checklist

- [ ] Projeto criado no Supabase
- [ ] Credenciais de conexão obtidas
- [ ] `.env` configurado com credenciais do Supabase
- [ ] Migrations executadas (`php artisan migrate`)
- [ ] Seeders executados (`php artisan db:seed`)
- [ ] Conexão testada
- [ ] IPs liberados no Supabase (se necessário)
- [ ] Variáveis de ambiente configuradas no servidor de produção

## 🆘 Problemas Comuns

### Erro: "could not connect to server"

- Verifique se o `DB_HOST` está correto
- Verifique se o IP está liberado no Supabase
- Verifique se a porta está correta (5432 ou 6543 para pooling)

### Erro: "password authentication failed"

- Verifique se a senha está correta
- Certifique-se de que não há espaços extras no `.env`

### Erro: "relation does not exist"

- Execute as migrations: `php artisan migrate`
- Verifique se está conectado ao banco correto

### Erro de sintaxe SQL

- Algumas queries podem precisar de adaptação
- Verifique se não há sintaxe específica do MySQL

## 📚 Recursos

- [Documentação Supabase](https://supabase.com/docs)
- [PostgreSQL no Laravel](https://laravel.com/docs/10.x/database#postgresql)
- [Conversor MySQL para PostgreSQL](https://www.sqlines.com/online)

