DELIMITER $$
CREATE  TRIGGER Trigger_Ex_24
AFTER INSERT ON PurchLine
FOR EACH ROW
BEGIN
 UPDATE PRODUCT SET ProdQOH = ProdQOH + NEW.PurchQty WHERE ProdNo = NEW.fk_ProdNo;
END$$
DELIMITER ;

INSERT INTO Product (ProdNo, ProdName, fk_SuppNo, ProdQOH, ProdPrice, ProdNextShipDate)
VALUES (NULL, 'Produto A', 1, 50, 100.00, NOW());

INSERT INTO Purchase (PurchNo, PurchDate, fk_SuppNo, PurchPayMethod, PurchDelDate)
VALUES (NULL, NOW(), 1, 'Credit Card', NOW());

INSERT INTO PurchLine (fk_ProdNo, fk_PurchNo, PurchQty, PurchUnitCost)
VALUES (2, 1, 20, 95.00);

SELECT * FROM Product;