/* 9. Crie 20 perguntas e 20 respostas onde as respostas devem ser todas com Join.*/

/*1. Quais carros foram alugados por cada cliente?*/
SELECT c.nome, car.modelo
FROM CLIENTES c
JOIN LOCACAO l ON c.idCliente = l.fk_idCliente
JOIN CARROS car ON l.fk_idCarro = car.idCarro;

/*2. Quais clientes alugaram carros da categoria "SUV"?*/
SELECT c.nome, car.categoria
FROM CLIENTES c
JOIN LOCACAO l ON c.idCliente = l.fk_idCliente
JOIN CARROS car ON l.fk_idCarro = car.idCarro
WHERE car.categoria = 'SUV';

/*3. Quais carros têm devoluções registradas?*/
SELECT car.modelo, d.dataDevolucao
FROM CARROS car
JOIN LOCACAO l ON car.idCarro = l.fk_idCarro
JOIN DEVOLUCAO d ON l.idLocacao = d.idLocacao;

/*4. Quais clientes devolveram carros com quilometragem acima do permitido?*/
SELECT c.nome, d.quilometragemFinal, l.quilometragemPermitida
FROM CLIENTES c
JOIN LOCACAO l ON c.idCliente = l.fk_idCliente
JOIN DEVOLUCAO d ON l.idLocacao = d.idLocacao
WHERE d.quilometragemFinal > l.quilometragemPermitida;

/*5. Quais carros possuem devoluções com valor extra?*/
SELECT car.modelo, d.valorExtra
FROM CARROS car
JOIN LOCACAO l ON car.idCarro = l.fk_idCarro
JOIN DEVOLUCAO d ON l.idLocacao = d.idLocacao
WHERE d.valorExtra > 0;

/*6. Quais clientes alugaram carros fabricados pela Toyota?*/
SELECT c.nome, car.fabricante
FROM CLIENTES c
JOIN LOCACAO l ON c.idCliente = l.fk_idCliente
JOIN CARROS car ON l.fk_idCarro = car.idCarro
WHERE car.fabricante = 'Toyota';

/*7. Quais carros têm mais de 5 ocupantes e foram alugados?*/
SELECT car.modelo, dim.ocupante
FROM CARROS car
JOIN DIMENSOES dim ON car.idCarro = dim.fk_idCarro
JOIN LOCACAO l ON car.idCarro = l.fk_idCarro
WHERE dim.ocupante > 5;

/*8. Quais locações possuem clientes do tipo "Premium"?*/
SELECT l.idLocacao, c.tipo
FROM LOCACAO l
JOIN CLIENTES c ON l.fk_idCliente = c.idCliente
WHERE c.tipo = 'Premium';

/*9. Quais carros brancos foram devolvidos com quilometragem acima do permitido?*/
SELECT car.modelo, d.quilometragemFinal
FROM CARROS car
JOIN LOCACAO l ON car.idCarro = l.fk_idCarro
JOIN DEVOLUCAO d ON l.idLocacao = d.idLocacao
WHERE car.cor = 'Branco' AND d.quilometragemFinal > l.quilometragemPermitida;

/*10. Qual é o valor total das locações por cliente?*/
SELECT c.nome, SUM(l.valorDiaria) AS totalGasto
FROM CLIENTES c
JOIN LOCACAO l ON c.idCliente = l.fk_idCliente
GROUP BY c.nome;

/*11. Quais são os modelos e suas categorias alugados por clientes intermediários?*/
SELECT car.modelo, car.categoria
FROM CARROS car
JOIN LOCACAO l ON car.idCarro = l.fk_idCarro
JOIN CLIENTES c ON l.fk_idCliente = c.idCliente
WHERE c.tipo = 'Intermediario';

/*12. Quais carros têm porta-malas maior que 300L e foram alugados?*/
SELECT car.modelo, dim.porta_mala_L
FROM CARROS car
JOIN DIMENSOES dim ON car.idCarro = dim.fk_idCarro
JOIN LOCACAO l ON car.idCarro = l.fk_idCarro
WHERE dim.porta_mala_L > 300;

/*13. Quais clientes nunca devolveram carros?*/
SELECT c.nome
FROM CLIENTES c
LEFT JOIN LOCACAO l ON c.idCliente = l.fk_idCliente
LEFT JOIN DEVOLUCAO d ON l.idLocacao = d.idLocacao
WHERE d.idDevolucao IS NULL;

/*14. Quais são os modelos de carros alugados por mais de um cliente?*/
SELECT car.modelo, COUNT(DISTINCT l.fk_idCliente) AS totalClientes
FROM CARROS car
JOIN LOCACAO l ON car.idCarro = l.fk_idCarro
GROUP BY car.modelo
HAVING totalClientes > 1;

/*15. Quais carros foram devolvidos em fevereiro de 2023?*/
SELECT car.modelo, d.dataDevolucao
FROM CARROS car
JOIN LOCACAO l ON car.idCarro = l.fk_idCarro
JOIN DEVOLUCAO d ON l.idLocacao = d.idLocacao
WHERE d.dataDevolucao BETWEEN '2023-02-01' AND '2023-02-28';

/*16. Quais são os clientes e os carros alugados juntos?*/
SELECT c.nome, car.modelo
FROM CLIENTES c
JOIN LOCACAO l ON c.idCliente = l.fk_idCliente
JOIN CARROS car ON l.fk_idCarro = car.idCarro;

/*17. Qual é o carro mais alugado?*/
SELECT car.modelo, COUNT(l.idLocacao) AS totalAlugado
FROM CARROS car
JOIN LOCACAO l ON car.idCarro = l.fk_idCarro
GROUP BY car.modelo
ORDER BY totalAlugado DESC
LIMIT 1;

/*18. Quais clientes devolveram carros com tanque de combustível acima de 50L?*/
SELECT c.nome, dim.tanque_L
FROM CLIENTES c
JOIN LOCACAO l ON c.idCliente = l.fk_idCliente
JOIN DEVOLUCAO d ON l.idLocacao = d.idLocacao
JOIN CARROS car ON l.fk_idCarro = car.idCarro
JOIN DIMENSOES dim ON car.idCarro = dim.fk_idCarro
WHERE dim.tanque_L > 50;

/*19. Qual é a soma dos valores extras pagos em devoluções por cliente?*/
SELECT c.nome, SUM(d.valorExtra) AS totalExtra
FROM CLIENTES c
JOIN LOCACAO l ON c.idCliente = l.fk_idCliente
JOIN DEVOLUCAO d ON l.idLocacao = d.idLocacao
GROUP BY c.nome;

/*20. Quais são os carros mais alugados por categoria?*/
SELECT car.categoria, car.modelo, COUNT(l.idLocacao) AS totalAlugado
FROM CARROS car
JOIN LOCACAO l ON car.idCarro = l.fk_idCarro
GROUP BY car.categoria, car.modelo
ORDER BY totalAlugado DESC;