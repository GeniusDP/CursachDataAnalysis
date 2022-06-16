DROP VIEW IF EXISTS ADISCOURSEWORK.MAIN_VIEW cascade;
drop view if exists ADISCOURSEWORK.the_most_main_view cascade;
drop view if exists adiscoursework.deaths_reasons_influence_on_happiness cascade;

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
       HAPPINESS_SCORE,
       category
FROM ADISCOURSEWORK.HAPPINESS_REPORT
INNER JOIN ADISCOURSEWORK.DATE D ON D.ID = ADISCOURSEWORK.HAPPINESS_REPORT.DATE_ID
INNER JOIN ADISCOURSEWORK.COUNTRY C ON C.ID = ADISCOURSEWORK.HAPPINESS_REPORT.COUNTRY_ID
WHERE YEAR BETWEEN 2015 AND 2019;
/*
    1)дропнули life_expectancy - большая corr с gdp.
    2)дропнули energy_consumption_per_capita - большая corr с gdp
*/

-- \copy (SELECT * FROM adiscoursework.main_view) TO 'C:\Users\Asus\Desktop\Лабы2022\CursachDataAnalysis\main_view.csv' with csv header




--убрали исходя из данных corr() illnesses.py
----убрали исходя из обоюдной корреляции
--******************************************************************************************************

create view adiscoursework.deaths_reasons_influence_on_happiness as
SELECT name,
       year,
--      "Self-harm"/(AVERAGE_POPULATION::REAL - (2020-YEAR) * NET_POPULATION_CHANGE)*10000 as "Self-harm",
--     "Interpersonal violence"/(AVERAGE_POPULATION::REAL - (2020-YEAR) * NET_POPULATION_CHANGE)*10000 as "Interpersonal violence",
--     "Drowning"/(AVERAGE_POPULATION::REAL - (2020-YEAR) * NET_POPULATION_CHANGE)*10000  "Drowning"                                 ,
     "Malaria"/(AVERAGE_POPULATION::REAL - (2020-YEAR) * NET_POPULATION_CHANGE)*10000    "Malaria"                                ,
--     "Fire, heat, and hot substances"/(AVERAGE_POPULATION::REAL - (2020-YEAR) * NET_POPULATION_CHANGE)*10000 "Fire, heat, and hot substances"            ,
     "Neoplasms"/(AVERAGE_POPULATION::REAL - (2020-YEAR) * NET_POPULATION_CHANGE)*10000  "Neoplasms"                                ,
--     "Digestive diseases"/(AVERAGE_POPULATION::REAL - (2020-YEAR) * NET_POPULATION_CHANGE)*10000 "Digestive diseases"                        ,
--     "Cirrhosis and other chronic liver diseases"/(AVERAGE_POPULATION::REAL - (2020-YEAR) * NET_POPULATION_CHANGE)*10000 "Cirrhosis and other chronic liver diseases",
--     "Chronic respiratory diseases"/(AVERAGE_POPULATION::REAL - (2020-YEAR) * NET_POPULATION_CHANGE)*10000 "Chronic respiratory diseases"              ,
--     "Chronic kidney disease"/(AVERAGE_POPULATION::REAL - (2020-YEAR) * NET_POPULATION_CHANGE)*10000  "Chronic kidney disease"                   ,
--     "Cardiovascular diseases"/(AVERAGE_POPULATION::REAL - (2020-YEAR) * NET_POPULATION_CHANGE)*10000 "Cardiovascular diseases"                   ,
     "Drug use disorders"/(AVERAGE_POPULATION::REAL - (2020-YEAR) * NET_POPULATION_CHANGE)*10000  "Drug use disorders"                       ,
