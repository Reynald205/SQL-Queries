--Data Cleaning example complete with Housing Dataset by Reynald Walme
--Create new Database named Housing_Database
--Import MS Excel files to Database with each using their file name for Tables

/* Tasks for the data include: Standardize Date Format, Populating the Address Data,
   Breaking down address into individual columns(Address, City, State),
   Change Y and N to Yes and No in 'Sold as Vacant' field, Remove Duplicates, Delete Unused Columns.
*/
---------------------------------------------------------------------------------------------------------------
--Testing if Data Imported Correctly

use Housing_Database
SELECT * FROM Housing

---------------------------------------------------------------------------------------------------------------
--Standardize Date Format

SELECT SaleDate, CONVERT(Date,SaleDate)
FROM Housing
-- Learned that SaleDate was a variable incompatitable with the a date converion 

ALTER TABLE Housing
ALTER COLUMN SaleDate Date
--Change the column type

Update dbo.Housing 
SET SaleDate = CONVERT(Date,SaleDate)
From Housing
--Update the Table with the conversion

---------------------------------------------------------------------------------------------------------------
--Populating the Address Data

SELECT * 
FROM Housing
WHERE PropertyAddress IS NULL
--Searching for Null values: 29 found, Can use the Parcel ID to match address.

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress) 
FROM Housing a
JOIN Housing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL
--Finds the true values for the NULL Property Address by comparing ParcelID on the same table 

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM Housing a
JOIN Housing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL
--Updates and sets the Null values to their true address, run the previous query to check for no NULL 

---------------------------------------------------------------------------------------------------------------
--Breaking down address into individual columns(Address, City, State)

SELECT PropertyAddress
FROM Housing

SELECT SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress) -1) AS Alt_Address,
	SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress) +1, LEN(PropertyAddress)) AS City
FROM Housing
-- Altering the string from Property Address to get Address and City

ALTER TABLE Housing
ADD Alt_Address Nvarchar(255)
--Add the column and type

Update dbo.Housing 
SET Alt_Address = SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress) -1)

ALTER TABLE Housing
ADD City Nvarchar(255)
--Add the column and type

Update dbo.Housing 
SET City = SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress) +1, LEN(PropertyAddress))


SELECT OwnerAddress 
FROM Housing

SELECT 
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1) 
FROM Housing

ALTER TABLE Housing
ADD Alt_OwnerAddress Nvarchar(255)
--Add the column and type

Update dbo.Housing 
SET Alt_OwnerAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

ALTER TABLE Housing
ADD OwnerCity Nvarchar(255)
--Add the column and type

Update dbo.Housing 
SET OwnerCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

ALTER TABLE Housing
ADD Owner_State Nvarchar(255)
--Add the column and type

Update dbo.Housing 
SET Owner_State = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

---------------------------------------------------------------------------------------------------------------
--Change Y and N to Yes and No in 'Sold as Vacant' field 

SELECT DISTINCT SoldAsVacant, COUNT(SoldAsVacant)
FROM Housing
GROUP BY SoldAsVacant
ORDER BY 2
--Finds the different of values but must be changed to either Yes or No

SELECT SoldAsVacant,
	CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
		 WHEN SoldAsVacant = 'N' THEN 'No'
		 ELSE SoldAsVacant
		 END
FROM Housing
--Case Switch to change values on conditions

Update dbo.Housing 
SET SoldAsVacant =
	CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
		 WHEN SoldAsVacant = 'N' THEN 'No'
		 ELSE SoldAsVacant
		 END
--Update Table with the changed values and run first Query to check values

---------------------------------------------------------------------------------------------------------------
--Remove Duplicates 

WITH row_numCTE AS (
SELECT *, ROW_NUMBER () OVER ( 
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY UniqueID
				 ) row_num
FROM Housing
--Finding the duplicate data using CTE
) /*DELETE*/ SELECT * FROM row_numCTE
	WHERE row_num > 1
	--ORDER BY PropertyAddress
	--Deleting Duplicates
	--Switch code to Select after delete to confirm duplicates are gone

---------------------------------------------------------------------------------------------------------------
--Delete Unused Columns.

SELECT * FROM Housing

ALTER TABLE Housing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress 
--Useless Data Deleted!

---------------------------------------------------------------------------------------------------------------

