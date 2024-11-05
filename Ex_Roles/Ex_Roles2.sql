-- Usando o schema da loja informatica
-- apague todos usuarios menos:
/*mysql.infoschema
mysql.session
mysql.sys
root
*/

SELECT user, host FROM mysql.user;
/*
DROP USER 
			'admin'@'%', 
			'JoanaASCII'@'localhost',
            'KarenMouse'@'localhost',
			'MarcusTeras'@'localhost',
            'RonanAsus'@'localhost',
            'TioTeclas'@'localhost';
            
DROP ROLE
			'role_clientes'@'localhost',
            'role_enderecos'@'localhost',
            'role_itemsvendas'@'localhost',
            'role_produtos'@'localhost',
            'role_vendas'@'localhost';
*/

# crie 5 roles.
# Role 1
#   apenas select no schema
CREATE ROLE 'Role1'@'localhost';
GRANT 
	SELECT
    ON lojainformatica2.* 
    TO 'Role1'@'localhost';

# Role 2
#   apenas insert em clientes e create e drop
CREATE ROLE 'Role2'@'localhost';
GRANT 
	INSERT, CREATE, DROP
    ON lojainformatica2.clientes 
    TO 'Role2'@'localhost';
    
# Role 3
#   apenas select no vendas
CREATE ROLE 'Role3'@'localhost';
GRANT 
	SELECT
    ON lojainformatica2.vendas
    TO 'Role3'@'localhost';
    
# Role 4
# apenas select,insert,update e delete no schema
CREATE ROLE 'Role4'@'localhost';
GRANT 
	SELECT, INSERT, UPDATE, DELETE
    ON lojainformatica2.*
    TO 'Role4'@'localhost';

# Role 5
#   apenas upadate em vendas
CREATE ROLE 'Role5'@'localhost';
GRANT 
	UPDATE
    ON lojainformatica2.vendas
    TO 'Role5'@'localhost';

# Crie 10 usuarios
CREATE USER 'JoanaASCII'@'localhost' IDENTIFIED BY '123',
			'KarenMouse'@'localhost' IDENTIFIED BY '123', 
			'TioTeclas'@'localhost' IDENTIFIED BY '123',
            'RonanAsus'@'localhost' IDENTIFIED BY '123',
            'Rafael'@'localhost' IDENTIFIED BY '123',
            'Lucas'@'localhost' IDENTIFIED BY '123',
            'Gabriel'@'localhost' IDENTIFIED BY '123',
            'Samuel'@'localhost' IDENTIFIED BY '123',
            'Giovana'@'localhost' IDENTIFIED BY '123',
            'MarcusTeras'@'localhost' IDENTIFIED BY '123';

# aplique os roles aos usuario como quiser
GRANT 'Role1'@'localhost' TO 'JoanaASCII'@'localhost';
SET DEFAULT ROLE 'Role1'@'localhost' TO 'JoanaASCII'@'localhost';
GRANT 'Role1'@'localhost' TO 'KarenMouse'@'localhost';
SET DEFAULT ROLE 'Role1'@'localhost' TO 'KarenMouse'@'localhost';

GRANT 'Role2'@'localhost' TO 'TioTeclas'@'localhost';
SET DEFAULT ROLE 'Role2'@'localhost' TO 'TioTeclas'@'localhost';
GRANT 'Role2'@'localhost' TO 'RonanAsus'@'localhost';
SET DEFAULT ROLE 'Role2'@'localhost' TO 'RonanAsus'@'localhost';

GRANT 'Role3'@'localhost' TO 'Rafael'@'localhost';
SET DEFAULT ROLE 'Role3'@'localhost' TO 'Rafael'@'localhost';
GRANT 'Role3'@'localhost' TO 'Lucas'@'localhost';
SET DEFAULT ROLE 'Role3'@'localhost' TO 'Lucas'@'localhost';

GRANT 'Role4'@'localhost' TO 'Gabriel'@'localhost';
SET DEFAULT ROLE 'Role4'@'localhost' TO 'Gabriel'@'localhost';
GRANT 'Role4'@'localhost' TO 'Samuel'@'localhost';
SET DEFAULT ROLE 'Role4'@'localhost' TO 'Samuel'@'localhost';

GRANT 'Role5'@'localhost' TO 'Giovana'@'localhost';
SET DEFAULT ROLE 'Role5'@'localhost' TO 'Giovana'@'localhost';
GRANT 'Role5'@'localhost' TO 'MarcusTeras'@'localhost';
SET DEFAULT ROLE 'Role5'@'localhost' TO 'MarcusTeras'@'localhost';

# revogue os privilegios de select do role1 e insira create e drop 
REVOKE 
	SELECT
    ON lojainformatica2.* 
    FROM 'Role1'@'localhost';
    
GRANT 
	CREATE, DROP
    ON lojainformatica2.* 
    TO 'Role1'@'localhost';