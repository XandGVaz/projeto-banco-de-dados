/*
        Script SQL para inserimento de dados no banco de dados do sistema de doaçao de sangue (Grupo 06)
        Autores:
               - Danielle Pereira - 11918539
               - Gabriel Dezejácomo Maruschi - 14571525
               - Pedro Gasparelo Leme - 14602421
               - Vitor Alexandre Garcia Vaz - 14611432 
*/

-- Insercao de locais
INSERT INTO local (cnpj_placa, cidade, bairro, rua, numero, capacidade, tipo)
VALUES('11111111111111', 'SAO CARLOS', 'SANTA FELICIA', 'ALAMEDA DAS PAPOULAS', 170, 100000, 'HEMONUCLEO');
INSERT INTO local (cnpj_placa, cidade, bairro, rua, numero, capacidade, tipo)
VALUES('22222222222222', 'SAO CARLOS', 'CENTRO', 'ALAMEDA DAS ORQUIDEAS', 160, 10000,'HOSPITAL');
INSERT INTO local (cnpj_placa, cidade, bairro, rua, numero, capacidade, tipo)
VALUES('3333333', 'SAO CARLOS', NULL, NULL, NULL, 50, 'AMBULANCIA');
INSERT INTO local (cnpj_placa, cidade, bairro, rua, numero, capacidade, tipo)
VALUES('44444444444444', 'SAO CARLOS', 'SANTA MARIA', 'RUA AMARAL PEIXOTO', 17, 200000, 'HEMONUCLEO');
INSERT INTO local (cnpj_placa, cidade, bairro, rua, numero, capacidade, tipo)
VALUES('55555555555555', 'SAO CARLOS', 'JARDIM BANDEIRANTES', 'ALAMEDA DAS CASCATAS', 16, 20000, 'HOSPITAL');
INSERT INTO local (cnpj_placa, cidade, bairro, rua, numero, capacidade, tipo)
VALUES('6666666', 'SAO CARLOS', NULL, NULL, NULL, 100, 'AMBULANCIA');
INSERT INTO local (cnpj_placa, cidade, bairro, rua, numero, capacidade, tipo)
VALUES('77777777777777', 'SAO CARLOS', 'JARDIM PARAISO', 'MAESTRO JOAO SEPPE', 2, 100000, 'HEMONUCLEO');


-- Insercao de hemonucleos
INSERT INTO hemonucleo(id)
(SELECT id FROM local WHERE tipo = 'HEMONUCLEO');


-- Insercao de hospitais
INSERT INTO hospital(id)
(SELECT id FROM local WHERE tipo = 'HOSPITAL');


-- Insercao de ambulancias
INSERT INTO ambulancia(id, crv, sede, modelo)
VALUES ((SELECT id FROM local WHERE tipo = 'AMBULANCIA' AND cnpj_placa = '3333333'), '33333333333', '11111111111111', 'MERCEDES 211');
INSERT INTO ambulancia(id, crv, sede, modelo)
VALUES ((SELECT id FROM local WHERE tipo = 'AMBULANCIA' AND cnpj_placa = '6666666'), '44444444444', '22222222222222', 'MERCEDES 222');


