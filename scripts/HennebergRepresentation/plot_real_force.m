d = read_spec('QI_Nvol2_DescurInput.sp.h5');

nt = 128;
nz = 64;

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
   
   modB = squeeze(get_spec_modB(d, lvol, sarr, tarr, zarr));
   
   Bsquare(:,:,innout+1) = modB.*modB;
    
end



freal = Bsquare(:,:,2) - Bsquare(:,:,1);

[zgrid,tgrid]=meshgrid(zarr,tarr);
figure
pcolor(tgrid,zgrid,log10(abs(freal)))
colorbar




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
        fimag(nn+ntor+1,mm+1) = trapz(zarr, trapz(tarr, freal, 1)) / 2*pi^2;
    end
end

fimag(ntor+1,1) = fimag(ntor+1,1) / 2.0;

figure
pcolor(fimag)
colorbar