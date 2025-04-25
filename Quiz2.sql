--1.
SELECT VendorID, SUM(PaymentTotal) AS [Payment Sum]
FROM [dbo].[Invoices]
GROUP BY VendorID

--2.
SELECT TOP (10) VendorName, SUM(PaymentTotal) AS [PaymentSum]  
FROM Invoices as i JOIN [dbo].[Vendors] as v ON i.VendorID = v.VendorID
GROUP BY VendorName  
--3
SELECT VendorName, COUNT(i.VendorID) AS InvoiceCount, SUM(InvoiceTotal) AS InvoiceSum
FROM [dbo].[Invoices] i JOIN [dbo].[Vendors] v ON v.VendorID = i.VendorID
GROUP BY VendorName
ORDER BY 2 DESC

--4
SELECT AccountDescription, COUNT(ILI.AccountNo) AS LineItemCount,
        SUM(ILI.InvoiceLineItemAmount) AS LineItemSum
FROM GlAccounts GL
JOIN InvoiceLineItems ILI ON GL.AccountNo = ILI.AccountNo
GROUP BY GL.AccountDescription
HAVING COUNT(ILI.AccountNo) > 1
ORDER BY 
    LineItemCount DESC;

--Q5
SELECT AccountDescription, COUNT(ILI.AccountNo) AS LineItemCount,
        SUM(ILI.InvoiceLineItemAmount) AS LineItemSum
FROM GlAccounts GL 
JOIN InvoiceLineItems ILI ON GL.AccountNo = ILI.AccountNo
JOIN Invoices I on ILI.InvoiceID = I.InvoiceID
WHERE I.InvoiceDate >= '2012-01-01' AND I.InvoiceDate <='2012-04-30'
GROUP BY GL.AccountDescription
HAVING COUNT(ILI.AccountNo) > 1
ORDER BY 
    LineItemCount DESC;

--Q6
SELECT v.VendorName, gl.AccountDescription, 
    COUNT(gl.AccountNo) AS LineItemCount, 
    SUM(ili.InvoiceLineItemAmount) AS LineItemSum
FROM Vendors as v 
JOIN Invoices as i on v.VendorID = i.VendorID
JOIN [dbo].[InvoiceLineItems] as ili ON i.InvoiceID = ili.InvoiceID
JOIN GlAccounts as gl on ili.AccountNo = gl.AccountNo
GROUP BY v.VendorName, gl.AccountDescription
ORDER BY v.VendorName, gl.AccountDescription;
--Q7
SELECT InvoiceNumber, InvoiceTotal, VendorName
FROM Vendors v JOIN [dbo].[Invoices] i on v.VendorID= i.VendorID
WHERE InvoiceTotal = (SELECT max(InvoiceTotal) FROM [dbo].[Invoices])
	
--Q8
SELECT DISTINCT VendorName
FROM [dbo].[Vendors]
WHERE VendorID IN (SELECT VendorID FROM [dbo].[Invoices])
ORDER BY 1

--Q9.
SELECT InvoiceNumber, InvoiceTotal
FROM [dbo].[Invoices]
WHERE InvoiceTotal >(
		SELECT AVG(InvoiceTotal)
		FROM [dbo].[Invoices]
		WHERE InvoiceDate BETWEEN '2012-01-01' AND '2012-05-31'
	AND InvoiceNumber LIKE '%[A-Z]%')
ORDER BY InvoiceTotal;



--Q10.
SELECT AccountNo
FROM [dbo].[GLAccounts]
WHERE AccountNo NOT IN (SELECT DefaultAccountNo FROM Vendors);