%**********************************************************************
clear all;
delete('loadincr.m');delete('savedata.m');delete('updaelda.m'); 
delete('plotdata.m');

crd0 = [
0 0; 1 0;
0 1; 1 1;
0 2; 1 2;
0 3; 1 3;
0 4; 1 4;
0 5; 1 5;
0 6; 1 6;
0 7; 1 7;
0.5 8; 3 8;
-4 0; 5 0];

esc = 1e5; edc = 0;

eldata = [
 1  2 esc edc 1;
 1  3 esc edc 1;
 2  4 esc edc 1;
 1  4 esc edc 1;
 3  4 esc edc 1;
 3  5 esc edc 1;
 4  6 esc edc 1;
 4  5 esc edc 1;
 5  6 esc edc 1;
 5  7 esc edc 1;
 6  8 esc edc 1;
 5  8 esc edc 1;
 7  8 esc edc 1;
 7  9 esc edc 1;
 8 10 esc edc 1;
 8  9 esc edc 1;
 9 10 esc edc 1;
 9 11 esc edc 1;
10 12 esc edc 1;
 9 12 esc edc 1;
11 12 esc edc 1;
11 13 esc edc 1;
12 14 esc edc 1;
12 13 esc edc 1;
13 14 esc edc 1;
13 15 esc edc 1;
14 16 esc edc 1;
13 16 esc edc 1;
15 16 esc edc 1;
15 17 esc edc 1;
16 17 esc edc 1;
17 18 esc edc 1;
 1 19 esc/100000 1 1;
 2 20 esc/100000 1 1;] ;

map = [ 18 ];
maw = [ 1 ];

%pp = [ 1 1 0; 1 2 0; 2 1 0; 2 2 0 ];
pp = [ 1 2 0; 2 2 0; 19 1 0; 19 2 0; 20 1 0; 20 2 0 ];
pf = [ 18 2 -10 ];

nic = 200;
mit = 10;
ccr = 1e-8;
ts  = 0.1;
im  = 5;
nl  = 1;
Ga=0.25; Gd=0.5; 

loin=fopen('loadincr.m','w');
fprintf(loin,'peC = pe0; \n');
fprintf(loin,'feC = fe0; \n');
fclose(loin);

matf = './mat/chain';
s1 = 'crd';
sada=fopen('savedata.m','w');
fprintf(sada,'save(savefile,s1); \n');
fclose(sada);




%**********************************************************************
