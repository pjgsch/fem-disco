%**********************************************************************
clear all;
delete('loadincr.m');delete('savedata.m');delete('updaelda.m'); 

crd0 = [
0 5; 
2 4; 2 6;
4 4; 4 6;
6 4; 6 6;
8 4; 8 6;  
10 4; 10 6;
2 0; 4 0; 6 0; 8 0; 10 0 ]*1e-5;

st1 = 1e14;
%st1 = 1e15;
%st1 = 1e16;

eldata = [
1 2 st1 0 1;
1 3 st1 0 1;
2 3 st1 0 1;
2 4 st1 0 1;
3 5 st1 0 1;
2 5 st1 0 1;
3 4 st1 0 1;
4 5 st1 0 1;
4 6 st1 0 1;
5 7 st1 0 1;
4 7 st1 0 1;
5 6 st1 0 1;
6 7 st1 0 1;
6 8 st1 0 1;
7 9 st1 0 1;
6 9 st1 0 1;
7 8 st1 0 1;
8 9 st1 0 1;
8 10 st1 0 1;
9 11 st1 0 1;
8 11 st1 0 1;
9 10  st1 0 1;
10 11 st1 0 1;
2 12 194 1e-6 3;
4 13 194 1e-6 3;
6 14 194 1e-6 3;
8 15 194 1e-6 3;
10 16 194 1e-6 3; ];

pp = [ 1 1 0; 1 2 0; 12 1 0; 12 2 0; 13 1 0; 13 2 0; 
       14 1 0; 14 2 0; 15 1 0; 15 2 0; 16 1 0; 16 2 0];
pp = [ pp; 11 2 3e-7 ];
map = [];

nic = 149; ts = 1; im = 6; nl = 1; mit = 10; ccr = 1e-5;

loin = fopen('loadincr.m','w');
fprintf(loin,'peC = pe0; \n;');
fclose(loin);

Tmax = (eldata(28,3)/eldata(28,4))*(1/exp(1));

matf = './mat/chz5';
S1   = 'crd';

sada = fopen('savedata.m','w');
fprintf(sada,'Su11y(ic+1) = MTp(11,2); \n');
fprintf(sada,'Sf11y(ic+1) = Mfi(11,2); \n');
fprintf(sada,'SD1(ic+1) = (eldaB(24,3)-elda0(24,3))/elda0(24,9); \n');
fprintf(sada,'ST1(ic+1) = eldaB(24,19)/Tmax; \n');
fprintf(sada,'SD2(ic+1) = (eldaB(25,3)-elda0(25,3))/elda0(25,9); \n');
fprintf(sada,'ST2(ic+1) = eldaB(25,19)/Tmax; \n');
fprintf(sada,'SD3(ic+1) = (eldaB(26,3)-elda0(26,3))/elda0(26,9); \n');
fprintf(sada,'ST3(ic+1) = eldaB(26,19)/Tmax; \n');
fprintf(sada,'SD4(ic+1) = (eldaB(27,3)-elda0(27,3))/elda0(27,9); \n');
fprintf(sada,'ST4(ic+1) = eldaB(27,19)/Tmax; \n');
fprintf(sada,'SD5(ic+1) = (eldaB(28,3)-elda0(28,3))/elda0(28,9); \n');
fprintf(sada,'ST5(ic+1) = eldaB(28,19)/Tmax; \n');
fprintf(sada,'save(savefile,S1); \n');
fclose(sada);

