from sklearn.feature_extraction.text import CountVectorizer
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score
import csv

## Code is adapted from https://www.twilio.com/blog/2017/12/sentiment-analysis-scikit-learn.html
## But assumes data is from SemEval 2018 Task 1 SubTask EI-reg:
##   https://competitions.codalab.org/competitions/17751#learn_the_details-datasets
data=[]
data_labels = []

# load the data
with open("./EI-reg-En-anger-train.txt") as f:
	csv_reader = csv.reader(f, delimiter='\t')
	next(csv_reader)
	for row in csv_reader:
		data.append(row[1])
		data_labels.append('anger')

##with open("./EI-reg-En-fear-train.txt") as f:
##	csv_reader = csv.reader(f, delimiter='\t')
##	next(csv_reader)
##	for row in csv_reader:
##		data.append(row[1])
##		data_labels.append('fear')

with open("./EI-reg-En-joy-train.txt") as f:
	csv_reader = csv.reader(f, delimiter='\t')
	next(csv_reader)
	for row in csv_reader:
		data.append(row[1])
		data_labels.append('joy')

with open("./EI-reg-En-sadness-train.txt") as f:
	csv_reader = csv.reader(f, delimiter='\t')
	next(csv_reader)
	for row in csv_reader:
		data.append(row[1])
		data_labels.append('sadness')

# array of features
vectorizer = CountVectorizer(
    analyzer = 'word',
    lowercase = False,
)
features = vectorizer.fit_transform(
    data
)
features_nd = features.toarray() 

# 80/20 train/test split
X_train, X_test, y_train, y_test  = train_test_split(
        features_nd, 
        data_labels,
        train_size=0.8, 
        random_state=1234)

# create model
log_model = LogisticRegression()

# fit model to training data
log_model = log_model.fit(X=X_train, y=y_train)

# classify test data
y_pred = log_model.predict(X_test)

# print results
print(accuracy_score(y_test, y_pred))
