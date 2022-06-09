import pandas as pd

# configurations
pd.options.display.max_rows = 10000
pd.options.display.max_columns = 10000
pd.set_option('display.expand_frame_repr', False)

df1 = pd.read_csv('../stage_zone/age-between-15-and-49.csv', sep=',', decimal='.', encoding='cp1252')
df2 = pd.read_csv('../stage_zone/age-between-50-and-69.csv', sep=',', decimal='.', encoding='cp1252')
df3 = pd.read_csv('../stage_zone/above-age-70.csv', sep=',', decimal='.', encoding='cp1252')

df = pd.concat( [df1, df2, df3])
df = df.groupby(['Country', 'Year']).sum()
df.to_csv('../main_warehouse/death_reasons.csv')

df = pd.read_csv('../main_warehouse/death_reasons.csv', sep=',', decimal='.', encoding='cp1252')
# df = df.melt(id_vars=['Country', 'Year'], var_name="reason", value_name="count")
df.to_csv('../main_warehouse/death_reasons.csv')