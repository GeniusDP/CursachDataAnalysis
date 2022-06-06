drop view if exists adiscoursework.main_view;

create view adiscoursework.main_view AS
select
       name country_name,
       year,
       gdp,
       social_support,
       freedom,
       trust,
       generosity,
       total_deaths,
       happiness_score
from adiscoursework.happiness_report
inner join adiscoursework.date d on d.id = adiscoursework.happiness_report.date_id
inner join adiscoursework.country c on c.id = adiscoursework.happiness_report.country_id
where (energy_consumption is not null)
  AND (year >= 2015 )
  AND (year <= 2019)
  AND (total_deaths is not null);
--AND (total_deaths <= 3000000);

/*
    1)дропнули life_expectancy - большая corr с gdp.
    2)дропнули energy_consumption - большая corr с total_deaths
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