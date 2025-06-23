-- Projeto 3 - Implementando o Modelo Dimensional no DW

-- Criação das tabelas de dimensão

CREATE TABLE dw.DIM_LOJA (
    Codigo INT PRIMARY KEY,
    Nome VARCHAR(255),
    Cidade VARCHAR(255),
    Estado CHAR(2)
);

CREATE TABLE dw.DIM_PRODUTO (
    Codigo_SKU INT PRIMARY KEY,
    Nome VARCHAR(255),
    Marca VARCHAR(255),
    Categoria VARCHAR(255)
);

CREATE TABLE dw.DIM_CLIENTE (
    ID_Cliente INT PRIMARY KEY,
    Nome VARCHAR(255),
    Endereço VARCHAR(255),
    Cidade VARCHAR(255),
    Estado CHAR(2)
);

CREATE TABLE dw.DIM_VENDEDOR (
    Matricula INT PRIMARY KEY,
    Nome VARCHAR(255)
);

CREATE TABLE dw.DIM_DATA (
    Data_Completa DATE PRIMARY KEY,
    Ano INT,
    Mes INT,
    Dia INT
);

-- Criação da tabela de fatos
CREATE TABLE dw.FATO_VENDA (
    Data DATE,
    Produto INT,
    Loja INT,
    Vendedor INT,
    Cliente INT,
    Quantidade_Vendida INT,
    Total_Venda DECIMAL(10,2),
    ID_Transacao INT,
    PRIMARY KEY (Data, Produto, Loja, Vendedor, Cliente),
    FOREIGN KEY (Data) REFERENCES dw.DIM_DATA(Data_Completa),
    FOREIGN KEY (Produto) REFERENCES dw.DIM_PRODUTO(Codigo_SKU),
    FOREIGN KEY (Loja) REFERENCES dw.DIM_LOJA(Codigo),
    FOREIGN KEY (Vendedor) REFERENCES dw.DIM_VENDEDOR(Matricula),
    FOREIGN KEY (Cliente) REFERENCES dw.DIM_CLIENTE(ID_Cliente)
);
