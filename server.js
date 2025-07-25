const pool = require('./db')

// FUNÇÃO DE CONSULTAS GERAIS
async function consultas_principais(){
    try{
        const pessoa = await pool.query('SELECT * FROM Pessoa')
        console.log('TABELA DE PESSOAS')
        console.table(pessoa.rows)

        const funcionario = await pool.query('SELECT * FROM Funcionario')
        console.log('TABELA DE FUNCIONARIOS')
        console.table(funcionario.rows)

        const cliente = await pool.query('SELECT * FROM Cliente')
        console.log('TABELA DE CLIENTES')
        console.table(cliente.rows)

        const atendente = await pool.query('SELECT * FROM Atendente')
        console.log('TABELA DE ATENDENTES')
        console.table(atendente.rows)

        const gerente = await pool.query('SELECT * FROM Gerente')
        console.log('TABELA DE GERENTES')
        console.table(gerente.rows)

        const ingresso = await pool.query('SELECT * FROM Ingresso')
        console.log('TABELA DE INGRESSO')
        console.table(ingresso.rows)

        const filme = await pool.query('SELECT * FROM Filme')
        console.log('TABELA DE FILMES')
        console.table(filme.rows)

        const sessao = await pool.query('SELECT * FROM Sessao')
        console.log('TABELA DE SESSÕES')
        console.table(sessao.rows)

        const sala = await pool.query('SELECT * FROM Sala')
        console.log('TABELA DE SALAS')
        console.table(sala.rows)

        const gerencia = await pool.query('SELECT * FROM Gerencia')
        console.log('TABELA DA RELAÇÃO GERENCIA')
        console.table(gerencia.rows)

        const dependente = await pool.query('SELECT * FROM Dependente')
        console.log('TABELA DEPENDENTES')
        console.table(dependente.rows)

        const transacao = await pool.query('SELECT * FROM Transacao')
        console.log('TABELA DA RELAÇÃO TRANSAÇÃO')
        console.table(transacao.rows)

    }catch(error){
        console.error('Não foi possível', error)
    }
}

