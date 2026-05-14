	-- Cleansed FACT_InternetSales Table --
	SELECT 
	  [ProductKey], 
	  [OrderDateKey], 
	  [DueDateKey], 
	  [ShipDateKey], 
	  [CustomerKey], 
	  --  ,[PromotionKey]
	  --  ,[CurrencyKey]
	  --  ,[SalesTerritoryKey]
	  [SalesOrderNumber], 
	  --  [SalesOrderLineNumber], 
	  --  ,[RevisionNumber]
	  --  ,[OrderQuantity], 
	  --  ,[UnitPrice], 
	  --  ,[ExtendedAmount]
	  --  ,[UnitPriceDiscountPct]
	  --  ,[DiscountAmount] 
	  --  ,[ProductStandardCost]
	  --  ,[TotalProductCost] 
	  [SalesAmount] --  ,[TaxAmt]
	  --  ,[Freight]
	  --  ,[CarrierTrackingNumber] 
	  --  ,[CustomerPONumber] 
	  --  ,[OrderDate] 
	  --  ,[DueDate] 
	  --  ,[ShipDate] 
	FROM 
	  [AdventureWorksDW2019].[dbo].[FactInternetSales]
	ORDER BY
	  OrderDateKey ASC