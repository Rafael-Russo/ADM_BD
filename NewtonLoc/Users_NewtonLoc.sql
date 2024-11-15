/*6. Crie 10 usuários com senha para acessar (Roles) conforme as restrições abaixo (Você decide quem acessa o que) cada acesso é uma Role*/

/*Acesso1 - Apenas para dar select em todas as tabelas.*/
CREATE USER 'usuario_select1'@'localhost' IDENTIFIED BY 'senha123';
GRANT SELECT ON NewtonLoc.* TO 'usuario_select1'@'localhost';
CREATE USER 'usuario_select2'@'localhost' IDENTIFIED BY 'senha123';
GRANT SELECT ON NewtonLoc.* TO 'usuario_select2'@'localhost';

/*Acesso2 - Apenas Select e insert na tabela de carros*/
CREATE USER 'usuario_carros1'@'localhost' IDENTIFIED BY 'senha123';
GRANT SELECT, INSERT ON NewtonLoc.CARROS TO 'usuario_carros1'@'localhost';
CREATE USER 'usuario_carros2'@'localhost' IDENTIFIED BY 'senha123';
GRANT SELECT, INSERT ON NewtonLoc.CARROS TO 'usuario_carros2'@'localhost';

/*Acesso3 - Total no Sistema e database.*/
CREATE USER 'admin_total1'@'localhost' IDENTIFIED BY 'senha123';
GRANT ALL PRIVILEGES ON *.* TO 'admin_total1'@'localhost' WITH GRANT OPTION;
CREATE USER 'admin_total2'@'localhost' IDENTIFIED BY 'senha123';
GRANT ALL PRIVILEGES ON *.* TO 'admin_total2'@'localhost' WITH GRANT OPTION;

/*Acesso4 - Create, alter e drop em tabelas e schema.*/
CREATE USER 'usuario_ddl1'@'localhost' IDENTIFIED BY 'senha123';
GRANT CREATE, ALTER, DROP ON NewtonLoc.* TO 'usuario_ddl1'@'localhost';
CREATE USER 'usuario_ddl2'@'localhost' IDENTIFIED BY 'senha123';
GRANT CREATE, ALTER, DROP ON NewtonLoc.* TO 'usuario_ddl2'@'localhost';

/*Acesso5 - Total ao schema.*/
CREATE USER 'schema_admin1'@'localhost' IDENTIFIED BY 'senha123';
GRANT ALL PRIVILEGES ON NewtonLoc.* TO 'schema_admin1'@'localhost';
CREATE USER 'schema_admin2'@'localhost' IDENTIFIED BY 'senha123';
GRANT ALL PRIVILEGES ON NewtonLoc.* TO 'schema_admin2'@'localhost';

/* 7. Entre os usuários criados acima, altere as permissões de 5. A sua escolha.*/
GRANT INSERT ON NewtonLoc.CLIENTES TO 'usuario_select1'@'localhost';

GRANT UPDATE ON NewtonLoc.CARROS TO 'usuario_carros1'@'localhost';

REVOKE GRANT OPTION ON *.* FROM 'admin_total1'@'localhost';

GRANT SELECT ON NewtonLoc.* TO 'usuario_ddl1'@'localhost';

REVOKE SELECT ON NewtonLoc.* FROM 'schema_admin1'@'localhost';