async function consultas_elaboradas() {
    try {
        const sessao = await pool.query("SELECT filme_id FROM Sessao WHERE filme_id = 1;")
        console.log('SESSÕES EXIBIDAS ACIMA DAS 16:00:00')
        console.table(sessao.rows)

        const mais_ingresso = await pool.query(`
            SELECT cliente_cpf, COUNT(*) AS ingressos_comprados
            FROM Transacao
            GROUP BY cliente_cpf
            HAVING COUNT(*) > 1
        `)
        console.log('CLIENTES COM MAIS DE UM INGRESSO COMPRADO')
        console.table(mais_ingresso.rows)

        const mais_transacoes = await pool.query(`
            SELECT p.cpf, COUNT(t.id) AS total_transacoes
            FROM Pessoa p
            JOIN Funcionario f ON f.cpf = p.cpf
            JOIN Transacao t ON f.cpf = t.funcionario_cpf
            GROUP BY p.cpf
            ORDER BY total_transacoes DESC
            LIMIT 1
        `)
        console.log('FUNCIONARIO COM MAIS VENDAS/TRANSAÇÕES')
        console.table(mais_transacoes.rows)

        const ingressos_filme = await pool.query(`    
            SELECT f.titulo, COUNT(t.id) AS ingressos_vendidos
            FROM Filme f
            JOIN Sessao s ON f.id = s.filme_id
            JOIN Ingresso i ON i.sessao_id = s.id
            JOIN Transacao t ON t.ingresso_id = i.id
            GROUP BY f.titulo
            ORDER BY ingressos_vendidos DESC
        `)
        console.log('INGRESSOS VENDIDOS POR FILME')
        console.table(ingressos_filme.rows)

        const clientes_ing_leg = await pool.query(`
            SELECT DISTINCT p.nome, f.titulo
            FROM Pessoa p
            JOIN Cliente c ON p.cpf = c.cpf
            JOIN Ingresso i ON i.cliente_cpf = c.cpf
            JOIN Sessao s ON s.id = i.sessao_id
            JOIN Filme f ON f.id = s.filme_id
            WHERE f.versao = 'Legendado';
        `)
        console.log('CLIENTES COM INGRESSOS PARA SESSÕES COM FILMES LEGENDADOS')
        console.table(clientes_ing_leg.rows)

        const venda_funcionario = await pool.query(`
            SELECT f.cpf, p.nome, COUNT(t.id) AS total_vendas
            FROM Funcionario f
            JOIN Pessoa p ON p.cpf = f.cpf
            LEFT JOIN Transacao t ON t.funcionario_cpf = f.cpf
            GROUP BY f.cpf, p.nome
            ORDER BY total_vendas DESC;
        `)
        console.log('QUANTIDADE DE INGRESSOS VENDIDOS POR CADA FUNCIONARIO')
        console.table(venda_funcionario.rows)

        const lista_sessao1 = await pool.query(`
            SELECT s.id AS sessao_id, COUNT(i.id) AS ingressos_vendidos
            FROM Sessao s
            JOIN Ingresso i ON i.sessao_id = s.id
            GROUP BY s.id
            HAVING COUNT(i.id) >= 2;
        `)
        console.log('SESSÕES COM MAIS DE 1 INGRESSOS VENDIDOS')
        console.table(lista_sessao1.rows)

        const gerente_1 = await pool.query(`
            SELECT g.cpf, p.nome, COUNT(ge.atendente_cpf) AS num_atendentes
            FROM Gerente g
            JOIN Pessoa p ON p.cpf = g.cpf
            JOIN Gerencia ge ON ge.gerente_cpf = g.cpf
            GROUP BY g.cpf, p.nome
            HAVING COUNT(ge.atendente_cpf) >= 1;
        `)
        console.log('GERENTES QUE GERENCIAM MAIS DE 1 OU MAIS ATENDENTE')
        console.table(gerente_1.rows)

        const filmes_svip = await pool.query(`
            SELECT DISTINCT f.titulo, s.numero_identificador AS sala
            FROM Filme f
            JOIN Sessao ss ON ss.filme_id = f.id
            JOIN Sala s ON s.numero_identificador = ss.sala_id
            WHERE s.classificacao = 'VIP';
        `)
        console.log('FILMES EXIBIDOS EM SALAS VIP')
        console.table(filmes_svip.rows)

        const mais1_ingresso = await pool.query(`
            SELECT p.nome, COUNT(DISTINCT f.id) AS filmes_diferentes
            FROM Pessoa p
            JOIN Cliente c ON c.cpf = p.cpf
            JOIN Ingresso i ON i.cliente_cpf = c.cpf
            JOIN Sessao s ON s.id = i.sessao_id
            JOIN Filme f ON f.id = s.filme_id
            GROUP BY p.nome
            HAVING COUNT(DISTINCT f.id) > 1;   
        `)
        console.log('CLIENTES QUE COMPRARAM INGRESSO PARA MAIS DE 1 FILME DIFERENTE')
        console.table(mais1_ingresso.rows)

        const sessao_filtrada = await pool.query(`
            SELECT s.id, s.data, s.horario, f.titulo, sala.classificacao
            FROM Sessao s
            JOIN Filme f ON f.id = s.filme_id
            JOIN Sala sala ON sala.numero_identificador = s.sala_id
            WHERE s.horario BETWEEN '14:00:00' AND '20:00:00'
              AND sala.classificacao = 'VIP';
        `)
        console.log('SESSÕES ENTRE 14h E 20h EM SALAS VIP')
        console.table(sessao_filtrada.rows)

        const dependente_menor = await pool.query(`
            SELECT DISTINCT p.nome AS funcionario_nome, f.cpf AS funcionario_cpf
            FROM Funcionario f
            JOIN Pessoa p ON p.cpf = f.cpf
            JOIN Dependente d ON d.funcionario_cpf = f.cpf
            WHERE d.idade < 18;
        `)
        console.log('FUNCIONÁRIOS COM DEPENDENTES MENORES DE 18 ANOS')
        console.table(dependente_menor.rows)

        const atendentes_gerentes = await pool.query(`
            SELECT a.cpf AS atendente_cpf, pa.nome AS atendente_nome,
                   g.cpf AS gerente_cpf, pg.nome AS gerente_nome
            FROM Gerencia ge
            JOIN Atendente a ON a.cpf = ge.atendente_cpf
            JOIN Pessoa pa ON pa.cpf = a.cpf
            JOIN Gerente g ON g.cpf = ge.gerente_cpf
            JOIN Pessoa pg ON pg.cpf = g.cpf;
        `)
        console.log('ATENDENTES E SEUS GERENTES')
        console.table(atendentes_gerentes.rows)

          const filmes_multiplas_sessoes = await pool.query(`
            SELECT f.titulo, COUNT(s.id) AS total_sessoes
            FROM Filme f
            JOIN Sessao s ON s.filme_id = f.id
            GROUP BY f.titulo
            HAVING COUNT(s.id) >= 1;
        `)
        console.log('FILMES COM MAIS DE UMA SESSÕES')
        console.table(filmes_multiplas_sessoes.rows)
        
        const cliente_0 = await pool.query(`
        SELECT p.nome, p.cpf
        FROM Pessoa p
        JOIN Cliente c ON c.cpf = p.cpf
        WHERE p.cpf NOT IN (
            SELECT i.cliente_cpf FROM Ingresso i
        );
        `)
        console.log('TABELA DE CLIENTES QUE NÃO COMPRARAM INGRESSO')
        console.table(cliente_0.rows)

    
        const filmes_multiplas_salas = await pool.query(`
            SELECT f.titulo, COUNT(DISTINCT s.sala_id) AS salas_diferentes
            FROM Filme f
            JOIN Sessao s ON s.filme_id = f.id
            GROUP BY f.titulo
            HAVING COUNT(DISTINCT s.sala_id) >= 1;
        `)
        console.log('FILMES EXIBIDOS EM MAIS DE UMA SALA DIFERENTE')
        console.table(filmes_multiplas_salas.rows)

        const sessoes_por_data = await pool.query(`
            SELECT data, COUNT(*) AS total_sessoes
            FROM Sessao
            GROUP BY data
            ORDER BY data;
        `)
        console.log('QUANTIDADE DE SESSÕES POR DATA')
        console.table(sessoes_por_data.rows)

    } catch (error) {
        console.error('erro', error)
    }
}

async function executar_funcao(){
    await consultas_principais()
    await consultas_elaboradas()
}

executar_funcao()
