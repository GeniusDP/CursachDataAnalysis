import pandas as pd
from matplotlib import pyplot as plt


# гистограмма частот(frequency histogram)
def build_hist(dataset, column):
    plt.style.use('seaborn-whitegrid')
    plt.figure(figsize=(4, 3))
    plt.title(f'Histogram of frequencies for {column}')
    plt.hist(dataset[column], edgecolor='blue', facecolor='cyan')
    plt.savefig(f'./images/hists/{column.replace("/", "-")}.png')
    plt.show()
    pass


def build_hists_for_columns_list(df, column_list):
    for column in column_list:
        build_hist(df, column)
    pass


# диаграмма размаха(range diagram)
def build_plot(dataset, column):
    plt.figure()
    plt.title(f'Range diagram for {column}')
    plt.boxplot(dataset[column], showmeans=True)
    plt.savefig(f'./images/plots/{column.replace("/", "-")}.png')
    plt.show()


def build_plots_for_columns_list(df, column_list):
    for column in column_list:
        build_plot(df, column)
    pass


df = pd.read_csv('the_most_main_view.csv', sep=',', decimal='.', encoding='cp1252')
list = ['gdp', 'freedom', 'trust', 'generosity', 'Malaria', 'happiness_score']
build_hists_for_columns_list(df, list)
build_plots_for_columns_list(df, list)