SELECT 
  Top (1000) [DateKey], 
  [FullDateAlternateKey] AS Date 
  --,[DayNumberOfWeek]
  , 
  [EnglishDayNameOfWeek] AS Day 
  -- ,[SpanishDayNameOfWeek]
  -- ,[FrenchDayNameOfWeek]
  -- ,[DayNumberOfMonth]
  -- ,[DayNumberOfYear]
  , 
  [WeekNumberOfYear] AS Week, 
  [EnglishMonthName] As Month, 
  LEFT([EnglishMonthName], 3) AS MonthShort 
  -- ,[SpanishMonthName]
  -- ,[FrenchMonthName]
  , 
  [MonthNumberOfYear] AS MonthNo, 
  [CalendarQuarter] AS Quarter, 
  [CalendarYear] AS Year 
  -- ,[CalendarSemester]
  -- ,[FiscalQuarter]
  -- ,[FiscalYear]
  -- ,[FiscalSemester]
FROM 
  [AdventureWorksDW2019].[dbo].[DimDate]
WHERE
   CalendarYear >= 2014
