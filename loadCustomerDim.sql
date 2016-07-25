INSERT INTO FinanceDW.Customer (
	custID,
	custName,
	custAddr1,
	custAddr2,
	custCity,
	custState,
	custZip,
	custTypeID,
	custTypeName)
SELECT custID,
	   custName,
	   custAddr1,
	   custAddr2,
	   custCity,
	   custState,
	   custZip,
	   custTypeID,
	   custTypeName
FROM financeDW.staging
GROUP BY 
	custID,
	custName,
	custAddr1,
	custAddr2,
	custCity,
	custState,
	custZip,
	custTypeID,
	custTypeName
;
	
	