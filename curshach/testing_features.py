import matplotlib.pyplot as plt
import numpy as np

a = np.array([[ 1, 1.5, 2.5, 3, 3.5, 6.5, 5, 6, 7, 8, 7.5 ],
              [ 8, 11, 10, 8, 12, 4.3, 4, 7, 2, 5, 7.5 ]])



def printScatter(param1, param2, categories, x_label, y_label):
    DevelopingCountryColor = (0.984, 0.396, 0.035, 1.0)
    DevelopedCountryColor = (0.094, 0.968, 0.313, 1.0)
    LeastDevelopedCountryColor = (0.054, 0.035, 0.984, 1.0)

    colormap = np.array([DevelopingCountryColor, DevelopedCountryColor, LeastDevelopedCountryColor])

    plt.scatter(param1, param2, s=100, c=colormap[categories])
    plt.xlabel(x_label)
    plt.ylabel(y_label)
    plt.title('Supervised Learning')

    plt.show()
    pass

printScatter(a[0], a[1], [0, 0, 0, 0, 2, 1, 2, 2, 1, 1, 1], "gdp", "mood")