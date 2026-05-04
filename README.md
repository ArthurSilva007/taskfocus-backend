# 📋 TaskFocus - Sistema de Gestão de Tarefas

> **Um poderoso gerenciador de tarefas com autenticação segura, dashboard inteligente e notificações automáticas**

⚠️ **AVISO DE SEGURANÇA:** Este arquivo contém exemplos de configuração APENAS. Nunca commit credenciais reais em repositórios públicos. Veja `.env.example` para um template seguro.

[![Java 17](https://img.shields.io/badge/Java-17-ED8B00?style=flat-square&logo=java)](https://www.oracle.com/java/)
[![Spring Boot 3.3.1](https://img.shields.io/badge/Spring%20Boot-3.3.1-6DB33F?style=flat-square&logo=spring-boot)](https://spring.io/projects/spring-boot)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Latest-336791?style=flat-square&logo=postgresql)](https://www.postgresql.org/)
[![Maven](https://img.shields.io/badge/Maven-4.0.0-C71A36?style=flat-square&logo=apache-maven)](https://maven.apache.org/)

## 📐 Arquitetura do Projeto

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         CLIENT (Frontend)                               │
│              (React/Angular/Vue + TypeScript/JavaScript)                │
│                      Port: 3000 / 4200                                  │
└────────────────────────┬──────────────────────────────────────────────┘
                         │ HTTP/REST + JWT Token
                         │
┌────────────────────────▼──────────────────────────────────────────────┐
│                  API Gateway & CORS Filter                            │
│                     TaskFocus Backend                                  │
│                Port: 8085 (dev) | $PORT (prod)                        │
└────────────────────────┬──────────────────────────────────────────────┘
                         │
        ┌────────────────┼────────────────┐
        │                │                │
┌───────▼──────┐ ┌──────▼────────┐ ┌─────▼──────────┐
│ AuthModule   │ │ TaskModule    │ │ DashboardMdl   │
│ - Register   │ │ - CRUD Ops    │ │ - Statistics   │
│ - Login      │ │ - Filtering   │ │ - Charts       │
│ - JWT Token  │ │ - Sorting     │ │ - Insights     │
│ - Validation │ │ - Validation  │ │ - Analytics    │
└───────┬──────┘ └──────┬────────┘ └─────┬──────────┘
        │                │                │
        └────────────────┼────────────────┘
                         │
        ┌────────────────┼────────────────┐
        │                │                │
┌───────▼──────┐ ┌──────▼────────┐ ┌─────▼──────────┐
│ Controllers  │ │ Services      │ │ Repositories   │
│ - Auth Ctrl  │ │ - AuthService │ │ - TaskRepository
│ - Task Ctrl  │ │ - TaskService │ │ - UserReposty
│ - Dashboard  │ │ - DashboardSvc│ │ (JPA)          │
│   Ctrl       │ │ - EmailSvc    │ │                │
└───────────────┘ └──────┬────────┘ └─────┬──────────┘
                         │                │
        ┌────────────────┼────────────────┐
        │                │                │
┌───────▼───────────────────────────────────────────────────────┐
│                    JPA/Hibernate ORM                          │
│         Automatic SQL Generation & Entity Mapping             │
└───────┬───────────────────────────────────────────────────────┘
        │
┌───────▼──────────────────────────────────┐
│    PostgreSQL Database                   │
│  ┌──────────────┐  ┌────────────────┐   │
│  │  users       │  │  tasks         │   │
│  ├──────────────┤  ├────────────────┤   │
│  │ id (PK)      │  │ id (PK)        │   │
│  │ email (UQ)   │  │ user_id (FK)   │   │
│  │ password     │  │ title          │   │
│  │ firstname    │  │ description    │   │
│  │ lastname     │  │ status (ENUM)  │   │
│  │ role (ENUM)  │  │ priority (ENUM)│   │
│  │ created_at   │  │ due_date       │   │
│  └──────────────┘  │ value          │   │
│                    │ currency       │   │
│                    └────────────────┘   │
└────────────────────────────────────────┘


┌─────────────────────────────────────────────────────────────────────┐
│                    Cross-Cutting Concerns                            │
├─────────────────────────────────────────────────────────────────────┤
│ • JWT Security Filter → Token Validation & User Context             │
│ • Exception Handling → Centralized Error Responses                  │
│ • Request/Response Logging → Audit Trail                            │
│ • Email Service → MailerSend Integration                            │
│ • Task Scheduler → Quartz Cron Jobs (Notifications)                 │
│ • Actuator Endpoints → /actuator/health, /actuator/info             │
└─────────────────────────────────────────────────────────────────────┘
```

---

## 🚀 Começando Rápido

### Pré-requisitos

- **Java 17+** ([Download](https://www.oracle.com/java/technologies/downloads/#java17))
- **Maven 3.8+** ([Download](https://maven.apache.org/download.cgi))
- **PostgreSQL 12+** ([Download](https://www.postgresql.org/download/))


## 🔧 Estrutura de Pacotes

```
src/main/java/Gestaodetarefa/demo/
├── TaskfocusApplication.java           # Entry point da aplicação
├── auth/                               # Autenticação & Autorização
│   ├── AuthController.java             # Endpoints: /auth/register, /auth/login
│   ├── AuthenticationService.java      # Lógica de autenticação
│   ├── AuthenticationRequest.java      # DTO para login
│   ├── AuthenticationResponse.java     # DTO para resposta com JWT
│   └── RegisterRequest.java            # DTO para registro
├── config/                             # Configurações Spring
│   ├── security/
│   │   └── SecurityConfig.java         # Configuração de segurança
│   └── filter/
│       └── JwtAuthenticationFilter.java# Interceptor para validar JWT
├── model/                              # Entidades JPA
│   ├── Task.java                       # Entidade Task
│   ├── Status.java                     # Enum: PENDING, IN_PROGRESS, COMPLETED
│   ├── Priority.java                   # Enum: LOW, MEDIUM, HIGH, URGENT
│   ├── ChartDataDTO.java               # DTO para gráficos
│   └── DashboardStatsDTO.java          # DTO para estatísticas
├── repository/                         # Data Access Layer (JPA)
│   └── TaskRepository.java             # Queries customizadas para tarefas
├── service/                            # Business Logic Layer
│   ├── TaskService.java                # Lógica de negócio para tarefas
│   ├── DashboardService.java           # Cálculo de estatísticas/dashboards
│   └── AuthenticationService.java      # Lógica de autenticação
├── scheduler/                          # Processamento assíncrono
│   └── TaskNotificationScheduler.java  # Notificações via Quartz
├── Jwt/                                # Geração e validação JWT
│   └── JwtService.java                 # Operações com tokens JWT
├── TaskController/                     # REST Endpoints
│   ├── TaskController.java             # CRUD de tarefas
│   └── DashboardController.java        # Endpoints de dashboard
├── User/                               # Usuários & Roles
│   ├── User.java                       # Entidade User (implementa UserDetails)
│   ├── Role.java                       # Enum: USER, ADMIN
│   ├── UserRepository.java             # Queries customizadas para usuários
│   └── UserDetailsServiceImpl.java      # Spring Security User Service
└── email/                              # Notificações por Email
    └── EMAILSERVICE/
        └── EmailService.java           # Integração MailerSend
```

---

## 📚 Endpoints Principais da API

### 🔐 Autenticação

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| `POST` | `/api/auth/register` | Registrar novo usuário |
| `POST` | `/api/auth/login` | Login (retorna JWT Token) |
| `POST` | `/api/auth/refresh` | Renovar token JWT |

**Exemplo de Login:**
```bash
curl -X POST http://localhost:8085/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user@example.com",
    "password": "senha123"
  }'
```

**Resposta:**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "type": "Bearer",
  "expiresIn": 86400000
}
```

### 📋 Tarefas

| Método | Endpoint | Descrição | Auth |
|--------|----------|-----------|------|
| `GET` | `/api/tasks` | Listar todas as tarefas do usuário | ✅ |
| `GET` | `/api/tasks/{id}` | Obter detalhes de uma tarefa | ✅ |
| `POST` | `/api/tasks` | Criar nova tarefa | ✅ |
| `PUT` | `/api/tasks/{id}` | Atualizar uma tarefa | ✅ |
| `DELETE` | `/api/tasks/{id}` | Deletar uma tarefa | ✅ |
| `GET` | `/api/tasks/status/{status}` | Filtrar por status | ✅ |
| `GET` | `/api/tasks/priority/{priority}` | Filtrar por prioridade | ✅ |

taskfocus-backend/
├── README.md                  ✅ Documentação essencial
├── DEPLOYMENT_RAILWAY.md      ✅ Guia de deploy
└── demo/
├── pom.xml               ✅ Maven config
├── .env.example          ✅ Template env seguro
├── .gitignore            ✅ Git config
├── mvnw / mvnw.cmd       ✅ Maven wrapper
├── src/                  ✅ Código
│   ├── main/java/Gestaodetarefa/demo/
│   │   ├── auth/
│   │   ├── controller/
│   │   ├── service/
│   │   ├── repository/
│   │   ├── model/
│   │   ├── config/
│   │   ├── scheduler/
│   │   └── email/
│   └── resources/
└── target/               ✅ Compilado