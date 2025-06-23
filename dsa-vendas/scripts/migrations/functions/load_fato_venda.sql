-- FUNCTION: dw.load_fato_venda()

-- DROP FUNCTION IF EXISTS dw.load_fato_venda();

CREATE OR REPLACE FUNCTION dw.load_fato_venda(
	)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
BEGIN
    -- Assegurando que pelo menos 1000 registros únicos sejam inseridos, repetindo os dados das dimensões conforme necessário
    INSERT INTO dw.FATO_VENDA (Data, Produto, Loja, Vendedor, Cliente, Quantidade_Vendida, Total_Venda, ID_Transacao)
    SELECT
        d.Data_Completa,
        p.Codigo_SKU,
        l.Codigo,
        v.Matricula,
        c.ID_Cliente,
        (RANDOM() * 10 + 1)::INT AS Quantidade_Vendida,  -- Gera quantidade vendida entre 1 e 10
        (RANDOM() * 1000 + 100)::NUMERIC(10,2) AS Total_Venda,  -- Gera valor total da venda entre 100 e 1100
        nextval('transacao_seq') AS ID_Transacao  -- Sequência para ID de transação
    FROM
        (SELECT Data_Completa, ROW_NUMBER() OVER (ORDER BY RANDOM()) AS rn FROM dw.DIM_DATA) d
        JOIN (SELECT Codigo_SKU, ROW_NUMBER() OVER (ORDER BY RANDOM()) AS rn FROM dw.DIM_PRODUTO) p ON MOD(d.rn, (SELECT COUNT(*) FROM dw.DIM_PRODUTO)) = p.rn % (SELECT COUNT(*) FROM dw.DIM_PRODUTO)
        JOIN (SELECT Codigo, ROW_NUMBER() OVER (ORDER BY RANDOM()) AS rn FROM dw.DIM_LOJA) l ON MOD(d.rn, (SELECT COUNT(*) FROM dw.DIM_LOJA)) = l.rn % (SELECT COUNT(*) FROM dw.DIM_LOJA)
        JOIN (SELECT Matricula, ROW_NUMBER() OVER (ORDER BY RANDOM()) AS rn FROM dw.DIM_VENDEDOR) v ON MOD(d.rn, (SELECT COUNT(*) FROM dw.DIM_VENDEDOR)) = v.rn % (SELECT COUNT(*) FROM dw.DIM_VENDEDOR)
        JOIN (SELECT ID_Cliente, ROW_NUMBER() OVER (ORDER BY RANDOM()) AS rn FROM dw.DIM_CLIENTE) c ON MOD(d.rn, (SELECT COUNT(*) FROM dw.DIM_CLIENTE)) = c.rn % (SELECT COUNT(*) FROM dw.DIM_CLIENTE)
    WHERE d.rn <= 1000;  -- Limita a inserção aos primeiros 1000 registros
END;
$BODY$;

ALTER FUNCTION dw.load_fato_venda()
    OWNER TO dsa;
