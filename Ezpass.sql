--E-Z pass Data set collected for Tax purposes by Reynald Walme
use Ezpass
-- Defines Database to use

SELECT * FROM EZ2024
Order By [POSTING DATE] asc
--Using these commands to check if the collection of data is successful. 854 rows.

SELECT * FROM EZ2024
WHERE [ACTIVITY] = 'Prepaid Toll Payment'
ORDER BY [POSTING DATE] asc
--Finds all the pre-paid ez-pass payments made over the year.

SELECT AGENCY, ACTIVITY, SUM(AMOUNT) as Yearly_Total FROM EZ2024
GROUP BY AGENCY, ACTIVITY
ORDER BY Yearly_Total DESC
--Finds all the Yearly Total Sums of the Different Tolls including the E-Z pass prepaid $5710.91

SELECT ACTIVITY, SUM(AMOUNT)AS Yearly_EZ_Pass FROM EZ2024
WHERE [ACTIVITY] = 'Prepaid Toll Payment'
GROUP BY ACTIVITY
--Finds Directly the Yearly Total amount of the EZ-pass $5710.91
