%**********************************************************************
clear all;
delete('loadincr.m');delete('savedata.m');delete('updaelda.m');
delete('plotdata.m'); 

%lok = [ 1 1 1 2; 1 1 2 3 ];
nnod = 3;

eldata = [ 1 2 1 1 0 1e10 0 ; 2 3 1 1 1e-13 0 1e6 ];
pp     = [ 1 0.1 ; 3 0 ]; 
%pf     = [ 1 3 ];

nic = 100; ts  = 0.0001; 
im  = 1;   Ga  = 0.25; Gd  = 0.5;
nl  = 0;   mit = 1;    ccr = 0.001;

loin=fopen('loadincr.m','w');
% for disco1
%fprintf(loin,'if ic==1, pe = pe0; end;\n');
%fprintf(loin,'if ic>1, pe = 0*pe0; end; \n');
% for disco11
fprintf(loin,'pe = pe0; \n');
fclose(loin);

sada=fopen('savedata.m','w');
fprintf(sada,'tim(ic+1)=ti; \n');
fprintf(sada,'v1(ic+1)=Tp(1); \n');
fprintf(sada,'v2(ic+1)=Tp(2); \n');
fprintf(sada,'i2(ic+1)=fi(2); \n');
fclose(sada);

%**********************************************************************
