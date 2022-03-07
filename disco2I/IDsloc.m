%**********************************************************************
clear all;
delete('loadincr.m');delete('savedata.m');delete('updaelda.m');
delete('plotdata.m');map=[];

crd0   = [0 0; 100 0; 100 100];
eldata = [1 2 100000 0 1; 2 3 100000 0 1];
tr     = [2 60];
pp     = [1 1 0; 1 2 0; 2 2 0; 3 1 0; 3 2 0.1];
pf     = [ ];

nic=1; ts=1; mit=3; ccr=0.0001; nl=1; Ga=0.25;

loin=fopen('loadincr.m','w');
fprintf(loin,'peC = pe0;\n');
fprintf(loin,'feC = fe0;\n');
fclose(loin);


%**********************************************************************
