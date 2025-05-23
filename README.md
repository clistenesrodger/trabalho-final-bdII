
---

## 📘 Documentação - Ambiente com PostgreSQL e pgAdmin via Docker Compose

Este projeto configura um ambiente de banco de dados com **PostgreSQL** e a interface gráfica **pgAdmin 4** usando Docker Compose.

---

### 📁 Estrutura do Projeto
```
/seu-projeto
│
├── docker-compose.yml
├── README.md
└── init-db/
    ├── 01-init.sql
    └── 2019-Oct.csv
```

---

### 🚀 Como executar o projeto

1. **Pré-requisitos**:

   * Docker: [https://www.docker.com/get-started](https://www.docker.com/get-started)
   * Docker Compose (geralmente incluso no Docker Desktop)

2. **Clone este repositório ou crie os arquivos** em sua máquina:

```bash
git clone https://github.com/seu-usuario/seu-projeto.git
cd seu-projeto
```

3. **Suba os containers com o Docker Compose:**

```bash
docker-compose up -d 
```

---

### 🧰 Serviços disponíveis

#### 🔸 PostgreSQL

* **Imagem**: `postgres:15`
* **Porta exposta**: `5433`
* **Usuário padrão**: `admin`
* **Senha padrão**: `admin123`
* **Banco criado**: `meu_banco`

Você pode acessar o banco de dados com qualquer cliente PostgreSQL como DBeaver, DataGrip, ou linha de comando:

```bash
psql -h localhost -p 5432 -U admin -d meu_banco
```

---

#### 🔸 pgAdmin 4

* **Imagem**: `dpage/pgadmin4`
* **Porta exposta**: `5050`
* **Acesso via navegador**: [http://localhost:5050](http://localhost:5050)
* **E-mail padrão**: `admin@admin.com`
* **Senha padrão**: `admin123`

##### ▶️ Adicionando o servidor PostgreSQL no pgAdmin

1. Vá para **[http://localhost:5050](http://localhost:5050)** e entre com o e-mail e senha.
2. Clique com o botão direito em **Servers > Create > Server**.
3. Aba **General**:

   * **Name**: `PostgreSQL local`
4. Aba **Connection**:

   * **Host name/address**: `db` (nome do serviço Docker)
   * **Port**: `5433`
   * **Username**: `admin`
   * **Password**: `admin123`
   * Marque a opção “Save Password”

Clique em **Save** para conectar.

---

### 🗑️ Como parar e remover os containers

Para parar:

```bash
docker-compose down
```

Para parar e remover volumes persistentes:

```bash
docker-compose down -v
```

---

### 📦 Volumes persistentes

Os dados do banco e configurações do pgAdmin são armazenados em volumes Docker:

* `postgres_data`: dados do PostgreSQL
* `pgadmin_data`: dados de configuração do pgAdmin

---

### 🧾 Credenciais Padrão

| Serviço    | Host      | Porta | Usuário           | Senha      |
| ---------- | --------- | ----- | ----------------- | ---------- |
| PostgreSQL | localhost | 5433  | `admin`           | `admin123` |
| pgAdmin    | localhost | 5050  | `admin@admin.com` | `admin123` |

---

### 📂 Sobre a pasta `init-db/`

A pasta `init-db/` é utilizada para **automatizar a criação e o carregamento inicial do banco de dados PostgreSQL** dentro do container.

Ela é montada no container PostgreSQL no caminho especial:

```
/docker-entrypoint-initdb.d/
```

#### 🔧 O que acontece?

Durante a **primeira inicialização** do container, o PostgreSQL executa automaticamente **todos os arquivos `.sql` ou `.sh`** presentes nesse diretório, **na ordem alfabética**.

No seu caso:

* **`01-init.sql`**: contém comandos SQL para:

  * Criar a tabela `eventos`
  * Realizar o `COPY` para importar os dados do arquivo `2019-Oct.csv`

* **`2019-Oct.csv`**: é o arquivo de dados usado no comando `COPY`, e deve estar na mesma pasta para que o PostgreSQL consiga acessá-lo.

> 📌 Importante: o script `01-init.sql` deve utilizar um caminho relativo ao container para acessar o CSV, como:

```sql
COPY eventos FROM '/docker-entrypoint-initdb.d/2019-Oct.csv' DELIMITER ',' CSV HEADER;
```

---


🔗 **Dataset utilizado**:  
[E-commerce Behavior Data from Multi Category Store – Kaggle](https://www.kaggle.com/datasets/mkechinov/ecommerce-behavior-data-from-multi-category-store)
