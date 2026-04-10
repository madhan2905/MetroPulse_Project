"""
MetroPulse: Delhi Metro Travel Analytics
db_loader.py – Load cleaned CSV into SQLite and generate Markdown report.
"""
import os
from dotenv import load_dotenv

import os
from dotenv import load_dotenv

load_dotenv()

# Use the variables
DB_FILE = os.getenv("DB_PATH", "cleaned_data/metro_pulse.db")
CSV_FILE = os.getenv("CLEAN_CSV", "cleaned_data/delhi_metro_trips.csv")
import os
import sqlite3
import pandas as pd
import re

# Paths
BASE_DIR    = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CSV_FILE    = os.path.join(BASE_DIR, "cleaned_data", "delhi_metro_trips.csv")
SCHEMA_FILE = os.path.join(BASE_DIR, "sql", "schema.sql")
QUERY_FILE  = os.path.join(BASE_DIR, "sql", "queries.sql")
DB_FILE     = os.path.join(BASE_DIR, "cleaned_data", "metro_pulse.db")
REPORT_FILE = os.path.join(BASE_DIR, "METROPULSE_INSIGHTS.md")

def create_database(conn: sqlite3.Connection) -> None:
    print("[1/3] Creating database schema...")
    with open(SCHEMA_FILE, "r") as f:
        schema_sql = f.read()
    conn.executescript(schema_sql)
    conn.commit()

def load_data(conn: sqlite3.Connection) -> None:
    print("[2/3] Loading data into SQLite...")
    df = pd.read_csv(CSV_FILE)

    if "Date" in df.columns:
        df["Date"] = pd.to_datetime(df["Date"]).dt.strftime('%Y-%m-%d')

    df.to_sql("metro_trips", conn, if_exists="replace", index=False)
    conn.commit()
    count = conn.execute("SELECT COUNT(*) FROM metro_trips").fetchone()[0]
    print(f"✅ Inserted {count:,} clean rows.")

def run_queries(conn: sqlite3.Connection) -> None:
    print("[3/3] Running analytical queries...")
    with open(QUERY_FILE, "r") as f:
        raw = f.read()

    blocks = re.split(r"(-- Q\d+\..*)", raw)
    queries = []
    for i in range(1, len(blocks) - 1, 2):
        header = blocks[i].strip()
        body = blocks[i + 1].strip()
        stmts = [s.strip() for s in body.split(";") if s.strip().upper().startswith("SELECT")]
        if stmts:
            queries.append((header, stmts[0] + ";"))

    with open(REPORT_FILE, "w", encoding="utf-8") as f:
        f.write("# 🚇 MetroPulse: Delhi Metro Analytics Report\n\n")
        for header, sql in queries:
            try:
                df = pd.read_sql_query(sql, conn)
                f.write(f"## {header.replace('-- ', '')}\n")
                f.write(f"```sql\n{sql}\n```\n\n")
                f.write(df.to_markdown(index=False) if hasattr(df, 'to_markdown') else df.to_string(index=False))
                f.write("\n\n")
                print(f"Processed: {header}")
            except Exception as e:
                print(f"Error in {header}: {e}")

    print(f"✨ Report saved to: {REPORT_FILE}")

def main():
    print("=" * 60)
    print("  MetroPulse — Database Loader")
    print("=" * 60)
    os.makedirs(os.path.dirname(DB_FILE), exist_ok=True)
    with sqlite3.connect(DB_FILE) as conn:
        create_database(conn)
        load_data(conn)
        run_queries(conn)

if __name__ == "__main__":
    main()