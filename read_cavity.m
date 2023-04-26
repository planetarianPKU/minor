clear
load mine_sensor_coord_and_vel_model.mat
ind = 1:length(rec_pos);
ind = ind';
name = [];
NET = [];
for i = 1:length(ind)
    name = [name;num2str(ind(i),'%03d')];
    NET = [NET; 'SUN'];

end
z = 150+round(rec_pos(:,3),10)-min(round(rec_pos(:,3),10));
T = table(NET,name,round(rec_pos(:,2),10),round(rec_pos(:,1),10),z,z);
writetable(T,'C:\Users\16000\Desktop\cavity\STATIONS','delimiter','tab');