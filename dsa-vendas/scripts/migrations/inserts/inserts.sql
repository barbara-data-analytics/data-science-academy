-- Projeto 3 - ETL Para Carga de Dados

-- Carrega a tabela
INSERT INTO dw.DIM_LOJA (Codigo, Nome, Cidade, Estado) VALUES
(1, 'Loja A', 'São Paulo', 'SP'),
(2, 'Loja B', 'Rio de Janeiro', 'RJ'),
(3, 'Loja C', 'Belo Horizonte', 'MG'),
(4, 'Loja D', 'Curitiba', 'PR'),
(5, 'Loja E', 'Porto Alegre', 'RS'),
(6, 'Loja F', 'Salvador', 'BA'),
(7, 'Loja G', 'Recife', 'PE'),
(8, 'Loja H', 'Fortaleza', 'CE'),
(9, 'Loja I', 'Brasília', 'DF'),
(10, 'Loja J', 'Goiânia', 'GO');

-- Verifique se os dados foram inseridos corretamente
SELECT * FROM dw.DIM_LOJA;

-- Carrega a tabela
INSERT INTO dw.DIM_PRODUTO (Codigo_SKU, Nome, Marca, Categoria) VALUES
(101, 'TV UHD', 'Electron', 'Eletrônicos'),
(102, 'Smartphone 5G 128GB', 'TechPlus', 'Celulares'),
(103, 'Notebook Pro 8GB', 'TechPlus', 'Informática'),
(104, 'Cafeteira Expresso', 'Cafex', 'Eletrodomésticos'),
(105, 'Tênis Corrida Ultra', 'Sportex', 'Vestuário'),
(106, 'Blender Compacto', 'Cafex', 'Eletrodomésticos'),
(107, 'Camiseta Poliéster', 'Sportex', 'Vestuário'),
(108, 'Mouse Sem Fio Ergonômico', 'OfficeTech', 'Acessórios'),
(109, 'Fone de Ouvido Bluetooth', 'TechPlus', 'Acessórios'),
(110, 'Geladeira Duplex 500L', 'Cafex', 'Eletrodomésticos');

-- Verificação dos dados inseridos
SELECT * FROM dw.DIM_PRODUTO;

-- Carrega a tabela
INSERT INTO dw.DIM_CLIENTE (ID_Cliente, Nome, Endereço, Cidade, Estado) VALUES
(1, 'Maria Silva', 'Rua das Flores, 123', 'São Paulo', 'SP'),
(2, 'João Souza', 'Av. Brasil, 456', 'Rio de Janeiro', 'RJ'),
(3, 'Ana Costa', 'Praça da Árvore, 789', 'Belo Horizonte', 'MG'),
(4, 'Carlos Andrade', 'Rua do Sol, 101', 'Curitiba', 'PR'),
(5, 'Fernanda Gomes', 'Av. Boa Viagem, 202', 'Recife', 'PE'),
(6, 'Lucas Martins', 'Largo dos Leões, 303', 'Porto Alegre', 'RS'),
(7, 'Patricia Lima', 'Rua das Orquídeas, 404', 'Salvador', 'BA'),
(8, 'Rafael Dias', 'Av. Central, 505', 'Brasília', 'DF'),
(9, 'Cláudia Rocha', 'Praça do Mercado, 606', 'Fortaleza', 'CE'),
(10, 'Eduardo Pereira', 'Rua da Harmonia, 707', 'Manaus', 'AM');

-- Verifique se os dados foram inseridos corretamente
SELECT * FROM dw.DIM_CLIENTE;

-- Carrega a tabela
INSERT INTO dw.DIM_VENDEDOR (Matricula, Nome) VALUES
(101, 'Carlos Henrique'),
(102, 'Mariana Costa'),
(103, 'João Pedro Almeida'),
(104, 'Lúcia Ferreira'),
(105, 'Rogério Silva'),
(106, 'Fernanda Lima'),
(107, 'Eduardo Martins'),
(108, 'Ana Beatriz Souza'),
(109, 'Ricardo Oliveira'),
(110, 'Patrícia Barbosa');

-- Verifique se os dados foram inseridos corretamente
SELECT * FROM dw.DIM_VENDEDOR;

-- Carrega a tabela
INSERT INTO dw.DIM_DATA (Data_Completa, Ano, Mes, Dia)
SELECT
    data,
    EXTRACT(YEAR FROM data) AS Ano,
    EXTRACT(MONTH FROM data) AS Mes,
    EXTRACT(DAY FROM data) AS Dia
FROM generate_series('2024-01-01'::date, '2024-12-31'::date, '1 day'::interval) AS data;

-- Verifique se os dados foram inseridos corretamente
SELECT * FROM dw.DIM_DATA;

-- Cria uma sequence para gerar valor sequenciais para campo de ID
CREATE SEQUENCE transacao_seq;

-- Executa a função
SELECT dw.load_fato_venda();

-- Verifique se os dados foram inseridos corretamente
SELECT * FROM dw.fato_venda;
