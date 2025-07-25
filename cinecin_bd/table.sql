-- Tabela base: Pessoa
CREATE TABLE Pessoa (
    cpf VARCHAR(11) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(15),
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Tabela: Cliente
CREATE TABLE Cliente (
    cpf VARCHAR(11) PRIMARY KEY REFERENCES Pessoa(cpf)
);

-- Tabela: Funcionário
CREATE TABLE Funcionario (
    cpf VARCHAR(11) PRIMARY KEY REFERENCES Pessoa(cpf),
    salario NUMERIC(10,2) NOT NULL
);

-- Tabela: Dependente
CREATE TABLE Dependente (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    idade INT CHECK (idade >= 0),
    parentesco VARCHAR(50) NOT NULL,
    funcionario_cpf VARCHAR(11) REFERENCES Funcionario(cpf)
);

-- Tabela: Atendente
CREATE TABLE Atendente (
    cpf VARCHAR(11) PRIMARY KEY REFERENCES Funcionario(cpf),
    chave_caixa VARCHAR(10) NOT NULL
);

-- Tabela: Gerente
CREATE TABLE Gerente (
    cpf VARCHAR(11) PRIMARY KEY REFERENCES Funcionario(cpf),
    cargo_gerencial VARCHAR(100) NOT NULL
);

CREATE TABLE Gerencia (
    gerente_cpf VARCHAR(11) REFERENCES Gerente(cpf),
    atendente_cpf VARCHAR(11) REFERENCES Atendente(cpf),
    PRIMARY key (gerente_cpf, atendente_cpf)
);

-- Tabela: Filme
CREATE TABLE Filme (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    duracao INTERVAL NOT NULL,
    classificacao VARCHAR(10),
    genero VARCHAR(50),
    versao VARCHAR(10) CHECK (versao IN ('Dublado', 'Legendado'))
);

-- Tabela: Sala
CREATE TABLE Sala (
    numero_identificador INT PRIMARY KEY,
    capacidade INT CHECK (capacidade > 0),
    tipo_de_exibicao VARCHAR(10) NOT NULL,
    classificacao VARCHAR(10) CHECK (classificacao IN ('VIP', 'COMUM')),
    super_tela BOOLEAN,
    tela_normal BOOLEAN,
    CHECK (
        (classificacao = 'VIP' AND super_tela = TRUE AND tela_normal = FALSE) OR
        (classificacao = 'COMUM' AND tela_normal = TRUE AND super_tela = FALSE)
    )
);

-- Tabela: Sessão
CREATE TABLE Sessao (
    id SERIAL PRIMARY KEY,
    data DATE NOT NULL,
    horario TIME NOT NULL,
    sala_id INT NOT NULL,
    filme_id INT NOT NULL,
    UNIQUE (sala_id, data, horario), -- restrição de conflito de horário
    FOREIGN KEY (filme_id) REFERENCES Filme(id),
    FOREIGN KEY (sala_id) REFERENCES Sala(numero_identificador)
);

-- Tabela: Ingresso
CREATE TABLE Ingresso (
    id SERIAL PRIMARY KEY,
    tipo VARCHAR(15) CHECK (tipo IN ('Inteira', 'Meia-entrada')),
    assento_letra CHAR(1),
    assento_numero INT,
    sessao_id INT REFERENCES Sessao(id),
    cliente_cpf VARCHAR(11) REFERENCES Cliente(cpf),
    UNIQUE (sessao_id, assento_letra, assento_numero) -- sem assento duplicado na mesma sessão
);

-- Tabela: Venda
CREATE TABLE Transacao (
    id SERIAL PRIMARY KEY,
    funcionario_cpf VARCHAR(11) REFERENCES Funcionario(cpf),
    ingresso_id INT UNIQUE REFERENCES Ingresso(id),
    cliente_cpf VARCHAR(11) REFERENCES Cliente(cpf)
);