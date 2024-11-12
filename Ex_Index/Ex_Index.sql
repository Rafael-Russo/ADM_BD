CREATE TABLE log (
	id INT PRIMARY KEY AUTO_INCREMENT,
    select_type VARCHAR(120),
    table_ VARCHAR(120),
    partitions VARCHAR(120),
    type VARCHAR(120),
    possible_keys VARCHAR(120),
    key_ VARCHAR(120),
    key_len VARCHAR(120),
    ref VARCHAR(120),
    rows_ VARCHAR(120),
    filtered VARCHAR(120),
    extra VARCHAR(120)
);

SELECT * FROM log;

EXPLAIN SELECT * FROM clientes;
INSERT INTO log (id, select_type, table_, partitions, type, possible_keys, key_, key_len, ref, rows_, filtered, extra) 
		VALUES (null, 'SIMPLE', 'clientes', null, 'ALL', null, null, null, null, '8', '100.00', null);

EXPLAIN SELECT * FROM enderecos;
INSERT INTO log (id, select_type, table_, partitions, type, possible_keys, key_, key_len, ref, rows_, filtered, extra) 
		VALUES (null, 'SIMPLE', 'enderecos', null, 'ALL', null, null, null, null, '8', '100.00', null);

EXPLAIN SELECT * FROM itemsvendas;
INSERT INTO log (id, select_type, table_, partitions, type, possible_keys, key_, key_len, ref, rows_, filtered, extra) 
		VALUES (null, 'SIMPLE', 'itemsvendas', null, 'ALL', null, null, null, null, '8', '100.00', null);

EXPLAIN SELECT * FROM produtos;
INSERT INTO log (id, select_type, table_, partitions, type, possible_keys, key_, key_len, ref, rows_, filtered, extra) 
		VALUES (null, 'SIMPLE', 'produtos', null, 'ALL', null, null, null, null, '7', '100.00', null);
        
EXPLAIN SELECT * FROM vendas;
INSERT INTO log (id, select_type, table_, partitions, type, possible_keys, key_, key_len, ref, rows_, filtered, extra) 
		VALUES (null, 'SIMPLE', 'vendas', null, 'ALL', null, null, null, null, '6', '100.00', null);
        
EXPLAIN SELECT C.* FROM clientes C JOIN enderecos E ON C.fk_idEndereco = E.idEndereco;
INSERT INTO log (id, select_type, table_, partitions, type, possible_keys, key_, key_len, ref, rows_, filtered, extra) 
		VALUES (null, 'SIMPLE', 'C', null, 'ALL', 'fk_idEndereco', null, null, null, '8', '100.00', null),
			   (null, 'SIMPLE', 'E', null, 'eq_ref', 'PRIMARY', 'PRIMARY', '4', 'lojainformatica2.C.fk_idEndereco', '1', '100.00', 'Using index');

EXPLAIN SELECT * FROM itemsvendas WHERE idItemVenda > 3 AND quantidade > 0;
INSERT INTO log (id, select_type, table_, partitions, type, possible_keys, key_, key_len, ref, rows_, filtered, extra) 
		VALUES (null, 'SIMPLE', 'itemsvendas', null, 'range', 'PRIMARY', 'PRIMARY', '4', null, '5', '33.33', 'Using where');
        
EXPLAIN SELECT * FROM vendas WHERE valorTotal > 100;
INSERT INTO log (id, select_type, table_, partitions, type, possible_keys, key_, key_len, ref, rows_, filtered, extra) 
		VALUES (null, 'SIMPLE', 'vendas', null, 'ALL', null, null, null, null, '6', '33.33', 'Using where');

EXPLAIN SELECT * FROM produtos WHERE precoCompra > 200;
INSERT INTO log (id, select_type, table_, partitions, type, possible_keys, key_, key_len, ref, rows_, filtered, extra) 
		VALUES (null, 'SIMPLE', 'produtos', null, 'ALL', null, null, null, null, '7', '33.33', 'Using where');

EXPLAIN SELECT * FROM clientes WHERE cpf = '333.222.111-33';
INSERT INTO log (id, select_type, table_, partitions, type, possible_keys, key_, key_len, ref, rows_, filtered, extra) 
		VALUES (null, 'SIMPLE', 'clientes', null, 'ALL', null, null, null, null, '8', '12.50', 'Using where');

