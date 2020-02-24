import matplotlib.pyplot as plt
# import seaborn as sns
import pandas as pd
import numpy as np
import statistics
from pprint import pprint

aus = pd.read_csv('combinedaus.csv')
aus = aus.rename(index=str, columns={"Photo Id": "id"})

aus_ang = aus.loc[aus['id'].str.contains('_a')]

aus_c = aus_ang.loc[aus['id'].str.contains('^c')]
# for each in aus_c:
# 	aus_c[each] = aus_c[each].replace({0.00:np.nan, 0.00:np.nan})

aus_sa = aus_ang.loc[aus['id'].str.contains('^sa')]
# for each in aus_sa:
# 	aus_sa[each] = aus_sa[each].replace({0.00:np.nan, 0.00:np.nan})

d_c = {}
d_sa = {}
for each in aus_c.iloc[:,1:]:
	d_c[each[1:]] = statistics.median(aus_c[each].values.tolist())
for each in aus_sa.iloc[:,1:]:
	d_sa[each[1:]] = statistics.median(aus_sa[each].values.tolist())

X = np.arange(len(d_c))
ax = plt.subplot(111)
ax.bar(X, d_c.values(), width=0.2, color='black', align='center')
ax.bar(X-0.2, d_sa.values(), width=0.2, color='brown', align='center')
ax.legend(('Caucasian','South Asian'))
plt.xticks(X, d_c.keys())
plt.title("Median Action Unit Scores by Race (Angry Photos)", fontsize=17)
plt.show()