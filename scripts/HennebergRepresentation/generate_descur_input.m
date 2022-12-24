d1 = read_spec('QI_Nfp1_Nvol1.sp.h5');
R = squeeze(d1.poincare.R(8,:,:));
Z = squeeze(d1.poincare.Z(8,:,:));
[nphi,~] = size(R);
phi = linspace(0,2*pi,nphi+1);
phi = phi(1:end-1);

ntor = double(d1.input.physics.Ntor);
mpol = double(d1.input.physics.Mpol);
Rmnax = d1.output.Rbc(1:ntor+1,1);
Zmnax = d1.output.Zbs(1:ntor+1,1);

Rax = zeros(1,nphi);
Zax = zeros(1,nphi);
for nn=0:ntor
    Rax = Rax + Rmnax(nn+1)*cos(nn*phi);
    Zax = Zax - Zmnax(nn+1)*sin(nn*phi);
end

s = fluxSurface( 1, mpol, ntor, 1 );
s = s.initialize_from_poincare( R, Z, phi, Rax, Zax );

