--Q1
-- 1. Find FullName (e.g. "Doe, John") of contacts whose first names begin with the letter A, B, C, or F. Sort the result set by VendorContactFName)
Select VendorContactLName + ', ' + VendorContactFName As [Full Name]
From [dbo].[Vendors]
where VendorContactFName LIKE '[ABCF]%'
Order By VendorContactFName

--Q2
--2. Write a SELECT Statement that returns the following four columns from the Invoices table:
SELECT InvoiceNumber AS [Invoice No], InvoiceTotal Total, PaymentTotal + CreditTotal AS Credits,
	InvoiceTotal - PaymentTotal - CreditTotal AS Balance
FROM [dbo].[Invoices]
WHERE (InvoiceNumber LIKE '[A-z]%' AND InvoiceTotal - PaymentTotal - CreditTotal >=1000)
	OR (InvoiceNumber NOT LIKE '[a-z]%' AND InvoiceTotal - PaymentTotal - CreditTotal != 0)

--Q3
--Write a SELECT statement that returns vendorName, InvoiceNumber, InvoiceDate, and 

SELECT InvoiceNumber, VendorName, InvoiceDate,
	InvoiceTotal - PaymentTotal - CreditTotal AS Balance
FROM Vendors AS v JOIN Invoices AS i
	ON v.VendorID = i.vendorID
ORDER BY 1

--Q4
SELECT VendorName, InvoiceNumber, InvoiceDate, InvoicLineAmount, AccountDescription
FROM Vendors v JOIN Invoices i ON v.VendorID
--Q5
SELECT i.VendorID, v.VendorID, VendorName, InvoiceID
FROM Vendors v LEFT JOIN Invoices i ON v.VendorID = i.VendorID
WHERE i.VendorID IS NULL

--Q6
SELECT v.VendorID, VendorName, InvoiceID
FROM [dbo].[Vendors] as v join [dbo].[Invoices] as i ON v.VendorID = i.VendorID
WHERE InvoiceTotal <>0
ORDER BY InvoiceID

--Q7
SELECT 
    GL.AccountNo,
    GL.AccountDescription,
    V.VendorID,
    V.VendorName,
    I.InvoiceNumber,
    I.InvoiceTotal
FROM 
    GLAccounts GL
JOIN 
    Invoices I ON GL.AccountNo = I.AccountNo
JOIN 
    Vendors V ON I.VendorID = V.VendorID
WHERE 
    GL.AccountNo IN (SELECT DISTINCT AccountNo FROM Invoices)
ORDER BY 
    I.InvoiceTotal DESC;



--Q8
SELECT InvoiceNumber, VendorName, 'A-I' AS [Group]
FROM Invoices AS i INNER JOIN Vendors AS v ON i.VendorID = v.VendorID
WHERE VendorName LIKE '[a-i]%'
UNION
SELECT InvoiceNumber, VendorName, 'J-R' AS [Group]
FROM Invoices AS i INNER JOIN Vendors AS v ON i.VendorID = v.VendorID
WHERE VendorName LIKE '[j-r]%'
UNION
SELECT InvoiceNumber, VendorName, 'S-Z' AS [Group]
FROM Invoices AS i INNER JOIN Vendors AS v ON i.VendorID = v.VendorID
WHERE VendorName LIKE '[s-z]%'
ORDER BY 3, 2

--Q9
SELECT AccountNo
FROM GLAccounts
WHERE AccountNo >= 500 
    AND AccountDescription LIKE '%fee%' 

INTERSECT 

SELECT DefaultAccountNo
FROM Vendors;

--Q10
SELECT AccountNo
FROM GLAccounts
WHERE AccountNo >= 500 
    AND AccountDescription LIKE '%fee%' 
    AND AccountNo IN (SELECT DefaultAccountNo FROM Vendors);
