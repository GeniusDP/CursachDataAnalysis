import numpy as np
import pandas as pd

# configurations
pd.options.display.max_rows = 10000
pd.options.display.max_columns = 10000
pd.set_option('display.expand_frame_repr', False)

df = pd.read_csv('../stage_zone/Country_Consumption_TWH.csv',
                 sep=',', decimal='.', encoding='cp1252')
df = df.melt(id_vars=["Year"],
             var_name="Country",
                value_name="Consumption")


df.dropna(inplace=True)
df['Year'] = df['Year'].astype(int)
df.to_csv('../main_warehouse/country_consumption.csv')
