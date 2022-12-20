import standard_map
import numpy as np
import matplotlib.pyplot as plt


std_map = standard_map.standard_map(
    x0=np.append(np.zeros((100,)), np.ones((100,))),
    y0=np.append(np.linspace(0,2,100), np.linspace(0,2,100)),
    k=.5,
    niter=4000
)


fig, ax = plt.subplots(2,2,figsize=(10,8))

std_map.k = 0.0
std_map.evaluate_map(nfp=2)
for ii in range(0,std_map.npts):
    ax[0,0].scatter(std_map.x[ii,:]-1,std_map.y[ii,:]-1,s=.05,marker='.')
    ax[0,0].set_title('k=0.0')

std_map.k = 0.3
std_map.evaluate_map(nfp=2)
for ii in range(0,std_map.npts):
    ax[0,1].scatter(std_map.x[ii,:]-1,std_map.y[ii,:]-1,s=.05,marker='.')
    ax[0,1].set_title('k=0.3')

std_map.k = 0.9
std_map.evaluate_map(nfp=2)
for ii in range(0,std_map.npts):
    ax[1,0].scatter(std_map.x[ii,:]-1,std_map.y[ii,:]-1,s=.05,marker='.')
    ax[1,0].set_title('k=0.9')

std_map.k = 1.3 
std_map.evaluate_map(nfp=2)
for ii in range(0,std_map.npts):
    ax[1,1].scatter(std_map.x[ii,:]-1,std_map.y[ii,:]-1,s=.05,marker='.')
    ax[1,1].set_title('k=1.3')

for el in np.reshape(ax,(1,4))[0]:
    el.set_xlabel('x',fontsize=18)
    el.set_ylabel('y',fontsize=18)
    el.set_xticks([-1,-.5,0,.5,1])
    el.set_yticks([-1,-.5,0,.5,1])

plt.tight_layout()
plt.show()

