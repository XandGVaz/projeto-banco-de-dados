/*
        Script SQL referente às consultas do sistema de doaçao de sangue (Grupo 06)
        Autores:
               - Danielle Pereira - 11918539
               - Gabriel Dezejácomo Maruschi - 14571525
               - Pedro Gasparelo Leme - 14602421
               - Vitor Alexandre Garcia Vaz - 14611432
*/

--------------- Consulta 01 ----------------------------------------------------------





--------------- Consulta 02 ----------------------------------------------------------





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
INNER JOIN pessoa OPE ON OPR.id = OPE.id
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
VERSAO NÃO OTIMIZADA
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

/*
VERSÃO OTIMIZADA
        A query inicia selecionando o id_doador, o nome_doador, o id_hemonucleo e o Nro_doacoes,
utilizando COALESCE para substituir NULL por 0. Dentro do LEFT JOIN, a subquery agrupa todas as 
doacoes por hemonucleo e doador (em GROUP BY), contando quantas doacoes cada doador fez em cada
hemonucleo. PARTITION particiona por hemonúcleo o quantas doações cada doador fez neste, enquanto
o MAX(COUNT()) conta o valor máximo em cada partição.
        Esta solução evita um SELECT externo com a mesma tabela usada em WITH, oq gerava redundancia
de busca e subotimização.
*/

SELECT 
    HN.id AS "id_hemonucleo",
    contagens.doador AS "id_doador", 
    PE.nome AS "nome_doador",
    COALESCE(contagens.total_doacoes, 0) AS "Nro_doacoes"
FROM hemonucleo HN
LEFT JOIN (
    SELECT 
        hemonucleo,
        doador,
        COUNT(*) AS total_doacoes,
        MAX(COUNT(*)) OVER (PARTITION BY hemonucleo) AS max_doacoes
    FROM doacao
    GROUP BY hemonucleo, doador
) contagens ON HN.id = contagens.hemonucleo
           AND contagens.total_doacoes = contagens.max_doacoes
LEFT JOIN pessoa PE ON PE.id = contagens.doador
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