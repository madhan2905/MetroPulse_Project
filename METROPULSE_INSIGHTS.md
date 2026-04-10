# 🚇 MetroPulse: Delhi Metro Analytics Report

## Q1. Which metro routes have the highest passenger traffic?
```sql
SELECT
    From_Station,
    To_Station,
    SUM(Passengers)             AS Total_Passengers,
    COUNT(TripID)               AS Total_Trips
FROM metro_trips
GROUP BY From_Station, To_Station
ORDER BY Total_Passengers DESC
LIMIT 10;
```

| From_Station   | To_Station           |   Total_Passengers |   Total_Trips |
|:---------------|:---------------------|-------------------:|--------------:|
| Rajiv Chowk    | Chandni Chowk        |               1758 |            88 |
| Rajiv Chowk    | Noida City Centre    |               1605 |            83 |
| Rajiv Chowk    | Old Delhi            |               1592 |            82 |
| Rajiv Chowk    | Kirti Nagar          |               1554 |            76 |
| Rajiv Chowk    | Janakpuri West       |               1527 |            76 |
| Rajiv Chowk    | Jasola Vihar         |               1522 |            75 |
| Rajiv Chowk    | Aiims                |               1505 |            76 |
| Rajiv Chowk    | Netaji Subhash Place |               1496 |            78 |
| Rajiv Chowk    | Kalkaji Mandir       |               1475 |            73 |
| Rajiv Chowk    | Hauz Khas            |               1434 |            75 |

## Q2. Which routes generate the highest total revenue?
```sql
SELECT
    From_Station,
    To_Station,
    ROUND(SUM(Fare), 2)         AS Total_Revenue,
    COUNT(TripID)               AS Total_Trips
FROM metro_trips
GROUP BY From_Station, To_Station
ORDER BY Total_Revenue DESC
LIMIT 10;
```

| From_Station   | To_Station        |   Total_Revenue |   Total_Trips |
|:---------------|:------------------|----------------:|--------------:|
| Rajiv Chowk    | Chandni Chowk     |         9493.74 |            88 |
| Rajiv Chowk    | Hauz Khas         |         8257.65 |            75 |
| Rajiv Chowk    | Kalkaji Mandir    |         8203.74 |            73 |
| Rajiv Chowk    | Old Delhi         |         8157.98 |            82 |
| Rajiv Chowk    | Dilshad Garden    |         8097.83 |            72 |
| Rajiv Chowk    | Aiims             |         8082.53 |            76 |
| Rajiv Chowk    | Noida City Centre |         7972.1  |            83 |
| Rajiv Chowk    | Laxmi Nagar       |         7795.99 |            67 |
| Rajiv Chowk    | Kirti Nagar       |         7720.31 |            76 |
| Rajiv Chowk    | Jasola Vihar      |         7592.18 |            75 |

## Q3. What is the average fare for each route?
```sql
SELECT
    From_Station,
    To_Station,
    ROUND(AVG(Fare), 2)         AS Avg_Fare,
    COUNT(TripID)               AS Total_Trips
FROM metro_trips
GROUP BY From_Station, To_Station
ORDER BY Avg_Fare DESC
LIMIT 10;
```

| From_Station   | To_Station        |   Avg_Fare |   Total_Trips |
|:---------------|:------------------|-----------:|--------------:|
| Laxmi Nagar    | Laxmi Nagar       |     167.98 |             3 |
| Dilshad Garden | Dilshad Garden    |     153.26 |             1 |
| Hauz Khas      | Pragati Maidan    |     140.6  |            13 |
| Chandni Chowk  | Laxmi Nagar       |     140.51 |            15 |
| Inderlok       | Model Town        |     134.58 |            22 |
| Chandni Chowk  | Rajiv Chowk       |     132.17 |            18 |
| Rajouri Garden | Noida City Centre |     131.87 |            18 |
| Kalkaji Mandir | Rajouri Garden    |     130.41 |            18 |
| Hauz Khas      | Noida City Centre |     130.15 |            23 |
| Jasola Vihar   | Kirti Nagar       |     129.13 |            18 |

