# E-scooter-company-data-pipeline
Automated data pipeline for GANS, an e-scooter company
<p align="center"> <h1 align="center">🛴🪿 Gans E-Scooter Data Pipeline</h1> <p align="center"> <strong>Automated ETL pipeline for predicting e-scooter demand using weather, flights &amp; city data</strong> </p> <p align="center"> <img src="https://img.shields.io/badge/Python-3.12-blue?logo=python&logoColor=white" alt="Python"> <img src="https://img.shields.io/badge/MySQL-8.0-blue?logo=mysql&logoColor=white" alt="MySQL"> <img src="https://img.shields.io/badge/Pandas-2.0+-green?logo=pandas&logoColor=white" alt="Pandas"> <img src="https://img.shields.io/badge/GCP-Cloud_Functions-orange?logo=googlecloud&logoColor=white" alt="GCP"> </p>
🏢 About Gans 🛴🪿

Gans is a startup developing an e-scooter-sharing system, aspiring to operate in the most populous cities worldwide, competing with players like TIER and Bird.

The core operational challenge: having scooters parked where users actually need them. Several real-world factors create demand asymmetries:

Factor	Impact on Scooter Distribution
🏔️ Hilly terrain	Users ride uphill, walk downhill
🌅 Morning commutes	Scooters flow from suburbs → city centre
🌧️ Rain	Usage drops drastically
✈️ Tourist arrivals	Budget travellers need scooters near landmarks

My role as Junior Data Engineer: to build an automated data pipeline to collect external data that helps predict scooter movement.

🎯 Project Goal

Design and implement an end-to-end ETL (Extract, Transform, Load) pipeline that:

Extracts data from 3 external sources (Wikipedia, Weather API, Flights API)
Transforms raw data into clean, structured formats
Loads everything into a MySQL database
Automates the process using Google Cloud Platform
🏗️ Architecture
Phase 1: Local Pipeline
Web Scraping
REST API
REST API
SQLAlchemy
🌐 Wikipedia
🐍 Python
🌤️ Weather API
✈️ Flights API
🗄️ MySQLLocalhost
Phase 2: Cloud Pipeline on GCP
Web Scraping
REST API
REST API
Triggers daily
Writes to
Reads from
🌐 Wikipedia
☁️ CloudFunction
🌤️ Weather API
✈️ Flights API
⏰ CloudScheduler
🗄️ GCPMySQL
💻 MySQLWorkbench
📊 Data Sources
1. Cities and Population - Web Scraping
Source: Wikipedia pages for Berlin, Hamburg, Munich
Tool: BeautifulSoup4
Data: City name, country, latitude, longitude, population
2. Weather Forecasts - API
Source: OpenWeatherMap (5-day forecast)
Tool: requests library
Data: Temperature, humidity, wind speed/gust, precipitation probability, rain, snow
3. Flight Arrivals - API
Source: AeroDataBox via RapidAPI
Tool: requests library
Data: Arriving flights, departure airport/country, scheduled and revised times, aircraft type
🗄️ Database Schema
has
has
has
receives
CITIES
int
city_id
PK
varchar
name
varchar
country
float
latitude
float
longitude
POPULATIONS
int
city_id
FK
int
population
date
date_gathered
FORECASTS
int
forecast_id
PK
float
temp
float
feels_like
int
humidity_pct
float
wind_speed
float
precipitation_pct
datetime
forecast_time
int
city_id
FK
AIRPORTS
char
icao
PK
varchar
name
bool
active
int
city_id
FK
FLIGHTS
int
flight_id
PK
char
arrive_icao
FK
char
depart_icao
varchar
depart_airport
char
depart_country
datetime
arrive_time_scheduled
datetime
arrive_time_revised
varchar
flight_number
varchar
aircraft
📁 Project Structure
gans-data-pipeline/
│
├── 📓 01_webScraping__structure.ipynb   # Learn web scraping + collect city data
├── 📓 02_python_to_sql.ipynb            # Connect Python to MySQL with SQLAlchemy
├── 📓 04_apis_weather.ipynb             # OpenWeatherMap API integration
├── 📓 5_aeroDataBox_introduction.ipynb  # AeroDataBox flights API integration
├── 📓 99_gans_pipeline.ipynb            # Complete pipeline - all steps combined
│
├── 🗄️ 03_gans_schema.sql               # Database schema (CREATE TABLE statements)
├── 🔒 .env                              # API keys and credentials (not in repo)
├── 🚫 .gitignore                        # Excludes .env and sensitive files
├── 📦 env.yml                           # Conda environment specification
└── 📖 README.md                         # You are here!
🚀 Quick Start
Prerequisites
Python 3.12+
MySQL 8.0+
Anaconda or Miniconda
1. Clone and set up environment
bash
git clone https://github.com/YOUR_USERNAME/gans-data-pipeline.git
cd gans-data-pipeline
conda env create -f env.yml
conda activate gans
2. Create the database

Open MySQL Workbench and run 03_gans_schema.sql

3. Configure credentials

Create a .env file in the project root:

env
CON_STRING=mysql+pymysql://root:YOUR_PASSWORD@127.0.0.1:3306/gans
OPENWEATHER_KEY=your_openweathermap_api_key
RAPIDAPI_KEY=your_rapidapi_key

API keys needed (all free tier):

Service	Sign Up	What For
MySQL	mysql.com	Local database
OpenWeatherMap	openweathermap.org	Weather forecasts
RapidAPI	rapidapi.com	AeroDataBox flights data
4. Run the pipeline

Open 99_gans_pipeline.ipynb in JupyterLab and run all cells.

🧠 Key Learnings
Challenge	Solution
Missing JSON keys crash the code	Use .get(key, default) for safe access
if_exists="append" creates duplicates	Clear tables before re-running, or run .to_sql() only once
API keys exposed in notebooks	Store in .env file, load with python-dotenv
Web scraping is fragile	APIs are more reliable for production pipelines
find_all() returns a list, not an element	Use [0] indexing or .find() for single elements
🛠️ Tech Stack
Category	Tools
Language	Python 3.12
Data	Pandas, NumPy
Web Scraping	BeautifulSoup4, Requests
Database	MySQL, SQLAlchemy, PyMySQL
APIs	OpenWeatherMap, AeroDataBox
Cloud	GCP (Cloud Functions, Cloud Scheduler, Cloud SQL)
Environment	Anaconda, JupyterLab, python-dotenv
📝 Future Improvements
 Add more cities beyond Germany
 Implement error handling and logging
 Build a dashboard to visualise collected data
 Add predictive model for scooter demand
 Implement data quality checks
🎓 Context

This project was completed as case study of the 17-week Data Science bootcamp at WBS Coding School. 

<p align="center"> <strong>Built with ☕ and 🐍</strong> </p>
