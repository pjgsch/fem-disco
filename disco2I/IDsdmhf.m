%**********************************************************************
clear all;
delete('loadincr.m');delete('savedata.m');delete('updaelda.m');

crd0   = [ 0 0; 1 0 ];
eldata = [ 1 2  1000 3 1 ];
pp     = [ 1 1 0 ; 1 2 0 ; 2 2 0 ];  
pf     = [ 2 1 10 ];
map    = [ 2 ];   
maw    = [ 1.6 ];

nic = 500; 
ts  = 0.01; 
im  = 5; 
Ga  = 0.25; 
Gd  = 0.5; 
mit = 1;
ccr = 0.01;
nl  = 1;

loin=fopen('loadincr.m','w');
fprintf(loin,'feC = fe0*sin(20*ti); \n');
fclose(loin);

s1 = 'crd';
sada=fopen('savedata.m','w');
fprintf(sada,'save(savefile,s1); \n');
fprintf(sada,'tim(ic+1)=ti; \n'); 
fprintf(sada,'ux2(ic+1)=MTp(2,1); \n');
fprintf(sada,'vx2(ic+1)=MTdp(2,1); \n');
fprintf(sada,'fx2(ic+1)=Mfi(1,1); \n');
fprintf(sada,'kx2(ic+1)=Mfe(2,1); \n');
fclose(sada);

%**********************************************************************
