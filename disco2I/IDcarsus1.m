%**********************************************************************
clear all;
delete('loadincr.m');delete('savedata.m');delete('updaelda.m');

crd0   = [ 0 0; 0 0.1; 0 0.5 ]; 
eldata = [ 1 2 100000 0 1 ; 2 3 12500 800 1];
map    = [ 2 3 ]; 
maw    = [ 30 250 ];

pp     = [ 1 1 0; 2 1 0; 3 1 0; 1 2 0.1 ];   
pf     = [ ];

nic = 50;   
mit = 1;
ccr = 0.01;
ts  = 0.05;
im  = 6;    
Ga  = 0.25;  
Gd  = 0.5;      
nl  = 1;

loin=fopen('loadincr.m','w');
fprintf(loin,'if (ic==1), peC = pe0; else, peC = 0*pe0; end; \n');
%fprintf(loin,'if (ic>=1), peC = pe0; end; \n');
fclose(loin);

s1 = 'crd';
sada=fopen('savedata.m','w');
fprintf(sada,'save(savefile,s1); \n');
fprintf(sada,'tim(ic+1)=ti; \n');
fprintf(sada,'uy1(ic+1)=MTp(1,2); \n');
fprintf(sada,'uy2(ic+1)=MTp(2,2); \n');
fprintf(sada,'uy3(ic+1)=MTp(3,2); \n');
fprintf(sada,'fy1(ic+1)=Mfi(1,2); \n');
fprintf(sada,'ky1(ic+1)=Mfe(1,2); \n');
fclose(sada);

%**********************************************************************
