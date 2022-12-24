

d1 = read_spec('QI_Nfp1_Nvol1.sp.h5');

nm = SPEC_Namelist('QI_Nfp1_Nvol2.sp');
d2 = read_spec('QI_Nfp1_Nvol2.sp.h5');
d2hr = read_spec('QI_Nfp1_Nvol2_HR.sp.h5');

%% 3d boundary
plot_spec_modB_boundary(d1, 1, 0, 64, 64, 3)
set(gcf,'Position',[200 200 900 800])
set(gcf,'Color','w')
ax = gca;
ax.Title.Visible='off';

%% vacuum field and initial guess
c = EPFL_colors;
nzarr = [1,12,24,36,48,60,72,84,96];

ii=0;
for nz=nzarr
    ii=ii+1;
    plot_spec_poincare(d1,nz,1,1)

    Ntor = double(d1.input.physics.Ntor);
    Ndiscrete = double(d1.input.numerics.Ndiscrete);
    Nplan     = max(Ndiscrete*4*Ntor, 1);
    zeta      = 2*pi*(nz-1) / (Nplan);

    nm.plot_initial_guess(1024,zeta,0,'Color',c.Leman,'LineWidth',4)
    title(sprintf('(%i) $%s=%2.2f$',ii,'\zeta',zeta), 'Fontsize', 18, 'Interpreter', 'latex')
    ax=gca;
    ax.Children(1).Visible='off';
end


%% force scalar
figure('Position',[200 200 900 700],'Color','w')
plot(log10(d2.iterations.ForceErr),'LineWidth',2,'Color',c.SwissRed)
hold on
plot(log10(d2hr.iterations.ForceErr),'LineWidth',2,'Color',c.Leman)
set(gca,'FontSize',20)
xlabel('$N_{eval}$','Interpreter','latex')
ylabel('$|f|$', 'Interpreter','latex')
xlim([0,42])
ax=gca;
ax.XTick=0:10:40;
ax.YTick=-4:1:0;
for ii=1:5
    ax.YTickLabel{ii}=sprintf('$10^{%i}$',-5+ii);
end
ax.TickLabelInterpreter='latex';
legend({'$M_{pol}=8,N_{tor}=6$', '$M_{pol}=8,N_{tor}=10$'}, 'Interpreter', 'latex')

%% force residual

nt = 128;
nz = 128;

tarr = linspace(0,2*pi,nt+1);
zarr = linspace(0,2*pi,nz+1);
tarr=tarr(1:end-1);
zarr=zarr(1:end-1);

Bsquare = zeros(nt,nz,2);
for innout = [0,1]
   if innout==0
       lvol=1;
       sarr=1;
   else
       lvol=2;
       sarr=-1;
   end
   
   modB = squeeze(get_spec_modB(d2, lvol, sarr, tarr, zarr));
   
   Bsquare(:,:,innout+1) = modB.*modB;
    
end

freal = Bsquare(:,:,2) - Bsquare(:,:,1);

[zgrid,tgrid]=meshgrid(zarr,tarr);
figure
pcolor(tgrid,zgrid,log10(abs(freal)))
shading interp
colorbar

set(gcf,'Color','w')
set(gcf,'Position',[200 200 900 800])
set(gca,'FontSize',20)
fig = gcf;
fig.Children(1).Label.String='$[[B^2]]$';
fig.Children(1).Label.Interpreter='latex';
fig.Children(1).Label.Rotation=pi/2;
fig.Children(1).Ticks=-5:1:0;
xlabel('$\theta$','Interpreter','latex')
ylabel('$\zeta$','Interpreter','latex')



%% force in fourier space

% Fourier transform
mpol = double(2*d.input.physics.Mpol + 1);
ntor = double(2*d.input.physics.Ntor + 1);

nmn = ntor+1+mpol*(2*ntor+1);
fimag = zeros(2*ntor+1,mpol+1);
for mm = 0:mpol
    for nn = -ntor:ntor
        if mm==0 && nn<0
            continue
        end
        
        arg = mm*tgrid-nn*zgrid;
        fimag(nn+ntor+1,mm+1) = trapz(zarr, trapz(tarr, freal, 1)*cos(arg)) / 2*pi^2;
    end
end

fimag(1:ntor,1) = flip(fimag(ntor+2:2*ntor+1,1));

fimag(ntor+1,1) = fimag(ntor+1,1) / 2.0;

figure
pcolor(log10(abs(fimag)))
colorbar
ax=gca;
ax.YTick=[1,8,ntor+1,20,2*ntor+1];
for ii=1:5
    ax.YTickLabel{ii} = num2str(str2num(ax.YTickLabel{ii}) - ntor - 1);
end
ax.XTick=[1,6,12,18];
for ii=1:4
    ax.XTickLabel{ii} = num2str(str2num(ax.XTickLabel{ii}) - 1);
end
shading interp
set(gcf,'Color','w')
set(gcf,'Position',[200 200 900 800])
set(gca,'FontSize',20)
fig = gcf;
fig.Children(1).Label.String='$F^{ph}_{mn}$';
fig.Children(1).Label.Interpreter='latex';
fig.Children(1).Label.Rotation=pi/2;
fig.Children(1).Ticks=-2:1:2;
for ii=1:4
    fig.Children(1).TickLabels{ii}=sprintf('$10^{%i}$',-3+ii);
end
fig.Children(1).TickLabelInterpreter='latex';
xlabel('$m$','Interpreter','latex')
ylabel('$n$','Interpreter','latex')



%% Poincare
plot_spec_poincare(d2,1,1,1)
nm.plot_initial_guess(1024,0,0,'Color',c.Leman,'LineWidth',4,'LineStyle','--')
plot_spec_kam(d2,1,0)
set(gca,'FontSize',18)