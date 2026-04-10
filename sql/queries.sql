-- ============================================================
-- MetroPulse: Delhi Metro Travel Analytics
-- queries.sql  –  20 Analytical SQL Queries
-- ============================================================

-- ────────────────────────────────────────────────────────────
-- ROUTE ANALYSIS
-- ────────────────────────────────────────────────────────────

-- Q1. Which metro routes have the highest passenger traffic?
SELECT
    From_Station,
    To_Station,
    SUM(Passengers)             AS Total_Passengers,
    COUNT(TripID)               AS Total_Trips
FROM metro_trips
GROUP BY From_Station, To_Station
ORDER BY Total_Passengers DESC
LIMIT 10;

-- ──────────────────────────────────────────────────────────

-- Q2. Which routes generate the highest total revenue?
SELECT
    From_Station,
    To_Station,
    ROUND(SUM(Fare), 2)         AS Total_Revenue,
    COUNT(TripID)               AS Total_Trips
FROM metro_trips
GROUP BY From_Station, To_Station
ORDER BY Total_Revenue DESC
LIMIT 10;

-- ──────────────────────────────────────────────────────────

-- Q3. What is the average fare for each route?
SELECT
    From_Station,
    To_Station,
    ROUND(AVG(Fare), 2)         AS Avg_Fare,
    COUNT(TripID)               AS Total_Trips
FROM metro_trips
GROUP BY From_Station, To_Station
ORDER BY Avg_Fare DESC
LIMIT 10;

-- ──────────────────────────────────────────────────────────

-- Q4. Which routes have the longest travel distances?
SELECT
    From_Station,
    To_Station,
    ROUND(AVG(Distance_km), 2)  AS Avg_Distance_km
FROM metro_trips
GROUP BY From_Station, To_Station
ORDER BY Avg_Distance_km DESC
LIMIT 10;


-- ────────────────────────────────────────────────────────────
-- STATION ANALYSIS
-- ────────────────────────────────────────────────────────────

-- Q5. Which stations have the highest number of trip departures?
SELECT
    From_Station                AS Station,
    COUNT(TripID)               AS Departures
FROM metro_trips
GROUP BY From_Station
ORDER BY Departures DESC
LIMIT 10;

-- ──────────────────────────────────────────────────────────

-- Q6. Which stations receive the highest number of passengers?
SELECT
    To_Station                  AS Station,
    SUM(Passengers)             AS Total_Arriving_Passengers
FROM metro_trips
GROUP BY To_Station
ORDER BY Total_Arriving_Passengers DESC
LIMIT 10;

-- ──────────────────────────────────────────────────────────

-- Q7. What are the top 10 most frequently used metro stations?
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

-- ──────────────────────────────────────────────────────────

-- Q8. Which station pairs are most frequently used for travel?
SELECT
    From_Station,
    To_Station,
    COUNT(TripID)               AS Trip_Count
FROM metro_trips
GROUP BY From_Station, To_Station
ORDER BY Trip_Count DESC
LIMIT 10;


-- ────────────────────────────────────────────────────────────
-- REVENUE ANALYSIS
-- ────────────────────────────────────────────────────────────

-- Q9. What is the total revenue generated from all trips?
SELECT
    ROUND(SUM(Fare), 2)         AS Total_Revenue
FROM metro_trips;

-- ──────────────────────────────────────────────────────────

-- Q10. What is the average fare per trip?
SELECT
    ROUND(AVG(Fare), 2)         AS Avg_Fare_Per_Trip
FROM metro_trips;

-- ──────────────────────────────────────────────────────────

-- Q11. Which routes generate the highest revenue per kilometer?
SELECT
    From_Station,
    To_Station,
    ROUND(SUM(Fare) / NULLIF(SUM(Distance_km), 0), 2) AS Revenue_Per_Km
FROM metro_trips
GROUP BY From_Station, To_Station
ORDER BY Revenue_Per_Km DESC
LIMIT 10;

-- ──────────────────────────────────────────────────────────

-- Q12. Which ticket type generates the highest revenue?
SELECT
    Ticket_Type,
    ROUND(SUM(Fare), 2)         AS Total_Revenue,
    COUNT(TripID)               AS Total_Trips,
    ROUND(AVG(Fare), 2)         AS Avg_Fare
FROM metro_trips
GROUP BY Ticket_Type
ORDER BY Total_Revenue DESC;


-- ────────────────────────────────────────────────────────────
-- PASSENGER ANALYSIS
-- ────────────────────────────────────────────────────────────

-- Q13. What is the average number of passengers per trip?
SELECT
    ROUND(AVG(Passengers), 2)   AS Avg_Passengers_Per_Trip
FROM metro_trips;

-- ──────────────────────────────────────────────────────────

-- Q14. Which trips recorded the highest passenger counts?
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

-- ──────────────────────────────────────────────────────────

-- Q15. What is the passenger distribution by ticket type?
SELECT
    Ticket_Type,
    SUM(Passengers)             AS Total_Passengers,
    ROUND(AVG(Passengers), 2)   AS Avg_Passengers,
    COUNT(TripID)               AS Trip_Count
FROM metro_trips
GROUP BY Ticket_Type
ORDER BY Total_Passengers DESC;

-- ──────────────────────────────────────────────────────────

-- Q16. What is the total passenger count for each station?
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


-- ────────────────────────────────────────────────────────────
-- TRAVEL PATTERN ANALYSIS
-- ────────────────────────────────────────────────────────────

-- Q17. How many trips occur during peak, off-peak, festival, and weekend conditions?
SELECT
    Remarks                     AS Travel_Condition,
    COUNT(TripID)               AS Total_Trips,
    SUM(Passengers)             AS Total_Passengers
FROM metro_trips
GROUP BY Remarks
ORDER BY Total_Trips DESC;

-- ──────────────────────────────────────────────────────────

-- Q18. Which travel condition generates the highest revenue?
SELECT
    Remarks                     AS Travel_Condition,
    ROUND(SUM(Fare), 2)         AS Total_Revenue,
    ROUND(AVG(Fare), 2)         AS Avg_Fare
FROM metro_trips
GROUP BY Remarks
ORDER BY Total_Revenue DESC;

-- ──────────────────────────────────────────────────────────

-- Q19. What is the monthly passenger trend across the dataset?
SELECT
    STRFTIME('%Y-%m', Date)     AS Year_Month,  -- SQLite syntax
    -- DATE_FORMAT(Date, '%Y-%m') AS Year_Month, -- MySQL syntax
    SUM(Passengers)             AS Total_Passengers,
    COUNT(TripID)               AS Total_Trips
FROM metro_trips
GROUP BY Year_Month
ORDER BY Year_Month;

-- ──────────────────────────────────────────────────────────

-- Q20. Which travel condition has the highest average passenger count per trip?
SELECT
    Remarks                     AS Travel_Condition,
    ROUND(AVG(Passengers), 2)   AS Avg_Passengers_Per_Trip,
    COUNT(TripID)               AS Total_Trips
FROM metro_trips
GROUP BY Remarks
ORDER BY Avg_Passengers_Per_Trip DESC;
