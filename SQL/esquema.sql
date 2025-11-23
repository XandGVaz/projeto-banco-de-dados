/*
        Esquema SQL referente ao banco de dados do sistema de doaçao de sangue (Grupo 06)
        Autores:
               - Danielle Pereira - 11918539
               - Gabriel Dezejácomo Maruschi - 14571525
               - Pedro Gasparelo Leme - 14602421
               - Vitor Alexandre Garcia Vaz - 14611432
*/

-- Criacao da tabela "Local"
CREATE TABLE IF NOT EXISTS local (
	id		SERIAL		NOT NULL,
	cnpj_placa	VARCHAR(14)	NOT NULL,
	cidade		VARCHAR(40),
	bairro		VARCHAR(40),
	rua		VARCHAR(40),
	numero		INT,
	capacidade	BIGINT,	
	tipo		VARCHAR(10)	NOT NULL,
	CONSTRAINT	pk_local	PRIMARY KEY(id),
	CONSTRAINT	sk_local	UNIQUE(cnpj_placa),
        CONSTRAINT      cnpj_placa_len  CHECK( (LENGTH(cnpj_placa) = 7 AND tipo = 'AMBULANCIA') OR ( LENGTH(cnpj_placa) = 14 AND tipo != 'AMBULANCIA') ),
        CONSTRAINT      ck_tipo         CHECK(tipo IN('HEMONUCLEO', 'HOSPITAL', 'AMBULANCIA')),
        CONSTRAINT      ck_numero       CHECK(numero >= 0)   
      
);

-- Criacao da tabela "Hemonucleo"
CREATE TABLE IF NOT EXISTS hemonucleo (
	id		INT			NOT NULL,
	CONSTRAINT 	pk_hemonucleo		PRIMARY KEY(id),
	CONSTRAINT 	fk_hemonucleo_local	FOREIGN KEY(id) REFERENCES local(id) ON DELETE CASCADE
);

-- Criacao da tabela "Hospital"
CREATE TABLE IF NOT EXISTS hospital (
	id		INT			NOT NULL,
	CONSTRAINT 	pk_hospital		PRIMARY KEY(id),
	CONSTRAINT 	fk_hospital_local	FOREIGN KEY(id) REFERENCES local(id) ON DELETE CASCADE
);

-- Criacao da tabela "Ambulancia"
CREATE TABLE IF NOT EXISTS ambulancia (
	id		INT			NOT NULL,
	crv		CHAR(11)		NOT NULL,
	sede		VARCHAR(40),
        modelo          VARCHAR(40),			
	CONSTRAINT 	pk_ambulancia		PRIMARY KEY(id),
	CONSTRAINT 	sk_ambulancia		UNIQUE(crv),
	CONSTRAINT 	fk_ambulancia_local	FOREIGN KEY(id) REFERENCES local(id) ON DELETE CASCADE
);

-- Criacao da tabela "Inventario"
CREATE TABLE IF NOT EXISTS inventario (
	local		INT			NOT NULL,
	fator_rh	CHAR(1)			NOT NULL,
	fator_abo	VARCHAR(2)		NOT NULL, 
	fator_ee	CHAR(1)		    	NOT NULL,
	fator_cc	CHAR(1)		    	NOT NULL, 
	fator_kk	CHAR(1)		    	NOT NULL, 
	estoque		INT			NOT NULL,
	CONSTRAINT      pk_inventario		PRIMARY KEY(local, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk),
	CONSTRAINT 	fk_inventario_local	FOREIGN KEY(local) REFERENCES local(id) ON DELETE CASCADE,
        CONSTRAINT      ck_fator_rh             CHECK(fator_rh IN ('+','-')),
        CONSTRAINT      ck_fator_abo            CHECK(fator_abo IN ('AB', 'A', 'B', 'O')),
        CONSTRAINT      ck_fator_ee             CHECK(fator_ee IN ('E', 'e')),
        CONSTRAINT      ck_fator_cc             CHECK(fator_cc IN ('C', 'c')),
        CONSTRAINT      ck_fator_kk             CHECK(fator_kk IN ('K', 'k')),
        CONSTRAINT      ck_estoque              CHECK(estoque >= 0)
);

-- Criacao da tabela "Transferencia"
CREATE TABLE IF NOT EXISTS transferencia (
	id		BIGSERIAL	        NOT NULL,
	local_origem	INT			NOT NULL,
	local_destino	INT			NOT NULL,
	data		TIMESTAMP		NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT	pk_transferencia	PRIMARY KEY(id),
        CONSTRAINT      sk_transferencia        UNIQUE(id, local_origem, local_destino),
	CONSTRAINT 	fk_local_origem		FOREIGN KEY(local_origem) REFERENCES local(id) ON DELETE CASCADE,
	CONSTRAINT 	fk_local_destino	FOREIGN KEY(local_destino) REFERENCES local(id) ON DELETE CASCADE
);

