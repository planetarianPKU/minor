
clear all
load mine_sensor_coord_and_vel_model.mat

xmin = min(min(min( tomo_xx)));
xmax = max(max(max( tomo_xx )));

ymin = min(min(min( tomo_yy)));
ymax = max(max(max( tomo_yy )));

zmin = min(min(min( tomo_zz)));
zmax = max(max(max( tomo_zz )));

tomo_vp = tomo_vv;
tomo_vs = tomo_vv / 1.73;
tomo_rho = tomo_vv / 2.18;


dz = 50;

x = xmin:dz:xmax;
y = ymin:dz:ymax;
z = zmin:dz:zmax;

Nx = length(x);
Ny = length(y);
Nz = length(z);

 

 [xx_save, yy_save, zz_save] = meshgrid(x, y, z);
 
 dz_extent = 150;
 
 id1 = round( dz_extent / dz );
 id2 = Nz +  round( dz_extent / dz );
 
 Nz_new = Nz + 2 * round( dz_extent / dz );

 
 tomo_vp_interp = griddata(tomo_xx, tomo_yy, tomo_zz, tomo_vp,xx_save,yy_save,zz_save, 'natural');
 
 xx = zeros(Ny,Nx,Nz_new);
 yy = xx;
 zz = xx;
 
 vp_extent = xx;
 
 xx(:,:,id1+1:id2) = xx_save;
 yy(:,:,id1+1:id2) = yy_save;
 zz(:,:,id1+1:id2) = zz_save;
 
 vp_extent(:,:,id1+1:id2) = tomo_vp_interp;
 
 for k=[ 1:id1 id2+1:Nz_new ]
     
 xx(:,:,k) = xx_save(:,:,1);
 yy(:,:,k) = yy_save(:,:,1);
 zz(:,:,k) = zmin - dz_extent + (k-1) * dz;
 
 if ( k <= id1 )
    vp_extent(:,:,k) = tomo_vp_interp(:,:,1);
 elseif ( k >= id2 )
    vp_extent(:,:,k) = tomo_vp_interp(:,:,end);
 end
 
 end
 


       figure(1);clf;hold on
 
       maxA = max(max(max(abs(tomo_vp_interp))));
       minA = min(min(min(abs(tomo_vp_interp))));
       clims = [minA, maxA ];
       
 
       for k=1:Nz_new
           
%            allpos_total = [ reshape(xx_save(:,:,k),Nx*Ny,1)  reshape(yy_save(:,:,k),Nx*Ny,1)  reshape(zz_save(:,:,k),Nx*Ny,1) ];
%            allv_total = reshape(tomo_vp_interp(:,:,k),Nx*Ny,1);
           allpos_total = [ reshape(xx(:,:,k),Nx*Ny,1)  reshape(yy(:,:,k),Nx*Ny,1)  reshape(zz(:,:,k),Nx*Ny,1) ];
           allv_total = reshape(vp_extent(:,:,k),Nx*Ny,1);
           scatter3( allpos_total(:,1), allpos_total(:,2), allpos_total(:,3), 80*ones(numel(allv_total(:,1)),1 ), allv_total(:,1), 'filled', 'LineWidth', 14 );
           
       end
       
	   set(gca, 'CLim', clims );
       %set(gca,'YDir','reverse');
       xlabel( 'X axis (m)')
       ylabel( 'Y axis (m)')
       zlabel( 'Depth (m)' );
       axis equal tight ;
       colormap( jet ); %colormap( mycmap );
       colorbar
       
       title([ 'tomographic velocity model' ],'FontSize',22,'FontWeight','bold');
       
        vs_extent = vp_extent/sqrt(3);
        rho_extent = vp_extent/2.18;
       