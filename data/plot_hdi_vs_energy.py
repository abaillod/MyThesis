import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import matplotlib
import os

plt.rcParams['text.usetex'] = True
font = {'family' : 'normal',
        'weight' : 'bold',
        'size'   : 18}
matplotlib.rc('font', **font)

os.chdir('/Users/antoinebaillod/OneDrive/Studies/PhD/MyThesis/data')

xls = pd.ExcelFile('hdi_vs_energy.xlsx')
data_ea = pd.read_excel(xls, 'East Asia and Pacific')
data_ss = pd.read_excel(xls, 'Sub-Saharan Africa')
data_na = pd.read_excel(xls, 'North America')
data_eca = pd.read_excel(xls, 'Europe and central Asia')
data_la = pd.read_excel(xls, 'Latin america')
data_me = pd.read_excel(xls, 'Middle East and North Africa')
data_sa = pd.read_excel(xls, 'South Asia')

data = [data_ea, data_ss, data_na, data_eca, data_la, data_me, data_sa]
cc = ['#A2559C', '#8C4569', '#E56E5A', '#4C6A9C', '#883039', '#BC8E5A', '#578145']

fig, ax = plt.subplots()
for d, c in zip(data,cc):
    d = d.to_numpy()

    country = d[:,0]
    energy = np.array([float(f)*11.63 for f in d[:,1]])
    hdi = np.array([float(f) for f in d[:,3]])
    population = np.array([float(f) for f in d[:,2]])
    population = population / 1e9

    ax.scatter(np.log10(energy), hdi, population*1e3, c=c)

ax.set_xticks([3,4,5])
ax.set_xticklabels([r'$10^{3}$',r'$10^4$',r'$10^5$'])
ax.set_yticks(np.arange(0.4,1.1,0.1))
ax.set_ylabel('HDI')
ax.set_xlabel('kWh per inhabitant')


# France
ii = 12
data_eca = data_eca.to_numpy()
ax.annotate(data_eca[ii,0], xy=(np.log10(data_eca[ii,1]*11.63),
            data_eca[ii,3]),
            color='#4C6A9C',
            xytext=(3.75, 0.9),
            arrowprops={"arrowstyle":"-", "color":'#4C6A9C'},
            )

# Chine
ii = 2
data_ea = data_ea.to_numpy()
ax.annotate(data_ea[ii,0], xy=(np.log10(data_ea[ii,1]*11.63),
            data_ea[ii,3]),
            color='#A2559C',
            xytext=(5, 0.65),
            arrowprops={"arrowstyle":"-", "color":'#A2559C'},
            )

# Niger
ii = 13
data = data_ss.to_numpy()
ax.annotate(data[ii,0], xy=(np.log10(data[ii,1]*11.63),
            data[ii,3]),
            color='#8C4569',
            xytext=(3, 0.5),
            arrowprops={"arrowstyle":"-", "color":'#8C4569'},
            )

# Argentina
ii = 13
data = data_la.to_numpy()
ax.annotate(data[ii,0], xy=(np.log10(data[ii,1]*11.63),
            data[ii,3]),
            color='#883039',
            xytext=(3, 0.78),
            arrowprops={"arrowstyle":"-", "color":'#8C4569'},
            )

plt.tight_layout()
plt.show()