-- Insercao de pessoas
INSERT INTO pessoa (cpf, rg, uf, nome, contato, cidade, bairro, rua, numero, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk)
VALUES ('10000000001', '1234567', 'SP', 'Ana Silva',    '11999990001', 'SAO CARLOS', 'CENTRO', 'RUA A', 10, '+', 'O', 'E', 'C', 'K');
INSERT INTO pessoa (cpf, rg, uf, nome, contato, cidade, bairro, rua, numero, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk)
VALUES ('10000000002', '2234567', 'SP', 'Bruno Costa',  '11999990002', 'SAO CARLOS', 'CENTRO', 'RUA B', 20, '-', 'A', 'E', 'C', 'K');
INSERT INTO pessoa (cpf, rg, uf, nome, contato, cidade, bairro, rua, numero, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk)
VALUES('10000000003', '3234567', 'SP', 'Caio Oliveira','11999990003', 'SAO CARLOS', 'JARDIM', 'RUA C', 30, '+', 'B', 'E', 'C', 'K');
INSERT INTO pessoa (cpf, rg, uf, nome, contato, cidade, bairro, rua, numero, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk)
VALUES ('10000000004', '4234567', 'SP', 'Daniela Reis', '11999990004', 'SAO CARLOS', 'JARDIM', 'RUA D', 40, '-', 'AB','E', 'C', 'K');
INSERT INTO pessoa (cpf, rg, uf, nome, contato, cidade, bairro, rua, numero, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk)
VALUES ('10000000005', '5234567', 'SP', 'Eduardo Lima', '11999990005', 'SAO CARLOS', 'CENTRO', 'RUA E', 50, '+', 'O', 'E', 'C', 'K');
INSERT INTO pessoa (cpf, rg, uf, nome, contato, cidade, bairro, rua, numero, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk)
VALUES ('10000000006', '6234567', 'SP', 'Fernanda Paz','11999990006', 'SAO CARLOS', 'CENTRO', 'RUA F', 60, '-', 'A', 'E', 'C', 'K');
INSERT INTO pessoa (cpf, rg, uf, nome, contato, cidade, bairro, rua, numero, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk)
VALUES ('10000000007', '7234567', 'SP', 'Gabriel Mora', '11999990007', 'SAO CARLOS', 'VILA',   'RUA G', 70, '+', 'B', 'E', 'C', 'K');
INSERT INTO pessoa (cpf, rg, uf, nome, contato, cidade, bairro, rua, numero, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk)
VALUES ('10000000008', '8234567', 'SP', 'Helena Souza', '11999990008', 'SAO CARLOS', 'VILA',   'RUA H', 80, '-', 'O', 'E', 'C', 'K');
INSERT INTO pessoa (cpf, rg, uf, nome, contato, cidade, bairro, rua, numero, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk)
VALUES ('10000000009', '9234567', 'SP', 'Igor Nunes',   '11999990009', 'SAO CARLOS', 'CENTRO', 'RUA I', 90, '+', 'A', 'E', 'C', 'K');
INSERT INTO pessoa (cpf, rg, uf, nome, contato, cidade, bairro, rua, numero, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk)
VALUES ('10000000010', '0234567', 'SP', 'Joana Lima',   '11999990010', 'SAO CARLOS', 'CENTRO', 'RUA J',100, '-', 'B', 'E', 'C', 'K');
INSERT INTO pessoa (cpf, rg, uf, nome, contato, cidade, bairro, rua, numero, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk)
VALUES ('10000000011', '1234568', 'SP', 'Kleber Dias',  '11999990011', 'SAO CARLOS', 'CENTRO', 'RUA K',110, '+', 'AB','E', 'C', 'K');
INSERT INTO pessoa (cpf, rg, uf, nome, contato, cidade, bairro, rua, numero, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk)
VALUES ('10000000012', '2234568', 'SP', 'Livia Rocha',  '11999990012', 'SAO CARLOS', 'VILA',   'RUA L',120, '-', 'O', 'E', 'C', 'K');


-- Insercao de profissionais
INSERT INTO profissional (id, local) VALUES (1, (SELECT id FROM local WHERE cnpj_placa = '22222222222222'));
INSERT INTO profissional (id, local) VALUES (2, (SELECT id FROM local WHERE cnpj_placa = '11111111111111'));
INSERT INTO profissional (id, local) VALUES (3, (SELECT id FROM local WHERE cnpj_placa = '44444444444444'));
INSERT INTO profissional (id, local) VALUES (4, (SELECT id FROM local WHERE cnpj_placa = '55555555555555'));


-- Insercao de doadores 
INSERT INTO doador (id, ultima_doacao, peso) VALUES (5, '2025-01-10 10:00:00', 70);
INSERT INTO doador (id, ultima_doacao, peso) VALUES (6, '2025-03-01 09:00:00', 65);
INSERT INTO doador (id, ultima_doacao, peso) VALUES (7, NULL, 80);
INSERT INTO doador (id, ultima_doacao, peso) VALUES (8, '2024-12-20 14:30:00', 75);


-- Insercao de receptores
INSERT INTO receptor (id) VALUES (9);
INSERT INTO receptor (id) VALUES (10);
INSERT INTO receptor (id) VALUES (11); 
INSERT INTO receptor (id) VALUES (12);


