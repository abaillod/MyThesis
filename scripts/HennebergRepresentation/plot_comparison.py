import py_spec
import matplotlib.pyplot as plt

plt.rcParams['text.usetex'] = True

ii = 1


bean = ii==1
torsion = ii==2
ellipse = ii==3
w7x = ii==4

ft = 20

# ==============================================================================
# Bean shape
if bean:
    dbs_lb0 = py_spec.SPECout('BeanShape_Lb0_Lf2.sp.h5')
    dbs_lb1 = py_spec.SPECout('BeanShape_Lb1_Lf2.sp.h5')
    
    fig,ax = plt.subplots(1,3,figsize=(12,4))
    dbs_lb0.plot_poincare(ax=ax[0],prange='upper',facecolor='k')
    dbs_lb1.plot_poincare(ax=ax[0],prange='lower',facecolor='k')
    dbs_lb0.plot_kam_surface(ax=ax[0])
    dbs_lb1.plot_kam_surface(ax=ax[0],c='b')
    ax[0].set_xlim((0.25,3.4))
    ax[0].set_xlabel(r'$R$[m]',fontsize=ft)
    ax[0].set_ylabel(r'$Z$[m]',fontsize=ft)
    ax[0].tick_params(axis='both', labelsize=ft)
    
    dbs_lb1.plot_iota(ax=ax[1],marker='x')
    dbs_lb0.plot_iota(ax=ax[1],marker='o',facecolor='none',edgecolor='r')
    ax[1].set_ylim((0.25,0.4))
    ax[1].set_xlabel(r'$R$[m]',fontsize=ft)
    ax[1].set_ylabel(r'$\iota$',fontsize=ft+2)
    ax[1].tick_params(axis='both', labelsize=ft)
    
    
    ax[2].plot(dbs_lb0.iterations['ForceErr'],c='r')
    ax[2].plot(dbs_lb1.iterations['ForceErr'],c='b')
    ax[2].set_yscale('log')
    ax[2].set_xlabel(r'$N_{eval}$', fontsize=ft)
    ax[2].set_ylabel(r'$|f|$', fontsize=ft)
    ax[2].tick_params(axis='both', labelsize=ft)

# ==============================================================================
# Circular cross section with torsion
if torsion:
    dbs_lb0 = py_spec.SPECout('TokamakTorsion_Lb0_Lf2.sp.h5')
    dbs_lb1 = py_spec.SPECout('TokamakTorsion_Lb1_Lf2.sp.h5')
    
    fig,ax = plt.subplots(1,3,figsize=(12,4))
    dbs_lb1.plot_poincare(ax=ax[0],facecolor='k')
    dbs_lb0.plot_kam_surface(ax=ax[0])
    dbs_lb1.plot_kam_surface(ax=ax[0],c='b')
    ax[0].set_xlabel(r'$R$[m]', fontsize=ft)
    ax[0].set_ylabel(r'$Z$[m]', fontsize=ft)
    ax[0].set_xlim((9.5,12.5))
    ax[0].tick_params(axis='both', labelsize=ft)
    
    dbs_lb1.plot_iota(ax=ax[1],marker='x')
    dbs_lb0.plot_iota(ax=ax[1],marker='o',facecolor='none',edgecolor='r')
    ax[1].set_ylim((3,5.5))
    ax[1].set_xlabel(r'$R$[m]', fontsize=ft)
    ax[1].set_ylabel(r'$\iota$',fontsize=ft+2)
    ax[1].tick_params(axis='both', labelsize=ft)
    
    
    ax[2].plot(dbs_lb1.iterations['ForceErr'],c='b')
    ax[2].plot(dbs_lb0.iterations['ForceErr'],c='r')
    ax[2].set_yscale('log')
    ax[2].set_xlabel(r'$N_{eval}$', fontsize=ft)
    ax[2].set_ylabel(r'$|f|$', fontsize=ft)
    ax[2].tick_params(axis='both', labelsize=ft)

