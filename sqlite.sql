-- 1 RESPOSTA
SELECT Dependents.nome AS Cliente , clients.nome AS Nome_Dependente
FROM 

(SELECT cliente.nome AS nome, cliente_conta.id_conta AS id, cliente_conta.dependente AS dependente 
FROM cliente
INNER JOIN cliente_conta 
ON cliente.id = cliente_conta.id_cliente) AS clients

INNER JOIN

(SELECT cliente.nome AS nome, cliente_conta.id_conta AS id, cliente_conta.dependente AS dependente 
FROM cliente
INNER JOIN cliente_conta 
ON cliente.id = cliente_conta.id_conta) AS Dependents

ON Dependents.id = clients.id
WHERE clients.dependente=1 AND Dependents.dependente=1
GROUP BY Nome_Dependente;

-- 2 RESPOSTA
SELECT cliente.nome AS Cliente, conta.numero AS Nro_Conta, 
COUNT(id_cliente_conta)AS Menor_nro_Transacaos
FROM transacao
INNER JOIN cliente_conta
ON cliente_conta.id_cliente = transacao.id_cliente_conta
INNER JOIN cliente ON cliente.id = cliente_conta.id_cliente
INNER JOIN conta ON cliente_conta.id_conta = conta.id
GROUP BY transacao.id_cliente_conta
ORDER BY Menor_nro_Transacaos
LIMIT 5;

SELECT cliente.nome AS Cliente, conta.numero AS Nro_Conta, 
COUNT(id_cliente_conta)AS Maior_nro_Transacaos
FROM (transacao
INNER JOIN cliente_conta
ON cliente_conta.id_cliente = transacao.id_cliente_conta
INNER JOIN cliente ON cliente.id = cliente_conta.id_cliente
INNER JOIN conta ON cliente_conta.id_conta = conta.id)
GROUP BY transacao.id_cliente_conta
ORDER BY Maior_nro_Transacaos DESC
LIMIT 5;

-- 3 RESPOSTA
SELECT cliente.nome AS Cliente, conta.numero AS NroConta,
SUM(CASE WHEN id_tipo_transacao = 1 THEN valor 
WHEN id_tipo_transacao = 2 THEN (-1)*valor 
WHEN id_tipo_transacao = 3 THEN (-1)*valor 
WHEN id_tipo_transacao = 4 THEN valor ELSE 0 END) AS Total

FROM (transacao
JOIN cliente_conta
ON cliente_conta.id_cliente = transacao.id_cliente_conta
JOIN cliente ON cliente.id = cliente_conta.id_cliente
JOIN conta ON cliente_conta.id_conta = conta.id)

GROUP BY id_cliente_conta;
