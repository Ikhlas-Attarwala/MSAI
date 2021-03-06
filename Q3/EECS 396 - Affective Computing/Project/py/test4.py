import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd
import numpy as np
from mpl_toolkits import mplot3d
from mpl_toolkits.mplot3d import Axes3D

fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')


# Data for three-dimensional scattered points
Pdata = [2.0, 2.0, 4.0, 1.0, 1.0, 3.0, 4.0, 5.0, 5.0, 5.0, 3.0, 4.0, 1.0, 3.0, 3.0, 1.0, 1.0, 3.0, 4.0, 4.0, 4.0, 2.0, 5.0, 4.0, 3.0, 4.0, 3.0, 2.0, 3.0, 2.0, 3.0, 4.0, 4.0, 1.0, 1.0, 1.0, 2.0, 1.0, 1.0, 2.0, 2.0, 1.0, 2.0, 3.0, 2.0, 2.0, 1.0, 1.0, 3.0, 4.0, 3.0, 3.0, 4.0, 2.0, 3.0, 3.0, 3.0, 3.0, 2.0, 3.0, 3.0, 2.0, 2.0, 3.0, 2.0, 4.0, 3.0, 1.0, 1.0, 2.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.0, 2.0, 2.0, 2.0, 2.0, 4.0, 3.0, 4.0, 3.0, 3.0, 5.0, 3.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 3.0, 3.0, 3.0, 1.0, 3.0, 4.0, 2.0, 1.0, 2.0, 4.0, 2.0, 3.0, 3.0, 4.0, 3.0, 3.0, 3.0, 3.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.0, 3.0, 3.0, 3.0, 4.0, 2.0, 1.0, 2.0, 3.0, 3.0, 4.0, 3.0, 3.0, 3.0, 2.0, 4.0, 3.0, 3.0, 3.0, 4.0, 3.0, 5.0, 5.0, 1.0, 2.0, 5.0, 3.0, 3.0, 4.0, 3.0, 4.0, 3.0, 2.0, 2.0, 3.0, 2.0, 2.0, 1.0, 1.0, 1.0, 1.0, 1.0]
Adata = [4.0, 3.0, 3.0, 4.0, 3.0, 2.0, 1.0, 3.0, 4.0, 4.0, 1.0, 3.0, 6.0, 4.0, 4.0, 5.0, 4.0, 4.0, 1.0, 4.0, 4.0, 2.0, 2.0, 3.0, 1.0, 1.0, 2.0, 1.0, 3.0, 1.0, 2.0, 1.0, 4.0, 4.0, 4.0, 4.0, 2.0, 1.0, 1.0, 4.0, 1.0, 5.0, 2.0, 2.0, 2.0, 3.0, 1.0, 1.0, 3.0, 1.0, 5.0, 1.0, 2.0, 1.0, 1.0, 3.0, 1.0, 3.0, 1.0, 1.0, 2.0, 3.0, 1.0, 1.0, 3.0, 4.0, 2.0, 3.0, 3.0, 3.0, 4.0, 4.0, 4.0, 1.0, 6.0, 4.0, 4.0, 3.0, 4.0, 3.0, 4.0, 1.0, 3.0, 2.0, 1.0, 2.0, 1.0, 4.0, 5.0, 5.0, 4.0, 3.0, 3.0, 4.0, 1.0, 3.0, 3.0, 1.0, 1.0, 3.0, 5.0, 5.0, 3.0, 3.0, 2.0, 3.0, 1.0, 3.0, 3.0, 1.0, 1.0, 3.0, 3.0, 3.0, 4.0, 4.0, 5.0, 2.0, 4.0, 2.0, 5.0, 1.0, 2.0, 2.0, 3.0, 2.0, 1.0, 4.0, 2.0, 6.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.0, 3.0, 2.0, 3.0, 4.0, 5.0, 2.0, 3.0, 4.0, 6.0, 5.0, 1.0, 3.0, 2.0, 1.0, 2.0, 3.0, 3.0, 4.0, 5.0, 5.0, 5.0, 5.0, 6.0, 1.0]
Ddata = [3.0, 3.0, 4.0, 5.0, 3.0, 3.0, 1.0, 4.0, 3.0, 2.0, 2.0, 3.0, 5.0, 4.0, 4.0, 5.0, 2.0, 3.0, 2.0, 3.0, 3.0, 2.0, 2.0, 3.0, 2.0, 3.0, 4.0, 3.0, 4.0, 1.0, 4.0, 1.0, 6.0, 4.0, 4.0, 5.0, 4.0, 5.0, 2.0, 3.0, 4.0, 5.0, 2.0, 2.0, 4.0, 1.0, 3.0, 1.0, 4.0, 3.0, 5.0, 1.0, 2.0, 2.0, 1.0, 1.0, 1.0, 3.0, 1.0, 2.0, 3.0, 3.0, 1.0, 4.0, 4.0, 3.0, 3.0, 6.0, 2.0, 3.0, 4.0, 4.0, 4.0, 5.0, 5.0, 4.0, 3.0, 3.0, 4.0, 5.0, 5.0, 1.0, 2.0, 1.0, 3.0, 1.0, 2.0, 5.0, 5.0, 5.0, 4.0, 4.0, 4.0, 4.0, 3.0, 3.0, 3.0, 3.0, 3.0, 3.0, 4.0, 5.0, 3.0, 3.0, 3.0, 3.0, 1.0, 3.0, 2.0, 2.0, 3.0, 3.0, 4.0, 4.0, 4.0, 5.0, 5.0, 1.0, 3.0, 3.0, 4.0, 2.0, 3.0, 3.0, 3.0, 4.0, 1.0, 4.0, 1.0, 4.0, 2.0, 2.0, 2.0, 1.0, 1.0, 2.0, 3.0, 1.0, 3.0, 4.0, 5.0, 2.0, 4.0, 4.0, 6.0, 4.0, 1.0, 3.0, 3.0, 3.0, 3.0, 4.0, 2.0, 2.0, 3.0, 4.0, 4.0, 2.0, 4.0, 2.0]

ax.scatter(Pdata, Adata, Ddata, c=Ddata, marker='o')

ax.set_xlabel('Pleasure')
ax.set_ylabel('Arousal')
ax.set_zlabel('Dominance')

# ax.scatter3D(np.asarray(Pdata), np.asarray(Adata), np.asarray(Ddata), c=np.asarray(Ddata), cmap='Greens');