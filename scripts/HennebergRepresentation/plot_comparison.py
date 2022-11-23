import py_spec
import matplotlib.pyplot as plt

plt.rcParams['text.usetex'] = True

# ==============================================================================
# Bean shape
dbs_lb0 = py_spec.SPECout('BeanShape_Lb0_Lf2.sp.h5')
dbs_lb1 = py_spec.SPECout('BeanShape_Lb1_Lf2.sp.h5')

fig,ax = plt.subplots(1,3,figsize=(12,4))
dbs_lb0.plot_poincare(ax=ax[0],prange='upper',facecolor='k')
dbs_lb1.plot_poincare(ax=ax[0],prange='lower',facecolor='k')
dbs_lb0.plot_kam_surface(ax=ax[0])
dbs_lb1.plot_kam_surface(ax=ax[0],c='b')
ax[0].set_xlabel(r'$R$[m]')
ax[0].set_ylabel(r'$Z$[m]')

dbs_lb0.plot_iota(ax=ax[1],marker='x')
dbs_lb1.plot_iota(ax=ax[1],marker='o',facecolor='none',edgecolor='r')
ax[1].set_ylim((0.25,0.4))
ax[1].set_xlabel(r'$R$[m]')


ax[2].plot(dbs_lb0.iterations['ForceErr'],c='b')
ax[2].plot(dbs_lb1.iterations['ForceErr'],c='r')
ax[2].set_yscale('log')
ax[2].set_xlabel(r'$N_{eval}$')
ax[2].set_ylabel(r'$|f|$')


# ==============================================================================
# Circular cross section with torsion
dbs_lb0 = py_spec.SPECout('TokamakTorsion_Lb0_Lf2.sp.h5')
dbs_lb1 = py_spec.SPECout('TokamakTorsion_Lb1_Lf2.sp.h5')

fig,ax = plt.subplots(1,3,figsize=(12,4))
dbs_lb0.plot_poincare(ax=ax[0],prange='upper',facecolor='k')
dbs_lb1.plot_poincare(ax=ax[0],prange='lower',facecolor='k')
dbs_lb0.plot_kam_surface(ax=ax[0])
dbs_lb1.plot_kam_surface(ax=ax[0],c='b')
ax[0].set_xlabel(r'$R$[m]')
ax[0].set_ylabel(r'$Z$[m]')
ax[0].set_xlim((9.5,12.5))

dbs_lb0.plot_iota(ax=ax[1],marker='x')
dbs_lb1.plot_iota(ax=ax[1],marker='o',facecolor='none',edgecolor='r')
ax[1].set_ylim((3,5.5))
ax[1].set_xlabel(r'$R$[m]')


ax[2].plot(dbs_lb0.iterations['ForceErr'],c='b')
ax[2].plot(dbs_lb1.iterations['ForceErr'],c='r')
ax[2].set_yscale('log')
ax[2].set_xlabel(r'$N_{eval}$')
ax[2].set_ylabel(r'$|f|$')





plt.tight_layout()
plt.show()


