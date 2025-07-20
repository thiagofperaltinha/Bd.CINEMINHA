-- Funcionários com dependentes menores de 12 anos
SELECT f.cpf, f.salario, d.nome AS dependente, d.idade
FROM Funcionario f
JOIN Dependente d ON f.cpf = d.funcionario_cpf
WHERE d.idade < 12;

-- Funcionários que não possuem dependentes (incluindo nome dos funcionários)
SELECT f.cpf, p.nome, f.salario
FROM Funcionario f
JOIN Pessoa p ON f.cpf = p.cpf
LEFT JOIN Dependente d ON f.cpf = d.funcionario_cpf
WHERE d.id IS NULL;

-- Mostrar os gerentes e os atendentes que eles supervisionam
SELECT g.cpf AS gerente_cpf, g.cargo_gerencial, a.cpf AS atendente_cpf, a.chave_caixa
FROM Gerente g
JOIN Gerencia ge ON g.cpf = ge.gerente_cpf
JOIN Atendente a ON ge.atendente_cpf = a.cpf;

-- Assentos ocupados na sessão 3
SELECT i.assento_letra, i.assento_numero
FROM Ingresso i
WHERE i.sessao_id = 3;

-- Quantos ingressos para o filme Superman foram vendidos no total (incluindo a data)
SELECT COUNT(*) AS total_ingressos, s.data
FROM Ingresso i
JOIN Sessao s ON i.sessao_id = s.id
JOIN Filme f ON s.filme_id = f.id
WHERE f.titulo = 'Superman'
GROUP BY s.data;

-- Lotação de cada sessão (ordenados por ID da sessão)
SELECT s.id AS sessao_id, COUNT(i.id) AS ingressos_vendidos
FROM Sessao s
LEFT JOIN Ingresso i ON s.id = i.sessao_id
GROUP BY s.id
ORDER BY s.id ASC;

-- Sessões que ainda têm assentos disponíveis
SELECT s.id AS sessao_id, 
       COUNT(i.id) AS assentos_vendidos, 
       sa.capacidade - COUNT(i.id) AS assentos_disponiveis
FROM Sessao s
JOIN Sala sa ON s.sala_id = sa.numero_identificador
LEFT JOIN Ingresso i ON s.id = i.sessao_id
GROUP BY s.id, sa.capacidade
HAVING sa.capacidade - COUNT(i.id) > 0;

-- Filmes com duração maior que 2 horas
SELECT titulo, duracao
FROM Filme
WHERE duracao > '02:00:00';

-- Filmes dublados que serão exibidos em salas comuns
SELECT f.titulo, f.versao, sa.classificacao
FROM Filme f
JOIN Sessao s ON f.id = s.filme_id
JOIN Sala sa ON s.sala_id = sa.numero_identificador
WHERE f.versao = 'Dublado' AND sa.classificacao = 'COMUM';

-- Total de ingressos vendidos por tipo (inteira x meia)
SELECT i.tipo, COUNT(*) AS total_vendidos
FROM Ingresso i
GROUP BY i.tipo;

-- Clientes que compraram mais de 1 ingresso
SELECT i.cliente_cpf, COUNT(*) AS total_ingressos
FROM Ingresso i
GROUP BY i.cliente_cpf
HAVING COUNT(*) > 1;

-- Listar todos os filmes com suas salas e horários de exibição
SELECT f.titulo, s.data, s.horario, sa.numero_identificador AS sala
FROM Filme f
JOIN Sessao s ON f.id = s.filme_id
JOIN Sala sa ON s.sala_id = sa.numero_identificador;

-- Clientes que compraram ingressos em mais de uma sessão
SELECT p.nome, COUNT(DISTINCT s.id) AS sessoes_distintas
FROM Compra c
JOIN Ingresso i ON c.ingresso_id = i.id
JOIN Sessao s ON i.sessao_id = s.id
JOIN Pessoa p ON c.cliente_cpf = p.cpf
GROUP BY p.nome
HAVING COUNT(DISTINCT s.id) > 1;

-- Sessões com lotação superior a 70% da capacidade da sala
SELECT s.id AS sessao_id, f.titulo, sa.capacidade,
       COUNT(i.id) AS ingressos_vendidos,
       ROUND(COUNT(i.id)::decimal / sa.capacidade * 100, 1) AS porcentagem_lotacao
FROM Sessao s
JOIN Filme f ON s.filme_id = f.id
JOIN Sala sa ON s.sala_id = sa.numero_identificador
JOIN Ingresso i ON s.id = i.sessao_id
GROUP BY s.id, f.titulo, sa.capacidade
HAVING COUNT(i.id) > sa.capacidade * 0.7
ORDER BY porcentagem_lotacao DESC;

-- Quantos clientes compraram meia-entrada por filme
SELECT f.titulo, COUNT(*) AS meia_entrada
FROM Ingresso i
JOIN Sessao s ON i.sessao_id = s.id
JOIN Filme f ON s.filme_id = f.id
WHERE i.tipo = 'Meia-entrada'
GROUP BY f.titulo
ORDER BY meia_entrada DESC;

-- Funcionário (nome) que mais realizou vendas
SELECT p.nome, COUNT(*) AS total_vendas
FROM Venda v
JOIN Pessoa p ON v.funcionario_cpf = p.cpf
GROUP BY p.nome
ORDER BY total_vendas DESC
LIMIT 1;

-- Nome, email e total de ingressos comprados por cada cliente
SELECT p.nome, p.email, COUNT(c.ingresso_id) AS total_ingressos
FROM Compra c
JOIN Pessoa p ON c.cliente_cpf = p.cpf
GROUP BY p.nome, p.email
ORDER BY total_ingressos DESC;