-- Insercao de doacoes (12 registros)
--      Observação: usa doadores existentes (ids 5..8), profissionais (1..4) e hemonucleos
--      referentes aos hemonucleos com cnpj_placa '11111111111111' e '44444444444444'.
INSERT INTO doacao (doador, hemonucleo, data, profissional)
VALUES (5,  (SELECT id FROM hemonucleo WHERE id = (SELECT id FROM local WHERE cnpj_placa = '11111111111111')), '2025-01-05 09:00:00', 1);
INSERT INTO doacao (doador, hemonucleo, data, profissional)
VALUES (6,  (SELECT id FROM hemonucleo WHERE id = (SELECT id FROM local WHERE cnpj_placa = '11111111111111')), '2025-01-15 10:30:00', 2);
INSERT INTO doacao (doador, hemonucleo, data, profissional)
VALUES (7,  (SELECT id FROM hemonucleo WHERE id = (SELECT id FROM local WHERE cnpj_placa = '44444444444444')), '2025-02-01 08:45:00', 3);
INSERT INTO doacao (doador, hemonucleo, data, profissional)
VALUES (8,  (SELECT id FROM hemonucleo WHERE id = (SELECT id FROM local WHERE cnpj_placa = '44444444444444')), '2025-02-10 11:15:00', 4);
INSERT INTO doacao (doador, hemonucleo, data, profissional)
VALUES (8,  (SELECT id FROM hemonucleo WHERE id = (SELECT id FROM local WHERE cnpj_placa = '11111111111111')), '2025-03-03 14:00:00', 1);
INSERT INTO doacao (doador, hemonucleo, data, profissional)
VALUES (6,  (SELECT id FROM hemonucleo WHERE id = (SELECT id FROM local WHERE cnpj_placa = '44444444444444')), '2025-03-20 09:30:00', 2);
INSERT INTO doacao (doador, hemonucleo, data, profissional)
VALUES (7,  (SELECT id FROM hemonucleo WHERE id = (SELECT id FROM local WHERE cnpj_placa = '11111111111111')), '2025-04-02 13:20:00', 3);
INSERT INTO doacao (doador, hemonucleo, data, profissional)
VALUES (8,  (SELECT id FROM hemonucleo WHERE id = (SELECT id FROM local WHERE cnpj_placa = '44444444444444')), '2025-04-15 16:45:00', 4);
INSERT INTO doacao (doador, hemonucleo, data, profissional) 
VALUES (5,  (SELECT id FROM hemonucleo WHERE id = (SELECT id FROM local WHERE cnpj_placa = '44444444444444')), '2025-05-01 07:50:00', 1);
INSERT INTO doacao (doador, hemonucleo, data, profissional)
VALUES (6, (SELECT id FROM hemonucleo WHERE id = (SELECT id FROM local WHERE cnpj_placa = '11111111111111')), '2025-05-10 12:10:00', 2);
INSERT INTO doacao (doador, hemonucleo, data, profissional)
VALUES (7, (SELECT id FROM hemonucleo WHERE id = (SELECT id FROM local WHERE cnpj_placa = '44444444444444')), '2025-06-07 15:30:00', 3);
INSERT INTO doacao (doador, hemonucleo, data, profissional) 
VALUES (8, (SELECT id FROM hemonucleo WHERE id = (SELECT id FROM local WHERE cnpj_placa = '11111111111111')), '2025-06-20 10:00:00', 4);


-- Insercao de bolsas_de_sangue (uma bolsa por doacao inserida acima)
--      Cada bolsa referencia a doacao via subselect e copia os fatores sanguineos da pessoa doadora
INSERT INTO bolsa_de_sangue (doacao, numero, volueme_real, local_atual, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk)
SELECT dc.id, 1, 450,
       dc.hemonucleo,
       p.fator_rh, p.fator_abo, p.fator_ee, p.fator_cc, p.fator_kk
FROM doacao dc
JOIN doador dd ON dc.doador = dd.id
JOIN pessoa p ON dd.id = p.id
WHERE dc.id = 1;

INSERT INTO bolsa_de_sangue (doacao, numero, volueme_real, local_atual, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk)
SELECT dc.id, 1, 450,
       dc.hemonucleo,
       p.fator_rh, p.fator_abo, p.fator_ee, p.fator_cc, p.fator_kk
FROM doacao dc
JOIN doador dd ON dc.doador = dd.id
JOIN pessoa p ON dd.id = p.id
WHERE dc.id = 2;

INSERT INTO bolsa_de_sangue (doacao, numero, volueme_real, local_atual, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk)
SELECT dc.id, 1, 450,
       dc.hemonucleo,
       p.fator_rh, p.fator_abo, p.fator_ee, p.fator_cc, p.fator_kk
FROM doacao dc
JOIN doador dd ON dc.doador = dd.id
JOIN pessoa p ON dd.id = p.id
WHERE dc.id = 3;

