--1.
	DROP VIEW IF EXISTS VendorAddress
GO 
	CREATE VIEW VendorAddress
	WITH SCHEMABINDING 
	AS
	SELECT VendorID, VendorAddress1, VendorAddress2, VendorCity, VendorState, VendorZipCode
	FROM [dbo].[Vendors]
GO
--2.
	SELECT * FROM VendorAddress
	WHERE VendorID =4
GO 
--3. 
	DROP VIEW IF EXISTS InvoiceBasic
GO 
	CREATE VIEW InvoiceBasic
	AS
	SELECT InvoiceNumber, InvoiceTotal
	FROM [dbo].[Invoices]
GO 
	SELECT*FROM InvoiceBasic ORDER BY InvoiceTotal DESC 
--4.
	DROP VIEW IF EXISTS VendorInvoice
GO 
	CREATE VIEW VendorInvoice
	AS
	SELECT VendorName, InvoiceNumber, InvoiceTotal
	FROM [dbo].[Vendors] v JOIN [dbo].[Invoices] i 
		ON v.VendorID = i.VendorID
GO 
	SELECT * FROM VendorInvoice WHERE VendorName LIKE '[anop]%' ORDER BY VendorName 

