%**********************************************************************
clear all;
delete('loadincr.m');delete('savedata.m');delete('updaelda.m'); 

crd0 = [ 0 4; 2 4;4 4;6 4;8 4;10 4; 2 0; 4 0; 6 0; 8 0; 10 0 ]*1e-5;

st1 = 1e14;
%st1 = 1e15;
%st1 = 1e16;

eldata = [
1 2 st1 0 1; 2 3 st1 0 1; 3 4 st1 0 1; 4 5 st1 0 1; 5 6 st1 0 1;
2 7 194 1e-6 3; 3 8 194 1e-6 3; 4 9 194 1e-6 3; 5 10 194 1e-6 3;
6 11 194 1e-6 3; ];

pp = [ 1 1 0; 1 2 0; 7 1 0; 7 2 0; 8 1 0; 8 2 0; 
       9 1 0; 9 2 0; 10 1 0; 10 2 0; 11 1 0; 11 2 0];
pp = [ pp; 6 2 3e-7 ];
map = [];

pl  = [ 2 1; 2 2; 3 1; 3 2; 4 1; 4 2; 5 1; 5 2 ];
pr  = [ 6 1; 6 2 ];
lim = [ 1/5 0; 0 1/5; 2/5 0; 0 2/5; 3/5 0; 0 3/5; 4/5 0; 0 4/5 ];

nic = 149; ts = 1; im = 6; nl = 1; mit = 10; ccr = 1e-5;

loin = fopen('loadincr.m','w');
fprintf(loin,'peC = pe0; \n;');
fclose(loin);

Tmax = (eldata(10,3)/eldata(10,4))*(1/exp(1));

matf = './mat/chz5a';
S1   = 'crd';

sada = fopen('savedata.m','w');
fprintf(sada,'Su11y(ic+1) = MTp(6,2); \n');
fprintf(sada,'Sf11y(ic+1) = Mfi(6,2); \n');
fprintf(sada,'SD1(ic+1) = (eldaB(6,3)-elda0(6,3))/elda0(6,9); \n');
fprintf(sada,'ST1(ic+1) = eldaB(6,19)/Tmax; \n');
fprintf(sada,'SD2(ic+1) = (eldaB(7,3)-elda0(7,3))/elda0(7,9); \n');
fprintf(sada,'ST2(ic+1) = eldaB(7,19)/Tmax; \n');
fprintf(sada,'SD3(ic+1) = (eldaB(8,3)-elda0(8,3))/elda0(8,9); \n');
fprintf(sada,'ST3(ic+1) = eldaB(8,19)/Tmax; \n');
fprintf(sada,'SD4(ic+1) = (eldaB(9,3)-elda0(9,3))/elda0(9,9); \n');
fprintf(sada,'ST4(ic+1) = eldaB(9,19)/Tmax; \n');
fprintf(sada,'SD5(ic+1) = (eldaB(10,3)-elda0(10,3))/elda0(10,9); \n');
fprintf(sada,'ST5(ic+1) = eldaB(10,19)/Tmax; \n');
fprintf(sada,'save(savefile,S1); \n');
fclose(sada);

