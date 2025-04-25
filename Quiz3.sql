--Q1.	Assuming that InvoiceCopy and VendorCopy already exist, you first code two DROP TABLE statements to delete them. 
--Then, write SELECT INTO statements to create two test tables named InvoiceCopy and VendorCopy that are complete copies of the Invoices and Vendors tables. 
--(114 row(s) affected and 122 row(s) affected)
DROP TABLE [dbo].[InvoiceCopy]
DROP TABLE [dbo].[VendorCopy]
SELECT *
INTO [dbo].[InvoiceCopy]
FROM [dbo].[Invoices];
SELECT *
INTO [dbo].[VendorCopy]
FROM [dbo].[Vendors];

--2.	Write an INSERT statement that adds a row to the InvoiceCopy table with the following values:
--VendorID:	 32	InvoiceTotal:	$434.58	TermsID:	2
--InvoiceNumber:     AX-014-027	PaymentTotal:	$0.00          InvoiceDueDate:      7/8/12
--InvoiceDate:	6/21/12	CreditTotal:	$0.00	PaymentDate:	null
INSERT INTO [dbo].[InvoiceCopy]
	(VendorID, InvoiceTotal, TermsID, InvoiceNumber, PaymentTotal, InvoiceDueDate, InvoiceDate, CreditTotal, PaymentDate)
VALUES (32, '434.58', 2, 'AX-014-027', 0, '2012-07-08', '2012-06-21', 0, NULL)

--3.	Write an INSERT statement that adds a row to the VendorCopy table for each 
--non-California vendor in the Vendors table. (This will result in duplicate vendors in the VendorCopy table.) (47 row(s) affected)

INSERT INTO [dbo].[VendorCopy] 
(VendorID, VendorName, VendorAddress1, VendorAddress2, VendorCity, VendorState, VendorZipCode, VendorPhone, VendorContactLName,VendorContactFName, DefaultTermsID, DefaultAccountNo)
SELECT VendorID, VendorName, VendorAddress1, VendorAddress2, VendorCity, VendorState, VendorZipCode, VendorPhone, VendorContactLName,VendorContactFName, DefaultTermsID, DefaultAccountNo
FROM [dbo].[Vendors]
WHERE VendorState <> 'CA';


--Q4.	Write an UPDATE statement that modifies the InvoiceCopy table. 
--Change TermsID to 2 for each invoice thatâs from a vendor with a DefaultTermsID of 2. (18 row(s) affected)
UPDATE [dbo].[InvoiceCopy]
SET TERMSID = 2
FROM [dbo].[InvoiceCopy]
INNER JOIN [dbo].[Vendors] ON [dbo].[InvoiceCopy].VendorID=Vendors.VendorID
WHERE Vendors.DefaultTermsID=2;

--5.	Write a DELETE statement that deletes all vendors in the state of Minnesota from the VendorCopy table. (1 row(s) affected)
DELETE [dbo].[VendorCopy]
WHERE VendorState = 'MN';

--q6.
SELECT InvoiceTotal,
    CAST(InvoiceTotal AS decimal(18,2)) AS InvDecimal,
    CAST(InvoiceTotal AS decimal(20,1)) AS InvDec2,
	CONVERT(VARCHAR, InvoiceTotal, 2) AS varcharInvoiceTotal1
FROM Invoices; 
SELECT	
	CONVERT(VARCHAR, InvoiceDate, 1) AS InvoiceDate1
FROM [dbo].[Invoices];

--Q7.	Write a SELECT statement that returns all the columns of those invoices that have non-zero balance and that are associated with the vendor 
--whose phone number is â555-4091â. Note that vendor phone numbers in the vendors table are in this format: â(xxx) xxx-xxxxâ. (4 row(s) affected)
SELECT *
FROM Invoices AS I
JOIN Vendors AS V ON I.VendorID = V.VendorID
WHERE SUBSTRING(V.VendorPhone, LEN(V.VendorPhone) - 7, LEN(V.VendorPhone)) = '555-4091'
AND I.InvoiceTotal <> 0;


--Q8.
SELECT VendorName, VendorState,
    CASE VendorState
        WHEN 'CA' THEN 'CA'
        ELSE 'Outside CA'
    END AS 'CA or not'
FROM Vendors
ORDER BY 'CA or not'

--9.	Write a SELECT statement with CASE functions to return a result set consisting of the following four columns: 
--(1) the InvoiceNumber column from the Invoices table, (2) the VendorName column from the Vendors table, 
--(3) a string literal indicating the type of invoices with InvoiceType alias, and (4) a string literal indicating which group a vendor belongs with VendorGroup alias.
--If the InvoiceNumber contains any letter (A-Z), the string literal is âType 1â. 
--If the InvoiceNumber does not contain any letter (A-Z), the string literal is âType 2â. 
--If the VendorName begins with the letter A-M, the string literal is âGroup 1â. 
--If the VendorName begins with the letter N-Z, the string literal is âGroup 2â. 
--Sort the final result set by InvoiceType, and then by VendorGroup. 
--(114 row(s) affected) â this one is worth 20 points.

SELECT 
    InvoiceNumber,
    VendorName,
    CASE 
        WHEN InvoiceNumber LIKE '%[A-Z]%' THEN 'Type 1'
        ELSE 'Type 2'
    END AS InvoiceType,
    CASE 
        WHEN LEFT(VendorName, 1) BETWEEN 'A' AND 'M' THEN 'Group 1'
        ELSE 'Group 2'
    END AS VendorGroup
FROM 
    Invoices AS I
JOIN 
    Vendors AS V ON I.VendorID = V.VendorID
ORDER BY 
    InvoiceType,
    VendorGroup;
