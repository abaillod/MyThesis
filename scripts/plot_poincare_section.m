d = read_spec('Vacuum.sp.h5');
nt = 64;
nz = 64;
phiend = 2*pi*2;
phistart = 0;
thetastart = -pi/2;
nstep = 1e4;
Nvol=2;

col = EPFL_colors;

% 3D plot
% Define coordinate arrays in real space
figure('Position', [200 200 900 700], 'Color', 'w')
sarr = 1;                       % We plot on the outermost surface, i.e. the plasma boundary
tarr = linspace(0,2*pi       ,nt);
zarr = linspace(0,2*pi ,nz);

R = get_spec_R_derivatives(d,Nvol,sarr,tarr,zarr,'R');
Z = get_spec_R_derivatives(d,Nvol,sarr,tarr,zarr,'Z');

R = squeeze(R{1});   
Z = squeeze(Z{1});


% Construct cartesian corrdinates 

X = zeros(nt,nz);
Y = zeros(nt,nz);

for it=1:nt
    for iz=1:nz
        X(it,iz) = R(it,iz)*cos(zarr(iz));
        Y(it,iz) = R(it,iz)*sin(zarr(iz));
    end
end


% Plot
s = size(X);
c = zeros(s(1), s(2), 3);
c(:,:,1) = 1;
p = mesh(X,Y,Z,c,'EdgeAlpha', 0.3, 'FaceAlpha', 0.7);
hold on

axis equal
shading interp

xlabel('X')
ylabel('Y')
zlabel('Z')
set(gca, 'FontSize', 18 )

% Field line
phi = phistart;
dstep = (phiend-phistart)/nstep;

tarr_out = zeros(1, nstep+1);
tarr_out(1) = thetastart;

for istep=1:nstep
   phi(istep+1) = phi(istep) + dstep;

   B = get_spec_magfield( d, Nvol, 1, tarr_out(1,istep), phi(istep) );

   Bt = reshape(B{2}, length(B{2}), 1);
   Bz = reshape(B{3}, length(B{2}), 1);

   tarr_out(1,istep+1) = tarr_out(1,istep) + Bt./Bz * dstep;

end

tend = tarr_out(end);

X = [];
Y = [];
Z = [];
for ii = 1:nstep
    Rd = get_spec_R_derivatives(d,Nvol,1,tarr_out(1,ii),phi(ii),'R');
    Zd = get_spec_R_derivatives(d,Nvol,1,tarr_out(1,ii),phi(ii),'Z');

    X(ii) = squeeze(Rd{1}) * cos(phi(ii));
    Y(ii) = squeeze(Rd{1}) * sin(phi(ii));
    Z(ii) = squeeze(Zd{1});
end

l = scatter3( X, Y, Z, 10, 'MarkerFaceColor', col.Leman, 'MarkerEdgeColor', col.Leman);


ax = gca;
ax.Visible='off';





% Poincare section
d = read_spec('/BIG_14TB/BetaScan/RotatingEllipse/Nfp5/BSmodel1_Pmodel1_Bz002/BetaScan_30/BetaScan_Bz002_run_18.sp.h5');
d.poincare.R = d.poincare.R(:,:,1:3000);
d.poincare.Z = d.poincare.Z(:,:,1:3000);
plot_spec_poincare(d,1,1,1)
xlim([8.7,11.5])
ax = gca;
ax.Visible = 'off';


for ii=1:6
    ax.Children(ii).Visible='off';
end


ax.Children(7).MarkerEdgeColor = col.Carotte;
ax.Children(7).SizeData = 50;

ax.Children(20).MarkerEdgeColor = col.SwissRed;
ax.Children(20).SizeData = 50;

ax.Children(44).MarkerEdgeColor = col.Leman;
ax.Children(44).SizeData = 30;