## Q4. Which routes have the longest travel distances?
```sql
SELECT
    From_Station,
    To_Station,
    ROUND(AVG(Distance_km), 2)  AS Avg_Distance_km
FROM metro_trips
GROUP BY From_Station, To_Station
ORDER BY Avg_Distance_km DESC
LIMIT 10;
```

| From_Station        | To_Station          |   Avg_Distance_km |
|:--------------------|:--------------------|------------------:|
| Inderlok            | Inderlok            |             12.54 |
| Dilshad Garden      | Hauz Khas           |              9.74 |
| Hauz Khas           | Noida City Centre   |              9.26 |
| Hauz Khas           | Old Delhi           |              9.05 |
| Kashmere Gate       | Kalkaji Mandir      |              8.41 |
| Inderlok            | Central Secretariat |              8.12 |
| Model Town          | Old Delhi           |              8.01 |
| Central Secretariat | New Delhi           |              7.95 |
| Hauz Khas           | Punjabi Bagh        |              7.95 |
| Hauz Khas           | Pragati Maidan      |              7.93 |

## Q5. Which stations have the highest number of trip departures?
```sql
SELECT
    From_Station                AS Station,
    COUNT(TripID)               AS Departures
FROM metro_trips
GROUP BY From_Station
ORDER BY Departures DESC
LIMIT 10;
```

| Station           |   Departures |
|:------------------|-------------:|
| Rajiv Chowk       |         1694 |
| Noida City Centre |         1237 |
| New Delhi         |          838 |
| Mandi House       |          832 |
| Chandni Chowk     |          450 |
| Inderlok          |          447 |
| Model Town        |          425 |
| Kashmere Gate     |          425 |
| Aiims             |          423 |
| Laxmi Nagar       |          422 |

## Q6. Which stations receive the highest number of passengers?
```sql
SELECT
    To_Station                  AS Station,
    SUM(Passengers)             AS Total_Arriving_Passengers
FROM metro_trips
GROUP BY To_Station
ORDER BY Total_Arriving_Passengers DESC
LIMIT 10;
```

| Station              |   Total_Arriving_Passengers |
|:---------------------|----------------------------:|
| Jasola Vihar         |                        9018 |
| Laxmi Nagar          |                        9010 |
| Chandni Chowk        |                        8812 |
| Barakhamba Road      |                        8709 |
| Rajouri Garden       |                        8664 |
| Kalkaji Mandir       |                        8652 |
| Netaji Subhash Place |                        8504 |
| Noida City Centre    |                        8447 |
| Inderlok             |                        8359 |
| Aiims                |                        8240 |

## Q7. What are the top 10 most frequently used metro stations?
```sql
SELECT
    Station,
    SUM(Usage_Count)            AS Total_Usage
FROM (
    SELECT From_Station AS Station, COUNT(*) AS Usage_Count FROM metro_trips GROUP BY From_Station
    UNION ALL
    SELECT To_Station   AS Station, COUNT(*) AS Usage_Count FROM metro_trips GROUP BY To_Station
) AS combined
GROUP BY Station
ORDER BY Total_Usage DESC
LIMIT 10;
```

| Station           |   Total_Usage |
|:------------------|--------------:|
| Rajiv Chowk       |          2078 |
| Noida City Centre |          1660 |
| Mandi House       |          1249 |
| New Delhi         |          1243 |
| Chandni Chowk     |           884 |
| Inderlok          |           876 |
| Laxmi Nagar       |           874 |
| Jasola Vihar      |           867 |
| Aiims             |           840 |
| Kalkaji Mandir    |           838 |

