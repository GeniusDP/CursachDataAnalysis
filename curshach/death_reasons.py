import pandas as pd

# configurations
from matplotlib import pyplot as plt

pd.options.display.max_rows = 10000
pd.options.display.max_columns = 10000
pd.set_option('display.expand_frame_repr', False)


def build_hist(dataset, column):
    plt.style.use('seaborn-whitegrid')
    plt.figure(figsize=(4, 3))
    plt.title(f'Histogram of frequencies for {column}')
    plt.hist(dataset[column], edgecolor='blue', facecolor='cyan')
    plt.show()
    pass


def build_hists_for_columns_list(df, column_list):
    for column in column_list:
        build_hist(df, column)
    pass



df1 = pd.read_csv('../stage_zone/age-between-15-and-49.csv', sep=',', decimal='.', encoding='cp1252')
df2 = pd.read_csv('../stage_zone/age-between-50-and-69.csv', sep=',', decimal='.', encoding='cp1252')
df3 = pd.read_csv('../stage_zone/above-age-70.csv', sep=',', decimal='.', encoding='cp1252')

df = pd.concat([df1, df2, df3])
df = df.groupby(['Country', 'Year']).sum()

#build_hists_for_columns_list(df, ['Self-harm', 'Interpersonal violence', 'Drowning', 'Malaria', "Fire, heat, and hot substances", 'Neoplasms', 'Digestive diseases','Cirrhosis and other chronic liver diseases','Chronic respiratory diseases','Chronic kidney disease','Cardiovascular diseases','Drug use disorders','Nutritional deficiencies','Alcohol use disorders','Lower respiratory infections','Diabetes mellitus','Protein-energy malnutrition','Exposure to forces of nature','Environmental heat and cold exposure','Diarrheal diseases','Road injuries','Tuberculosis','HIV/AIDS',"Alzheimer's disease and other dementias","Parkinson's disease","Acute hepatitis"])

df.to_csv('../main_warehouse/death_reasons.csv')
df = pd.read_csv('../main_warehouse/death_reasons.csv', sep=',', decimal='.', encoding='cp1252')
df = df.melt(id_vars=["Country", "Year"],
        var_name="Reason",
        value_name="Count")
df.to_csv('../main_warehouse/death_reasons.csv')
