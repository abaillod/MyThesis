%% read spec output
%d = read_spec('QI_Nfp1_Nvol1.sp.h5');
d = read_spec('QH_Nvol1.sp.h5');
write = true;

%% select surface
isurf = 28;

R = squeeze(d.poincare.R(isurf,:,:));
Z = squeeze(d.poincare.Z(isurf,:,:));

[nphi,ntheta]=size(R);
if ntheta>800
    ntheta=800;
end
phi = linspace(0,2*pi,nphi+1);
phi = phi(1:end-1);

figure
plot_spec_poincare(d,1,1,0)
hold on;
scatter(R(1,:),Z(1,:))



%% write input
if write
    fileID = fopen('descur_input.txt','w');
    fprintf(fileID,'%12i %12i %12i\n',ntheta,nphi,1);
    for ii=1:nphi
        for jj=1:ntheta
            fprintf(fileID,'%12.8f %12.8f %12.8f\n',R(ii,jj),phi(ii),Z(ii,jj));
        end
    end
    fclose(fileID);
end



%% Read descur output
nfp=1;
norm=1;
[s,ax] = read_descur( 'outcurve', nfp, norm );


%% Compute toroidal flux in s

% % First, construct grid
% nr = 128;
% nz = 64;
% 
% % Construct grid
% Rmax = max(R(1,:));
% Zmax = max(Z(1,:));
% Rmin = min(R(1,:));
% Zmin = min(Z(1,:));
% 
% Rarr = linspace(Rmin, Rmax, nr);
% Zarr = linspace(Zmin, Zmax, nz);
% [Zgrid, Rgrid] = meshgrid(Zarr,Rarr);
% 
% sarr = zeros(nr,nz);
% tarr = zeros(nr,nz);
% 
% % Find corresponding s, theta coordinates in SPEC
% ir = 1; iz = 1;
% 
% lbnd = [-1,0];
% ubnd = [1,2*pi];
% 
% plot=true;
% x = [0,0];
% for ir = 1:nr
%     for iz = 1:nz
%         % Test if point is inside the surface
%         if ~inpolygon(Rarr(ir),Zarr(iz), R(1,:), Z(1,:))
%             continue
%         end
%         
%         if plot
%             figure
%             scatter(R(1,:),Z(1,:))
%             axis equal
%             hold on
%             scatter(Rarr(ir),Zarr(iz),80,'*')
%         end
%         x0 = x;
%         x = fmincon( @(x) distance(x,d,Rarr(ir),Zarr(iz),plot), x0, [], [], [], [], lbnd, ubnd );
%         sarr(ir,iz) = x(1);
%         tarr(ir,iz) = x(2);
%     end
% end

ns = 256;
nt = 512;
sarr = linspace(-1, 1,ns+1);
sarr = sarr(2:end);
tarr = linspace(0,2*pi,nt);
[tgrid,sgrid] = meshgrid(sarr,tarr);

% Evaluate R-Z coord
Rgrid = get_spec_R_derivatives( d, 1, sarr, tarr, 0, 'R' );
Zgrid = get_spec_R_derivatives( d, 1, sarr, tarr, 0, 'Z' );
Rgrid = squeeze(Rgrid{1});
Zgrid = squeeze(Zgrid{1});

% Evaluate sqrt B^phi
Bcontrav = get_spec_magfield(d, 1, sarr, tarr, 0);
sg = get_spec_jacobian(d, 1, sarr, tarr, 0);
integrand = Bcontrav{3}.*sg;

% Set integrand to zero if point not in surface
for is=1:ns
    for it=1:nt
        if ~inpolygon(Rgrid(is,it),Zgrid(is,it), R(1,:), Z(1,:))
            integrand(is,it) = 0.0;
        end
    end
end

% Integrate
tflux = trapz(sarr,trapz(tarr,integrand,2));

%% Create input file
%nm = SPEC_Namelist('QI_Nfp1_Nvol2.sp');
nm = SPEC_Namelist('QH_Nvol2.sp');

fl = nm.physicslist.tflux;
pe = nm.physicslist.phiedge;
nm.physicslist.tflux(1)=tflux * fl(2) / pe;

% Set initial guess
nm = nm.set_harmonics_to_zero( 'ric' );
nm = nm.set_harmonics_to_zero( 'ris' );
nm = nm.set_harmonics_to_zero( 'zic' );
nm = nm.set_harmonics_to_zero( 'zis' );
for imn=1:s.nmn
   mm = s.im(imn);
   nn = s.in(imn);
   nm = nm.set_fourier_harmonics( 'ric', mm, nn, s.rmnc(imn), 1 );
   nm = nm.set_fourier_harmonics( 'zis', mm, nn, s.zmns(imn), 1 );
   nm = nm.set_fourier_harmonics( 'ris', mm, nn, 0.0, 1 );
   nm = nm.set_fourier_harmonics( 'zic', mm, nn, 0.0, 1 );
   nm = nm.set_fourier_harmonics( 'ric', mm, nn, nm.get_fourier_harmonics('rbc',mm,nn), 2 );
   nm = nm.set_fourier_harmonics( 'zis', mm, nn, nm.get_fourier_harmonics('zbs',mm,nn), 2 );
   nm = nm.set_fourier_harmonics( 'ris', mm, nn, 0.0, 2 );
   nm = nm.set_fourier_harmonics( 'zic', mm, nn, 0.0, 2 );
end

% Set axis
nm.physicslist.rac = ax.r;
nm.physicslist.zas = ax.z;

% write input file
nm.write_input_file( 'QI_Nvol2_DescurInput.sp' )



%% checks...

ind = intersect(find(s.im==0), find(s.in==0));
s.im(ind)
s.in(ind)
s.rmnc(ind)






