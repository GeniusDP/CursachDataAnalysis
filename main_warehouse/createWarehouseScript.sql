CREATE SCHEMA IF NOT EXISTS stageCoursework;
CREATE SCHEMA IF NOT EXISTS ADISCoursework;
CREATE TABLE IF NOT EXISTS ADISCoursework.date(
    id bigserial PRIMARY KEY UNIQUE NOT NULL,
    year int
);

CREATE TABLE IF NOT EXISTS ADISCoursework.region(
    id bigserial PRIMARY KEY UNIQUE NOT NULL,
    name varchar(100) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS ADISCoursework.country(
    id bigserial PRIMARY KEY UNIQUE NOT NULL,
    name varchar(100) UNIQUE NOT NULL,
    iso varchar(10),
    region_id bigint,
    area int,
    average_population bigint,
    net_population_change bigint,
    FOREIGN KEY (region_id) REFERENCES ADISCoursework.region(id)
);

CREATE TABLE IF NOT EXISTS ADISCoursework.happiness_report(
    id bigserial PRIMARY KEY UNIQUE NOT NULL,
    date_id bigint NOT NULL,
    country_id bigint NOT NULL,
    happiness_score float4 NOT NULL,
    gdp float4,
    social_support float4,
    life_expectancy float4,
    freedom float4,
    trust float4,
    generosity float4,
    energy_consumption float4,
    total_deaths int,
    category text,
    FOREIGN KEY (date_id) REFERENCES ADISCoursework.date(id),
    FOREIGN KEY (country_id) REFERENCES ADISCoursework.country(id)
);

CREATE TABLE IF NOT EXISTS ADISCoursework.death_report(
    id                                         bigserial PRIMARY KEY UNIQUE NOT NULL,
    country_id                                   int NOT NULL,
    date_id                                      int NOT NULL,
    "Self-harm"                                  integer,
    "Interpersonal violence"                     integer,
    "Drowning"                                   integer,
    "Malaria"                                    integer,
    "Fire, heat, and hot substances"             integer,
    "Neoplasms"                                  integer,
    "Digestive diseases"                         integer,
    "Cirrhosis and other chronic liver diseases" integer,
    "Chronic respiratory diseases"               integer,
    "Chronic kidney disease"                     integer,
    "Cardiovascular diseases"                    integer,
    "Drug use disorders"                         integer,
    "Nutritional deficiencies"                   integer,
    "Alcohol use disorders"                      integer,
    "Lower respiratory infections"               integer,
    "Diabetes mellitus"                          integer,
    "Protein-energy malnutrition"                integer,
    "Exposure to forces of nature"               integer,
    "Environmental heat and cold exposure"       integer,
    "Diarrheal diseases"                         integer,
    "Road injuries"                              integer,
    "Tuberculosis"                               integer,
    "HIV/AIDS"                                   integer,
    "Alzheimer's disease and other dementias"    integer,
    "Parkinson's disease"                        integer,
    "Acute hepatitis"                            integer,
    happiness_score real NOT NULL,
    FOREIGN KEY (country_id) REFERENCES ADISCoursework.country(id),
    FOREIGN KEY (date_id) REFERENCES ADISCoursework.date(id)
);

