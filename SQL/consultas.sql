/*
        Script SQL referente às consultas do sistema de doaçao de sangue (Grupo 06)
        Autores:
               - Danielle Pereira - 11918539
               - Gabriel Dezejácomo Maruschi - 14571525
               - Pedro Gasparelo Leme - 14602421
               - Vitor Alexandre Garcia Vaz - 14611432
*/

--------------- Consulta 01 ----------------------------------------------------------
/*
        Esta consulta retorna, para cada receptor, o histórico de transfusões
        realizadas tanto via socorrimentos (ambulâncias) quanto via solicitações
        (hospitais), unificando os dois domínios em um único conjunto de resultados.

        Para cada transfusão, é apresentada a quantidade de bolsas de sangue
        efetivamente utilizadas, calculada a partir da tabela "bolsa_de_sangue".

        A unificação dos domínios de socorrimentos e solicitações é feita por
        meio do operador de conjunto UNION ALL, em uma CTE ("historico_transfusoes")
        que normaliza as informações de cada tipo de transfusão (id, data, local,
        receptor e número de bolsas).

        Em seguida, utiliza-se um JOIN EXTERNO (LEFT JOIN) entre "receptor" e a CTE
        "historico_transfusoes" para garantir que receptores sem qualquer transfusão
        também apareçam no resultado, com os campos de transfusão nulos e a quantidade
        de bolsas igual a zero.
*/
WITH historico_transfusoes AS (
        -- Domínio de socorrimentos
        SELECT
                S.id           AS id_transfusao,
                S.receptor     AS id_receptor,
                'SOCORRIMENTO' AS tipo_transfusao,
                S.data         AS data_transfusao,
                L.cidade       AS cidade_transfusao,
                L.bairro       AS bairro_transfusao,
                L.rua          AS rua_transfusao,
                COUNT(B.doacao) AS qtd_bolsas
        FROM socorrimento S
        INNER JOIN ambulancia A    ON A.id = S.ambulancia
        INNER JOIN local L         ON L.id = A.id
        LEFT JOIN bolsa_de_sangue B
               ON B.socorrimento = S.id
        GROUP BY
                S.id, S.receptor, S.data, L.cidade, L.bairro, L.rua
        UNION ALL
        -- Domínio de solicitações
        SELECT
                SO.id          AS id_transfusao,
                SO.receptor    AS id_receptor,
                'SOLICITACAO'  AS tipo_transfusao,
                SO.data        AS data_transfusao,
                L.cidade       AS cidade_transfusao,
                L.bairro       AS bairro_transfusao,
                L.rua          AS rua_transfusao,
                COUNT(B.doacao) AS qtd_bolsas
        FROM solicitacao SO
        INNER JOIN hospital H      ON H.id = SO.hospital
        INNER JOIN local L         ON L.id = H.id
        LEFT JOIN bolsa_de_sangue B
               ON B.solicitacao = SO.id
        GROUP BY
                SO.id, SO.receptor, SO.data, L.cidade, L.bairro, L.rua
)
SELECT
        R.id                    AS "id_receptor",
        P.nome                  AS "nome_receptor",
        HT.id_transfusao        AS "id_transfusao",
        HT.tipo_transfusao      AS "tipo_transfusao",
        HT.data_transfusao      AS "data_transfusao",
        HT.cidade_transfusao    AS "cidade_transfusao",
        HT.bairro_transfusao    AS "bairro_transfusao",
        HT.rua_transfusao       AS "rua_transfusao",
        COALESCE(HT.qtd_bolsas, 0) AS "qtd_bolsas_utilizadas"
FROM receptor R
INNER JOIN pessoa P
        ON P.id = R.id
LEFT JOIN historico_transfusoes HT
        ON HT.id_receptor = R.id
ORDER BY
        R.id,
        HT.data_transfusao;
		

--------------- Consulta 02 ----------------------------------------------------------
/*
        Esta consulta retorna, para cada receptor do sistema, todos os locais
        que possuem bolsas de sangue compatíveis com o seu tipo sanguíneo,
        considerando a igualdade completa dos fatores (Rh, ABO, Ee, Cc e Kk).

        A compatibilidade é verificada comparando diretamente os fatores
        sanguíneos do receptor (armazenados em "pessoa") com as combinações
        de fatores disponíveis no inventário de cada local (tabela "inventario").

        Para cada par (receptor, local) é retornada a quantidade total de
        bolsas compatíveis, calculada como a soma do estoque das entradas
        do inventário daquele local que possuem o mesmo conjunto de fatores
        sanguíneos do receptor.

        A consulta utiliza apenas joins internos (INNER JOIN) entre
        receptor, pessoa, inventario e local, e um GROUP BY para consolidar
        a quantidade de bolsas compatíveis em cada local.
*/

SELECT
        R.id            AS "id_receptor",
        P.nome          AS "nome_receptor",
        L.id            AS "id_local",
        L.cidade        AS "cidade_local",
        L.bairro        AS "bairro_local",
        L.rua           AS "rua_local",
        SUM(I.estoque)  AS "qtd_bolsas_compativeis"
FROM receptor   R
INNER JOIN pessoa      P ON P.id = R.id
INNER JOIN inventario  I
        ON  I.fator_rh  = P.fator_rh
        AND I.fator_abo = P.fator_abo
        AND I.fator_ee  = P.fator_ee
        AND I.fator_cc  = P.fator_cc
        AND I.fator_kk  = P.fator_kk