--     "Nutritional deficiencies"/(AVERAGE_POPULATION::REAL - (2020-YEAR) * NET_POPULATION_CHANGE)*10000 "Nutritional deficiencies"                  ,
--     "Alcohol use disorders"/(AVERAGE_POPULATION::REAL - (2020-YEAR) * NET_POPULATION_CHANGE)*10000  "Alcohol use disorders"                    ,
--     "Lower respiratory infections"/(AVERAGE_POPULATION::REAL - (2020-YEAR) * NET_POPULATION_CHANGE)*10000  "Lower respiratory infections"             ,
--     "Diabetes mellitus"/(AVERAGE_POPULATION::REAL - (2020-YEAR) * NET_POPULATION_CHANGE)*10000    "Diabetes mellitus"                      ,
--     "Protein-energy malnutrition"/(AVERAGE_POPULATION::REAL - (2020-YEAR) * NET_POPULATION_CHANGE)*10000   "Protein-energy malnutrition"             ,
--     "Exposure to forces of nature"/(AVERAGE_POPULATION::REAL - (2020-YEAR) * NET_POPULATION_CHANGE)*10000   "Exposure to forces of nature"            ,
--     "Environmental heat and cold exposure"/(AVERAGE_POPULATION::REAL - (2020-YEAR) * NET_POPULATION_CHANGE)*10000 "Environmental heat and cold exposure"      ,
     "Diarrheal diseases"/(AVERAGE_POPULATION::REAL - (2020-YEAR) * NET_POPULATION_CHANGE)*10000  "Diarrheal diseases"                       ,
--     "Road injuries"/(AVERAGE_POPULATION::REAL - (2020-YEAR) * NET_POPULATION_CHANGE)*10000  "Road injuries"                            ,
----     "Tuberculosis"/(AVERAGE_POPULATION::REAL - (2020-YEAR) * NET_POPULATION_CHANGE)*10000 "Tuberculosis"                              ,
     "HIV/AIDS"/(AVERAGE_POPULATION::REAL - (2020-YEAR) * NET_POPULATION_CHANGE)*10000 "HIV/AIDS"                                  ,
----     "Alzheimer's disease and other dementias"/(AVERAGE_POPULATION::REAL - (2020-YEAR) * NET_POPULATION_CHANGE)*10000 "Alzheimer's disease and other dementias"   ,
----     "Parkinson's disease"/(AVERAGE_POPULATION::REAL - (2020-YEAR) * NET_POPULATION_CHANGE)*10000 "Parkinson's disease"                       ,
     "Acute hepatitis"/(AVERAGE_POPULATION::REAL - (2020-YEAR) * NET_POPULATION_CHANGE)*10000 "Acute hepatitis"                           ,
    happiness_score
FROM adiscoursework.death_report
inner join adiscoursework.country on adiscoursework.death_report.country_id = adiscoursework.country.id
inner join ADISCOURSEWORK.date on adiscoursework.death_report.date_id = adiscoursework.date.id;



create view ADISCOURSEWORK.the_most_main_view as
    select
       name as country_name,
       main_view.year as year,
       --social_support,
       gdp,
       freedom,
       trust,
       generosity,
       --"Malaria", --14.06
       --"Neoplasms", --14.06
       "Drug use disorders",
       --"Diarrheal diseases",
       "HIV/AIDS",
       --"Acute hepatitis",
       main_view.happiness_score as happiness_score,
       category
from adiscoursework.deaths_reasons_influence_on_happiness
inner join ADISCOURSEWORK.MAIN_VIEW on
    (ADISCOURSEWORK.MAIN_VIEW.COUNTRY_NAME = adiscoursework.deaths_reasons_influence_on_happiness.name)
AND
    (ADISCOURSEWORK.MAIN_VIEW.YEAR = adiscoursework.deaths_reasons_influence_on_happiness.year)
WHERE "HIV/AIDS" <= 40 AND "Drug use disorders" <= 1.4;

create view adiscoursework.country_classification as
select
       --happiness_score,
       --social_support,
       --"Neoplasms",
       country_name,
       year,
       gdp,
       freedom,
       trust,
       generosity,
       --"Malaria",
       "Drug use disorders",
       "HIV/AIDS",
       category
from
    ADISCOURSEWORK.the_most_main_view
    inner join adiscoursework.country on (adiscoursework.country.name = adiscoursework.the_most_main_view.country_name)
    where category is not null;