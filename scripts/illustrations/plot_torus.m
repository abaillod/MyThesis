
nt = 32;
nz = 64;

tarr = linspace(0,2*pi,nt);
zarr = linspace(0,3*pi/2,nz);

[zgrid, tgrid] = meshgrid(zarr, tarr);


R = ones(nt,nz) + 0.75*cos(tgrid);
Z = zeros(nt,nz) + 0.75*sin(tgrid);
x = R.*cos(zgrid);
y = R.*sin(zgrid);
C = 10*ones(nt,nz);

mesh(x,y,Z,C)
hold on

% poloidal circle
zarr = zeros(size(tarr));

R = ones(1,nt) + 0.85*cos(tarr);
Z = zeros(1,nt) + 0.85*sin(tarr);
x = R;
y = R*0;

plot3(x,y,Z,'r','LineWidth',2.3)


% toroidal circle
zarr = linspace(0,2*pi,nz);
tarr = zeros(size(zarr));

R = ones(1,nz) + 0.8;
Z = zeros(1,nz);
x = R.*cos(zarr);
y = R.*sin(zarr);

plot3(x,y,Z,'k','LineWidth',2.3)


axis equal
ax = gca;
set(gcf,'Color','w')
ax.Visible='off';