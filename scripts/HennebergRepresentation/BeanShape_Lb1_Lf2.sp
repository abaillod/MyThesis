&physicslist
 Igeometry   =         3
 Istellsym   =         1
 Lfreebound  =         0
 Lboundary   =         1
 twoalpha    =         0
 phiedge     =   2.000000000000000E+00
 curtor      =   1.038123580200000E-09
 curpol      =   0.000000000000000E+00
 gamma       =   0.000000000000000E+00
 Nfp         =         1
 Nvol        =         2
 Mpol        =         6
 Ntor        =         2
 Lrad        =                       12                    12
 tflux       =   3.033538489388870E-01  1.000000000000000E+00
 pflux       =   0.000000000000000E+00 -2.040878894181875E-01
 helicity    =   2.036396095021530E-02  1.559429589793997E-03
 pscale      =   1.000000000000000E-03
 Ladiabatic  =         0
 pressure    =   1.000000000000000E+00  0.000000000000000E+00
 adiabatic   =   1.000000000000000E+00  0.000000000000000E+00
 mu          =  -2.429942657520279E-04 -1.606028675492643E-04
 Lconstraint =         1
 pl          =                       0                      0                      0
 ql          =                       0                      0                      0
 pr          =                       0                      0                      0
 qr          =                       0                      0                      0
 iota        =   0.000000000000000E+00  2.809417939338480E-01  3.050000000000000E-01
 lp          =                       0                      0                      0
 lq          =                       0                      0                      0
 rp          =                       0                      0                      0
 rq          =                       0                      0                      0
 oita        =   0.000000000000000E+00  2.809417939338480E-01  3.050000000000000E-01
 mupftol     =   1.000000000000000E-12
 mupfits     =       128
 Rac         =   1.984000000000000E+00  0.000000000000000E+00  0.000000000000000E+00  0.000000000000000E+00  0.000000000000000E+00
 Zas         =   0.000000000000000E+00  0.000000000000000E+00  0.000000000000000E+00  0.000000000000000E+00  0.000000000000000E+00
 Ras         =   0.000000000000000E+00  0.000000000000000E+00  0.000000000000000E+00  0.000000000000000E+00  0.000000000000000E+00
 Zac         =   0.000000000000000E+00  0.000000000000000E+00  0.000000000000000E+00  0.000000000000000E+00  0.000000000000000E+00
R0c(0) =  1.816
bn(0)  = -1.419
rhomn(0,1) = 1.184
rhomn(0,2) = 0.208
rhomn(0,3) = -0.143
rhomn(0,4) = 0.064
rhomn(0,5) = -0.032
rhomn(0,6) = 0.011
/
&numericlist
 Linitialize =         1
 Ndiscrete   =         2
 Nquad       =        -1
 iMpol       =        -4
 iNtor       =        -4
 Lsparse     =         0
 Lsvdiota    =         0
 imethod     =         3
 iorder      =         2
 iprecon     =         1
 iotatol     =  -1.000000000000000E+00
 Lrzaxis     =         3
/
&locallist
 LBeltrami   =         4
 Linitgues   =         1
 Lmatsolver  =         1
/
&globallist
 Lfindzero   =         2
 escale      =   0.000000000000000E+00
 pcondense   =   4.000000000000000E+00
 forcetol    =   1.000000000000000E-12
 c05xtol     =   1.000000000000000E-12
 c05factor   =   1.000000000000000E-04
 LreadGF     =         F
 opsilon     =   1.000000000000000E+00
 epsilon     =   1.000000000000000E+00
 upsilon     =   1.000000000000000E+00
/
&diagnosticslist
 odetol      =   1.000000000000000E-07
 absreq      =   1.000000000000000E-08
 relreq      =   1.000000000000000E-08
 absacc      =   1.000000000000000E-04
 epsr        =   1.000000000000000E-08
 nPpts       =         500
 nPtrj       =    20 20
 Ppts        =       1
 LHevalues   =         F
 LHevectors  =         F
/
&screenlist
 Wpp00aa = T
/
