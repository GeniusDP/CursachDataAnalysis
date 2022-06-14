import pandas as pd

# configurations
import seaborn
from matplotlib import pyplot as plt

pd.options.display.max_rows = 1000
pd.options.display.max_columns = 1000
pd.set_option('display.expand_frame_repr', False)

# program
df = pd.read_csv('../data/deaths_reasons_influence_on_happiness.csv', sep=',', decimal='.')
print(df.info())

df.drop(columns=['name', 'year'], inplace=True)

corr = df.corr() #.sort_values('happiness_score', ascending=False)
seaborn.heatmap(corr, xticklabels=corr.columns, yticklabels=corr.columns, annot=True, cmap=seaborn.color_palette("coolwarm", as_cmap=True))
plt.savefig('../data/images/illnesses_corr.png')
plt.show()
print(corr)
