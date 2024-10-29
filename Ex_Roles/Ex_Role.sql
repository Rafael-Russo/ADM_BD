/*
Exercicio sobre Roles
Crie dentro deste mesmo arquivo
Usando o lojaInformatica
5 usuarios locais com senha.
5 Roles diferentes usando qualquer nome.
Aplique 5 privilegios diferentes em cada role
cada usuario criado deve ter um role.
crie um usuario chamado Admin que tenha acesso 
a todos os roles criados.
*/

CREATE USER 'JoanaASCII'@'localhost' IDENTIFIED BY '123',
			'KarenMouse'@'localhost' IDENTIFIED BY '123', 
			'TioTeclas'@'localhost' IDENTIFIED BY '123',
            'RonanAsus'@'localhost' IDENTIFIED BY '123',
            'MarcusTeras'@'localhost' IDENTIFIED BY '123';
            
CREATE ROLE 'role_clientes'@'localhost',
			'role_enderecos'@'localhost', 
			'role_itemsvendas'@'localhost',
            'role_produtos'@'localhost',
            'role_vendas'@'localhost';

GRANT 
	SELECT, INSERT, UPDATE, DELETE, ALTER
    ON lojainformatica2.clientes 
    TO 'role_clientes'@'localhost';
SHOW GRANTS FOR 'role_clientes'@'localhost';
    
GRANT 
	SELECT, INSERT, UPDATE, DELETE, ALTER 
    ON lojainformatica2.enderecos 
    TO 'role_enderecos'@'localhost';
SHOW GRANTS FOR 'role_enderecos'@'localhost';
    
GRANT 
	SELECT, INSERT, UPDATE, DELETE, ALTER 
    ON lojainformatica2.itemsvendas 
    TO 'role_itemsvendas'@'localhost';
SHOW GRANTS FOR 'role_itemsvendas'@'localhost';
    
GRANT 
	SELECT, INSERT, UPDATE, DELETE, ALTER 
    ON lojainformatica2.produtos 
    TO 'role_produtos'@'localhost';
SHOW GRANTS FOR 'role_produtos'@'localhost';

GRANT 
	SELECT, INSERT, UPDATE, DELETE, ALTER 
    ON lojainformatica2.vendas 
    TO 'role_vendas'@'localhost';
SHOW GRANTS FOR 'role_vendas'@'localhost';

GRANT 'role_clientes'@'localhost' TO 'JoanaASCII'@'localhost';
SET DEFAULT ROLE 'role_clientes'@'localhost' TO 'JoanaASCII'@'localhost';

GRANT 'role_enderecos'@'localhost' TO 'KarenMouse'@'localhost';
SET DEFAULT ROLE 'role_enderecos'@'localhost' TO 'KarenMouse'@'localhost';

GRANT 'role_itemsvendas'@'localhost' TO 'TioTeclas'@'localhost';
SET DEFAULT ROLE 'role_itemsvendas'@'localhost' TO 'TioTeclas'@'localhost';

GRANT 'role_produtos'@'localhost' TO 'RonanAsus'@'localhost';
SET DEFAULT ROLE 'role_produtos'@'localhost' TO 'RonanAsus'@'localhost';

GRANT 'role_vendas'@'localhost' TO 'MarcusTeras'@'localhost';
SET DEFAULT ROLE 'role_vendas'@'localhost' TO 'MarcusTeras'@'localhost';

CREATE USER 'admin'@'%' IDENTIFIED BY '123456';

GRANT 
	'role_clientes'@'localhost',
    'role_enderecos'@'localhost',
    'role_itemsvendas'@'localhost',
    'role_produtos'@'localhost',
    'role_vendas'@'localhost' 
TO 'admin'@'%';

SET DEFAULT ROLE 'role_clientes'@'localhost' TO 'admin'@'%';
SHOW GRANTS FOR 'admin'@'%';