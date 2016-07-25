UPDATE staging s
JOIN date d
ON s.salesDate = d.date
SET s.salesDateSK = d.dateSK;

UPDATE staging s
JOIN customer c
USING (custID)
SET s.custSK = c.custSK;

UPDATE staging s
JOIN product p
USING (prodID)
SET s.prodSK = p.prodSK;

SET FOREIGN_KEY_CHECKS = 0;
SET UNIQUE_CHECKS = 0;

INSERT INTO FinanceDW.salesFact (
	custSK,
	salesDateSK,
	prodSK,
	invoiceID,
	quantity,
	salesAmount,
	division,
	costAmount,
	discounted
	)
SELECT 
	custSK,
	salesDateSK,
	prodSK,
	invoiceID,
	quantity,
	salesAmount,
	division,
	costAmount,
	discounted
FROM FinanceDW.Staging
GROUP BY
	custSK,
	salesDateSK,
	prodSK,
	invoiceID,
	quantity,
	salesAmount,
	division,
	costAmount,
	discounted
;

SET UNIQUE_CHECKS = 1;
SET FOREIGN_KEY_CHECKS = 1;