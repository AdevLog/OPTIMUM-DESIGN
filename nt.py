from __future__ import division
import numpy as np
import matplotlib.pyplot as plt

# Newton's Method
def newton_method(data, degree):
    AT = np.ones(data.shape[0])
    n=data.shape[0]
    theta = np.zeros(1)
    for d in range(1, degree + 1):
        AT = np.vstack((data[:, 0]**d, AT))
        h=np.dot(data[:, 0],0)
        # print("h-shape",h.shape)
        j_first_order=1/n*np.dot(data[:, 0].T,h-data[:, 1])#(m,1)
        j_second_order=1/n*np.dot(np.dot(np.dot(data[:, 0].T,np.diag(h.reshape(n))),np.diag(1-h.reshape(n))),data[:, 0])#(m,m)
        b=data-np.dot(j_second_order,j_first_order)
    A = np.transpose(AT)
    ATAinv = np.linalg.inv(np.dot(AT, A))
    b = data[:, 1]
    a = np.dot(np.dot(ATAinv, AT), b)
    return a

# graphs data and model
def graphFit(data, a, extra=0):
    degree = a.size - 1
    plot1 = plt.plot(data[:, 0], data[:, 1], 'o', label='data')
    x = np.linspace(np.amax(data, axis=0)[0] + extra,
                    np.amin(data, axis=0)[0] - extra, 100)
    yp = a[degree]
    for d in range(degree):
        yp += a[d]*(x**(degree - d))
    plot2 = plt.plot(x, yp, 'b', label='fit_result')
    plt.xlabel('x')
    plt.ylabel('y')
    plt.legend(loc=0)
    plt.title('Newton method best-fit, %d -order result' % degree)
    plt.show()
    
poly_degree = int(input("Enter a degree: "))

# initializes data matrix
m = np.array([[0.1, 20],
      [0.9, 24],
      [1.9, 27],
      [2.3, 29],
      [3, 32],
      [4.1, 37.3],
      [5.2,  36.4],
      [5.9, 32.4],
      [6.8, 28.5],
      [8.1, 30],
      [8.7, 38],
      [9.2, 43],
      [10.1, 40],
      [12, 32]])

a = newton_method(m, poly_degree)
print (a)
graphFit(m, a)