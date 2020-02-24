import numpy as np
import matplotlib.pyplot as plt

# board
BOARD = np.zeros((8,8))
BOARD[1::2, 0::2] = 1
BOARD[0::2, 1::2] = 1
fig, ax1 = plt.subplots(1,1)
labels = range(0, 8, 1)
# x-axis
plt.xticks(labels)
ax1.set_xticklabels(['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'])
# y-axis
plt.yticks(labels)
ax1.set_yticklabels(['8', '7', '6', '5', '4', '3', '2', '1'])
# plot
plt.imshow(BOARD, cmap='tab20c')
plt.show()