INSERT INTO bolsa_de_sangue (doacao, numero, volueme_real, local_atual, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk)
SELECT dc.id, 1, 450,
       dc.hemonucleo,
       p.fator_rh, p.fator_abo, p.fator_ee, p.fator_cc, p.fator_kk
FROM doacao dc
JOIN doador dd ON dc.doador = dd.id
JOIN pessoa p ON dd.id = p.id
WHERE dc.id = 4;

INSERT INTO bolsa_de_sangue (doacao, numero, volueme_real, local_atual, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk)
SELECT dc.id, 1, 450,
       dc.hemonucleo,
       p.fator_rh, p.fator_abo, p.fator_ee, p.fator_cc, p.fator_kk
FROM doacao dc
JOIN doador dd ON dc.doador = dd.id
JOIN pessoa p ON dd.id = p.id
WHERE dc.id = 5;

INSERT INTO bolsa_de_sangue (doacao, numero, volueme_real, local_atual, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk)
SELECT dc.id, 1, 450,
       dc.hemonucleo,
       p.fator_rh, p.fator_abo, p.fator_ee, p.fator_cc, p.fator_kk
FROM doacao dc
JOIN doador dd ON dc.doador = dd.id
JOIN pessoa p ON dd.id = p.id
WHERE dc.id = 6;

INSERT INTO bolsa_de_sangue (doacao, numero, volueme_real, local_atual, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk)
SELECT dc.id, 1, 450,
       dc.hemonucleo,
       p.fator_rh, p.fator_abo, p.fator_ee, p.fator_cc, p.fator_kk
FROM doacao dc
JOIN doador dd ON dc.doador = dd.id
JOIN pessoa p ON dd.id = p.id
WHERE dc.id = 7;

INSERT INTO bolsa_de_sangue (doacao, numero, volueme_real, local_atual, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk)
SELECT dc.id, 1, 450,
       dc.hemonucleo,
       p.fator_rh, p.fator_abo, p.fator_ee, p.fator_cc, p.fator_kk
FROM doacao dc
JOIN doador dd ON dc.doador = dd.id
JOIN pessoa p ON dd.id = p.id
WHERE dc.id = 8;

INSERT INTO bolsa_de_sangue (doacao, numero, volueme_real, local_atual, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk)
SELECT dc.id, 1, 450,
       dc.hemonucleo,
       p.fator_rh, p.fator_abo, p.fator_ee, p.fator_cc, p.fator_kk
FROM doacao dc
JOIN doador dd ON dc.doador = dd.id
JOIN pessoa p ON dd.id = p.id
WHERE dc.id = 9;

INSERT INTO bolsa_de_sangue (doacao, numero, volueme_real, local_atual, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk)
SELECT dc.id, 1, 450,
       dc.hemonucleo,
       p.fator_rh, p.fator_abo, p.fator_ee, p.fator_cc, p.fator_kk
FROM doacao dc
JOIN doador dd ON dc.doador = dd.id
JOIN pessoa p ON dd.id = p.id
WHERE dc.id = 10;

INSERT INTO bolsa_de_sangue (doacao, numero, volueme_real, local_atual, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk)
SELECT dc.id, 1, 450,
       dc.hemonucleo,
       p.fator_rh, p.fator_abo, p.fator_ee, p.fator_cc, p.fator_kk
FROM doacao dc
JOIN doador dd ON dc.doador = dd.id
JOIN pessoa p ON dd.id = p.id
WHERE dc.id = 11;

INSERT INTO bolsa_de_sangue (doacao, numero, volueme_real, local_atual, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk)
SELECT dc.id, 1, 450,
       dc.hemonucleo,
       p.fator_rh, p.fator_abo, p.fator_ee, p.fator_cc, p.fator_kk
FROM doacao dc
JOIN doador dd ON dc.doador = dd.id
JOIN pessoa p ON dd.id = p.id
WHERE dc.id = 12;


-- Insercao de Transferencias envolvendo somente bolsas que vao de hemonucleos para hospitais (doacao 7..12)
--      1) Transferencia A: do hemonucleo '11111111111111' para hospital '22222222222222'
--      1.1) Transferencia A em si
INSERT INTO transferencia (local_origem, local_destino, data)
VALUES (
        (SELECT id FROM local WHERE cnpj_placa = '11111111111111'),
        (SELECT id FROM local WHERE cnpj_placa = '22222222222222'),
        '2025-07-10 08:00:00'
);
--      1.2) envolve: relaciona a transferencia A com as bolsas (doacao 7, 10, 12)
INSERT INTO envolve (transferencia, doacao, numero)
VALUES (1, 7, 1);
INSERT INTO envolve (transferencia, doacao, numero)
VALUES (1, 10, 1);
INSERT INTO envolve (transferencia, doacao, numero)
VALUES (1, 12, 1);
--      1.3) nro_bolsas para Transferencia A: uma unidade de cada tipo das bolsas envolvidas
INSERT INTO nro_bolsas (transferencia, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk, quantidade)
SELECT 1, b.fator_rh, b.fator_abo, b.fator_ee, b.fator_cc, b.fator_kk, 1
FROM bolsa_de_sangue b
WHERE b.doacao = 7 AND b.numero = 1;