## Q8. Which station pairs are most frequently used for travel?
```sql
SELECT
    From_Station,
    To_Station,
    COUNT(TripID)               AS Trip_Count
FROM metro_trips
GROUP BY From_Station, To_Station
ORDER BY Trip_Count DESC
LIMIT 10;
```

| From_Station   | To_Station           |   Trip_Count |
|:---------------|:---------------------|-------------:|
| Rajiv Chowk    | Chandni Chowk        |           88 |
| Rajiv Chowk    | Noida City Centre    |           83 |
| Rajiv Chowk    | Old Delhi            |           82 |
| Rajiv Chowk    | Netaji Subhash Place |           78 |
| Rajiv Chowk    | Aiims                |           76 |
| Rajiv Chowk    | Inderlok             |           76 |
| Rajiv Chowk    | Janakpuri West       |           76 |
| Rajiv Chowk    | Kirti Nagar          |           76 |
| Rajiv Chowk    | Hauz Khas            |           75 |
| Rajiv Chowk    | Jasola Vihar         |           75 |

## Q9. What is the total revenue generated from all trips?
```sql
SELECT
    ROUND(SUM(Fare), 2)         AS Total_Revenue
FROM metro_trips;
```

|   Total_Revenue |
|----------------:|
|     1.04386e+06 |

## Q10. What is the average fare per trip?
```sql
SELECT
    ROUND(AVG(Fare), 2)         AS Avg_Fare_Per_Trip
FROM metro_trips;
```

|   Avg_Fare_Per_Trip |
|--------------------:|
|              104.39 |

## Q11. Which routes generate the highest revenue per kilometer?
```sql
SELECT
    From_Station,
    To_Station,
    ROUND(SUM(Fare) / NULLIF(SUM(Distance_km), 0), 2) AS Revenue_Per_Km
FROM metro_trips
GROUP BY From_Station, To_Station
ORDER BY Revenue_Per_Km DESC
LIMIT 10;
```

| From_Station        | To_Station        |   Revenue_Per_Km |
|:--------------------|:------------------|-----------------:|
| Dilshad Garden      | Dilshad Garden    |           255.43 |
| Central Secretariat | Pragati Maidan    |            47.09 |
| Kalkaji Mandir      | Barakhamba Road   |            45.3  |
| Laxmi Nagar         | Laxmi Nagar       |            42.6  |
| Aiims               | Aiims             |            40.47 |
| Inderlok            | Dilshad Garden    |            36.45 |
| Rajouri Garden      | Dilshad Garden    |            34.53 |
| Inderlok            | Noida City Centre |            33.76 |
| Jasola Vihar        | Jasola Vihar      |            33.67 |
| Kalkaji Mandir      | Inderlok          |            33.2  |

## Q12. Which ticket type generates the highest revenue?
```sql
SELECT
    Ticket_Type,
    ROUND(SUM(Fare), 2)         AS Total_Revenue,
    COUNT(TripID)               AS Total_Trips,
    ROUND(AVG(Fare), 2)         AS Avg_Fare
FROM metro_trips
GROUP BY Ticket_Type
ORDER BY Total_Revenue DESC;
```

| Ticket_Type   |   Total_Revenue |   Total_Trips |   Avg_Fare |
|:--------------|----------------:|--------------:|-----------:|
| Tourist Card  |        506805   |          4845 |     104.6  |
| Single        |        266359   |          2549 |     104.5  |
| Smart Card    |        259084   |          2494 |     103.88 |
| Unknown       |         11614.1 |           112 |     103.7  |

## Q13. What is the average number of passengers per trip?
```sql
SELECT
    ROUND(AVG(Passengers), 2)   AS Avg_Passengers_Per_Trip
FROM metro_trips;
```

|   Avg_Passengers_Per_Trip |
|--------------------------:|
|                     19.85 |

## Q14. Which trips recorded the highest passenger counts?
```sql
SELECT
    TripID,
    Date,
    From_Station,
    To_Station,
    Passengers,
    Ticket_Type,
    Remarks
FROM metro_trips
ORDER BY Passengers DESC
LIMIT 10;
```

