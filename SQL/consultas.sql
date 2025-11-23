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
                        SELECT 
                                d.doador as "doador"
                        FROM profissional p
                        INNER JOIN doacao d ON d.profissional = p.id
                        WHERE p.id = PR.id                        
                )
                EXCEPT
                (
                        SELECT 
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





--------------- Consulta 05 ----------------------------------------------------------