create database Border_Traffic
use Border_Traffic

select * from Borderdata

--Traffic Volume by Border
SELECT Border, SUM(CAST(Value AS BIGINT)) AS Total_Traffic
FROM Borderdata
GROUP BY Border
ORDER BY Total_Traffic DESC;

--Traffic Volume by State
SELECT State, SUM(cast(Value as bigint)) AS Total_Traffic
FROM borderdata
GROUP BY State
ORDER BY Total_Traffic DESC;

--Monthly Traffic Trends
SELECT Date, SUM(CAST(Value AS BIGINT)) AS Monthly_Traffic
FROM borderdata
GROUP BY Date
ORDER BY Date;

--Yearly Traffic Trends
SELECT LEFT(Date, 4) AS Year, SUM(CAST(Value AS BIGINT)) AS Yearly_Traffic
FROM borderdata
GROUP BY LEFT(Date, 4)
ORDER BY Year;

--Most Active Ports
SELECT Port_Name, SUM(CAST(Value AS BIGINT)) AS Total_Traffic
FROM borderdata
GROUP BY Port_Name
ORDER BY Total_Traffic DESC;

--Traffic by Measure
SELECT Measure, SUM(CAST(Value AS BIGINT)) AS Total_Traffic
FROM borderdata
GROUP BY Measure
ORDER BY Total_Traffic DESC;

--Geospatial Analysis (Latitude and Longitude)
SELECT Latitude, Longitude, SUM(CAST(Value AS BIGINT)) AS Total_Traffic
FROM borderdata
GROUP BY Latitude, Longitude
ORDER BY Total_Traffic DESC;

--Top Ports by Vehicle Type
SELECT Port_Name, Measure,
SUM(CAST(Value AS BIGINT)) Total_Traffic
FROM borderdata
WHERE Measure IN ('Trucks', 'Personal Vehicles', 'Buses')
GROUP BY Port_Name, Measure
ORDER BY Total_Traffic DESC;

--Comparison of Loaded vs. Empty Containers
SELECT 
    Port_Name, 
    SUM(CASE WHEN Measure = 'Truck Containers Loaded' THEN Value ELSE 0 END) AS Loaded_Containers,
    SUM(CASE WHEN Measure = 'Truck Containers Empty' THEN Value ELSE 0 END) AS Empty_Containers
FROM borderdata
GROUP BY Port_Name
ORDER BY Loaded_Containers DESC, Empty_Containers DESC;

--Peak Traffic Ports by Month
SELECT Port_Name, Date,
SUM(CAST(Value AS BIGINT)) AS Total_Traffic
FROM borderdata
GROUP BY Port_Name, Date
ORDER BY Total_Traffic DESC;

--Custom Metrics: Traffic Density
SELECT 
    Latitude, 
    Longitude, 
    Port_Name,
    SUM(Value) AS Total_Traffic,
    SUM(Value) / COUNT(DISTINCT Port_Name) AS Traffic_Density
FROM borderdata
GROUP BY Latitude, Longitude, Port_Name
ORDER BY Traffic_Density DESC;


