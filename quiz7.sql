SQL
DECLARE @TotInv INT;
SET @TotInv = (SELECT COUNT(*) FROM Invoices
                WHERE InvoiceTotal-PaymentTotal-CreditTotal > 5000)
SELECT ' Invoices exceed $5,000.'
SELECT CONVERT(VARCHAR, @TotInv) + 'invoices exceed $5000.';

--2
DECLARE @TotInv INT
DECLARE @SumBalance MONEY
SELECT @TotInv= COUNT(*), 
		@SumBalance = SUM(InvoiceTotal-PaymentTotal-CreditTotal)
FROM [dbo].[Invoices]
WHERE InvoiceTotal-PaymentTotal-CreditTotal >0;
IF @SumBalance >= 10000
BEGIN
	SELECT'' 

END
ELSE
SELECT 'Total balance due is less than $10,000.'

--q3.
DROP PROC IF EXISTS spVendorStateInvTotal
GO
CREATE PROC spVendorStateInvTotal





--q4.
DROP PROC IF EXISTS spVendorStateInvTotal
GO
CREATE PROC spVendorStateInvTotal
	@SumInvoiceTotal MONEY OUTPUT
	@VendorState VARCHAR(2)
AS
SELECT 