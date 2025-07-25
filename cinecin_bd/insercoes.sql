-- PESSOA
INSERT INTO Pessoa (cpf, nome, telefone, email) VALUES 
('12345678901', 'Ana Souza', '81999999999', 'ana.souza@gmail.com'),
('23456789012', 'Bruno Lima', '81988888888', 'bruno.lima@gmail.com'),
('34567890123', 'Carla Menezes', '81977777777', 'carla.menezes@gmail.com'),
('45678901234', 'Daniel Rocha', '81966666666', 'daniel.rocha@gmail.com'),
('56789012345', 'Elisa Teixeira', '81955555555', 'elisa.teixeira@gmail.com'),
('67890123456', 'Fernando Alves', '81944444444', 'fernando.alves@gmail.com'),
('78901234567', 'Gabriela Dias', '81933333333', 'gabriela.dias@gmail.com'),
('89012345678', 'Henrique Borges', '81922222222', 'henrique.borges@gmail.com'),
('56789546632', 'Murilo Pedrosa', '81445255588', 'Pedrozinha@gmail.com');

-- CLIENTE
INSERT INTO Cliente (cpf) VALUES 
('12345678901'),
('23456789012'),
('56789012345'),
('67890123456');

-- FUNCIONARIO
INSERT INTO Funcionario (cpf, salario) VALUES 
('34567890123', 1512.00),
('45678901234', 2500.00),
('78901234567', 1512.00),
('89012345678', 2000.00),
('56789546632', 1512.00);

-- ATENDENTE
INSERT INTO Atendente (cpf, chave_caixa) VALUES 
('34567890123', 'CX001'),
('78901234567', 'CX002'),
('56789546632', 'CX003');


-- GERENTE
INSERT INTO Gerente (cpf, cargo_gerencial) VALUES 
('45678901234', 'Coordenador de Atendimento'),
('89012345678', 'Supervisor Operacional');

-- GERENCIA
INSERT INTO Gerencia (gerente_cpf, atendente_cpf) VALUES 
('45678901234', '34567890123'),
('89012345678', '78901234567');

-- DEPENDENTE
INSERT INTO Dependente (nome, idade, parentesco, funcionario_cpf) VALUES 
('Lucas Rocha', 10, 'Filho', '45678901234'),
('Paula Rocha', 8, 'Filha', '45678901234'),
('Rafael Borges', 12, 'Filho', '89012345678');

-- FILME
INSERT INTO Filme (titulo, duracao, classificacao, genero, versao) VALUES 
('Quarteto Fantástico', '02:16:00', '16', 'Ação', 'Legendado'),
('Como Treinar o seu Dragão', '01:40:00', 'L', 'Animação', 'Dublado'),
('Oppenhaimer', '03:00:00', '18', 'Ficção', 'Legendado'),
('Superman', '02:10:00', '14', 'Ação', 'Dublado');

-- SALA
INSERT INTO Sala (numero_identificador, capacidade, tipo_de_exibicao, classificacao, super_tela, tela_normal) VALUES 
(1, 100, '3D', 'VIP', TRUE, FALSE),
(2, 80, '2D', 'COMUM', FALSE, TRUE),
(3, 120, '3D', 'VIP', TRUE, FALSE),
(4, 60, '2D', 'COMUM', FALSE, TRUE);

-- SESSAO
INSERT INTO Sessao (data, horario, sala_id, filme_id) VALUES 
('2025-07-20', '18:00:00', 1, 1),
('2025-07-20', '16:00:00', 2, 2),
('2025-07-21', '19:00:00', 3, 3),
('2025-07-21', '14:00:00', 4, 4);

-- INGRESSO
INSERT INTO Ingresso (tipo, assento_letra, assento_numero, sessao_id, cliente_cpf) VALUES 
('Inteira', 'A', 1, 1, '67890123456'),
('Meia-entrada', 'B', 2, 2, '23456789012'),
('Inteira', 'C', 5, 3, '56789012345'),
('Meia-entrada', 'D', 10, 4, '12345678901'),
('Inteira', 'E', 6, 1, '12345678901'),
('Meia-entrada', 'F', 8, 3, '12345678901');

-- TRANSACAO
INSERT INTO Transacao(funcionario_cpf, ingresso_id, cliente_cpf) VALUES 
('34567890123', 3,'12345678901'),
('78901234567', 4,'12345678901'),
('34567890123', 5,'12345678901'),
('34567890123', 6,'23456789012'),
('78901234567', 7,'56789012345'),
('78901234567', 8,'67890123456');