INSERT INTO nro_bolsas (transferencia, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk, quantidade)
SELECT 1, b.fator_rh, b.fator_abo, b.fator_ee, b.fator_cc, b.fator_kk, 1
FROM bolsa_de_sangue b
WHERE b.doacao = 10 AND b.numero = 1;

INSERT INTO nro_bolsas (transferencia, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk, quantidade)
SELECT 1, b.fator_rh, b.fator_abo, b.fator_ee, b.fator_cc, b.fator_kk, 1
FROM bolsa_de_sangue b
WHERE b.doacao = 12 AND b.numero = 1;
--      1.4)atualiza local_atual das bolsas
UPDATE bolsa_de_sangue 
SET local_atual = (SELECT id FROM local WHERE cnpj_placa = '22222222222222')
WHERE doacao = 7 AND numero = 1;

UPDATE bolsa_de_sangue 
SET local_atual = (SELECT id FROM local WHERE cnpj_placa = '22222222222222')
WHERE doacao = 10 AND numero = 1;

UPDATE bolsa_de_sangue 
SET local_atual = (SELECT id FROM local WHERE cnpj_placa = '22222222222222')
WHERE doacao = 12 AND numero = 1;
--      2)Transferencia B: do hemonucleo '44444444444444' para hospital '55555555555555'
--      2.1) Transferencia B em si
INSERT INTO transferencia (local_origem, local_destino, data)
VALUES (
        (SELECT id FROM local WHERE cnpj_placa = '44444444444444'),
        (SELECT id FROM local WHERE cnpj_placa = '55555555555555'),
        '2025-07-11 09:00:00'
);
--      2.2) envolve: relaciona a transferencia B com as bolsas (doacao 8, 9, 11)
INSERT INTO envolve (transferencia, doacao, numero)
VALUES (2, 8, 1);
INSERT INTO envolve (transferencia, doacao, numero)
VALUES (2, 9, 1);
INSERT INTO envolve (transferencia, doacao, numero)
VALUES (2, 11, 1);
--      2.3)nro_bolsas para Transferencia B (uma unidade de cada tipo das bolsas envolvidas)
INSERT INTO nro_bolsas (transferencia, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk, quantidade)
SELECT 2, b.fator_rh, b.fator_abo, b.fator_ee, b.fator_cc, b.fator_kk, 1
FROM bolsa_de_sangue b
WHERE b.doacao = 8 AND b.numero = 1;

INSERT INTO nro_bolsas (transferencia, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk, quantidade)
SELECT 2, b.fator_rh, b.fator_abo, b.fator_ee, b.fator_cc, b.fator_kk, 1
FROM bolsa_de_sangue b
WHERE b.doacao = 9 AND b.numero = 1;

