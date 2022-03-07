%**********************************************************************
clear all;
delete('loadincr.m','savedata.m','updaelda.m');

crd0   = [0 0; eps 0];
eldata = [1 2 3*crd0(2,1)^2-1 0 1];
map    = [2];
maw    = [1];
pp     = [1 1 0; 1 2 0; 2 2 0];
pf     = [2 1 0.3e0];

nic = 2000;
mit = 10;
ccr = 0.00001;
ts  = 0.025;
Ga  = 0.25;  
Gd  = 0.5;   
im  = 6;
nl  = 1;

loin=fopen('loadincr.m','w');
%fprintf(loin,'fe = fe0*cos(1*ti); \n');
fprintf(loin,'if ic==1, feC = 1e-6*fe0; else, feC=0*fe0; end; \n');
fprintf(loin,'peC = pe0; \n');
fclose(loin);

upda=fopen('updaelda.m','w');
fprintf(upda,'eldaC(1,5) = 3*crd(2,1)^2 - 1; \n');
fclose(upda);

sada=fopen('savedata.m','w');
fprintf(sada,'Sti(ic+1) = ti; \n');
fprintf(sada,'Sit(ic+1) = it; \n');
fprintf(sada,'Sxx(ic+1) = crd(2,1); \n');
fprintf(sada,'Svv(ic+1) = MTdp(2,1); \n');
fprintf(sada,'Saa(ic+1) = MTddp(2,1); \n');
fclose(sada);

%**********************************************************************
