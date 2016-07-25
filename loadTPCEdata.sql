USE salesorders;

LOAD DATA INFILE
'C:/dbw/input/tpce/business_unit.csv'
INTO TABLE businessUnit
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA INFILE
'C:/dbw/input/tpce/customer_type.csv'
INTO TABLE customerType
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA INFILE
'C:/dbw/input/tpce/supplier.csv'
INTO TABLE supplier
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA INFILE
'C:/dbw/input/tpce/prod_type.csv'
INTO TABLE prodType
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA INFILE
'C:/dbw/input/tpce/product.csv'
INTO TABLE product
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA INFILE
'C:/dbw/input/tpce/customer.csv'
INTO TABLE customer
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 
'C:/dbw/input/tpce/invoice.csv'
INTO TABLE invoicehdr
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(invoiceID, customerID, @var)
SET saleDate = str_to_date(@var, '%m/%d/%Y');

LOAD DATA LOCAL INFILE 
'C:/dbw/input/tpce/invoice_details.csv'
INTO TABLE invoicedtl
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;
