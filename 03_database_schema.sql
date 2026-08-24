DROP SCHEMA IF EXISTS gans;
CREATE SCHEMA gans;

USE gans;

CREATE TABLE cities(
    city_id INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(80) NOT NULL,
    country VARCHAR(80),
    latitude FLOAT,
    longitude FLOAT
);

CREATE TABLE populations(
    city_id INT,
    population INT,
    date_gathered DATE,
    FOREIGN KEY (city_id) REFERENCES cities(city_id),
    PRIMARY KEY (city_id, date_gathered)
);

CREATE TABLE forecasts(
    temp FLOAT,
    feels_like FLOAT,
    `humidity_%` INT,
    wind_speed FLOAT,
    wind_gust FLOAT,
    `precipitation_%` FLOAT,
    rain_3h FLOAT,
    snow_3h FLOAT, 
    forecast_time DATETIME NOT NULL,    
    city_id INT,
    forecast_id INT AUTO_INCREMENT PRIMARY KEY,
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

CREATE TABLE airports(
    icao CHAR(4) PRIMARY KEY,
    `name` VARCHAR(80),
    `active` BOOL DEFAULT 1,
    city_id INT,
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

CREATE TABLE flights(
	flight_id INT AUTO_INCREMENT PRIMARY KEY,
	arrive_icao	CHAR(4),
    depart_icao CHAR(4),	
    depart_airport VARCHAR(80),	
    depart_country CHAR(2),	
    arrive_time_scheduled DATETIME,	
    arrive_time_revised	DATETIME,
    flight_number VARCHAR(32),	
    aircraft VARCHAR(128),
    FOREIGN KEY (arrive_icao) REFERENCES airports(icao)
);

# run after populating airports
UPDATE airports
SET `active` = 0 
WHERE icao = 'EDDT';