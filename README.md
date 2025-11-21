# 📌 Sistema de Doação de Sangue

## 📍 Descrição


Repositório com artefatos e código para o projeto "Sistema de Doação de Sangue" — um esquema de banco de dados e um pequeno aplicativo demonstrativo.

## 📍 Estrutura do projeto 

```bash
projeto-banco-de-dados/
├── Application
│   └── app.py
├── Docs
│   ├── Relatorio_Base_de_Dados.pdf
│   ├── Sangue_MER.drawio
│   ├── Sangue_MER.jpg
│   ├── Sangue_Relacional.drawio
│   └── Sangue_Relacional.jpg
├── SQL
│   ├── consultas.sql
│   ├── dados.sql
│   ├── drop.sql
│   └── esquema.sql
├── .gitignore
└── README.md
```

Breve explicação dos diretórios:
- `Application/` : código do aplicativo (ex.: scripts para demonstrar o uso do banco de dados).
- `Docs/` : diagramas (MER e modelo relacional) em formato draw.io.
- `SQL/` : scripts SQL com o esquema, inserção de dados e operações.

Observações:
- Os arquivos `.drawio` contêm os diagramas (MER e modelo relacional).

## 📍 Como rodar aplicação no linux

1. Clonar repositório e ir para pasta `Application`
   ```bash
   git clone https://github.com/XandGVaz/projeto-banco-de-dados.git
   cd projeto-banco-de-dados/Application
   ```

2. Criar e ativar um ambiente virtual
   ```bash
   python3 -m venv .venv
   source .venv/bin/activate
   ```

3. Instalar dependências

     ```bash
     pip install python-dotenv 
     ```
     ```bash
     pip install python-dotenv psycopg2-binary
     ```
   Ajuste conforme o driver que o seu código importa.

4. Criar o arquivo .env
   - Coloque o `.env` na pasta `Application/` (ou carregue as variáveis no ambiente).
   - Exemplo de `.env`:
     ```
     DB_HOST=localhost
     DB_PORT=5432
     DB_DATABASE=seu_banco
     DB_USER=seu_usuario
     DB_PASSWORD=sua_senha
     ```
   - Não versionar `.env`.

5. Preparar o banco (opcional)
   - Crie o banco e rode o esquema SQL se necessário:
     ```bash
     psql -h $DB_HOST -U $DB_USER -d $DB_DATABASE -f SQL/esquema.sql
     ```

6. Executar a aplicação
   ```bash
   source .venv/bin/activate
   python3 app.py
   ```

Observações:
- Certifique-se de que o servidor PostgreSQL está rodando e que as credenciais em `.env` estão corretas.
- Use `python-dotenv` (load_dotenv) no código para carregar as variáveis do `.env`. Se preferir, exporte variáveis diretamente no shell.