INSERT INTO nro_bolsas (transferencia, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk, quantidade)
SELECT 2, b.fator_rh, b.fator_abo, b.fator_ee, b.fator_cc, b.fator_kk, 1
FROM bolsa_de_sangue b
WHERE b.doacao = 11 AND b.numero = 1;
--      2.4)atualiza local_atual das bolsas
UPDATE bolsa_de_sangue 
SET local_atual = (SELECT id FROM local WHERE cnpj_placa = '55555555555555')
WHERE doacao = 8 AND numero = 1;
UPDATE bolsa_de_sangue 
SET local_atual = (SELECT id FROM local WHERE cnpj_placa = '55555555555555')
WHERE doacao = 9 AND numero = 1;
UPDATE bolsa_de_sangue 
SET local_atual = (SELECT id FROM local WHERE cnpj_placa = '55555555555555')
WHERE doacao = 11 AND numero = 1;       
        
           
-- Insercao de Transferencias envolvendo somente bolsas que vao de hemonucleos para ambulancias (doacao 1..6)
--      1) Transferencia C: do hemonucleo '11111111111111' para ambulancia '3333333'
--      1.1) Transferencia C em si
INSERT INTO transferencia (local_origem, local_destino, data)
VALUES (
        (SELECT id FROM local WHERE cnpj_placa = '11111111111111'),
        (SELECT id FROM local WHERE cnpj_placa = '3333333'),
        '2025-07-07 07:30:00'
);
--      1.2) envolve: relaciona a transferencia C com as bolsas (doacao 1, 2, 5)
INSERT INTO envolve (transferencia, doacao, numero)
VALUES (3, 1, 1);
INSERT INTO envolve (transferencia, doacao, numero)
VALUES (3, 2, 1);
INSERT INTO envolve (transferencia, doacao, numero)
VALUES (3, 5, 1);
--      1.3) nro_bolsas para Transferencia C: uma unidade de cada tipo das bolsas envolvidas
INSERT INTO nro_bolsas (transferencia, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk, quantidade)
SELECT 3, b.fator_rh, b.fator_abo, b.fator_ee, b.fator_cc, b.fator_kk, 1
FROM bolsa_de_sangue b
WHERE b.doacao = 1 AND b.numero = 1;

INSERT INTO nro_bolsas (transferencia, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk, quantidade)
SELECT 3, b.fator_rh, b.fator_abo, b.fator_ee, b.fator_cc, b.fator_kk, 1
FROM bolsa_de_sangue b
WHERE b.doacao = 2 AND b.numero = 1;

INSERT INTO nro_bolsas (transferencia, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk, quantidade)
SELECT 3, b.fator_rh, b.fator_abo, b.fator_ee, b.fator_cc, b.fator_kk, 1
FROM bolsa_de_sangue b
WHERE b.doacao = 5 AND b.numero = 1;
--      1.4) atualiza local_atual das bolsas para a ambulancia
UPDATE bolsa_de_sangue 
SET local_atual = (SELECT id FROM local WHERE cnpj_placa = '3333333')
WHERE doacao = 1 AND numero = 1;

UPDATE bolsa_de_sangue 
SET local_atual = (SELECT id FROM local WHERE cnpj_placa = '3333333')
WHERE doacao = 2 AND numero = 1;

UPDATE bolsa_de_sangue 
SET local_atual = (SELECT id FROM local WHERE cnpj_placa = '3333333')
WHERE doacao = 5 AND numero = 1;

--      2) Transferencia D: do hemonucleo '44444444444444' para ambulancia '6666666'
--      2.1) Transferencia D em si
INSERT INTO transferencia (local_origem, local_destino, data)
VALUES (
        (SELECT id FROM local WHERE cnpj_placa = '44444444444444'),
        (SELECT id FROM local WHERE cnpj_placa = '6666666'),
        '2025-07-08 08:15:00'
);
--      2.2) envolve: relaciona a transferencia D com as bolsas (doacao 3, 4, 6)
INSERT INTO envolve (transferencia, doacao, numero)
VALUES (4, 3, 1);
INSERT INTO envolve (transferencia, doacao, numero)
VALUES (4, 4, 1);
INSERT INTO envolve (transferencia, doacao, numero)
VALUES (4, 6, 1);
--      2.3) nro_bolsas para Transferencia D (uma unidade de cada tipo das bolsas envolvidas)
INSERT INTO nro_bolsas (transferencia, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk, quantidade)
SELECT 4, b.fator_rh, b.fator_abo, b.fator_ee, b.fator_cc, b.fator_kk, 1
FROM bolsa_de_sangue b
WHERE b.doacao = 3 AND b.numero = 1;

INSERT INTO nro_bolsas (transferencia, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk, quantidade)
SELECT 4, b.fator_rh, b.fator_abo, b.fator_ee, b.fator_cc, b.fator_kk, 1
FROM bolsa_de_sangue b
WHERE b.doacao = 4 AND b.numero = 1;

INSERT INTO nro_bolsas (transferencia, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk, quantidade)
SELECT 4, b.fator_rh, b.fator_abo, b.fator_ee, b.fator_cc, b.fator_kk, 1
FROM bolsa_de_sangue b
WHERE b.doacao = 6 AND b.numero = 1;
--      2.4) atualiza local_atual das bolsas para a ambulancia
UPDATE bolsa_de_sangue 
SET local_atual = (SELECT id FROM local WHERE cnpj_placa = '6666666')
WHERE doacao = 3 AND numero = 1;

UPDATE bolsa_de_sangue 
SET local_atual = (SELECT id FROM local WHERE cnpj_placa = '6666666')
WHERE doacao = 4 AND numero = 1;

