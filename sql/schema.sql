-- ============================================================
-- MetroPulse: Delhi Metro Travel Analytics
-- schema.sql  –  Table creation + indexes
-- ============================================================

-- Drop existing table if re-running
DROP TABLE IF EXISTS metro_trips;

-- Main trips table
CREATE TABLE metro_trips (
    TripID              INTEGER      PRIMARY KEY,
    Date                DATE         NOT NULL,
    From_Station        VARCHAR(100) NOT NULL,
    To_Station          VARCHAR(100) NOT NULL,
    Distance_km         DECIMAL(8,2),
    Fare                DECIMAL(10,2),
    Cost_per_passenger  DECIMAL(10,2),
    Passengers          INTEGER,
    Ticket_Type         VARCHAR(50),
    Remarks             VARCHAR(50)
);

-- ── Indexes for faster analytical queries ──────────────────
CREATE INDEX idx_date            ON metro_trips (Date);
CREATE INDEX idx_from_station    ON metro_trips (From_Station);
CREATE INDEX idx_to_station      ON metro_trips (To_Station);
CREATE INDEX idx_ticket_type     ON metro_trips (Ticket_Type);
CREATE INDEX idx_remarks         ON metro_trips (Remarks);
CREATE INDEX idx_route           ON metro_trips (From_Station, To_Station);
