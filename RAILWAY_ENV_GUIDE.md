# 🚀 COMO USAR `.env.production` NO RAILWAY

## Opção 1: Usar Railway CLI (Recomendado)

### Passo 1: Instalar Railway CLI
```bash
npm install -g @railway/cli
```

### Passo 2: Fazer login no Railway
```bash
railway login
```

### Passo 3: Lincar seu projeto
```bash
cd D:\taskfocus-beckend
railway link
```

### Passo 4: Fazer upload das variáveis
```bash
# Isso vai fazer upload de TODAS as variáveis do `.env.production`
cat .env.production | railway variables set
```

Ou, linha por linha:
```bash
railway variables set --file .env.production
```

---

## Opção 2: Configurar Manualmente no Painel do Railway

1. Abra o painel do Railway
2. Clique no seu projeto
3. Vá em **Environment** ou **Variables**
4. Clique em **Add Variable**
5. Copie cada linha do `.env.production` e cole manualmente

---

## Opção 3: Usar Railway CLI com configuração individual

```bash
# Exemplo: configurar JWT_SECRET
railway variables set JWT_SECRET="sua-chave-segura-aqui"

# Exemplo: configurar SPRING_DATASOURCE_URL
railway variables set SPRING_DATASOURCE_URL="jdbc:postgresql://..."
```

---

## ✅ Após configurar

1. Dê um push para GitHub:
```bash
git add .
git commit -m "feat: add production environment configuration"
git push origin main
```

2. Railway vai fazer build e deploy automático

3. Verifique os logs:
```bash
railway logs
```

4. Teste se a API está up:
```bash
curl https://seu-app.railway.app/actuator/health
```

---

## ⚠️ Importante

- **Nunca** faça commit do `.env.production` com valores reais no Git
- Use `.env.production` apenas como **referência local** ou **upload via CLI**
- Adicione `.env.production` ao `.gitignore` se tiver valores reais:

```bash
echo ".env.production" >> .gitignore
```

---

## 🔒 Dados sensíveis a substituir

Antes de fazer upload, edite `.env.production` e substitua:

```env
# ANTES (placeholder)
SPRING_DATASOURCE_PASSWORD=sua_senha_do_railway_aqui
JWT_SECRET=substitua_por_uma_chave_gerada_com_openssl_crypto_segura
CORS_ALLOWED_ORIGINS=https://seu-frontend.com,...

# DEPOIS (valores reais)
SPRING_DATASOURCE_PASSWORD=minha_senha_real_segura_123!@#
JWT_SECRET=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
CORS_ALLOWED_ORIGINS=https://meu-app-real.com,https://admin.meu-app.com
```

---

## Troubleshooting

### Railway CLI não conecta?
```bash
railway login --force
railway link --force
```

### Variáveis não aparecem no painel?
Aguarde 5-10 segundos e atualize a página.

### Deploy não pegou as variáveis?
Faça um trigger de novo build:
```bash
railway redeploy
```

---

**Pronto! Agora você pode usar `.env.production` para fazer upload rápido de todas as variáveis.**