UPDATE bolsa_de_sangue 
SET local_atual = (SELECT id FROM local WHERE cnpj_placa = '6666666')
WHERE doacao = 6 AND numero = 1;


-- Insercao em inventario para os locais com base nas bolsas inseridas/atualizadas acima
INSERT INTO inventario (local, fator_rh, fator_abo, fator_ee, fator_cc, fator_kk, estoque)
SELECT b.local_atual AS local,
       b.fator_rh,
       b.fator_abo,
       b.fator_ee,
       b.fator_cc,
       b.fator_kk,
       COUNT(*) AS estoque
FROM bolsa_de_sangue b
GROUP BY b.local_atual, b.fator_rh, b.fator_abo, b.fator_ee, b.fator_cc, b.fator_kk
ORDER BY b.local_atual;


-- Insercao de 3 socorrimentos para algumas das primeiras 6 bolsas (doacoes 1..3)
--      Usam ambulancias cadastradas via local cnpj_placa '3333333' e '6666666'
--      1.1) Insercao dos socorrimentos em si
INSERT INTO socorrimento (ambulancia, receptor, data)
VALUES (
        (SELECT id FROM ambulancia WHERE id = (SELECT id FROM local WHERE cnpj_placa = '3333333')),
        9, '2025-07-01 08:00:00'
);
INSERT INTO socorrimento (ambulancia, receptor, data)
VALUES (
        (SELECT id FROM ambulancia WHERE id = (SELECT id FROM local WHERE cnpj_placa = '3333333')),
        10, '2025-07-02 09:30:00'
);
INSERT INTO socorrimento (ambulancia, receptor, data)
VALUES (
        (SELECT id FROM ambulancia WHERE id = (SELECT id FROM local WHERE cnpj_placa = '6666666')),
        11, '2025-07-03 11:15:00'
);
--      1.2) Atualizacao do atributo socorimento das bolsas envolvidas
UPDATE bolsa_de_sangue
SET socorrimento = 1
WHERE doacao = 1 AND numero = 1;

UPDATE bolsa_de_sangue
SET socorrimento = 2
WHERE doacao = 2 AND numero = 1;

UPDATE bolsa_de_sangue
SET socorrimento = 3
WHERE doacao = 3 AND numero = 1;
--- 1.3) Atualizacao do inventario para os locais envolvidos nos socorrimentos acima
UPDATE inventario
SET estoque = estoque - 1
WHERE local = (SELECT local_atual FROM bolsa_de_sangue WHERE doacao = 1 AND numero = 1)
  AND fator_rh = (SELECT fator_rh FROM bolsa_de_sangue WHERE doacao = 1 AND numero = 1)
  AND fator_abo = (SELECT fator_abo FROM bolsa_de_sangue WHERE doacao = 1 AND numero = 1)
  AND fator_ee = (SELECT fator_ee FROM bolsa_de_sangue WHERE doacao = 1 AND numero = 1)
  AND fator_cc = (SELECT fator_cc FROM bolsa_de_sangue WHERE doacao = 1 AND numero = 1)
  AND fator_kk = (SELECT fator_kk FROM bolsa_de_sangue WHERE doacao = 1 AND numero = 1);

UPDATE inventario
SET estoque = estoque - 1
WHERE local = (SELECT local_atual FROM bolsa_de_sangue WHERE doacao = 2 AND numero = 1)
  AND fator_rh = (SELECT fator_rh FROM bolsa_de_sangue WHERE doacao = 2 AND numero = 1)
  AND fator_abo = (SELECT fator_abo FROM bolsa_de_sangue WHERE doacao = 2 AND numero = 1)
  AND fator_ee = (SELECT fator_ee FROM bolsa_de_sangue WHERE doacao = 2 AND numero = 1)
  AND fator_cc = (SELECT fator_cc FROM bolsa_de_sangue WHERE doacao = 2 AND numero = 1)
  AND fator_kk = (SELECT fator_kk FROM bolsa_de_sangue WHERE doacao = 2 AND numero = 1);

