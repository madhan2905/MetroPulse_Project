"""
MetroPulse: Delhi Metro Travel Analytics
Step 1 - Data Cleaning Script 
"""
import os
from dotenv import load_dotenv

# This loads the variables from the .env file into your system environment
load_dotenv()

data_path = os.getenv("RAW_DATA_PATH")
import json
import pandas as pd
import numpy as np
import os

# Paths
BASE_DIR    = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SOURCE_FILE = os.path.join(BASE_DIR, "source_data", "delhi_metro_trips.json")
OUTPUT_FILE = os.path.join(BASE_DIR, "cleaned_data", "delhi_metro_trips.csv")

def load_json(path: str) -> pd.DataFrame:
    """Load JSON and correctly handle dictionary-style formatting."""
    print(f"[1/6] Loading JSON from: {path}")
    with open(path, "r", encoding="utf-8") as f:
        data = json.load(f)

    # Use from_dict to handle the nested dictionary structure properly
    df = pd.DataFrame.from_dict(data)
    
    # If the rows/columns are swapped (transposed), fix it
    if "TripID" not in df.columns and len(df) < len(df.columns):
        df = df.T
    
    print(f"✅ Loaded {len(df):,} actual rows.")
    return df

def clean_station_names(df: pd.DataFrame) -> pd.DataFrame:
    print("[2/6] Cleaning station names ...")
    for col in ["From_Station", "To_Station"]:
        if col in df.columns:
            df[col] = df[col].astype(str).str.strip().str.title()
    return df

def handle_missing_ticket_types(df: pd.DataFrame) -> pd.DataFrame:
    print("[3/6] Handling ticket types ...")
    if "Ticket_Type" in df.columns:
        df["Ticket_Type"] = df["Ticket_Type"].fillna("Unknown").astype(str).str.title()
    return df

def convert_dates(df: pd.DataFrame) -> pd.DataFrame:
    print("[4/6] Converting date column ...")
    if "Date" in df.columns:
        df["Date"] = pd.to_datetime(df["Date"], errors="coerce")
    return df

def fix_numeric_columns(df: pd.DataFrame) -> pd.DataFrame:
    print("[5/6] Fixing numeric columns ...")
    float_cols = ["Distance_km", "Fare", "Cost_per_passenger"]
    for col in float_cols:
        if col in df.columns:
            df[col] = pd.to_numeric(df[col], errors="coerce").fillna(0)
    if "Passengers" in df.columns:
        df["Passengers"] = pd.to_numeric(df["Passengers"], errors="coerce").fillna(1).astype(int)
    return df

def standardize_remarks(df: pd.DataFrame) -> pd.DataFrame:
    print("[5.5] Standardizing Remarks ...")
    if "Remarks" in df.columns:
        df["Remarks"] = df["Remarks"].astype(str).str.strip().str.title()
        df["Remarks"] = df["Remarks"].replace({"None": "Normal", "Nan": "Normal"})
    return df

def save_csv(df: pd.DataFrame, path: str) -> None:
    print(f"[6/6] Saving cleaned data to: {path}")
    os.makedirs(os.path.dirname(path), exist_ok=True)
    df.to_csv(path, index=False)

def main():
    print("=" * 55)
    print("  MetroPulse — Data Cleaning Pipeline")
    print("=" * 55)
    df = load_json(SOURCE_FILE)
    df = clean_station_names(df)
    df = handle_missing_ticket_types(df)
    df = convert_dates(df)
    df = fix_numeric_columns(df)
    df = standardize_remarks(df)
    save_csv(df, OUTPUT_FILE)
    print("\n✅ CLEANING COMPLETE!")

if __name__ == "__main__":
    main()