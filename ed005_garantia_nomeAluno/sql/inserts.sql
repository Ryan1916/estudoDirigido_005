-- Arquivo: sql/inserts.sql

INSERT INTO usuario (nome, cpf, tel, email, senha) VALUES
('Ana Silva', '123.456.789-00', '(11) 98765-4321', 'ana.silva@teste.com', 'hash_senha_ana');

INSERT INTO loja (nome, cnpj, id_user) VALUES
('EletroFast', '11.111.111/0001-11', 1),
('MegaTech', '22.222.222/0001-22', 1),
('GigaByte Info', '33.333.333/0001-33', 1);

INSERT INTO equipamentos (produto, data_da_compra, marca, n_de_serie, preco, id_loja, id_user) VALUES
('Smartphone S100', '2024-03-01', 'MarcaA', 'SN-A1B2C3', 1500.00, 1, 1),
('Notebook Pro X', '2023-10-20', 'MarcaB', 'SN-D4E5F6', 4500.50, 2, 1),
('Monitor Ultrawide', '2024-05-15', 'MarcaC', 'SN-G7H8I9', 1200.99, 1, 1);

INSERT INTO garantia (inicio, fim, tipo_garantia, id_loja, id_equip) VALUES
('2024-03-01', '2025-03-01', 'Padrão 1 ano', 1, 1),
('2023-10-20', '2024-04-20', 'Curta', 2, 2),
('2024-05-15', '2024-11-15', 'Padrão 6 meses', 1, 3);

INSERT INTO documento (url_doc, tipo_doc, num_doc, data_emissao, id_loja, id_user, id_equip, id_garantia) VALUES
('docs/nf-s100.pdf', 'Nota Fiscal', 'NF-1001', '2024-03-01', 1, 1, 1, 1),
('docs/cert-proX.pdf', 'Certificado', 'CERT-2002', '2023-10-20', 2, 1, 2, 2),
('docs/nf-monitor.pdf', 'Nota Fiscal', 'NF-3003', '2024-05-15', 1, 1, 3, 3);