UPDATE inventario
SET estoque = estoque - 1
WHERE local = (SELECT local_atual FROM bolsa_de_sangue WHERE doacao = 3 AND numero = 1)
  AND fator_rh = (SELECT fator_rh FROM bolsa_de_sangue WHERE doacao = 3 AND numero = 1)
  AND fator_abo = (SELECT fator_abo FROM bolsa_de_sangue WHERE doacao = 3 AND numero = 1)
  AND fator_ee = (SELECT fator_ee FROM bolsa_de_sangue WHERE doacao = 3 AND numero = 1)
  AND fator_cc = (SELECT fator_cc FROM bolsa_de_sangue WHERE doacao = 3 AND numero = 1)
  AND fator_kk = (SELECT fator_kk FROM bolsa_de_sangue WHERE doacao = 3 AND numero = 1);


-- Insercao de 3 solicitacoes para algumas das ultimas 6 bolsas (doacoes 7..9)
--      Usam hospitais cadastrados via local cnpj_placa '22222222222222' e '55555555555555')
--      2.1) Insercao das solicitacoes em si
INSERT INTO solicitacao (hospital, receptor, data)
VALUES (
        (SELECT id FROM hospital WHERE id = (SELECT id FROM local WHERE cnpj_placa = '22222222222222')),
        9, '2025-07-04 10:00:00'
);

INSERT INTO solicitacao (hospital, receptor, data)
VALUES (
        (SELECT id FROM hospital WHERE id = (SELECT id FROM local WHERE cnpj_placa = '55555555555555')),
        10, '2025-07-05 14:30:00'
);

INSERT INTO solicitacao (hospital, receptor, data)
VALUES (
        (SELECT id FROM hospital WHERE id = (SELECT id FROM local WHERE cnpj_placa = '22222222222222')),
        11, '2025-07-06 16:45:00'
);
--      2.2) Atualizacao do atributo solicitacao das bolsas envolvidas
UPDATE bolsa_de_sangue
SET solicitacao = 1
WHERE doacao = 7 AND numero = 1;

UPDATE bolsa_de_sangue
SET solicitacao = 2
WHERE doacao = 8 AND numero = 1;

UPDATE bolsa_de_sangue
SET solicitacao = 3
WHERE doacao = 9 AND numero = 1;
--- 2.3) Atualizacao do inventario para os locais envolvidos nas solicitacoes acima
UPDATE inventario
SET estoque = estoque - 1
WHERE local = (SELECT local_atual FROM bolsa_de_sangue WHERE doacao = 7 AND numero = 1)
  AND fator_rh = (SELECT fator_rh FROM bolsa_de_sangue WHERE doacao = 7 AND numero = 1)
  AND fator_abo = (SELECT fator_abo FROM bolsa_de_sangue WHERE doacao = 7 AND numero = 1)
  AND fator_ee = (SELECT fator_ee FROM bolsa_de_sangue WHERE doacao = 7 AND numero = 1)
  AND fator_cc = (SELECT fator_cc FROM bolsa_de_sangue WHERE doacao = 7 AND numero = 1)
  AND fator_kk = (SELECT fator_kk FROM bolsa_de_sangue WHERE doacao = 7 AND numero = 1);

UPDATE inventario
SET estoque = estoque - 1
WHERE local = (SELECT local_atual FROM bolsa_de_sangue WHERE doacao = 8 AND numero = 1)
  AND fator_rh = (SELECT fator_rh FROM bolsa_de_sangue WHERE doacao = 8 AND numero = 1)
  AND fator_abo = (SELECT fator_abo FROM bolsa_de_sangue WHERE doacao = 8 AND numero = 1)
  AND fator_ee = (SELECT fator_ee FROM bolsa_de_sangue WHERE doacao = 8 AND numero = 1)
  AND fator_cc = (SELECT fator_cc FROM bolsa_de_sangue WHERE doacao = 8 AND numero = 1)
  AND fator_kk = (SELECT fator_kk FROM bolsa_de_sangue WHERE doacao = 8 AND numero = 1);

UPDATE inventario
SET estoque = estoque - 1
WHERE local = (SELECT local_atual FROM bolsa_de_sangue WHERE doacao = 9 AND numero = 1)
  AND fator_rh = (SELECT fator_rh FROM bolsa_de_sangue WHERE doacao = 9 AND numero = 1)
  AND fator_abo = (SELECT fator_abo FROM bolsa_de_sangue WHERE doacao = 9 AND numero = 1)
  AND fator_ee = (SELECT fator_ee FROM bolsa_de_sangue WHERE doacao = 9 AND numero = 1)
  AND fator_cc = (SELECT fator_cc FROM bolsa_de_sangue WHERE doacao = 9 AND numero = 1)
  AND fator_kk = (SELECT fator_kk FROM bolsa_de_sangue WHERE doacao = 9 AND numero = 1);



