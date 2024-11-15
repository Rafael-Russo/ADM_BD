/*8. Crie um índice para cada uma das tabelas acima.*/
CREATE INDEX idx_cpf ON CLIENTES (cpf);

CREATE INDEX idx_modelo ON CARROS (modelo);

CREATE INDEX idx_porta_mala ON DIMENSOES (porta_mala_L);

CREATE INDEX idx_fk_idCliente ON LOCACAO (fk_idCliente);
CREATE INDEX idx_fk_idCarro ON LOCACAO (fk_idCarro);

CREATE INDEX idx_idLocacao ON DEVOLUCAO (idLocacao);