-- Criacao da tabela "Nro_Bolsas"
CREATE TABLE IF NOT EXISTS nro_bolsas (
        transferencia   INT                     NOT NULL,
        fator_rh        CHAR(1)                 NOT NULL,
        fator_abo       VARCHAR(2)              NOT NULL,
        fator_ee        CHAR(1)                 NOT NULL,
        fator_cc        CHAR(1)                 NOT NULL,
        fator_kk        CHAR(1)                 NOT NULL,
        quantidade      INT                     NOT NULL,
        CONSTRAINT      pk_nro_bolsas           PRIMARY KEY(transferencia, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk),
        CONSTRAINT      fk_nro_bolsas_transf    FOREIGN KEY(transferencia) REFERENCES transferencia(id) ON DELETE CASCADE,                       
        CONSTRAINT      ck_fator_rh             CHECK(fator_rh IN ('+','-')),
        CONSTRAINT      ck_fator_abo            CHECK(fator_abo IN ('AB', 'A', 'B', 'O')),
        CONSTRAINT      ck_fator_ee             CHECK(fator_ee IN ('E', 'e')),
        CONSTRAINT      ck_fator_cc             CHECK(fator_cc IN ('C', 'c')),
        CONSTRAINT      ck_fator_kk             CHECK(fator_kk IN ('K', 'k')),
        CONSTRAINT      ck_quantidade           CHECK(quantidade >= 0)
);

-- Criacao da tabela "Pessoa"
CREATE TABLE IF NOT EXISTS pessoa (
        id	        BIGSERIAL 	NOT NULL,	
	cpf		CHAR(11)	NOT NULL,
	rg	        VARCHAR(8)	NOT NULL,
        uf              CHAR(2)         NOT NULL,
        nome            VARCHAR(40)     NOT NULL,
	contato 	VARCHAR(11),
	cidade 		VARCHAR(40),		
	bairro		VARCHAR(40),		
	rua		VARCHAR(40),					
	numero		INT,
	fator_rh	CHAR(1)		NOT NULL,
	fator_abo	VARCHAR(2)	NOT NULL,
	fator_ee	CHAR(1)	        NOT NULL,
	fator_cc	CHAR(1)	        NOT NULL,
	fator_kk	CHAR(1)	        NOT NULL,
	CONSTRAINT 	pk_pessoa	PRIMARY KEY(ID),
	CONSTRAINT 	sk_pessoa 	UNIQUE(cpf),
	CONSTRAINT	tk_pessoa       UNIQUE(rg, uf),
        CONSTRAINT      ck_numero       CHECK (numero >= 0),
        CONSTRAINT      ck_fator_rh     CHECK(fator_rh IN ('+','-')),
        CONSTRAINT      ck_fator_abo    CHECK(fator_abo IN ('AB', 'A', 'B', 'O')),
        CONSTRAINT      ck_fator_ee     CHECK(fator_ee IN ('E', 'e')),
        CONSTRAINT      ck_fator_cc     CHECK(fator_cc IN ('C', 'c')),
        CONSTRAINT      ck_fator_kk     CHECK(fator_kk IN ('K', 'k'))
);

-- Criacao da tabela "Profissional"
CREATE TABLE IF NOT EXISTS profissional (
	id		BIGINT		        NOT NULL,
	local		INT			NOT NULL,
	CONSTRAINT	pk_profissional		PRIMARY KEY(id),
	CONSTRAINT 	fk_profissional_pessoa	FOREIGN KEY(id) REFERENCES pessoa(id) ON DELETE CASCADE,
	CONSTRAINT 	fk_profissional_local	FOREIGN KEY(local) REFERENCES local(id) ON DELETE CASCADE
);

-- Criacao da tabela "Doador"
CREATE TABLE IF NOT EXISTS doador (
	id		BIGINT			NOT NULL,
	ultima_doacao	TIMESTAMP,
	peso		INT,				 
	CONSTRAINT	pk_doador		PRIMARY KEY(id),
	CONSTRAINT 	fk_doador_pessoa	FOREIGN KEY(id) REFERENCES pessoa(id) ON DELETE CASCADE
);

-- Criacao da tabela "Receptor"
CREATE TABLE IF NOT EXISTS receptor (
	id		BIGINT			NOT NULL,
	CONSTRAINT	pk_receptor		PRIMARY KEY(id),
	CONSTRAINT 	fk_receptor_pessoa	FOREIGN KEY(id) REFERENCES pessoa(id) ON DELETE CASCADE
);

-- Criacao da tabela "Doacao"
CREATE TABLE IF NOT EXISTS doacao (
	id		BIGSERIAL		NOT NULL,
	doador		BIGINT			NOT NULL,
	hemonucleo	INT			NOT NULL,
	data		TIMESTAMP		NOT NULL DEFAULT CURRENT_TIMESTAMP,
	profissional	BIGINT			NOT NULL,
	CONSTRAINT 	pk_doacao		PRIMARY KEY(id),
	CONSTRAINT	sk_doacao		UNIQUE(doador, hemonucleo, data), 
	CONSTRAINT	fk_doacao_doador	FOREIGN KEY(doador) REFERENCES doador(id) ON DELETE CASCADE,
	CONSTRAINT	fk_doacao_hemonucleo	FOREIGN KEY(hemonucleo) REFERENCES hemonucleo(id) ON DELETE CASCADE,
	CONSTRAINT	fk_doacao_profissional	FOREIGN KEY(profissional) REFERENCES profissional(id) ON DELETE CASCADE
);

