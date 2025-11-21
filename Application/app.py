"""
    Programa python referente à aplicação utilizando banco de dados do sistema de 
    doaçao de sangue (Grupo 06)
    Autores:
        - Danielle Pereira - 11918539
        - Gabriel Dezejácomo Maruschi - 14571525
        - Pedro Gasparelo Leme - 14602421
        - Vitor Alexandre Garcia Vaz - 14611432
"""

#=========================================================================================================#
# Importa as bibliotecas necessárias
import psycopg2 as pg               # Biblioteca para conectar ao PostgreSQL
import dotenv                       # Biblioteca para carregar variáveis de ambiente
import os                           # Biblioteca para interagir com o sistema operacional
import sys                          # Biblioteca para manipular o sistema Python

#=========================================================================================================#
""""
    Conexão com banco de dados usando variáveis de ambiente
        - Variáveis definidas no arquivo .env
        - OBS: Certifique-se de ter o arquivo .env na pasta Application do projeto com as 
        variáveis corretas
"""

"""
Função para conectar ao banco de dados PostgreSQL usando os parâmetros definidos.
    Retorna:
        - connection : conexão ao banco de dados PostgreSQL.
"""
def connect_db() -> pg.extensions.connection:
    
    # Carrega as variáveis de ambiente do arquivo .env
    dotenv.load_dotenv()

    # Define os parâmetros de conexão usando as variáveis de ambiente
    db_params = {
        "database": os.getenv("DB_DATABASE", "projeto-banco-de-dados"),
        "user":     os.getenv("DB_USER", "postgres"),
        "password": os.getenv("DB_PASSWORD", "postgres"),
        "host":     os.getenv("DB_HOST", "localhost"),
        "port":     int(os.getenv("DB_PORT", "5432"))
    }

    # Tenta conectar ao banco de dados
    try:
        connection = pg.connect(**db_params)  # Estabelece a conexão
        return connection                     # Retorna a conexão estabelecida

    # Trata erros de conexão
    except (Exception, pg.Error) as error:
        print(f"Erro ao conectar ao PostgreSQL: {error}")   # Exibe o erro
        sys.exit(1)                                         # Sai do programa com código de erro        

#=========================================================================================================#
# Função principal do script
def main():

    # Estabelece a conexão com banco postgreSQL
    connect = connect_db()



# Ponto de entrada do script
if "__name__" == "__main__":
    main()