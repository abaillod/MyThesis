
nt = 64;
nz = 64;

tarr = linspace(0,2*pi,nt);
zarr = linspace(pi/10,8*pi/5,nz);

[zgrid, tgrid] = meshgrid(zarr, tarr);


R = 3*ones(nt,nz) + 0.75*cos(tgrid) + 0.15*cos(tgrid-5*zgrid);
Z = zeros(nt,nz) + 0.75*sin(tgrid) - 0.15*sin(tgrid-5*zgrid);
x = R.*cos(zgrid);
y = R.*sin(zgrid);
C = 10*ones(nt,nz);

mesh(x,y,Z,C)
hold on


% Add white surface on plane y=0
M = makehgtform('xrotate',pi/2);
G = makehgtform('zrotate',pi/10);
t = hgtransform('Matrix', G*M);

pshape = polyshape(sqrt(x(:,1).^2+y(:,1).^2), Z(:,1));
c = EPFL_colors;
plot(pshape, 'Parent', t, 'FaceColor', 'w', 'FaceAlpha', .9, 'EdgeColor', c.Leman )
%plot(pshape, 'FaceColor', 'r' )

% Add axis
phi = linspace(0,2*pi,nz);
x = 3*cos(phi);
y = 3*sin(phi);
z = zeros(1, nz);
plot3(x,y,z, 'LineWidth', 2.5, 'Color', c.SwissRed)


axis equal
ax = gca;
set(gcf,'Color','w')
ax.Visible='off';


figure
plot(pshape, 'FaceColor', 'w', 'FaceAlpha', .9, 'EdgeColor', c.Leman )
hold on
scatter(3,0,'o','MarkerFaceColor',c.SwissRed, 'MarkerEdgeColor', c.SwissRed)
set(gcf,'Color','w')
set(gca,'Visible','off')
