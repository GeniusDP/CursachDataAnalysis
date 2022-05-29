import pandas as pd

# configurations
pd.options.display.max_rows = 10000
pd.options.display.max_columns = 10000
pd.set_option('display.expand_frame_repr', False)


def convert_column_to_float(dataset, column_label):
    dataset[column_label] = dataset[column_label].astype(str).str.replace(',', '.').astype(float)


df = pd.read_csv('../stage_zone/world-happiness-report-2015-2022-cleaned.csv', sep=',', decimal='.', encoding='cp1252')

convert_column_to_float(df, 'Happiness Score')
convert_column_to_float(df, 'Economy (GDP per Capita)')
convert_column_to_float(df, 'Family (Social Support)')
convert_column_to_float(df, 'Health (Life Expectancy)')
convert_column_to_float(df, 'Freedom')
convert_column_to_float(df, 'Trust (Government Corruption)')
convert_column_to_float(df, 'Generosity')

df = df.drop( columns = 'Unnamed: 0' )

df.to_csv('../main_warehouse/happiness.csv')
