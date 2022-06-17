DROP VIEW IF EXISTS ADISCOURSEWORK.MAIN_VIEW cascade;
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
    SELECT c.name AS country_name,
           year,
           dr.name AS reason_name,
           count / (AVERAGE_POPULATION::REAL - (2020-YEAR) * NET_POPULATION_CHANGE) * 10000 AS count
    FROM adiscoursework.death_report
    inner join adiscoursework.country c on c.id = death_report.country_id
    inner join adiscoursework.date d on d.id = death_report.date_id
    inner join adiscoursework.death_reason dr on dr.id = death_report.reason_id
    WHERE year BETWEEN 2015 AND 2019 AND count IS NOT NULL;