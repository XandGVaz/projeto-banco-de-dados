CREATE TABLE IF NOT EXISTS local (
	id			SERIAL			NOT NULL,
	cnpj_placa	VARCHAR(14)		NOT NULL,
	cidade		VARCHAR(40),
	bairro		VARCHAR(40),
	rua			VARCHAR(40),
	numero		INT				CHECK(numero >= 0),
	capacidade	BIGINT,	
	tipo		VARCHAR(10)		NOT NULL CHECK(tipo IN('HEMONUCLEO', 'HOSPITAL', 'AMBULANCIA')),
	CONSTRAINT	pk_local		PRIMARY KEY(id),
	CONSTRAINT	sk_local		UNIQUE(cnpj_placa)
);

CREATE TABLE IF NOT EXISTS hemonucleo (
	id			INT					NOT NULL,
	CONSTRAINT 	pk_hemonucleo		PRIMARY KEY(id),
	CONSTRAINT 	fk_hemonucleo_local	FOREIGN KEY(id) REFERENCES local(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS hospital (
	id			INT					NOT NULL,
	CONSTRAINT 	pk_hospital			PRIMARY KEY(id),
	CONSTRAINT 	fk_hospital_local	FOREIGN KEY(id) REFERENCES local(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS ambulancia (
	id			INT					NOT NULL,
	crv			CHAR(11)			NOT NULL,
	sede		VARCHAR(40),			
	CONSTRAINT 	pk_ambulancia		PRIMARY KEY(id),
	CONSTRAINT 	sk_ambulancia		UNIQUE(crv),
	CONSTRAINT 	fk_ambulancia_local	FOREIGN KEY(id) REFERENCES local(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS inventario (
	local		INT					NOT NULL,
	fator_rh	CHAR(1)				NOT NULL CHECK(fator_rh IN ('+','-')),
	fator_abo	VARCHAR(2)			NOT NULL CHECK(fator_abo IN ('AB', 'A', 'B', 'O')),
	fator_ee	CHAR(1)		    	NOT NULL CHECK(fator_ee IN ('E', 'e')),
	fator_cc	CHAR(1)		    	NOT NULL CHECK(fator_cc IN ('C', 'c')),
	fator_kk	CHAR(1)		    	NOT NULL CHECK(fator_kk IN ('K', 'k')),
	estoque		INT					NOT NULL CHECK(estoque >= 0),
	CONSTRAINT  pk_inventario		PRIMARY KEY(local),
	CONSTRAINT 	fk_inventario_local	FOREIGN KEY(local) REFERENCES(local) ON DELETE CASCADE			
);

CREATE TABLE IF NOT EXISTS nro_bolsas (
	local		INT					NOT NULL,
	fator_rh	CHAR(1)				NOT NULL CHECK(fator_rh IN ('+','-')),
	fator_abo	VARCHAR(2)			NOT NULL CHECK(fator_abo IN ('AB', 'A', 'B', 'O')),
	fator_ee	CHAR(1)		    	NOT NULL CHECK(fator_ee IN ('E', 'e')),
	fator_cc	CHAR(1)		    	NOT NULL CHECK(fator_cc IN ('C', 'c')),
	fator_kk	CHAR(1)		    	NOT NULL CHECK(fator_kk IN ('K', 'k')),
	quantidade	INT					NOT NULL CHECK(estoque >= 0),
	CONSTRAINT  pk_nro_bolsas		PRIMARY KEY(local),
	CONSTRAINT 	fk_nro_bolsas_local	FOREIGN KEY(local) REFERENCES(local) ON DELETE CASCADE			
);

CREATE TABLE IF NOT EXISTS transferencia (
	id				BIGSERIAL			NOT NULL,
	local_origem	INT					NOT NULL,
	local_destino	INT					NOT NULL,
	data			TIMESTAMP			NOT NULL,
	CONSTRAINT		pk_transferencia	PRIMARY KEY(id),
	CONSTRAINT 		fk_local_origem		FOREIGN KEY(local) REFERENCES(local) ON DELETE CASCADE,
	CONSTRAINT 		fk_local_destino	FOREIGN KEY(local) REFERENCES(local) ON DELETE CASCADE,
);

CREATE TABLE IF NOT EXISTS pessoa (
    id			BIGSERIAL 		NOT NULL,	
	cpf			CHAR(11)		NOT NULL,
	rg			VARCHAR(8)		NOT NULL,
	contato 	VARCHAR(11),
	cidade 		VARCHAR(40),		
	bairro		VARCHAR(40),		
	rua			VARCHAR(40),					
	numero		INT				CHECK (numero >= 0),
	fator_rh	CHAR(1)			NOT NULL CHECK(fator_rh IN ('+','-')),
	fator_abo	VARCHAR(2)		NOT NULL CHECK(fator_abo IN ('AB', 'A', 'B', 'O')),
	fator_ee	CHAR(1)		    NOT NULL CHECK(fator_ee IN ('E', 'e')),
	fator_cc	CHAR(1)		    NOT NULL CHECK(fator_cc IN ('C', 'c')),
	fator_kk	CHAR(1)		    NOT NULL CHECK(fator_kk IN ('K', 'k')),
	CONSTRAINT 	pk_pessoa		PRIMARY KEY(ID),
	CONSTRAINT 	sk_pessoa 		UNIQUE(cpf),
	CONSTRAINT	tk_pessoa		UNIQUE(rg)
);

CREATE TABLE IF NOT EXISTS profissional (
	id			BIGINT					NOT NULL,
	local		INT						NOT NULL,
	CONSTRAINT	pk_profissional			PRIMARY KEY(id),
	CONSTRAINT 	fk_profissional_pessoa	FOREIGN KEY(id) REFERENCES pessoa(id) ON DELETE CASCADE,
	CONSTRAINT 	fk_profissional_local	FOREIGN KEY(local) REFERENCES local(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS doador (
	id				BIGINT			NOT NULL,
	ultima_doacao	TIMESTAMP,
	peso			INT,				 
	CONSTRAINT	pk_doador			PRIMARY KEY(id),
	CONSTRAINT 	fk_doador_pessoa	FOREIGN KEY(id) REFERENCES pessoa(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS receptor (
	id			BIGINT				NOT NULL,
	CONSTRAINT	pk_receptor			PRIMARY KEY(id),
	CONSTRAINT 	fk_receptor_pessoa	FOREIGN KEY(id) REFERENCES pessoa(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS doacao (
	id				BIGINT					NOT NULL,
	doador			BIGINT					NOT NULL,
	hemonucleo		INT						NOT NULL,
	data			TIMESTAMP				NOT NULL,
	profissional	BIGINT					NOT NULL,
	CONSTRAINT 		pk_doacao				PRIMARY KEY(id),
	CONSTRAINT		sk_doacao				UNIQUE(doador, hemonucleo, data), 
	CONSTRAINT		fk_doacao_doador		FOREIGN KEY(doador) REFERENCES(doador) ON DELETE CASCADE,
	CONSTRAINT		fk_doacao_hemonucleo	FOREIGN KEY(hemonucleo) REFERENCES(hemonucleo) ON DELETE CASCADE,
	CONSTRAINT		fk_doacao_profissional	FOREIGN KEY(profissional) REFERENCES(profissional) ON DELETE CASCADE,
);

