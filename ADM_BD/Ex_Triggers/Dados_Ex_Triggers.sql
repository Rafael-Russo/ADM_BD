-- Populando a tabela Customer
INSERT INTO Customer (CustNo, CustFirstName, CustLastName, CustStreet, CustCity, CustState, CustZip, CustBal)
VALUES
(NULL, 'John', 'Doe', '123 Main St', 'New York', 'NY', '10001', '100.50'),
(NULL, 'Jane', 'Smith', '456 Elm St', 'Boston', 'MA', '02101', '50.75');

-- Populando a tabela Supplier
INSERT INTO Supplier (SuppNo, SuppName, SuppEmail, SuppPhone, SuppURL, SuppDiscount)
VALUES
(NULL, 'Fornecedor A', 'fornecedorA@example.com', '123456789', 'http://fornecedora.com', '10%'),
(NULL, 'Fornecedor B', 'fornecedorB@example.com', '987654321', 'http://fornecedorb.com', '15%');

-- Populando a tabela Employee_1
INSERT INTO Employee_1 (EmpNo, EmpFirstName, EmpLastName, EmpPhone, SupEmpNo, EmpCommRate)
VALUES
(NULL, 'Michael', 'Scott', '111-222-3333', '2', '5%'),
(NULL, 'Dwight', 'Schrute', '111-222-4444', '1', '7%');

-- Populando a tabela Employee (referencia Employee_1)
INSERT INTO Employee (EmpNo, EmpFirstName, EmpLastName, EmpPhone, fk_EmpNo, EmpCommRate)
VALUES
(NULL, 'Jim', 'Halpert', '555-1234', 1, '3%'),
(NULL, 'Pam', 'Beesly', '555-5678', 2, '2%');

-- Populando a tabela Product
INSERT INTO Product (ProdNo, ProdName, fk_SuppNo, ProdQOH, ProdPrice, ProdNextShipDate)
VALUES
(NULL, 'Produto A', 1, 50, 100.00, '2024-10-01'),
(NULL, 'Produto B', 2, 30, 200.00, '2024-11-01');

-- Populando a tabela Purchase
INSERT INTO Purchase (PurchNo, PurchDate, fk_SuppNo, PurchPayMethod, PurchDelDate)
VALUES
(NULL, NOW(), 1, 'Credit Card', NOW()),
(NULL, NOW(), 2, 'Debit Card', NOW());

-- Populando a tabela PurchLine (referencia Product e Purchase)
INSERT INTO PurchLine (fk_ProdNo, fk_PurchNo, PurchQty, PurchUnitCost)
VALUES
(1, 1, 10, 95.00),
(2, 2, 20, 190.00);

-- Populando a tabela OrderTbl (referencia Customer e Employee)
INSERT INTO OrderTbl (OrdNo, OrdDate, fk_CustNo, fk_EmpNo, OrdName, OrdStreet, OrdCity, OrdState, OrdZip)
VALUES
(NULL, NOW(), 1, 1, 'Order 1', '123 Main St', 'New York', 'NY', '10001'),
(NULL, NOW(), 2, 2, 'Order 2', '456 Elm St', 'Boston', 'MA', '02101');

-- Populando a tabela OrdLine (referencia OrderTbl e Product)
INSERT INTO OrdLine (fk_OrdNo, fk_ProdNo, Qty)
VALUES
(1, 1, 5),
(2, 2, 3);