-- Criacao da tabela "Solicitacao"
CREATE TABLE IF NOT EXISTS solicitacao (
	id		BIGSERIAL		        NOT NULL,
	hospital	INT				NOT NULL,
	receptor	BIGINT				NOT NULL,
	data		TIMESTAMP			NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT	pk_solicitacao			PRIMARY KEY(id),
	CONSTRAINT 	sk_solicitacao			UNIQUE(hospital, receptor, data),
	CONSTRAINT	fk_solicitacao_hospital		FOREIGN KEY(hospital) REFERENCES hospital(id) ON DELETE CASCADE,
	CONSTRAINT	fk_solicitacao_receptor		FOREIGN KEY(receptor) REFERENCES receptor(id) ON DELETE CASCADE
);

-- Criacao da tabela "Socorrimento"
CREATE TABLE IF NOT EXISTS socorrimento (
	id		BIGSERIAL		        NOT NULL,
	ambulancia	INT				NOT NULL,
	receptor	BIGINT				NOT NULL,
	data		TIMESTAMP			NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT	pk_socorrimento		        PRIMARY KEY(id),
	CONSTRAINT 	sk_socorrimento			UNIQUE(ambulancia, receptor, data),
	CONSTRAINT	fk_socorrimento_ambulancia	FOREIGN KEY(ambulancia) REFERENCES ambulancia(id) ON DELETE CASCADE,
	CONSTRAINT	fk_socorrimento_receptor	FOREIGN KEY(receptor) REFERENCES receptor(id) ON DELETE CASCADE
);

-- Criacao da tabela "Bolsa_de_sangue"
CREATE TABLE IF NOT EXISTS bolsa_de_sangue (
	doacao			BIGINT		        NOT NULL,
	numero			INT			NOT NULL,
	volueme_real	        INT		        NOT NULL,
	local_atual		INT			NOT NULL,
	fator_rh		CHAR(1)			NOT NULL,
	fator_abo		VARCHAR(2)              NOT NULL,
	fator_ee		CHAR(1)		    	NOT NULL,
	fator_cc		CHAR(1)		    	NOT NULL,
	fator_kk		CHAR(1)		    	NOT NULL,
	solicitacao		BIGINT,				
	socorrimento	        BIGINT,
	CONSTRAINT		pk_bolsa_de_sangue 	PRIMARY KEY(doacao, numero),
	CONSTRAINT		fk_bolsa_doacao	        FOREIGN KEY(doacao) REFERENCES doacao(id) ON DELETE CASCADE,
	CONSTRAINT		fk_bolsa_solicitacao    FOREIGN KEY(solicitacao) REFERENCES solicitacao(id) ON DELETE CASCADE,
	CONSTRAINT		fk_bolsa_socorrimento   FOREIGN KEY(socorrimento) REFERENCES socorrimento(id) ON DELETE CASCADE,
        CONSTRAINT              ck_numero               CHECK(numero >= 1 AND numero <= 4),
        CONSTRAINT              ck_vlume_real           CHECK(volueme_real >= 1 AND volueme_real <= 450),
        CONSTRAINT              ck_fator_rh             CHECK(fator_rh IN ('+','-')),
        CONSTRAINT              ck_fator_abo            CHECK(fator_abo IN ('AB', 'A', 'B', 'O')),
        CONSTRAINT              ck_fator_ee             CHECK(fator_ee IN ('E', 'e')),
        CONSTRAINT              ck_fator_cc             CHECK(fator_cc IN ('C', 'c')),
        CONSTRAINT              ck_fator_kk             CHECK(fator_kk IN ('K', 'k')),
        CONSTRAINT              ck_soli_socorr          CHECK((solicitacao IS NULL) OR (socorrimento IS NULL))
);

/*
	TODO: fazer com que o atributo "numero" de "bolsa_de_sangue" seja gerado automaticamente para 
	para uma mesma doação. Isso pode ser feito com um trigger
*/

-- Criacao da tabela "Envolve"
CREATE TABLE IF NOT EXISTS envolve (
	transferencia	        BIGINT				NOT NULL,
	doacao			BIGINT				NOT NULL,
	numero			INT				NOT NULL,
	CONSTRAINT		pk_envolve		        PRIMARY KEY(transferencia, doacao, numero),
	CONSTRAINT		fk_envolve_transferencia        FOREIGN KEY(transferencia) REFERENCES transferencia(id) ON DELETE CASCADE,
	CONSTRAINT		fk_envolve_bolsa		FOREIGN KEY(doacao, numero) REFERENCES bolsa_de_sangue(doacao, numero) ON DELETE CASCADE
);