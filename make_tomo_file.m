xx_use = [];
yy_use = [];
zz_use = [];
vp_use = [];
vs_use = [];
rho_use = [];

for i = 1:size(xx,3)
x = xx(:,:,i);
y = yy(:,:,i);
z = zz(:,:,i);
vp = vp_extent(:,:,i);
vs = vs_extent(:,:,i);
rho = rho_extent(:,:,i);
xx_use(:,:,i) = x';
yy_use(:,:,i) = y';
zz_use(:,:,i) = z';
vp_use(:,:,i) =vp';
vs_use(:,:,i) =vs';
rho_use(:,:,i) =rho';
end

x_line = reshape(xx_use,[],1);
y_line = reshape(yy_use,[],1);
z_line = reshape(zz_use,[],1)-1300;
vp_line = reshape(vp_use,[],1);
vs_line = reshape(vs_use,[],1);
rho_line = reshape(rho_use,[],1);
writematrix(round([x_line y_line z_line vp_line vs_line rho_line],10) ,'tomography_model_new.txt','delimiter','tab');