if ellipse:
    dbs_lb0 = py_spec.SPECout('RotatingEllipse_Lb0_Lf2.sp.h5')
    dbs_lb1 = py_spec.SPECout('RotatingEllipse_Lb1_Lf2.sp.h5')
    
    fig,ax = plt.subplots(1,3,figsize=(8,8))
    dbs_lb0.plot_poincare(ax=ax[0],prange='upper',facecolor='k')
    dbs_lb1.plot_poincare(ax=ax[0],prange='lower',facecolor='k')
    dbs_lb0.plot_kam_surface(ax=ax[0])
    dbs_lb1.plot_kam_surface(ax=ax[0],c='b')
    ax[0].set_xlabel(r'$R$[m]', fontsize=ft)
    ax[0].set_ylabel(r'$Z$[m]', fontsize=ft)
    ax[0].set_xlim((8.25,11.75))
    ax[0].tick_params(axis='both', labelsize=ft)
 
    dbs_lb1.plot_iota(ax=ax[1],marker='x')
    dbs_lb0.plot_iota(ax=ax[1],marker='o',facecolor='none',edgecolor='r')
    #ax[1].set_ylim((3,5.5))
    ax[1].set_xlabel(r'$R$[m]', fontsize=ft)
    ax[1].set_ylabel(r'$\iota$',fontsize=ft+2)
    ax[1].tick_params(axis='both', labelsize=ft)
    
    
    ax[2].plot(dbs_lb1.iterations['ForceErr'],c='b')
    ax[2].plot(dbs_lb0.iterations['ForceErr'],c='r')
    ax[2].set_yscale('log')
    ax[2].set_xlabel(r'$N_{eval}$', fontsize=ft)
    ax[2].set_ylabel(r'$|f|$', fontsize=ft)
    ax[2].tick_params(axis='both', labelsize=ft)

if w7x:
    import numpy as np
    dbs_lb0 = py_spec.SPECout('W7X_Nvol2_Lb0_Lf2.sp.h5')
    dbs_lb1 = py_spec.SPECout('W7X_Nvol2_Lb1_Lf2.sp.h5')
    
    fig,ax = plt.subplots(2,2,figsize=(10,8))
    dbs_lb0.plot_poincare(ax=ax[0,0],prange='upper',facecolor='k')
    dbs_lb1.plot_poincare(ax=ax[0,0],prange='lower',facecolor='k')
    dbs_lb0.plot_kam_surface(ax=ax[0,0])
    dbs_lb1.plot_kam_surface(ax=ax[0,0],c='b')
    ax[0,0].set_xlabel(r'$R$[m]', fontsize=ft)
    ax[0,0].set_ylabel(r'$Z$[m]', fontsize=ft)
    ax[0,0].set_xlim((5.5,6.3))
    ax[0,0].tick_params(axis='both', labelsize=ft)
 
    dbs_lb0.plot_poincare(ax=ax[0,1],toroidalIdx=24,prange='upper',facecolor='k')
    dbs_lb1.plot_poincare(ax=ax[0,1],toroidalIdx=48,prange='lower',facecolor='k')
    dbs_lb0.plot_kam_surface(ax=ax[0,1],zeta=np.pi/5)
    dbs_lb1.plot_kam_surface(ax=ax[0,1],zeta=np.pi/5,c='b')
    ax[0,1].set_xlabel(r'$R$[m]', fontsize=ft)
    ax[0,1].set_ylabel(r'$Z$[m]', fontsize=ft)
    ax[0,1].set_xlim((4.6,6))
    ax[0,1].tick_params(axis='both', labelsize=ft)
    
    dbs_lb1.plot_iota(ax=ax[1,0],marker='x')
    dbs_lb0.plot_iota(ax=ax[1,0],marker='o',facecolor='none',edgecolor='r')
    ax[1,0].set_ylim((-1,-0.6))
    ax[1,0].set_xlabel(r'$R$[m]', fontsize=ft)
    ax[1,0].set_ylabel(r'$\iota$',fontsize=ft+2)
    ax[1,0].tick_params(axis='both', labelsize=ft)
    
    
    ax[1,1].plot(dbs_lb1.iterations['ForceErr'],c='b')
    ax[1,1].plot(dbs_lb0.iterations['ForceErr'],c='r')
    ax[1,1].set_yscale('log')
    ax[1,1].set_xlabel(r'$N_{eval}$', fontsize=ft)
    ax[1,1].set_ylabel(r'$|f|$', fontsize=ft)
    ax[1,1].tick_params(axis='both', labelsize=ft)




plt.tight_layout()
plt.show()


