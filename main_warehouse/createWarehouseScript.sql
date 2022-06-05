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
    FOREIGN KEY (date_id) REFERENCES ADISCoursework.date(id),
    FOREIGN KEY (country_id) REFERENCES ADISCoursework.country(id)
);

CREATE TABLE IF NOT EXISTS ADISCoursework.death_reason(
    id bigserial PRIMARY KEY UNIQUE NOT NULL,
    name varchar(100) NOT NULL,
    total bigint
);

CREATE TABLE IF NOT EXISTS ADISCoursework.death_report(
    id bigserial PRIMARY KEY UNIQUE NOT NULL,
    date_id bigint NOT NULL,
    country_id bigint NOT NULL,
    reason_id bigint NOT NULL,
    count int,
    FOREIGN KEY (date_id) REFERENCES ADISCoursework.date(id),
    FOREIGN KEY (country_id) REFERENCES ADISCoursework.country(id),
    FOREIGN KEY (reason_id) REFERENCES ADISCoursework.death_reason(id)
);