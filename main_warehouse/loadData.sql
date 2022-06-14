INSERT INTO adiscoursework.region (name)
SELECT DISTINCT("Region") FROM stagecoursework.happiness;

WITH countries AS (
    SELECT "Country" AS name FROM stagecoursework.happiness
    UNION
    SELECT "Country" AS name FROM stagecoursework.country_consumption
    UNION
    SELECT "Country" AS name FROM stagecoursework.death_reasons
    UNION
    SELECT "Country" AS name FROM stagecoursework.population_by_country)
INSERT INTO adiscoursework.country (name, area, average_population, net_population_change)
SELECT DISTINCT
                (name),
                (select "Land Area (Km²)" AS area from stagecoursework.population_by_country where name = "Country"),
                (select "Population" from stagecoursework.population_by_country where name = "Country"),
                (select "Net Change" from stagecoursework.population_by_country where name = "Country")
FROM countries;

WITH years AS (
    SELECT "Year" AS year FROM stagecoursework.happiness
    UNION
    SELECT "Year" AS year FROM stagecoursework.country_consumption
    UNION
    SELECT "Year" AS year FROM stagecoursework.death_reasons
)
INSERT INTO adiscoursework.date (year)
SELECT DISTINCT(year) FROM years;

INSERT INTO adiscoursework.happiness_report(
                                            date_id,
                                            country_id,
                                            happiness_score,
                                            gdp,
                                            social_support,
                                            life_expectancy,
                                            freedom,
                                            trust,
                                            generosity,
                                            energy_consumption,
                                            category)
SELECT (SELECT id FROM adiscoursework.date WHERE "Year" = year),
       (SELECT id FROM adiscoursework.country WHERE "Country" = name),
       "Happiness Score",
       "Economy (GDP per Capita)",
       "Family (Social Support)",
       "Health (Life Expectancy)",
       "Freedom",
       "Trust (Government Corruption)",
       "Generosity",
       (SELECT "Consumption" FROM stagecoursework.country_consumption WHERE country_consumption."Year" = happiness."Year" AND country_consumption."Country" = happiness."Country"),
       (SELECT "Country Classification"
        FROM stagecoursework.country_indicators
        WHERE stagecoursework.country_indicators."Year" = happiness."Year"
          AND stagecoursework.country_indicators."Country" = happiness."Country")
FROM stagecoursework.happiness;

INSERT INTO adiscoursework.death_report(country_id, date_id, "Self-harm", "Interpersonal violence", "Drowning", "Malaria", "Fire, heat, and hot substances", "Neoplasms", "Digestive diseases", "Cirrhosis and other chronic liver diseases", "Chronic respiratory diseases", "Chronic kidney disease", "Cardiovascular diseases", "Drug use disorders", "Nutritional deficiencies", "Alcohol use disorders", "Lower respiratory infections", "Diabetes mellitus", "Protein-energy malnutrition", "Exposure to forces of nature", "Environmental heat and cold exposure", "Diarrheal diseases", "Road injuries", "Tuberculosis", "HIV/AIDS", "Alzheimer's disease and other dementias", "Parkinson's disease", "Acute hepatitis", happiness_score)
SELECT (SELECT id FROM adiscoursework.country WHERE "Country" = name),
       (SELECT id FROM adiscoursework.date WHERE "Year" = year),
       "Self-harm",
       "Interpersonal violence",
       "Drowning", "Malaria",
       "Fire, heat, and hot substances",
       "Neoplasms",
       "Digestive diseases",
       "Cirrhosis and other chronic liver diseases",
       "Chronic respiratory diseases",
       "Chronic kidney disease",
       "Cardiovascular diseases",
       "Drug use disorders",
       "Nutritional deficiencies",
       "Alcohol use disorders",
       "Lower respiratory infections",
       "Diabetes mellitus",
       "Protein-energy malnutrition",
       "Exposure to forces of nature",
       "Environmental heat and cold exposure",
       "Diarrheal diseases",
       "Road injuries",
       "Tuberculosis",
       "HIV/AIDS",
       "Alzheimer's disease and other dementias",
       "Parkinson's disease",
       "Acute hepatitis",
       happiness_score
FROM stagecoursework.death_reasons
inner join adiscoursework.happiness_report
    on "Year" = (SELECT year FROM adiscoursework.date WHERE date_id = adiscoursework.date.id) AND
       "Country" = (SELECT name FROM adiscoursework.country WHERE country_id = adiscoursework.country.id);
