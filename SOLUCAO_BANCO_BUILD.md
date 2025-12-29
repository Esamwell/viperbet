# Solução para Erro de Conexão com Banco Durante o Build

## 🔴 Problema

O build estava falhando porque o Laravel tentava conectar ao banco de dados MySQL durante o processo de descoberta de pacotes (`package:discover`):

```
SQLSTATE[HY000] [2002] Connection refused (Connection: mysql, SQL: select table_name...
```

Isso acontece porque:
1. O script `post-autoload-dump` no `composer.json` executa `php artisan package:discover`
2. Alguns pacotes (como Filament) tentam acessar o banco durante a descoberta
3. Durante o build, o banco de dados ainda não está disponível

## ✅ Solução Aplicada

Modificamos o `nixpacks.toml` para:

1. **Usar `--no-scripts` no composer**: Isso evita que os scripts do composer executem automaticamente
2. **Configurar SQLite em memória**: Define variáveis de ambiente para usar SQLite durante o build
3. **Executar comandos manualmente**: Executamos `package:discover` manualmente com `|| true` para ignorar erros

```toml
[variables]
APP_ENV = "production"
DB_CONNECTION = "sqlite"
DB_DATABASE = ":memory:"

[phases.install]
cmds = [
  "composer install --no-dev --optimize-autoloader --no-interaction --no-scripts",
  "php artisan package:discover --ansi || true",
  "php artisan key:generate --force || true"
]
```

## 📝 Explicação

- `--no-scripts`: Evita que os scripts do `composer.json` executem automaticamente
- `DB_CONNECTION = "sqlite"`: Usa SQLite em vez de MySQL durante o build
- `DB_DATABASE = ":memory:"`: Usa banco em memória (não precisa de arquivo)
- `|| true`: Garante que o comando não falhe o build mesmo se houver erro

## 🚀 Próximos Passos

1. **Faça commit e push:**
   ```bash
   git add .
   git commit -m "Fix: Evita conexão com banco durante build"
   git push
   ```

2. **No Railway:**
   - O build deve agora completar sem tentar conectar ao banco
   - As variáveis de ambiente do Railway (com as credenciais reais do banco) serão usadas em runtime

## ⚠️ Nota Importante

As variáveis de ambiente definidas no `nixpacks.toml` são apenas para o **build**. Em **runtime**, o Railway usará as variáveis de ambiente configuradas no painel, que devem ter as credenciais corretas do Supabase/PostgreSQL.

## 🔍 Se Ainda Houver Problemas

Se o `package:discover` ainda causar problemas, você pode:

1. **Remover completamente a descoberta de pacotes durante o build:**
   ```toml
   [phases.install]
   cmds = [
     "composer install --no-dev --optimize-autoloader --no-interaction --no-scripts",
     "php artisan key:generate --force || true"
   ]
   ```

2. **Ou modificar o composer.json** para não executar package:discover automaticamente (não recomendado, pois pode afetar o desenvolvimento local)

