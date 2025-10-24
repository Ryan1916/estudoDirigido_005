ed005_garantia_nomeAluno – Sistema de Controle de Garantia de Equipamentos

Projeto desenvolvido para o Estudo Dirigido 005, integrando PostgreSQL e Python POO, com foco no gerenciamento de equipamentos, lojas, garantias e documentos.

1. Modelo Lógico e Relações

O sistema possui 5 entidades principais: USUARIO, LOJA, EQUIPAMENTOS, GARANTIA, DOCUMENTO.

#	Relação	Tipo	Descrição
1	USUARIO (1) → (N) LOJA	1:N	Um usuário pode cadastrar várias lojas.
2	USUARIO (1) → (N) EQUIPAMENTOS	1:N	Um usuário pode registrar vários equipamentos.
3	LOJA (1) → (N) EQUIPAMENTOS	1:N	Uma loja possui vários equipamentos.
4	LOJA (1) → (N) GARANTIA	1:N	Uma loja emite várias garantias.
5	EQUIPAMENTOS (1) → (N) GARANTIA	1:N	Um equipamento pode ter várias garantias.
6	DOCUMENTO (N) → (1) LOJA	N:1	Cada documento pertence a uma loja.
7	DOCUMENTO (N) → (1) USUARIO	N:1	Cada documento foi enviado/cadastrado por um usuário.
8	DOCUMENTO (N) → (1) EQUIPAMENTOS	N:1	Cada documento está vinculado a um equipamento.
9	DOCUMENTO (N) → (1) GARANTIA	N:1	Cada documento pode estar associado a uma garantia.

Justificativa Técnica:

A relação Equipamentos → Garantia usa ON DELETE CASCADE para que, ao excluir um equipamento, suas garantias sejam automaticamente removidas, evitando registros órfãos.

Útil quando os dados filhos não têm sentido sem o pai. Perigoso se apagamentos acidentais ocorrerem.

2. Inserts Exemplo
-- Usuários
INSERT INTO usuario (nome, cpf, tel, email, senha) VALUES
('Ana Silva', '123.456.789-00', '(11) 98765-4321', 'ana.silva@teste.com', 'hash_senha_ana'),
('Carlos Souza', '987.654.321-00', '(21) 91234-5678', 'carlos.souza@teste.com', 'hash_senha_carlos'),
('Beatriz Lima', '456.789.123-00', '(31) 99876-5432', 'beatriz.lima@teste.com', 'hash_senha_beatriz');

-- Lojas
INSERT INTO loja (nome, cnpj, id_user) VALUES
('EletroFast', '11.111.111/0001-11', 1),
('MegaTech', '22.222.222/0001-22', 2),
('GigaByte Info', '33.333.333/0001-33', 3);

-- Equipamentos
INSERT INTO equipamentos (produto, data_da_compra, marca, n_de_serie, preco, id_loja, id_user) VALUES
('Smartphone S100', '2024-03-01', 'MarcaA', 'SN-A1B2C3', 1500.00, 1, 1),
('Notebook Pro X', '2023-10-20', 'MarcaB', 'SN-D4E5F6', 4500.50, 2, 2),
('Monitor Ultrawide', '2024-05-15', 'MarcaC', 'SN-G7H8I9', 1200.99, 3, 3);

-- Garantias
INSERT INTO garantia (inicio, fim, tipo_garantia, id_loja, id_equip) VALUES
('2024-03-01', '2025-03-01', 'Padrão 1 ano', 1, 1),
('2023-10-20', '2024-04-20', 'Curta', 2, 2),
('2024-05-15', '2024-11-15', 'Padrão 6 meses', 3, 3);

-- Documentos
INSERT INTO documento (url_doc, tipo_doc, num_doc, data_emissao, id_loja, id_user, id_equip, id_garantia) VALUES
('docs/nf-s100.pdf', 'Nota Fiscal', 'NF-1001', '2024-03-01', 1, 1, 1, 1),
('docs/cert-proX.pdf', 'Certificado', 'CERT-2002', '2023-10-20', 2, 2, 2, 2),
('docs/nf-monitor.pdf', 'Nota Fiscal', 'NF-3003', '2024-05-15', 3, 3, 3, 3);

3. Consultas Analíticas
1️⃣ Equipamentos por loja
SELECT 
    l.nome AS Loja, 
    e.produto AS Equipamento
FROM 
    loja l 
JOIN 
    equipamentos e ON l.id_loja = e.id_loja
ORDER BY Loja;


Uso: relatório de inventário de compras por fornecedor.

2️⃣ Garantias vencendo nos próximos 30 dias
SELECT 
    e.produto, 
    g.fim AS Data_Vencimento
FROM 
    equipamentos e 
JOIN 
    garantia g ON e.id_equip = g.id_equip
WHERE 
    g.fim BETWEEN CURRENT_DATE AND (CURRENT_DATE + INTERVAL '30 days');


Uso: alertas para renovação ou comunicação com clientes.

3️⃣ Loja com mais garantias vencidas
SELECT 
    l.nome AS Loja, 
    COUNT(g.id_garantia) AS Total_Vencidas
FROM 
    loja l 
JOIN 
    equipamentos e ON l.id_loja = e.id_loja
JOIN 
    garantia g ON e.id_equip = g.id_equip
WHERE 
    g.fim < CURRENT_DATE
GROUP BY 
    l.nome
ORDER BY 
    Total_Vencidas DESC
LIMIT 1;


Uso: identificar fornecedores ou lojas problemáticas.

4️⃣ Tempo médio de garantia por loja
SELECT 
    l.nome AS Loja, 
    AVG(g.fim - g.inicio) AS Tempo_Medio_Garantia_Dias
FROM 
    loja l 
JOIN 
    equipamentos e ON l.id_loja = e.id_loja
JOIN 
    garantia g ON e.id_equip = g.id_equip
GROUP BY 
    l.nome;


Uso: avaliar histórico de garantias e planejar compras futuras.

4. Execução do Projeto (Windows)

Criar banco: app_garantia no pgAdmin.

Executar schema.sql → criar tabelas.

Executar inserts.sql → popular tabelas.

Configurar senha em src/database.py.

Abrir terminal na pasta src e rodar:

python main.py


Resultado: listagem de equipamentos com status de garantia (ATIVA, VENCIDA, ALERTA).

5. ON DELETE CASCADE

Usado em chaves estrangeiras para deletar registros dependentes automaticamente.

Útil: evita registros órfãos (ex.: garantias sem equipamento).

Perigoso: apagar registro pai remove todos os filhos; cuidado com dados críticos.

6. Prints e Documentação

Modelo Lógico: prints/modelo_logico.png

Consultas no DBeaver: prints/consultas_dbeaver.png

Execução no terminal: prints/execucao_terminal.png

7. Reflexão Pessoal

Aprendi: integração entre Python POO e PostgreSQL, FK, ON DELETE CASCADE.

Erros e soluções: cuidado com chaves estrangeiras e dados órfãos.

Conexão com projeto integrador: gerenciamento de ativos, alertas de garantia e relatórios de estoque.