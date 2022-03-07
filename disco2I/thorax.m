%**********************************************************************
clear all;
delete('loadincr.m','savedata.m','updaelda.m');

crd0   = [ 0 0 ; 0.1 0 ; 0.16 0 ];
eldata = [ 1 2 10000 1000 1 ; 2 3 10000 1000 1 ];
pp     = [ 1 1 0; 1 2 0; 2 1 0; 3 1 0; 3 2 0.05 ];
pf     = [ ] ;
map    = [ 2 3 ]; 
maw    = [ 1.5 10 ];

nic    = 600;
ts     = 0.01;
im     = 6; 
Ga     = 0.25; 
Gd     = 0.5; 
mit    = 1;
ccr    = 0.01;
nl     = 1;
li     = 'tp';

loin=fopen('loadincr.m','w');
fprintf(loin,'peC = pe0*abs(sin(3*ti)); \n');
fclose(loin);

sada=fopen('savedata.m','w');
fprintf(sada,'tim(ic+1)=ti; \n'); 
fprintf(sada,'uy3(ic+1)=MTp(3,2); \n');
fprintf(sada,'fy3(ic+1)=Mfi(3,2); \n');
fprintf(sada,'uy2(ic+1)=MTp(2,2); \n');
fprintf(sada,'fy1(ic+1)=Mfi(1,2); \n');
fclose(sada);

%**********************************************************************


