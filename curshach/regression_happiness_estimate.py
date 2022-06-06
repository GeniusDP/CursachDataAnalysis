import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
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


def regression(x, y, max_degree):
    Xtrain, Xtest, Ytrain, Ytest = train_test_split(x, y, test_size=0.3, random_state=4)
    reg = make_pipeline(PolynomialFeatures(degree=max_degree), LinearRegression())
    reg.fit(Xtrain, Ytrain)
    Ypredicted = []
    for i in range(0, Xtest.__len__()):
        Ypredicted.append(reg.predict([Xtest[i]])[0])

    R2 = r2_score(Ytest, Ypredicted)

    coef = reg['linearregression'].coef_
    w0 = reg['linearregression'].intercept_
    return coef, w0, R2, reg


def main_work(df):
    x = []
    for i in range(0, df.__len__()):
        tmp = df.loc[i].to_numpy()
        tmp = np.delete(tmp, 8, 0)
        tmp = np.delete(tmp, 0, 0)
        tmp = np.delete(tmp, 0, 0)
        x.append(tmp)
    y = df['happiness_score'].to_numpy()

    coef, w0, R2, reg = regression(x, y, 1)
    print('degree 1: ', R2)

    printProjection(df, reg, 'gdp', 1000)
    printProjection(df, reg, 'trust', 1000)
    printProjection(df, reg, 'social_support', 1000)
    printProjection(df, reg, 'freedom', 1000)
    printProjection(df, reg, 'generosity', 1000)
    printProjection(df, reg, 'total_deaths', 1000)
    pass


def printProjection(df, regression, argument_name, detalization):
    xReg = []

    argument_position = df.columns.tolist().index(argument_name)
    print(argument_position)
    max_value = df[argument_name].max()
    step = max_value / detalization
    arg_value = 0
    print('step = ', step)
    print('max_value = ', max_value)
    while arg_value <= max_value:
        tmp = [0, 0, 0, 0, 0, 0]
        tmp[argument_position-2] = arg_value
        xReg.append(tmp)
        arg_value += step

    print('xReg size = ', len(xReg))
    print('predict size = ', len(regression.predict(xReg)))
    plt.figure(figsize=(5, 5))
    plt.title('Regression')
    plt.xlabel(argument_name)
    plt.ylabel('happiness')
    plt.grid(linestyle='--')

    plt.plot(np.linspace(0, max_value, len(xReg)).reshape(-1, 1), regression.predict(xReg), color='red')
    plt.scatter(df[argument_name].to_numpy(), df['happiness_score'])

    plt.show()
    pass


# program
df = pd.read_csv('../data/main_view.csv', sep=',', decimal='.')
# print(df.info())
print(df.corr())

main_work(df)

# xReg = []
# for i in range(0, df.__len__()):
#     tmp = df.loc[i].to_numpy()
#     tmp = np.delete(tmp, 8, 0)
#     tmp = np.delete(tmp, 0, 0)
#     tmp = np.delete(tmp, 0, 0)
#     tmp[1] = tmp[2] = tmp[3] = tmp[4] = tmp[5] = 0
#     xReg.append(tmp)
# print(xReg)
#
# print( xReg[0] )
# print( reg.predict([xReg[0]]) )
