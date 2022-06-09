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
--create view deaths_reasons_influence as
    select
           c.name as country_name,
           year,
           dr.name as reason,
           count,
           happiness_score
    from adiscoursework.happiness_report
    inner join adiscoursework.death_report
        on (adiscoursework.happiness_report.date_id = adiscoursework.death_report.date_id)
            and (adiscoursework.happiness_report.country_id = adiscoursework.death_report.country_id)
    inner join adiscoursework.country c on c.id = adiscoursework.death_report.country_id
    inner join adiscoursework.date d on d.id = adiscoursework.death_report.date_id
    inner join adiscoursework.death_reason dr on dr.id = adiscoursework.death_report.reason_id;