
import numpy as np
import math
import matplotlib.pyplot as plt
global sample_n # 样本数量
sample_n = 14
global poly_degree # 多项式次数
poly_degree = int(input("Enter a degree: "))
# poly_degree = 2

def genData(mu, sigma):
    # train_x = np.arange(0, 1, 1 / sample_n)
    # gauss_noise = np.random.normal(mu, sigma, sample_n)
    # train_y = np.sin(train_x * 2 * np.pi) + gauss_noise
    X = [0.1, 0.9, 1.9, 2.3, 3, 4.1, 5.2, 5.9, 6.8, 8.1, 8.7, 9.2, 10.1, 12]
    Y = [20, 24, 27, 29, 32, 37.3, 36.4, 32.4, 28.5, 30, 38, 43, 40, 32]
    train_x = np.array(X)
    train_y = np.array(Y)
    return train_x, train_y

def genMatrixX(train_x):
    X = np.zeros((sample_n, poly_degree + 1))
    for i in range(sample_n):
        row_i = np.ones(poly_degree + 1) * train_x[i]
        nature_row = np.arange(0, poly_degree+1)
        row_i = np.power(row_i, nature_row)
        X[i] = row_i
    return X

def conjugate_gradient(train_x, train_y, lam, eps):
    X = genMatrixX(train_x)
    Y = train_y.reshape((sample_n, 1))
    Q = np.dot(X.T, X) + lam * np.eye(X.shape[1])
    # Q.shape = (10, 10)
    w = np.zeros((poly_degree + 1, 1))
    gradient = np.dot(X.T, X).dot(w) - np.dot(X.T, Y) + lam * w
    r = -gradient
    # r.shape = (10, 1)
    p = r
    # p.shape = (10, 1)
    for i in range(poly_degree + 1):
        a = (r.T.dot(r)) / (p.T.dot(Q).dot(p))
        # a.shape = (1,1)
        r_prev = r
        w = w + a * p
        # w.shape = (10, 1)
        r = r - (a * Q).dot(p)
        beta= (r.T.dot(r)) / (r_prev.T.dot(r_prev))
        # beta.shape = (1, 1)
        p = r + beta * p
    poly = np.poly1d(w[::-1].reshape(poly_degree + 1))
    print(poly)
    return poly

def plt_show(train_x, poly_fit, train_y):
    plot1 = plt.plot(train_x, train_y, 'o', label='data')
    real_x = np.linspace(0, 0.9, 50)
    # real_y = np.sin(real_x * 2 * np.pi)
    # fit_y = poly_fit(real_x)
    if poly_degree == 1:
        fit_y = poly_fit[1]*train_x+poly_fit[0]
    elif poly_degree == 2:
        fit_y = poly_fit[2]*train_x**2+poly_fit[1]*train_x+poly_fit[0]
        
    else:
        print('degree cant over 2' )
    fit_y = poly_fit[2]*train_x**2+poly_fit[1]*train_x+poly_fit[0]
    plot2 = plt.plot(train_x, fit_y, 'b', label='fit_result')
    # plot3 = plt.plot(real_x, real_y, 'r', label='real_data')
    plt.xlabel('x')
    plt.ylabel('y')
    plt.legend(loc=0)
    plt.title('Fletcher-Reeves method best-fit, %d -order result' % poly_degree)
    plt.show()
    
    
train_x, train_y = genData(0, 0.1)
print(genMatrixX(train_x).T.dot(genMatrixX(train_x)))
# # numpy.polyfit直接拟合
# p1 = np_polyfit(train_x, train_y)
# plt_show(train_x, p1, train_y, 'np.polyfit result')
# print(p1)

# # 不加惩罚项，导数=0
# p2 = lsm_loss(train_x, train_y)
# plt_show(train_x, p2, train_y, 'lsm without punishment result')
# print(p2)

# # 加惩罚项，导数=0
# lam1 = 0.0005
# p3 = lsm_punished_loss(train_x, train_y, lam1)
# plt_show(train_x, p3, train_y, 'lsm with punishment result')
# print(p3)

# # 加惩罚项，梯度下降求loss最小值
# lam2 = 0.0001
# eta1 = 0.05
# epoch1 = 1000000
# eps1 = 1e-5
# p4, epoch_list, loss_list = descent_gradient(train_x, train_y, lam2, epoch1, eta1, eps1)
# plt_show(train_x, p4, train_y, 'lsm with punishment by descent gradient result')
# print(p4)
# # 输出loss图像
# plt.plot(epoch_list, loss_list, 'r')
# plt.xlabel('x')
# plt.ylabel('y')
# plt.title('E(w) loss in descent gradient')
# plt.show()

# 加惩罚项，共轭梯度法
lam3 = 0.0005
eps2 = 1e-5
p = conjugate_gradient(train_x, train_y, lam3, eps2)
plt_show(train_x, p, train_y)
print(p)  
