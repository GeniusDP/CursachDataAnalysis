import pandas as pd

# configurations
import seaborn
from matplotlib import pyplot as plt

pd.options.display.max_rows = 1000
pd.options.display.max_columns = 1000
pd.set_option('display.expand_frame_repr', False)

# program
df = pd.read_csv('../data/deaths_reasons_influence_on_happiness.csv', sep=',', decimal='.')
df.dropna(inplace=True)
df = df.pivot(index=["country_name", "year"], columns="reason_name", values="count")
print(df.info())

df = df.filter(items=["Malaria", "Drug use disorders", "HIV/AIDS"])
df_main = pd.read_csv('../data/main_view.csv', sep=',', decimal='.')
df = pd.merge(df, df_main, on=["country_name", "year"])
df = df.drop(columns=["social_support"])

df = df[df["HIV/AIDS"] <= 40]
df = df[df["Drug use disorders"] <= 1.4]

df.to_csv("../data/the_most_main_view.csv")
df = df.drop(columns=["country_name", "year"])

corr = df.corr() #.sort_values('happiness_score', ascending=False)
seaborn.heatmap(corr, xticklabels=corr.columns, yticklabels=corr.columns, annot=True, cmap=seaborn.color_palette("coolwarm", as_cmap=True))
plt.savefig('../data/images/illnesses_corr.png')
plt.show()
print(corr)

