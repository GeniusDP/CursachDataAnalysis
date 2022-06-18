import math

import numpy as np
import pandas as pd
import seaborn as sb
from matplotlib import pyplot as plt
from sklearn.linear_model import LinearRegression
from sklearn.metrics import r2_score
from sklearn.model_selection import train_test_split
from sklearn.pipeline import make_pipeline
from sklearn.preprocessing import PolynomialFeatures

# configurations
pd.options.display.max_rows = 1000
pd.options.display.max_columns = 1000
pd.set_option('display.expand_frame_repr', False)


def regression(x, y, max_degree):
    Xtrain, Xtest, Ytrain, Ytest = train_test_split(x, y, test_size=0.3, random_state=4)
    reg = make_pipeline(PolynomialFeatures(degree=max_degree), LinearRegression())
    reg.fit(Xtrain, Ytrain)
    Ypredicted = []
    for i in range(0, Xtest.__len__()):
        Ypredicted.append(reg.predict([Xtest[i]])[0])

    R2 = r2_score(Ytest, Ypredicted)
    _RSE = RSE(Ytest, Ypredicted)
    coef = reg['linearregression'].coef_
    w0 = reg['linearregression'].intercept_

    return coef, w0, R2, reg, _RSE


def RSE(y_true, y_predicted):
    """
    - y_true: Actual values
    - y_predicted: Predicted values
    """
    y_true = np.array(y_true)
    y_predicted = np.array(y_predicted)
    RSS = np.sum(np.square(y_true - y_predicted))

    rse = math.sqrt(RSS / (len(y_true) - 2))
    return rse


def main_work(df):
    x = []
    for i in range(0, df.__len__()):
        tmp = df.loc[i].to_numpy()
        tmp = np.delete(tmp, df.columns.size - 1, 0)
        x.append(tmp)
    y = df['happiness_score'].to_numpy()

    coef, w0, R2, reg, _RSE = regression(x, y, 2)
    print('degree 1 R^2: ', R2)
    print('degree 1 RSE: ', _RSE)
    for col in df.columns:
        if col != 'happiness_score':
            printProjection(df, reg, col, 1000)
    plt.show()
    pass


def printProjection(df, regression, argument_name, detalization):
    def fillZeros(list_length):
        list = []
        for i in range(list_length):
            list.append(0)
        return list

    xReg = []
    argument_position = df.columns.tolist().index(argument_name)
    max_value = df[argument_name].max()
    step = max_value / detalization
    arg_value = 0
    while arg_value <= max_value:
        tmp = fillZeros(df.columns.size - 1)
        tmp[argument_position] = arg_value
        xReg.append(tmp)
        arg_value += step

    plt.figure(figsize=(5, 5))
    plt.title('Regression')
    plt.xlabel(argument_name)
    plt.ylabel('happiness')
    plt.grid(linestyle='--')

    plt.plot(np.linspace(0, max_value, len(xReg)).reshape(-1, 1), regression.predict(xReg), color='red')
    plt.scatter(df[argument_name].to_numpy(), df['happiness_score'])
    pass


# program
df = pd.read_csv('../data/the_most_main_view.csv', sep=',', decimal='.')

print(df.info())

df.drop(columns=['country_name', 'year', 'category', 'Malaria', 'Unnamed: 0'],
        inplace=True)  # delete or not? , 'Neoplasms', 'social_support', 'Malaria'

corr = df.corr()

sb.heatmap(corr, xticklabels=corr.columns, yticklabels=corr.columns, annot=True,
           cmap=sb.color_palette("coolwarm", as_cmap=True))
plt.savefig('../data/images/happiness_corr.png')
plt.show()
main_work(df)
