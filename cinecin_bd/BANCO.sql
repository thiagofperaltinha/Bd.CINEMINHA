-- DROP TABLES (ordem para não ter problema de FK)
DROP TABLE IF EXISTS Transacao CASCADE;
DROP TABLE IF EXISTS Ingresso CASCADE;
DROP TABLE IF EXISTS Sessao CASCADE;
DROP TABLE IF EXISTS Sala CASCADE;
DROP TABLE IF EXISTS Filme CASCADE;
DROP TABLE IF EXISTS Dependente CASCADE;
DROP TABLE IF EXISTS Gerencia CASCADE;
DROP TABLE IF EXISTS Gerente CASCADE;
DROP TABLE IF EXISTS Atendente CASCADE;
DROP TABLE IF EXISTS Funcionario CASCADE;
DROP TABLE IF EXISTS Cliente CASCADE;
DROP TABLE IF EXISTS Pessoa CASCADE;

-- CREATE TABLES

CREATE TABLE Pessoa (
    cpf VARCHAR(11) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(15),
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Cliente (
    cpf VARCHAR(11) PRIMARY KEY,
    FOREIGN KEY (cpf) REFERENCES Pessoa(cpf)
);

CREATE TABLE Funcionario (
    cpf VARCHAR(11) PRIMARY KEY,
    salario NUMERIC(10,2),
    FOREIGN KEY (cpf) REFERENCES Pessoa(cpf)
);

CREATE TABLE Atendente (
    cpf VARCHAR(11) PRIMARY KEY,
    chave_caixa VARCHAR(10),
    FOREIGN KEY (cpf) REFERENCES Funcionario(cpf)
);

CREATE TABLE Gerente (
    cpf VARCHAR(11) PRIMARY KEY,
    cargo_gerencial VARCHAR(100),
    FOREIGN KEY (cpf) REFERENCES Funcionario(cpf)
);

CREATE TABLE Gerencia (
    gerente_cpf VARCHAR(11),
    atendente_cpf VARCHAR(11),
    PRIMARY KEY (gerente_cpf, atendente_cpf),
    FOREIGN KEY (gerente_cpf) REFERENCES Gerente(cpf),
    FOREIGN KEY (atendente_cpf) REFERENCES Atendente(cpf)
);

CREATE TABLE Dependente (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    idade INT,
    parentesco VARCHAR(50),
    funcionario_cpf VARCHAR(11),
    FOREIGN KEY (funcionario_cpf) REFERENCES Funcionario(cpf)
);

CREATE TABLE Filme (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(200),
    duracao TIME,
    classificacao VARCHAR(5),
    genero VARCHAR(50),
    versao VARCHAR(50)
);

CREATE TABLE Sala (
    numero_identificador INT PRIMARY KEY,
    capacidade INT,
    tipo_de_exibicao VARCHAR(20),
    classificacao VARCHAR(20),
    super_tela BOOLEAN,
    tela_normal BOOLEAN
);

CREATE TABLE Sessao (
    id SERIAL PRIMARY KEY,
    data DATE,
    horario TIME,
    sala_id INT,
    filme_id INT,
    FOREIGN KEY (sala_id) REFERENCES Sala(numero_identificador),
    FOREIGN KEY (filme_id) REFERENCES Filme(id)
);

CREATE TABLE Ingresso (
    id SERIAL PRIMARY KEY,
    tipo VARCHAR(20),
    assento_letra CHAR(1),
    assento_numero INT,
    sessao_id INT,
    cliente_cpf VARCHAR(11),
    FOREIGN KEY (sessao_id) REFERENCES Sessao(id),
    FOREIGN KEY (cliente_cpf) REFERENCES Cliente(cpf)
);

CREATE TABLE Transacao (
    id SERIAL PRIMARY KEY,
    funcionario_cpf VARCHAR(11),
    ingresso_id INT,
    cliente_cpf VARCHAR(11),
    FOREIGN KEY (funcionario_cpf) REFERENCES Funcionario(cpf),
    FOREIGN KEY (ingresso_id) REFERENCES Ingresso(id),
    FOREIGN KEY (cliente_cpf) REFERENCES Cliente(cpf)
);

-- INSERÇÃO DOS DADOS (corrigidos conforme o que te passei)

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
('Superman', '02:10:00', '14', 'Ação', 'Dublado'),
('Lilo e Stitch', '01:25:00', 'L', 'Animação', 'Dublado'),
('Barbie', '01:54:00', '12', 'Comédia', 'Legendado'),
('Homem-Aranha: Através do Aranhaverso', '02:20:00', '10', 'Animação', 'Dublado');

-- SALA
INSERT INTO Sala (numero_identificador, capacidade, tipo_de_exibicao, classificacao, super_tela, tela_normal) VALUES 
(1, 100, '3D', 'VIP', TRUE, FALSE),
(2, 80, '2D', 'COMUM', FALSE, TRUE),
(3, 120, '3D', 'VIP', TRUE, FALSE),
(4, 60, '2D', 'COMUM', FALSE, TRUE),
(5, 150, 'IMAX', 'VIP', TRUE, FALSE),
(6, 90, '2D', 'COMUM', FALSE, TRUE);

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

-- INGRESSO (com id para referencia na transacao)
INSERT INTO Ingresso (id, tipo, assento_letra, assento_numero, sessao_id, cliente_cpf) VALUES 
(1, 'Inteira', 'A', 1, 1, '67890123456'),
(2, 'Meia-entrada', 'B', 2, 2, '23456789012'),
(3, 'Inteira', 'C', 5, 3, '56789012345'),
(4, 'Meia-entrada', 'D', 10, 4, '12345678901'),
(5, 'Inteira', 'E', 6, 1, '12345678901'),
(6, 'Meia-entrada', 'F', 8, 3, '12345678901');

-- TRANSACAO (com id e referencia a ingressos válidos)
INSERT INTO Transacao(id, funcionario_cpf, ingresso_id, cliente_cpf) VALUES 
(1, '34567890123', 3, '56789012345'),
(2, '78901234567', 4, '12345678901'),
(3, '34567890123', 5, '12345678901'),
(4, '34567890123', 6, '12345678901'),
(5, '78901234567', 1, '67890123456'),
(6, '78901234567', 2, '23456789012');
