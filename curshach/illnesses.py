import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
from matplotlib.pyplot import show
from scipy import stats
from sklearn.linear_model import LinearRegression
from sklearn.metrics import r2_score
from sklearn.model_selection import train_test_split
from sklearn.pipeline import make_pipeline
from sklearn.preprocessing import PolynomialFeatures

# configurations
pd.options.display.max_rows = 1000
pd.options.display.max_columns = 1000
pd.set_option('display.expand_frame_repr', False)

# program
df = pd.read_csv('../data/deaths_reasons_influence_on_happiness.csv', sep=',', decimal='.')

print(df.info())

df.drop(columns=['name', 'year', 'Tuberculosis'], inplace=True)

#print(df.corr())

ix = df.corr().sort_values('happiness_score', ascending=False)
print(ix)
