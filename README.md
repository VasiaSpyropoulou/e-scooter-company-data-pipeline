<h1 align="center">🪿🛴 Gans E-Scooter Data Pipeline</h1>
     <p align="center">
    <strong>Automated ETL pipeline for predicting e-scooter demand using weather, flights &amp; city data</strong>
  </p>
  <p align="center">
    <img src="https://img.shields.io/badge/Python-3.12-blue?logo=python&logoColor=white" alt="Python">
    <img src="https://img.shields.io/badge/MySQL-8.0-blue?logo=mysql&logoColor=white" alt="MySQL">
    <img src="https://img.shields.io/badge/Pandas-2.0+-green?logo=pandas&logoColor=white" alt="Pandas">
    <img src="https://img.shields.io/badge/GCP-Cloud_Functions-orange?logo=googlecloud&logoColor=white" alt="GCP">
  </p>
</p>

---

## 🏢 About Gans🪿🛴

**Gans** is a startup developing an **e-scooter-sharing system**, aspiring to operate in the most populous cities worldwide, competing with players like [TIER](https://www.tier.app/) and [Bird](https://www.bird.co/).

The core operational challenge: **having scooters parked where users actually need them.** Several real-world factors create demand asymmetries:

| Factor | Impact on Scooter Distribution |
|--------|-------------------------------|
| 🏔️ Hilly terrain | Users ride uphill, walk downhill |
| 🌅 Morning commutes | Scooters flow from suburbs → city centre |
| 🌧️ Rain | Usage drops drastically |
| ✈️ Tourist arrivals | Budget travellers need scooters near landmarks |

> **My role:** Junior Data Engineer who has to build an automated data pipeline to collect external data that helps predict scooter movement.
> 
## 💡 How This Data Helps Gans

The collected data enables Gans to make smarter operational decisions:

**Weather Forecasts → Predict demand drops**
- When rain is forecast, scooter usage drops drastically
- Gans can proactively reduce scooter deployment and save on redistribution costs

**Flight Arrivals → Anticipate tourist demand**
- Budget airline arrivals bring potential users who need scooters near airports and landmarks
- Gans can position more scooters near airports before peak arrival times

**City and Population Data → Scale to new markets**
- Population and location data help Gans evaluate which cities to expand into
- Higher population density = higher potential scooter demand

### Example Scenario
Tomorrow at Berlin Brandenburg (EDDB): 85 flights arriving between 06:00–12:00, weather forecast shows 22°C and no rain → **high scooter demand expected near airport and city centre** → Gans deploys extra scooters in those areas.

---

## 🎯 Project Goal

Design and implement an **end-to-end ETL (Extract, Transform, Load) pipeline** that:

1. **Extracts** data from 3 external sources (Wikipedia, Weather API, Flights API)
2. **Transforms** raw data into clean, structured formats
3. **Loads** everything into a MySQL database
4. **Automates** the process using Google Cloud Platform

---

## 🏗️ Architecture

 ### Phase 1 - Local Pipeline

```mermaid
flowchart LR
    W[🌐 Wikipedia] -->|Web Scraping| P[🐍 Python]
    WA[🌤️ Weather API] -->|REST API| P
    F[✈️ Flights API] -->|REST API| P
    P -->|SQLAlchemy| DB[(🗄️ MySQL\nLocalhost)]
```

 ### Phase 2 - Cloud Pipeline on GCP

```mermaid
flowchart LR
    W[🌐 Wikipedia] -->|Web Scraping| CF[☁️ Cloud\nFunction]
    WA[🌤️ Weather API] -->|REST API| CF
    F[✈️ Flights API] -->|REST API| CF
    CS[⏰ Cloud\nScheduler] -->|Triggers daily| CF
    CF -->|Writes to| DB[(🗄️ GCP\nMySQL)]
    DB -->|Reads from| LOCAL[💻 MySQL\nWorkbench]
```

---

## 📊 Data Sources

### 1. Cities and Population - Web Scraping
- **Source:** Wikipedia pages for Berlin, Hamburg, Munich
- **Tool:** BeautifulSoup4
- **Data:** City name, country, latitude, longitude, population

### 2. Weather Forecasts - API
- **Source:** [OpenWeatherMap](https://openweathermap.org/api) (5-day forecast)
- **Tool:** `requests` library
- **Data:** Temperature, humidity, wind speed/gust, precipitation probability, rain, snow

### 3. Flight Arrivals - API
- **Source:** [AeroDataBox](https://rapidapi.com/aedbx-aedbx/api/aerodatabox/) via RapidAPI
- **Tool:** `requests` library
- **Data:** Arriving flights, departure airport/country, scheduled and revised times, aircraft type

---

## 📁 Project Structure

```
gans-data-pipeline/
│
├── 📓 01_web_scraping.ipynb          # Web scraping basics + city data collection
├── 📓 02_python_to_sql.ipynb         # Connect Python ↔ MySQL with SQLAlchemy
├── 📓 04_weather_api.ipynb           # OpenWeatherMap API integration
├── 📓 05_flights_api.ipynb           # AeroDataBox flights API integration
├── 📓 06_full_pipeline.ipynb         # ⭐ Complete pipeline, all steps combined
│
├── 🗄️ 03_database_schema.sql        # Database schema (CREATE TABLE statements)
├── 🔒 .env                           # API keys & credentials (not in repo)
├── 🚫 .gitignore                     # Excludes .env and sensitive files
├── 📦 env.yml                        # Conda environment specification
└── 📖 README.md                      # You are here!
```

---

## 🚀 Quick Start

### Prerequisites
- Python 3.12+
- MySQL 8.0+
- Anaconda or Miniconda

### 1. Clone and set up environment

```bash
git clone https://github.com/YOUR_USERNAME/gans-data-pipeline.git
cd gans-data-pipeline
conda env create -f env.yml
conda activate gans
```

### 2. Create the database

Open **MySQL Workbench** and run `03_database_schema.sql`

### 3. Configure credentials

Create a `.env` file in the project root:

```env
CON_STRING=mysql+pymysql://root:YOUR_PASSWORD@127.0.0.1:3306/gans
OPENWEATHER_KEY=your_openweathermap_api_key
RAPIDAPI_KEY=your_rapidapi_key
```

**API keys needed (all free tier):**

| Service | Sign Up | What For |
|---------|---------|----------|
| MySQL | [mysql.com](https://dev.mysql.com/downloads/) | Local database |
| OpenWeatherMap | [openweathermap.org](https://openweathermap.org/api) | Weather forecasts |
| RapidAPI | [rapidapi.com](https://rapidapi.com) | AeroDataBox flights data |

### 4. Run the pipeline

Open `06_full_pipeline.ipynb` in JupyterLab and run all cells.

---

## 🧠 Key Learnings

| Challenge | Solution |
|-----------|----------|
| Missing JSON keys crash the code | Use `.get(key, default)` for safe access |
| `if_exists="append"` creates duplicates | Clear tables before re-running, or run `.to_sql()` only once |
| API keys exposed in notebooks | Store in `.env` file, load with `python-dotenv` |
| Web scraping is fragile | APIs are more reliable for production pipelines |
| `find_all()` returns a list, not an element | Use `[0]` indexing or `.find()` for single elements |

---

## 🛠️ Tech Stack

| Category | Tools |
|----------|-------|
| **Language** | Python 3.12 |
| **Data** | Pandas, NumPy |
| **Web Scraping** | BeautifulSoup4, Requests |
| **Database** | MySQL, SQLAlchemy, PyMySQL |
| **APIs** | OpenWeatherMap, AeroDataBox |
| **Cloud** | GCP (Cloud Functions, Cloud Scheduler, Cloud SQL) |
| **Environment** | Anaconda, JupyterLab, python-dotenv |

---

## 📝 Future Improvements

- [ ] Add more cities beyond Germany
- [ ] Implement error handling and logging
- [ ] Build a dashboard to visualise collected data
- [ ] Add predictive model for scooter demand
- [ ] Implement data quality checks

---

## 🎓 Context

This project was completed as case study of the 17-week Data Science bootcamp at WBS Coding School. 

<p align="center">
  <strong>Built with a lot of ☕ and 🐍</strong>
</p>

