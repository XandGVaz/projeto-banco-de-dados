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
""""
    Exibição de menú do programa
"""

""""
    Função para exibição de menú do programa
        Retorna: 
            - response: opção escolhida pelo usuário no menú
"""        
def principal_menu() -> int:

    # Inicializa a variável de resultado
    result = 0
    
    # Exibe o menú principal
    print("=============== Menu do Sistema de Doação de Sangue ==================")
    print("1. Cadastrar Receptor")
    print("2. Consultar locais com estoque de sangue compatível")
    print("3. Sair\n")
    
    # Loop para obter uma entrada válida do usuário
    while(1):
        # Tenta converter a entrada do usuário para um inteiro
        try:
            result = int(input("Escolha uma opção: "))      # Solicita a entrada do usuário
            
            if result < 1 or result > 3:                    # Verifica se a entrada está dentro do intervalo válido
                print("Valor inválido, tente novamente")
                continue
            
            break
        # Trata erros de conversão
        except ValueError:
            print("Valor inválido, tente novamente")        # Solicita nova entrada em caso de erro
            continue

    return result

#=========================================================================================================#
"""
    Registro de receptor
"""

"""
    Função para exibir o formulário de registro de receptor
    Retorna: 
        - form: lista contendo os dados da pessoa receptor
"""
def register_receptor_form() -> list:
    # Inicializa a lista do formulário
    form = []

    # Coleta os dados do formulário
    print("=============== Insira dados do receptor ==================")
    CPF = input("CPF: ")
    RG = input("RG: ")
    UF = input("UF: ")
    Nome = input("Nome completo: ")
    Contato = input("Contato telefônico: ")
    Cidade = input("Cidade: ")
    Bairro = input("Bairro: ")
    Rua = input("Rua: ")
    Numero = input("Número: ")
    Fator_RH = input("Fator RH (+ ou -): ")
    Fator_ABO = input("Fator ABO (A, B, AB ou O): ")
    Fator_Ee = input("Fator Ee (E ou e): ")  
    Fator_Cc = input("Fator Cc (C ou c): ")
    Fator_Kk = input("Fator Kk (K ou k): ")

    # Monta a lista com os dados do formulário
    form = [CPF, RG, UF, Nome, Contato, Cidade, Bairro, Rua, Numero, Fator_RH, Fator_ABO, Fator_Ee, Fator_Cc, Fator_Kk]
    
    return form

# Query para obter o ID da pessoa a partir do CPF
dbGetPessoaIdQuery = """
    SELECT id FROM pessoa WHERE CPF = %s
"""

"""
    Função para obter o ID da pessoa a partir do CPF
    Parametros:
        - connect: conexão com o banco de dados PostgreSQL
        - CPF: CPF da pessoa a ser consultada
    Retorna: 
        - id: ID da pessoa correspondente ao CPF fornecido, ou None se não encontrado
"""
def get_pessoa_id(connect: pg.extensions.connection, CPF: str) -> int | None:
    
    # Inicializa variáveis
    cur = None
    id = None
    
    # Executa a query para obter o ID da pessoa
    try:
        
        cur = connect.cursor()                  # Cria o cursor para executar a query
        cur.execute(dbGetPessoaIdQuery, [CPF])  # Executa a query com o CPF fornecido
        tuple = cur.fetchone()                  # Obtém o resultado da query
        
        if tuple is not None:                   # Verifica se um resultado foi retornado
            id = int(tuple[0])
        
        connect.commit()                        # Confirma a transação

    # Trata erros de execução da query
    except pg.Error as error:                   
        print(f"Erro na query: {error}")
    
    # Fecha o cursor
    finally: 
        if cur is not None:
            cur.close()

    # Retorna o ID da pessoa ou None
    return id

# Query para verificar se o receptor existe
dbQueryVerifyReceptorExists = """
    SELECT 1 FROM receptor WHERE id = %s
"""

"""
    Função para verificar se o receptor existe no banco de dados
    Parametros:
        - connect: conexão com o banco de dados PostgreSQL
        - id: ID do receptor a ser verificado
    Retorna: 
        - result: True se o receptor existir, False se não existir, ou None em caso de erro
"""
def verify_receptor_exists(connect: pg.extensions.connection, id: int) -> bool | None :
    # Inicializa variáveis
    cur = None
    
    # Executa a query para verificar se o receptor existe
    try:
        cur = connect.cursor()                              # Cria o cursor para executar a query
        cur.execute(dbQueryVerifyReceptorExists, [id])      # Executa a query com o ID fornecido
        result = cur.fetchone() is not None                 # Verifica se um resultado foi retornado
        
        connect.commit()                                    # Confirma a transação
        
        return result                                       # Retorna o resultado da verificação        

    # Trata erros de execução da query
    except pg.Error as error:                       
        print(f"Erro na query: {error}")
        return None
    
    # Fecha o cursor
    finally: 
        if cur is not None:
            cur.close()

        
#=========================================================================================================#
# Função principal do script
def main():

    # Estabelece a conexão com banco postgreSQL
    connect = connect_db()

    # Fluxo de interface
    while(1):
        # Exibe o menú principal e obtém a opção escolhida
        command = principal_menu()

        # Executa a ação correspondente à opção escolhida            
        match command:
            case 1:
                continue
            case 2:
                continue
            case 3:
                connect.close()
                sys.exit(1)
                
        



# Ponto de entrada do script
if __name__ == "__main__":
    main()