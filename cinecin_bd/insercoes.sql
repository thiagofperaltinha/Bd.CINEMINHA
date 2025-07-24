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
('90123456789', 'Isabela Martins', '81911111111', 'isabela.martins@gmail.com'),
('01234567890', 'João Pedro', '81900000000', 'joao.pedro@gmail.com'),
('11223344556', 'Mariana Silva', '81924321860', 'mariana.silva@gmail.com'),
('22334455667', 'Carlos Eduardo', '81932458712', 'carlos.eduardo@gmail.com'),
('31415926535', 'Vinícius Santos', '81911112222', 'vinicius.santos@gmail.com'),
('27182818284', 'Juliana Castro', '81933334444', 'juliana.castro@gmail.com'),
('16180339887', 'Rodrigo Barros', '81955556666', 'rodrigo.barros@gmail.com'),
('14142135623', 'Patrícia Nunes', '81977778888', 'patricia.nunes@gmail.com'),
('17320508075', 'Tiago Martins', '81999990000', 'tiago.martins@gmail.com');

SELECT * FROM Pessoa;

-- CLIENTE
INSERT INTO Cliente (cpf) VALUES 
('12345678901'),
('23456789012'),
('56789012345'),
('67890123456'),
('90123456789'),
('01234567890'),
('31415926535'),
('27182818284'),
('16180339887'),
('14142135623'),
('17320508075');

SELECT * FROM Cliente;

-- FUNCIONARIO
INSERT INTO Funcionario (cpf, salario) VALUES 
('34567890123', 1512.00),
('45678901234', 2500.00),
('78901234567', 1512.00),
('89012345678', 2000.00),
('11223344556', 1800.00),
('22334455667', 2200.00);

SELECT * FROM Funcionario;

-- ATENDENTE
INSERT INTO Atendente (cpf, chave_caixa) VALUES 
('34567890123', 'CX001'),
('78901234567', 'CX002'),
('11223344556', 'CX003');

SELECT * FROM Atendente;

-- GERENTE
INSERT INTO Gerente (cpf, cargo_gerencial) VALUES 
('45678901234', 'Coordenador de Atendimento'),
('22334455667', 'Gerente Geral'),
('89012345678', 'Supervisor Operacional');

SELECT * FROM Gerente;

-- GERENCIA
INSERT INTO Gerencia (gerente_cpf, atendente_cpf) VALUES 
('45678901234', '34567890123'),
('22334455667', '11223344556'),
('89012345678', '78901234567');

SELECT * FROM Gerencia;

-- DEPENDENTE
INSERT INTO Dependente (nome, idade, parentesco, funcionario_cpf) VALUES 
('Lucas Rocha', 10, 'Filho', '45678901234'),
('Paula Rocha', 8, 'Filha', '45678901234'),
('Joana Martins', 5, 'Filha', '11223344556'),
('José Eduardo', 63, 'Pai', '22334455667'),
('Rafael Borges', 12, 'Filho', '89012345678');

SELECT * FROM Dependente;

-- FILME
INSERT INTO Filme (titulo, duracao, classificacao, genero, versao) VALUES 
('Quarteto Fantástico', '02:16:00', '16', 'Ação', 'Legendado'),
('Como Treinar o seu Dragão', '01:40:00', 'L', 'Animação', 'Dublado'),
('Oppenhaimer', '03:00:00', '18', 'Ficção', 'Legendado'),
('Superman', '02:10:00', '14', 'Ação', 'Dublado'),
('Lilo e Stitch', '01:25:00', 'L', 'Animação', 'Dublado'),
('Barbie', '01:54:00', '12', 'Comédia', 'Legendado'),
('Homem-Aranha: Através do Aranhaverso', '02:20:00', '10', 'Animação', 'Dublado');

SELECT * FROM Filme;

-- SALA
INSERT INTO Sala (numero_identificador, capacidade, tipo_de_exibicao, classificacao, super_tela, tela_normal) VALUES 
(1, 100, '3D', 'VIP', TRUE, FALSE),
(2, 80, '2D', 'COMUM', FALSE, TRUE),
(3, 120, '3D', 'VIP', TRUE, FALSE),
(4, 60, '2D', 'COMUM', FALSE, TRUE),
(5, 150, 'IMAX', 'VIP', TRUE, FALSE),
(6, 90, '2D', 'COMUM', FALSE, TRUE);

SELECT * FROM Sala;

-- SESSAO
INSERT INTO Sessao (data, horario, sala_id, filme_id) VALUES 
('2025-07-20', '18:00:00', 1, 1),
('2025-07-20', '18:00:00', 2, 2),
('2025-07-20', '18:30:00', 3, 4),
('2025-07-20', '16:00:00', 2, 2),
('2025-07-21', '18:00:00', 1, 5),
('2025-07-21', '19:00:00', 3, 3),
('2025-07-21', '19:45:00', 5, 2),
('2025-07-21', '20:00:00', 4, 4),
('2025-07-21', '22:00:00', 5, 4),
('2025-07-22', '17:00:00', 2, 5),
('2025-07-22', '18:30:00', 6, 6),
('2025-07-22', '20:00:00', 5, 7),
('2025-07-23', '21:00:00', 5, 7),
('2025-07-23', '17:00:00', 6, 5);

SELECT * FROM Sessao;

-- INGRESSO
INSERT INTO Ingresso (tipo, assento_letra, assento_numero, sessao_id, cliente_cpf) VALUES 
('Inteira', 'A', 1, 1, '12345678901'),
('Meia-entrada', 'B', 2, 2, '23456789012'),
('Inteira', 'C', 5, 3, '56789012345'),
('Meia-entrada', 'D', 10, 4, '67890123456'),
('Inteira', 'E', 6, 1, '56789012345'),
('Meia-entrada', 'F', 8, 3, '01234567890'),
('Meia-entrada', 'F', 9, 3, '01234567890'),
('Inteira', 'G', 10, 5, '90123456789'),
('Inteira', 'I', 20, 7, '56789012345'),
('Meia-entrada', 'J', 25, 8, '67890123456'),
('Meia-entrada', 'A', 2, 1, '31415926535'),
('Inteira', 'A', 3, 1, '27182818284'),
('Inteira', 'A', 4, 1, '27182818284'),
('Meia-entrada', 'B', 1, 3, '12345678901'),
('Meia-entrada', 'B', 2, 3, '12345678901'),
('Inteira', 'C', 1, 6, '14142135623'),
('Meia-entrada', 'C', 2, 6, '14142135623'),
('Inteira', 'D', 1, 10, '56789012345'),
('Meia-entrada', 'D', 2, 10, '01234567890'),
('Meia-entrada', 'D', 3, 10, '01234567890'),
('Meia-entrada', 'E', 1, 12, '17320508075'),
('Inteira', 'E', 2, 12, '17320508075'),
('Inteira', 'F', 1, 13, '31415926535'),
('Meia-entrada', 'F', 2, 13, '67890123456'),
('Meia-entrada', 'G', 1, 14, '27182818284'),
('Inteira', 'G', 2, 14, '27182818284'),
('Inteira', 'G', 3, 14, '27182818284');

SELECT * FROM Ingresso;