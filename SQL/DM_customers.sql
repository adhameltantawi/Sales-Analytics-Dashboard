-- Cleansed DIM Customers Table
SELECT 
  c.CustomerKey AS CustomerKey, 
  -- c.GeographyKey,
  -- c.CustomerAlternateKey,
  -- c.Title,
  c.FirstName AS [First Name], 
  -- c.MiddleName,
  c.LastName AS [Last Name], 
  c.FirstName + ' ' + c.LastName AS [Full Name], 
  -- Combined First and Last Name
  -- combaind first and last name
  -- c.NameStyle,
  -- c.BirthDate,
  -- c.MaritalStatus,
  -- c.Suffix,
  CASE WHEN c.Gender = 'M' THEN 'Male' WHEN c.Gender = 'F' THEN 'Female' ELSE 'Unknown' END AS Gender, 
  c.gender as Test,
  -- c.EmailAddress,
  -- c.YearlyIncome,
  -- c.TotalChildren,
  -- c.NumberChildrenAtHome,
  -- 
  -- c.EnglishEducation,
  -- c.SpanishEducation,
  -- c.FrenchEducation,
  -- 
  -- c.EnglishOccupation,
  -- c.SpanishOccupation,
  -- c.FrenchOccupation,
  -- 
  -- c.HouseOwnerFlag,
  -- c.NumberCarsOwned,
  --   
  -- c.AddressLine1,
  -- c.AddressLine2,
  -- c.Phone,
  c.DateFirstPurchase AS [Date First Purchase], 
  --  c.CommuteDistance,
  g.City AS [Customer City] 
  -- Joined from Geography Table
FROM 
  dbo.DimCustomer AS c 
  LEFT JOIN dbo.DimGeography AS g ON g.GeographyKey = c.GeographyKey 
ORDER BY 
  c.CustomerKey ASC;