INNER JOIN local       L ON L.id = I.local
GROUP BY
        R.id, P.nome,
        L.id, L.cidade, L.bairro, L.rua
HAVING
        SUM(I.estoque) > 0
ORDER BY
        R.id,
        L.id;
        
--------------- Consulta 03 ----------------------------------------------------------
/* 
        Esta consulta retorna para cada profissional todos os profissionas compatíveis
,ou seja, aqueles que já atenderam todos os doadores atendidos pelo profissional
em questão, exceto ele mesmo.
        Por se tratar de um caso de divisão de conjuntos, a consulta utiliza o operador
EXCEPT para comparar os conjuntos de doadores atendidos por cada profissional e o NOT
EXISTS para garantir que todos os doadores do profissional em questão estejam presentes no
conjunto de doadores atendidos pelo profissional compatível.
*/

SELECT
        PR.id AS "id_profissional",
        PE.nome AS "nome_profissional",
        OPR.id AS "id_profissional_compativel",
        OPE.nome AS "nome_profissional_compativel"
FROM profissional OPR
-- INNER JOIN para obter nome de profissionais compatíveis
INNER JOIN pessoa OPE ON OPR.id = OPE.id
-- RIGHT JOIN para obter profissionais em questão (mesmo que não tenham compatíveis)
RIGHT JOIN profissional PR ON NOT EXISTS (
                (
                        SELECT DISTINCT
                                d.doador as "doador"
                        FROM profissional p
                        INNER JOIN doacao d ON d.profissional = p.id
                        WHERE p.id = PR.id                        
                )
                EXCEPT
                (
                        SELECT DISTINCT
                                d.doador as "doador"
                        FROM profissional p
                        INNER JOIN doacao d ON d.profissional = p.id
                        WHERE p.id = OPR.id       
                )
        )
        AND OPR.id != PR.id
INNER JOIN pessoa PE ON PR.id = PE.id;

/*
        OBS: a comparação OPR.id != PR.id não pode estar em WHERE, pois isso
transformaria a consulta em INNER JOIN, devido à filtragem de colunas NULL, o 
que impediria a obtenção de profissionais sem um conjunto de outros profissionais 
compatíveis.
*/

--------------- Consulta 04 ----------------------------------------------------------
/*
        Esta consulta retorna, para cada hemocentro, o doador com maior número de doações. Em 
especial os atributos retornados são o id do doador, seu nome, o id do hemonucleo e o número
de doações.
        A Query inicia agrupando e contando as doações por hemonucleo e doador. Posteriormente,
pela função MAX() obtemos o maior número de doações feitas por uma pessoa em um hemonúcleo. Este
valor é armazenado. O uso de LEFT JOIN garante a junção com os hemonúcleos que não tiveram doações
        Posteriormente, a Query principal realiza JOINs externos nas tabelas de contagem_doacoes,
hemonucleo e pessoa, filtrando contagem_doacoes para conter apenas as tuplas com número de 
doações igual ao número máximo naquele hemonúcleo. Esta implementação garante a exibição de
hemonúcleos sem doações e doadores com resultados empatados.
*/

WITH contagem_doacoes AS (
    SELECT 
        HN.id AS hemonucleo_id,
        DD.doador,
        COUNT(DD.id) AS total_doacoes,
        MAX(COUNT(DD.id)) OVER (PARTITION BY HN.id) AS max_doacoes
    FROM hemonucleo HN
    LEFT JOIN doacao DD ON HN.id = DD.hemonucleo
    GROUP BY HN.id, DD.doador
)
SELECT 
    HN.id AS "id_hemonucleo",
    CD.doador AS "id_doador", 
    PE.nome AS "nome_doador",
    COALESCE(cd.total_doacoes, 0) AS "Nro_doacoes"
FROM hemonucleo HN
LEFT JOIN contagem_doacoes CD ON HN.id = CD.hemonucleo_id 
                            AND CD.total_doacoes = CD.max_doacoes
LEFT JOIN pessoa PE ON PE.id = CD.doador
ORDER BY HN.id;



--------------- Consulta 05 ----------------------------------------------------------
/* 
        Esta consulta retorna os identificadores de bolsa de sangue (id_doacao e numero), o
id do local onde foi gerada, o id do local onde está atualmente, e o número de transferências
das quais a bolsa de sangue participou.
        As duas junções internas iniciais correlacionam, nas tuplas de saída, o id do hemonucleo
onde a bolsa foi gerada. Posteriormente, a junção externa permite a contagem de transferências
envolvendo a bolsa (utilizamos a tabela envolve). 
*/

SELECT 
    BS.doacao AS "id_doacao",
    BS.numero AS "numero_bolsa",
    H1.id AS "local_geracao",
    BS.local_atual AS "local_atual", 
    COUNT(E.transferencia) AS "numero_transferencias"
FROM bolsa_de_sangue BS
-- JOIN para local onde foi gerada (via doacao -> hemonucleo)
INNER JOIN doacao DC ON BS.doacao = DC.id
INNER JOIN hemonucleo H1 ON DC.hemonucleo = H1.id
-- LEFT JOIN para contar transferências (pode ser 0)
LEFT JOIN envolve E ON BS.doacao = E.Doacao AND BS.numero = E.numero
GROUP BY BS.doacao, BS.numero, H1.id, BS.local_atual
ORDER BY BS.doacao, BS.numero;