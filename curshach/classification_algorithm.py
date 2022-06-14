import itertools
import numpy as np
import pandas as pd
import seaborn
from matplotlib import pyplot as plt
from sklearn.ensemble import RandomForestClassifier
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import confusion_matrix
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
from sklearn.tree import DecisionTreeClassifier

# configurations

pd.options.display.max_rows = 1000
pd.options.display.max_columns = 1000
pd.set_option('display.expand_frame_repr', False)


def classification_function():

    def plot_confusion_matrix(cm, classes, title='Confusion matrix', cmap=plt.cm.Blues):
        plt.imshow(cm, interpolation='nearest', cmap=cmap)
        plt.title(title)
        plt.colorbar()
        tick_marks = np.arange(len(classes))
        plt.xticks(tick_marks, classes, rotation=45)
        plt.yticks(tick_marks, classes)

        thresh = cm.max() / 2.
        for i, j in itertools.product(range(cm.shape[0]), range(cm.shape[1])):
            plt.text(j, i, format(cm[i, j], '.2f'),
                     horizontalalignment="center",
                     color="white" if cm[i, j] > thresh else "black")

        plt.tight_layout()
        plt.ylabel('True label')
        plt.xlabel('Predicted label')
        plt.show()
        pass

    def decisionTreeClassification(X_train, Y_train, X_test, Y_test):
        dtree_model = DecisionTreeClassifier().fit(X_train, Y_train)
        dtree_predictions = dtree_model.predict(X_test)

        # accuracy
        print('R^2 score for decision tree= ', dtree_model.score(X_test, Y_test))

        # confusion matrix
        cm = confusion_matrix(Y_test, dtree_predictions, normalize = 'all')
        plot_confusion_matrix(cm, ['Developed Country', 'Developing Country', 'Least Developed Country'],
                              title='Confusion matrix for DecisionTreeClassifier')
        pass

    def randomForest(X_train, Y_train, X_test, Y_test):
        random_forest = RandomForestClassifier().fit(X_train, Y_train)
        random_forest_prediction = random_forest.predict(X_test)

        # accuracy
        print('R^2 score for random forest: ', random_forest.score(X_test, Y_test))

        # confusion matrix
        cm = confusion_matrix(Y_test, random_forest_prediction, normalize = 'all')
        plot_confusion_matrix(cm, ['Developed Country', 'Developing Country', 'Least Developed Country'],
                              title='Confusion matrix for RandomForestClassifier')
        pass

    def logisticRegression(X_train, Y_train, X_test, Y_test):
        soft_max = LogisticRegression(max_iter=500, random_state=0, multi_class='auto').fit(X_train, Y_train)
        soft_max_predict = soft_max.predict(X_test)

        # accuracy
        print('R^2 score for logistic regression: ', soft_max.score(X_test, Y_test))

        # confusion matrix
        cm = confusion_matrix(Y_test, soft_max_predict, normalize = 'all')
        plot_confusion_matrix(cm, ['Developed Country', 'Developing Country', 'Least Developed Country'],
                              title='Confusion matrix for LogisticRegressionSoftMax')
        pass

    # read data
    df = pd.read_csv('../data/country_classification.csv', sep=',', decimal='.')
    print(df.info())
    df.drop(columns=['country_name', 'year'], inplace=True)

    # correlation
    corr = df.corr().round(2)
    seaborn.heatmap(corr, annot=True)
    plt.show()

    X_data = df.drop(columns=['category'], inplace=False)
    label_encoder = LabelEncoder()
    Y_data = label_encoder.fit_transform(df['category'])  # transforms 'Least Developed Country' into 2, etc...
    X_train, X_test, Y_train, Y_test = train_test_split(X_data.values, Y_data, test_size=0.3, random_state=5)

    # classification algorithm
    decisionTreeClassification(X_train, Y_train, X_test, Y_test)
    randomForest(X_train, Y_train, X_test, Y_test)
    logisticRegression(X_train, Y_train, X_test, Y_test)
    pass


#####################################################################

# program

classification_function()
