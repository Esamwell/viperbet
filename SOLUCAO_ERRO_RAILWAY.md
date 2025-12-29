# Solução para Erro "No version available for php 8.1" no Railway

## 🔴 Problema

O Railway estava apresentando o erro:
```
X No version available for php 8.1
```

Isso acontece porque o Railway (usando Nixpacks) não conseguiu encontrar ou instalar o PHP 8.1.

## ✅ Solução Aplicada

Foram criados os seguintes arquivos de configuração:

### 1. `nixpacks.toml`
Este arquivo especifica explicitamente a versão do PHP para o Nixpacks usar PHP 8.2 (que é compatível com Laravel 10 e requer PHP ^8.1):

```toml
[phases.setup]
nixPkgs = { php = "php82" }

[phases.install]
cmds = [
  "composer install --no-dev --optimize-autoloader --no-interaction",
  "php artisan key:generate --force || true"
]

[start]
cmd = "php artisan serve --host=0.0.0.0 --port=$PORT"
```

### 2. `.php-version`
Arquivo que especifica a versão do PHP:
```
8.2
```

### 3. `Procfile`
Arquivo para especificar o comando de inicialização:
```
web: php artisan serve --host=0.0.0.0 --port=$PORT
```

### 4. `railway.json`
Configuração específica do Railway:
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

### 5. `composer.json` (atualizado)
Ajustado para aceitar explicitamente PHP 8.1 ou 8.2:
```json
"php": "^8.1|^8.2"
```

## 🚀 Próximos Passos

1. **Faça commit e push dos novos arquivos:**
   ```bash
   git add .
   git commit -m "Adiciona configuração para Railway com PHP 8.2"
   git push
   ```

2. **No Railway:**
   - O Railway deve detectar automaticamente os novos arquivos
   - Se não detectar, force um novo deploy
   - O build deve agora usar PHP 8.2

3. **Verifique as variáveis de ambiente:**
   Certifique-se de que todas as variáveis necessárias estão configuradas no Railway:
   - `APP_KEY` (gere com: `php artisan key:generate`)
   - `APP_URL`
   - `DB_CONNECTION=pgsql`
   - `DB_HOST`, `DB_PORT`, `DB_DATABASE`, `DB_USERNAME`, `DB_PASSWORD`
   - Outras variáveis do `.env`

## 📝 Notas Importantes

- **PHP 8.2 é compatível** com Laravel 10 e requer PHP ^8.1
- O Railway agora usará PHP 8.2 em vez de tentar encontrar PHP 8.1
- Se ainda houver problemas, você pode tentar outras versões no `nixpacks.toml`:
  - `php81` (se disponível)
  - `php83` (versão mais recente)

## 🔍 Se o Problema Persistir

1. **Verifique os logs completos** no Railway para ver outros erros
2. **Tente limpar o cache do build** no Railway
3. **Verifique se todas as extensões PHP necessárias estão disponíveis**
4. **Considere usar um Dockerfile** como alternativa ao Nixpacks

## 📚 Recursos

- [Documentação Nixpacks](https://nixpacks.com/docs)
- [Documentação Railway PHP](https://docs.railway.app/guides/php)
- [Laravel Deployment](https://laravel.com/docs/10.x/deployment)

