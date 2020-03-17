CREATE TABLE [Covid].[FactCovid](
	[DimDateKey] [int] NOT NULL,
	[DimGeoLocationKey] [int] NOT NULL,
	[Confirmed] [int] NOT NULL,
	[Deaths] [int] NOT NULL,
	[Recovered] [int] NOT NULL,
 CONSTRAINT [PK_Covid_FactCovid] PRIMARY KEY CLUSTERED 
(
	[DimDateKey] ASC,
	[DimGeoLocationKey] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [Covid].[DimDate](
	[DimDateKey] [int] NOT NULL,
	[DimDate] [date] NULL,
	[YearNumber] [int] NULL,
	[YearMonthNumber] [int] NULL,
	[MonthNumber] [int] NULL,
	[MonthName] [varchar](50) NULL,
	[MonthYearName] [varchar](50) NULL,
	[WeekNumber] [int] NULL,
	[WeekName] [varchar](50) NULL,
	[WeekNumberName] [varchar](50) NULL,
 CONSTRAINT [PK_Covid_DimDate] PRIMARY KEY CLUSTERED 
(
	[DimDateKey] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [Covid].[DimGeoLocation](
	[DimGeoLocationKey] [int] IDENTITY(1,1) NOT NULL,
	[ProvinceState] [varchar](100) NULL,
	[RegionCountry] [varchar](100) NULL,
	[RegionCountryConsolidated] [varchar](100) NULL,
 CONSTRAINT [PK_Covid_DimGeoLocation] PRIMARY KEY CLUSTERED 
(
	[DimGeoLocationKey] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [Covid].[FactCovid]  WITH CHECK ADD  CONSTRAINT [FK_Covid_FactCovid_DimDateKey] FOREIGN KEY([DimDateKey])
REFERENCES [Covid].[DimDate] ([DimDateKey])
GO

ALTER TABLE [Covid].[FactCovid] CHECK CONSTRAINT [FK_Covid_FactCovid_DimDateKey]
GO

ALTER TABLE [Covid].[FactCovid]  WITH CHECK ADD  CONSTRAINT [FK_Covid_FactCovid_DimGeoLocationKey] FOREIGN KEY([DimGeoLocationKey])
REFERENCES [Covid].[DimGeoLocation] ([DimGeoLocationKey])
GO

ALTER TABLE [Covid].[FactCovid] CHECK CONSTRAINT [FK_Covid_FactCovid_DimGeoLocationKey]
GO


