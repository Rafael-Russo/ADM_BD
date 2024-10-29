# Cria Role remoto
CREATE ROLE Nivel1;
SHOW GRANTS FOR 'Nivel1';
DROP ROLE 'Nivel1';
# Cria Role local
CREATE ROLE 'Nivel2'@'localhost';
# Verifica as permissões do Role
SHOW GRANTS FOR 'Nivel2'@'localhost';
CREATE ROLE 'Nivel3'@'localhost';
SHOW GRANTS FOR 'Nivel3'@'localhost';
# Apaga um Role
DROP ROLE 'Nivel2'@'localhost';

# Listando Roles
SELECT * FROM MYSQL.USER;
# Cria vários Roles localhost 
CREATE ROLE 'Nivel4'@'localhost','Nivel5'@'localhost';
# Apaga vários Roles de uma vez
DROP ROLE 'Nivel4'@'localhost','Nivel5'@'localhost';


# ----PERMISSOES--------------
#     ---------Nivel 1---------
# Dando permissão total de: select, insert update e delete 
# no schema 'lojainformatica2'
GRANT ALL ON lojainformatica2.* TO Nivel1;
SHOW GRANTS FOR 'Nivel1';
#     ---------Nivel 2---------
# Dando permissão de: select no schema 'lojainformatica2'
GRANT SELECT ON lojainformatica2.* TO 'Nivel2'@'localhost';
# Dando permissão de insert apenas na tabela clientes
GRANT INSERT ON lojainformatica2.clientes TO 'Nivel2'@'localhost';
SHOW GRANTS FOR 'Nivel2'@'localhost';


#     ---------Nivel 3---------
# Dando permissão de: select e insert na tabela produtos do 
# schema 'lojainformatica2'
GRANT SELECT,INSERT ON lojainformatica2.produtos TO 'Nivel3'@'localhost';
GRANT UPDATE ON lojainformatica2.clientes TO 'Nivel3'@'localhost';
SHOW GRANTS FOR 'Nivel3'@'localhost';

# ----------------EXEMPLO DE APLICAÇÃO------------------------------
# Criando um novo usuario
CREATE USER 'juca'@'localhost' IDENTIFIED BY '123456';
# Inserindo o Nivel2 de privilégios para juca
GRANT 'Nivel2'@'localhost' TO 'juca'@'localhost';
# Ativando a permissão para o usuario
SET DEFAULT ROLE  'Nivel2'@'localhost' TO 'juca'@'localhost';
# Verificando os privilégios de Jota
show grants for 'juca'@'localhost';
# Verificando quais os privilégios do Role Nivel2
show grants for 'Nivel2'@'localhost';

