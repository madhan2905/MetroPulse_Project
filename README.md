Markdown
# 🚇 MetroPulse: Delhi Metro Travel Analytics

**MetroPulse** is an end-to-end data engineering and analytics pipeline. It transforms raw, nested JSON travel data from the Delhi Metro into a structured SQLite database, performing 20+ complex analytical queries to uncover trends in passenger traffic, revenue, and travel conditions.

---

## 🛠️ Project Architecture
1.  **Data Cleaning (`src/data_cleaning.py`)**: Handles dictionary-style JSON, fixes missing values, and standardizes station names.
2.  **Database Loading (`src/db_loader.py`)**: Migrates cleaned CSV data into a high-performance SQLite database.
3.  **Automated Reporting**: Generates a comprehensive Markdown report (`METROPULSE_INSIGHTS.md`) based on SQL analysis.
4.  **Interactive Exploration**: Provides a Jupyter Notebook (`insights.ipynb`) for live data evaluation.

---

## 📂 Project Structure
```text
metro-pulse-delhi-analytics/
├── cleaned_data/           # Processed CSV and SQLite .db file
├── source_data/            # Original raw JSON dataset
├── sql/                    # SQL schema and analytical queries
├── src/                    # Python source scripts
├── .env.example            # Template for environment variables
├── .gitignore              # Files to exclude from Git
├── insights.ipynb          # Jupyter Notebook for live analysis
├── METROPULSE_INSIGHTS.md  # Automatically generated report
└── requirements.txt        # Project dependencies
🚀 Installation & Setup
1. Prerequisites
Ensure you have Python 3.8+ installed on your system.

2. Set Up Virtual Environment
It is highly recommended to use a virtual environment to avoid library conflicts:

PowerShell
# Create the environment
python -m venv venv

# Activate it (Windows)
venv\Scripts\activate

# Activate it (Mac/Linux)
source venv/bin/activate
3. Install Dependencies
Once the environment is active, install the required packages:

Bash
pip install -r requirements.txt
4. Configure Environment Variables
Rename the .env.example file to .env in the root directory and update paths if necessary:

Bash
# Windows (PowerShell)
copy .env.example .env

# Mac/Linux
cp .env.example .env
⚙️ How to Run the Pipeline
Run these commands from the root directory of the project:

Step 1: Clean the Raw Data
Bash
python src/data_cleaning.py
Effect: Processes the JSON and creates cleaned_data/delhi_metro_trips.csv.

Step 2: Load Database & Generate Report
Bash
python src/db_loader.py
Effect: Creates metro_pulse.db and generates the METROPULSE_INSIGHTS.md analytics report.

📋 Quick Run Commands (Copy-Paste)
If your environment is already set up and activated, use these shortcuts:

Windows (PowerShell):

PowerShell
python src/data_cleaning.py; python src/db_loader.py
Mac/Linux (Terminal):

Bash
python3 src/data_cleaning.py && python3 src/db_loader.py
🧪 Troubleshooting
1. "Tabulate" Error:
If you see an error regarding tabulate while running the loader, ensure you ran pip install -r requirements.txt. You can also install it manually: pip install tabulate.

2. Script not finding files:
Ensure you are running the scripts from the root directory of the project (metro-pulse-delhi-analytics), not from inside the src folder. This ensures relative paths work correctly.

3. Execution Policy (Windows):
If you cannot activate the virtual environment in PowerShell, run this command:
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process