|   TripID | Date       | From_Station        | To_Station          |   Passengers | Ticket_Type   | Remarks     |
|---------:|:-----------|:--------------------|:--------------------|-------------:|:--------------|:------------|
|    93442 | 2023-11-04 | Mandi House         | Laxmi Nagar         |           37 | Smart Card    | Off-Peak    |
|    43161 | 2024-02-11 | New Delhi           | Punjabi Bagh        |           36 | Single        | nan         |
|    78615 | 2022-06-13 | Jasola Vihar        | Central Secretariat |           36 | Tourist Card  | Maintenance |
|   140529 | 2022-03-01 | New Delhi           | Noida City Centre   |           36 | Tourist Card  | Maintenance |
|    63781 | 2023-05-24 | Mandi House         | Chandni Chowk       |           35 | Smart Card    | Maintenance |
|    92107 | 2024-07-01 | Dilshad Garden      | Janakpuri West      |           35 | Tourist Card  | Festival    |
|    27146 | 2023-11-26 | Mandi House         | Kirti Nagar         |           35 | Single        | Maintenance |
|    52251 | 2023-07-10 | New Delhi           | Janakpuri West      |           35 | Smart Card    | Peak        |
|    87385 | 2024-10-15 | Central Secretariat | Chandni Chowk       |           35 | Single        | Maintenance |
|    48752 | 2024-04-01 | Chandni Chowk       | Pragati Maidan      |           35 | Tourist Card  | nan         |

## Q15. What is the passenger distribution by ticket type?
```sql
SELECT
    Ticket_Type,
    SUM(Passengers)             AS Total_Passengers,
    ROUND(AVG(Passengers), 2)   AS Avg_Passengers,
    COUNT(TripID)               AS Trip_Count
FROM metro_trips
GROUP BY Ticket_Type
ORDER BY Total_Passengers DESC;
```

| Ticket_Type   |   Total_Passengers |   Avg_Passengers |   Trip_Count |
|:--------------|-------------------:|-----------------:|-------------:|
| Tourist Card  |              96282 |            19.87 |         4845 |
| Single        |              50377 |            19.76 |         2549 |
| Smart Card    |              49562 |            19.87 |         2494 |
| Unknown       |               2247 |            20.06 |          112 |

## Q16. What is the total passenger count for each station?
```sql
SELECT
    Station,
    SUM(Passengers)             AS Total_Passengers
FROM (
    SELECT From_Station AS Station, Passengers FROM metro_trips
    UNION ALL
    SELECT To_Station   AS Station, Passengers FROM metro_trips
) AS combined
GROUP BY Station
ORDER BY Total_Passengers DESC
LIMIT 10;
```

| Station           |   Total_Passengers |
|:------------------|-------------------:|
| Rajiv Chowk       |              41013 |
| Noida City Centre |              32843 |
| Mandi House       |              24888 |
| New Delhi         |              24751 |
| Chandni Chowk     |              17883 |
| Laxmi Nagar       |              17421 |
| Jasola Vihar      |              17288 |
| Inderlok          |              17242 |
| Kalkaji Mandir    |              16851 |
| Aiims             |              16610 |

## Q17. How many trips occur during peak, off-peak, festival, and weekend conditions?
```sql
SELECT
    Remarks                     AS Travel_Condition,
    COUNT(TripID)               AS Total_Trips,
    SUM(Passengers)             AS Total_Passengers
FROM metro_trips
GROUP BY Remarks
ORDER BY Total_Trips DESC;
```

| Travel_Condition   |   Total_Trips |   Total_Passengers |
|:-------------------|--------------:|-------------------:|
| nan                |          1754 |              34812 |
| Festival           |          1673 |              33165 |
| Off-Peak           |          1655 |              33257 |
| Weekend            |          1651 |              32614 |
| Maintenance        |          1649 |              32682 |
| Peak               |          1618 |              31938 |

