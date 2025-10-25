CREATE TABLE IF NOT EXISTS pessoa (
    ID			BIGSERIAL 		NOT NULL,	
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
	CONSTRAINT 	pk_id			PRIMARY KEY(ID) 
);