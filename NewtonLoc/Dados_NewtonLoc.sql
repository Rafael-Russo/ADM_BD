 INSERT INTO CLIENTES (nome,cpf,telefone,email,pontuacao,tipo) 
				values ('Teclaudio Screen','12341234121','31987655434','te@gmail.com',0,'Basico'),
						('Maria Teclas','12332143445','32987800987','m@gmail.com',100,'Basico'),
						('Jonas Mouse','44489865432','31976533234','mouse@gmail.com',500,'Basico'),
						('Carlos CPU','45609087678','31978900627','cpu@gmail.com',1200,'Intemediario'),
						('Tiana Cooler','67512399900','31976432111','ti@gmail.com',3000,'Intermediario'),
						('Cassandra Pixel','88890097666','31980077654','cas@gmail.com',5600,'Premium');
    
  INSERT INTO CARROS (fabricante,modelo,cor,anoFabricacao,potenciaMotor,categoria,quilometragem) 
			values	('Fiat','Toro Freedom','preto','2022',1.8,'SUV',12000),
					  ('Toyota','Yaris','Branco','2022',1.5,'Sedan',3000),
					  ('Ford','Fiesta','Branco','2021',1.6,'Hatch',566),
					  ('Toyota','Corolla','Branco','2023',2.0,'Sedan',1022),
					  ('Hyundai','Hb20','Vermelho','2023',2.0,'Hatch',300),
					  ('Volksvagen','Gol','Verde','2020',1.6,'Hatch',5059),
					  ('Chevrolet','Onix','preto','2019',1.6,'Hatch',12034);
    
 INSERT INTO locacao(dataLocacao,valorDiaria,fk_idCliente,fk_idCarro) 
			values ('2023-01-10',123,1,1),
					('2023-01-10',183,2,2),
					('2023-01-10',100,3,3),
					('2023-01-10',199,4,4),
					('2023-01-10',99,5,5),
					('2023-02-10',183,2,2);
                    
INSERT INTO dimensoes(altura_mm,largura_mm,comprimento_mm,peso_kg,tanque_L,entre_eixos_mm,porta_mala_L,ocupante,fk_idCarro)
				VALUES (1.475, 1.656, 3.892, 1.020, 55, 2.467, 285, 5, 6),
						(1.480, 1.760, 4.540, 1.230, 60, 2.600, 470, 5, 4),
						(1.673, 1.844, 4.945, 1.650, 55, 2.982, 0, 5, 1),
						(1.487, 1.765, 3.935, 1.084, 54, 2.488, 270, 5, 3),
						(1.490, 1.730, 4.425, 1.130, 45, 2.550, 473, 5, 2),
						(1.470, 1.720, 4.015, 993, 50, 2.530, 300, 5, 5),
						(1.471, 1.731, 4.163, 1.034, 44, 2.551, 303, 5, 7);