## Q18. Which travel condition generates the highest revenue?
```sql
SELECT
    Remarks                     AS Travel_Condition,
    ROUND(SUM(Fare), 2)         AS Total_Revenue,
    ROUND(AVG(Fare), 2)         AS Avg_Fare
FROM metro_trips
GROUP BY Remarks
ORDER BY Total_Revenue DESC;
```

| Travel_Condition   |   Total_Revenue |   Avg_Fare |
|:-------------------|----------------:|-----------:|
| nan                |          182216 |     103.89 |
| Festival           |          177420 |     106.05 |
| Weekend            |          174009 |     105.4  |
| Off-Peak           |          172776 |     104.4  |
| Peak               |          169053 |     104.48 |
| Maintenance        |          168387 |     102.11 |

## Q19. What is the monthly passenger trend across the dataset?
```sql
SELECT
    STRFTIME('%Y-%m', Date)     AS Year_Month,  -- SQLite syntax
    -- DATE_FORMAT(Date, '%Y-%m') AS Year_Month, -- MySQL syntax
    SUM(Passengers)             AS Total_Passengers,
    COUNT(TripID)               AS Total_Trips
FROM metro_trips
GROUP BY Year_Month
ORDER BY Year_Month;
```

| Year_Month   |   Total_Passengers |   Total_Trips |
|:-------------|-------------------:|--------------:|
| 2022-01      |               5330 |           272 |
| 2022-02      |               5441 |           267 |
| 2022-03      |               5434 |           280 |
| 2022-04      |               5972 |           304 |
| 2022-05      |               5622 |           279 |
| 2022-06      |               5521 |           282 |
| 2022-07      |               5369 |           273 |
| 2022-08      |               5117 |           259 |
| 2022-09      |               5379 |           271 |
| 2022-10      |               5384 |           276 |
| 2022-11      |               5385 |           273 |
| 2022-12      |               5764 |           288 |
| 2023-01      |               5871 |           292 |
| 2023-02      |               4982 |           249 |
| 2023-03      |               5613 |           279 |
| 2023-04      |               5515 |           277 |
| 2023-05      |               5699 |           281 |
| 2023-06      |               5013 |           252 |
| 2023-07      |               6009 |           302 |
| 2023-08      |               5210 |           265 |
| 2023-09      |               5307 |           272 |
| 2023-10      |               5892 |           299 |
| 2023-11      |               5304 |           262 |
| 2023-12      |               6192 |           311 |
| 2024-01      |               6140 |           313 |
| 2024-02      |               5440 |           265 |
| 2024-03      |               5208 |           259 |
| 2024-04      |               5721 |           287 |
| 2024-05      |               5760 |           286 |
| 2024-06      |               5153 |           259 |
| 2024-07      |               5574 |           283 |
| 2024-08      |               5863 |           302 |
| 2024-09      |               6211 |           313 |
| 2024-10      |               5020 |           255 |
| 2024-11      |               4880 |           248 |
| 2024-12      |               5173 |           265 |

## Q20. Which travel condition has the highest average passenger count per trip?
```sql
SELECT
    Remarks                     AS Travel_Condition,
    ROUND(AVG(Passengers), 2)   AS Avg_Passengers_Per_Trip,
    COUNT(TripID)               AS Total_Trips
FROM metro_trips
GROUP BY Remarks
ORDER BY Avg_Passengers_Per_Trip DESC;
```

| Travel_Condition   |   Avg_Passengers_Per_Trip |   Total_Trips |
|:-------------------|--------------------------:|--------------:|
| Off-Peak           |                     20.09 |          1655 |
| nan                |                     19.85 |          1754 |
| Maintenance        |                     19.82 |          1649 |
| Festival           |                     19.82 |          1673 |
| Weekend            |                     19.75 |          1651 |
| Peak               |                     19.74 |          1618 |

