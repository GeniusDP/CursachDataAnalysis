import pandas as pd

# configurations
pd.options.display.max_rows = 1000
pd.options.display.max_columns = 1000
pd.set_option('display.expand_frame_repr', False)

# program
# df = pd.read_csv('../data/deaths_reasons_influence_on_happiness.csv', sep=',', decimal='.')
df = pd.read_csv('../data/the_most_main_view.csv', sep=',', decimal='.')
print(df.info())

df.drop(columns=['country_name', 'year'], inplace=True)

ix = df.corr().sort_values('happiness_score', ascending=False)
print(ix)
