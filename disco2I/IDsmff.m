%**********************************************************************
delete('loadincr.m');delete('savedata.m');delete('updaelda.m'); 

g  = 9.81;

crd0   = [ 0 0; 0 1 ];
eldata = [ 1 2 0 0 1 ];
pp     = [ 1 1 0; 1 2 0 ];
map    = [ 2 ];
maw    = [ 0.45 ];    % gewicht golfbal = 45 gram
pf     = [ 2 2 -g*maw ];

Gf = 40*pi/180;
v0 = 50; 
te = (2*v0/g)*sin(Gf);

nic = 100;   
mit = 1;
ccr = 1e-3;
ts  = te/nic;  
im  = 6;
Ga  = 0.25;  
Gd  = 0.5;   
nl  = 0;


loin=fopen('loadincr.m','w');
fprintf(loin,'peC = pe0; \n');
fprintf(loin,'fec = fe0; \n');

% launch the mass with initial velocity

fprintf(loin,'co = cos(Gf); si = sin(Gf); \n');
fprintf(loin,'if ic==1, Tdpt=[0 0 v0*co v0*si]''; end; \n');

%fprintf(loin,'fe = fe0 + (-1e-2*Tdp''*Tdp)*fe0; \n');
fclose(loin);

s1 = 'crd';
sada=fopen('savedata.m','w');
fprintf(sada,'save(savefile,s1); \n');
fprintf(sada,'tim(ic+1)=ti; \n');
fprintf(sada,'ux2(ic+1)=MTp(2,1); \n');
fprintf(sada,'uy2(ic+1)=MTp(2,2); \n');
fprintf(sada,'vx2(ic+1)=MTdp(2,1); \n');
fprintf(sada,'vy2(ic+1)=MTdp(2,2); \n');
fprintf(sada,'ay2(ic+1)=MTddp(2,2); \n');
fprintf(sada,'fy2(ic+1)=Mfi(2,2); \n');
fprintf(sada,'ky2(ic+1)=Mfe(2,2); \n');
fprintf(sada,'Axx(ic+1)=v0*ti*co; \n');
fprintf(sada,'Ayy(ic+1)=-g/2*ti*ti+v0*ti*si; \n');
fprintf(sada,'ADx(ic+1)=v0*co; \n');
fprintf(sada,'ADy(ic+1)=-g*ti+v0*si; \n');
fclose(sada);

%**********************************************************************
