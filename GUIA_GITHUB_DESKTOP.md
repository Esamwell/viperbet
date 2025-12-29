# Guia: Fazer Push usando GitHub Desktop

## Passo a Passo no GitHub Desktop

### 1. Abrir o GitHub Desktop
- Abra o aplicativo GitHub Desktop no seu computador

### 2. Adicionar o Repositório Local

**Opção A: Se o repositório ainda não está no GitHub Desktop**
1. Clique em **File** → **Add Local Repository**
2. Clique em **Choose...** e navegue até a pasta do projeto:
   ```
   C:\Users\star_\OneDrive\Documentos\GitHub\viper
   ```
3. Se aparecer uma mensagem dizendo que não é um repositório Git, clique em **"create a repository"** ou **"create a new repository"**

**Opção B: Se já está adicionado**
- O repositório aparecerá na lista de repositórios à esquerda

### 3. Inicializar o Repositório (se necessário)
Se o projeto ainda não for um repositório Git:
1. No GitHub Desktop, vá em **File** → **New Repository**
2. Preencha:
   - **Name**: `viperbet` (ou o nome que preferir)
   - **Local Path**: `C:\Users\star_\OneDrive\Documentos\GitHub\viper`
   - **Git ignore**: Selecione **Laravel** (isso vai usar o .gitignore correto)
   - **License**: Opcional
3. Clique em **Create Repository**

### 4. Publicar o Repositório no GitHub
1. No GitHub Desktop, você verá um botão **"Publish repository"** ou **"Publish to GitHub"** no topo
2. Clique nele
3. Configure:
   - **Name**: `viperbet`
   - **Description**: (opcional) "Plataforma de cassino online com Laravel e Filament"
   - **Keep this code private**: Desmarque se quiser público
   - **Organization**: Deixe em branco ou selecione se tiver uma organização
4. Clique em **Publish Repository**

### 5. Se o Repositório Já Existe no GitHub
Se o repositório https://github.com/Esamwell/viperbet.git já existe:

1. No GitHub Desktop, vá em **Repository** → **Repository Settings** (ou clique com botão direito no repositório)
2. Vá na aba **Remote**
3. Verifique se o **Primary remote repository (origin)** está configurado como:
   ```
   https://github.com/Esamwell/viperbet.git
   ```
4. Se não estiver, clique em **Edit** e cole a URL:
   ```
   https://github.com/Esamwell/viperbet.git
   ```
5. Clique em **Save**

### 6. Fazer o Commit e Push

1. **Verificar as alterações**:
   - No GitHub Desktop, você verá todas as alterações na aba **Changes**
   - Os arquivos que devem ser ignorados (como `.env`, `vendor/`, `node_modules/`) não aparecerão (graças ao `.gitignore`)

2. **Adicionar arquivos ao commit**:
   - Marque os arquivos que deseja commitar (ou deixe todos marcados)
   - **Importante**: Certifique-se de que o arquivo `.env` NÃO está marcado (não deve aparecer)

3. **Escrever mensagem do commit**:
   - No campo **Summary**, escreva: `Initial commit - Projeto Viper`
   - (Opcional) Adicione uma descrição no campo **Description**

4. **Fazer o commit**:
   - Clique no botão **Commit to main** (ou **Commit to master**)

5. **Fazer o push**:
   - Após o commit, clique no botão **Push origin** no topo
   - Ou vá em **Repository** → **Push**

### 7. Verificar no GitHub
- Abra o navegador e acesse: https://github.com/Esamwell/viperbet
- Você deve ver todos os arquivos do projeto lá

## Solução de Problemas

### Erro: "Repository not found" ou "Authentication failed"
- Certifique-se de estar logado no GitHub Desktop com a conta correta
- Vá em **File** → **Options** → **Accounts** e verifique sua conta

### Erro: "Remote repository already exists"
- O repositório já existe no GitHub
- Siga o passo 5 acima para configurar o remote corretamente
- Se houver conflitos, você pode precisar fazer um pull primeiro

### Arquivos que não devem ser enviados aparecem
- Verifique se o arquivo `.gitignore` está na raiz do projeto
- Se o `.env` aparecer, você pode removê-lo manualmente do commit desmarcando-o

### Não consigo ver o botão "Publish"
- O repositório já pode estar conectado ao GitHub
- Verifique em **Repository** → **Repository Settings** → **Remote**

## Dica Importante

⚠️ **NUNCA faça commit do arquivo `.env`** - ele contém informações sensíveis como senhas e chaves de API. O `.gitignore` já está configurado para ignorá-lo automaticamente.

## Próximos Passos

Após fazer o push inicial:
- Você pode continuar fazendo commits e pushes pelo GitHub Desktop
- Cada vez que fizer alterações, aparecerão na aba **Changes**
- Basta escrever uma mensagem de commit e clicar em **Commit to main** → **Push origin**


