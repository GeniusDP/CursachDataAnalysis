import numpy as np
import pandas as pd

# configurations
from matplotlib import pyplot as plt

pd.options.display.max_rows = 10000
pd.options.display.max_columns = 10000
pd.set_option('display.expand_frame_repr', False)


def convert_column_to_float(dataset, column_label):
    dataset[column_label] = dataset[column_label].astype(str).str.replace(',', '.').astype(float)


df = pd.read_csv('../stage_zone/world-happiness-report-2015-2022-cleaned.csv', sep=',', decimal='.', encoding='cp1252')


def build_hist(dataset, column):
    plt.style.use('seaborn-whitegrid')
    plt.figure(figsize=(4, 3))
    plt.title(f'Histogram of frequencies for {column}')
    plt.hist(dataset[column], edgecolor='blue', facecolor='cyan')
    plt.show()
    pass


convert_column_to_float(df, 'Happiness Score')
convert_column_to_float(df, 'Economy (GDP per Capita)')
convert_column_to_float(df, 'Family (Social Support)')
convert_column_to_float(df, 'Health (Life Expectancy)')
convert_column_to_float(df, 'Freedom')
convert_column_to_float(df, 'Trust (Government Corruption)')
convert_column_to_float(df, 'Generosity')

build_hist(df, 'Happiness Score')
build_hist(df, 'Economy (GDP per Capita)')
build_hist(df, 'Family (Social Support)')
build_hist(df, 'Health (Life Expectancy)')
build_hist(df, 'Freedom')
build_hist(df, 'Trust (Government Corruption)')
build_hist(df, 'Generosity')
df = df.drop(columns='Unnamed: 0')

df.to_csv('../main_warehouse/happiness.csv')
