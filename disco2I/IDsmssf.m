%**********************************************************************
clear all;
delete('loadincr.m');delete('savedata.m');delete('updaelda.m');

crd0   = [ 0 0; 1 0 ; 2 0 ];  
eldata = [ 1 2  100 0 1 ; 2 3  100 0 1 ];
pp     = [ 1 1 0 ; 1 2 0 ; 2 2 0 ; 3 2 0 ];  
pf     = [ 3 1 10 ];
map    = [ 2 ]; 
maw    = [ 1 ];

nic = 100; 
ts  = 0.01;
im  = 5;   
Ga  = 0.25; 
Gd  = 0.5; 
mit = 1;
ccr = 0.01;
nl  = 1;

loin=fopen('loadincr.m','w');
%fprintf(loin,'if (ic==1), feC = fe0; else, feC = 0*fe0; end; \n');
fprintf(loin,'feC = fe0; \n');
fclose(loin);

s1 = 'crd';
sada=fopen('savedata.m','w');
fprintf(sada,'save(savefile,s1); \n');
fprintf(sada,'tim(ic+1)=ti; \n'); 
fprintf(sada,'ux2(ic+1)=MTp(2,1); \n');
fprintf(sada,'fx2(ic+1)=Mfi(2,1); \n');
fprintf(sada,'kx3(ic+1)=Mfe(3,1); \n');
fprintf(sada,'vx2(ic+1)=Tdp(3); \n');
fclose(sada);

%**********************************************************************
