DROP VIEW IF EXISTS ADISCOURSEWORK.MAIN_VIEW;

CREATE VIEW ADISCOURSEWORK.MAIN_VIEW AS
SELECT
       NAME COUNTRY_NAME,
       YEAR,
       GDP,
       SOCIAL_SUPPORT,
       FREEDOM,
       --ENERGY_CONSUMPTION/(AVERAGE_POPULATION::REAL - (2020-YEAR) * C.NET_POPULATION_CHANGE) as ENERGY_CONSUMPTION_PER_CAPITA,
       TRUST,
       GENEROSITY,
       --(TOTAL_DEATHS::REAL)/(AVERAGE_POPULATION::REAL - (2020-YEAR) * C.NET_POPULATION_CHANGE) AS DEATHS_PER_CAPITA,
       --AREA,
       --(AVERAGE_POPULATION::REAL - (2020-YEAR) * C.NET_POPULATION_CHANGE) / AREA AS POPULATION_DENSITY,
       HAPPINESS_SCORE
FROM ADISCOURSEWORK.HAPPINESS_REPORT
INNER JOIN ADISCOURSEWORK.DATE D ON D.ID = ADISCOURSEWORK.HAPPINESS_REPORT.DATE_ID
INNER JOIN ADISCOURSEWORK.COUNTRY C ON C.ID = ADISCOURSEWORK.HAPPINESS_REPORT.COUNTRY_ID
WHERE (ENERGY_CONSUMPTION IS NOT NULL)
  AND (YEAR >= 2015 )
  AND (YEAR <= 2019)
  AND (TOTAL_DEATHS IS NOT NULL)
  AND (AREA IS NOT NULL);

/*
    1)дропнули life_expectancy - большая corr с gdp.
    2)дропнули energy_consumption_per_capita - большая corr с gdp
*/

-- \copy (SELECT * FROM adiscoursework.main_view) TO 'C:\Users\Asus\Desktop\Лабы2022\CursachDataAnalysis\main_view.csv' with csv header



--******************************************************************************************************
create view deaths_reasons_influence_on_happiness as
SELECT (SELECT name FROM adiscoursework.country WHERE country_id = adiscoursework.country.id) AS country_name,
       (SELECT year FROM adiscoursework.date WHERE date_id = adiscoursework.date.id) AS year,
       "Self-harm"                               ,
    "Interpersonal violence"                     ,
    "Drowning"                                   ,
    "Malaria"                                    ,
    "Fire, heat, and hot substances"             ,
    "Neoplasms"                                  ,
    "Digestive diseases"                         ,
    "Cirrhosis and other chronic liver diseases" ,
    "Chronic respiratory diseases"               ,
    "Chronic kidney disease"                     ,
    "Cardiovascular diseases"                    ,
    "Drug use disorders"                         ,
    "Nutritional deficiencies"                   ,
    "Alcohol use disorders"                      ,
    "Lower respiratory infections"               ,
    "Diabetes mellitus"                          ,
    "Protein-energy malnutrition"                ,
    "Exposure to forces of nature"               ,
    "Environmental heat and cold exposure"       ,
    "Diarrheal diseases"                         ,
    "Road injuries"                              ,
    "Tuberculosis"                               ,
    "HIV/AIDS"                                   ,
    "Alzheimer's disease and other dementias"    ,
    "Parkinson's disease"                        ,
    "Acute hepatitis"                            ,
    happiness_score
FROM adiscoursework.death_report