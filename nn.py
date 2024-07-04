import numpy as np
import matplotlib.pyplot as plt
from sklearn import neighbors

# np.random.seed(0)
# X = np.sort(5 * np.random.rand(40, 1), axis=0)
# y = np.sin(X).ravel()

X=[0.1, 0.9, 1.9, 2.3, 3, 4.1, 5.2, 5.9, 6.8, 8.1, 8.7, 9.2, 10.1, 12]
y=[20, 24, 27, 29, 32, 37.3, 36.4, 32.4, 28.5, 30, 38, 43, 40, 32]
X = np.array(X)
X = X.reshape(-1, 1)
y = np.array(y)
num = 10
T = np.linspace(0, 12, num)[:, np.newaxis]
# T = np.linspace(0, 12, num)[:, np.newaxis]
# print(X)
# print(X.shape)
# print("============")
# print(y)
# print(y.shape)

# Add noise to targets
# y[::5] += 1 * (0.5 - np.random.rand(4))

# #############################################################################
# Fit regression model
n_neighbors = 1
knn = neighbors.KNeighborsRegressor(n_neighbors, weights="distance")
y_ = knn.fit(X, y).predict(T)

plt.scatter(X, y, color="darkorange", label="data")
plt.plot(T, y_, color="b", label="fit_result")
plt.xlabel('x')
plt.ylabel('y')
plt.legend(loc=0)
plt.title("Nearest Neighbors (neighbors=%i, linspace=%isamples)" % (n_neighbors, num))

# for i, weights in enumerate(["uniform", "distance"]):
#     knn = neighbors.KNeighborsRegressor(n_neighbors, weights=weights)
#     y_ = knn.fit(X, y).predict(T)

#     plt.subplot(2, 1, i + 1)
#     plt.scatter(X, y, color="darkorange", label="data")
#     plt.plot(T, y_, color="navy", label="prediction")
#     plt.axis("tight")
#     plt.legend()
#     plt.title("KNeighborsRegressor (k = %i, weights = '%s')" % (n_neighbors, weights))
    
# for i in range(3):
#     knn = neighbors.KNeighborsRegressor(n_neighbors, weights="distance")
#     T = np.linspace(0, 12, num)[:, np.newaxis]
#     y_ = knn.fit(X, y).predict(T)

#     plt.subplot(3, 1, i + 1)
#     # plt.scatter(X, y, color="darkorange", label="data")
#     # plt.plot(T, y_, color="b", label="prediction")
#     plt.scatter(X, y, color="darkorange")
#     plt.plot(T, y_, color="b")
#     plt.axis("tight")
#     # plt.legend()
#     plt.title("Nearest Neighbors (neighbors=%i, linspace=%isamples)" % (n_neighbors, num)) 
#     # num = num - 20
#     n_neighbors = n_neighbors - 4

# plt.tight_layout()
plt.show()