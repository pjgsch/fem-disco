%**********************************************************************
clear all;
delete('loadincr.m');delete('savedata.m');delete('updaelda.m'); 
delete('plotdata.m');

crd0   = [ 
0    0; 
0.02 0; 0.04 0; 0.06 0; 0.08 0; 0.10 0;
0.12 0; 0.14 0; 0.16 0; 0.18 0; 0.20 0; 
0.22 0; 0.24 0; 0.26 0; 0.28 0; 0.30 0 ];

ety = 1; esc = 1e9; edc = 1; % rigid bar

eldata = [
 1  2 esc edc ety;  2  3 esc edc ety;  3  4 esc edc ety;  4  5 esc edc ety;
 5  6 esc edc ety;  6  7 esc edc ety;  7  8 esc edc ety;  8  9 esc edc ety;
 9 10 esc edc ety; 10 11 esc edc ety; 11 12 esc edc ety; 12 13 esc edc ety;
13 14 esc edc ety; 14 15 esc edc ety; 15 16 1e2 1 1; ];
map    = [ 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 ];
mas    = 0.1;
maw    = [ 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 ] * mas;

pp = [ 1 1 0; 1 2 0.004; ; 15 2 0; 16 1 0; 16 2 0 ];
wei = -9.8 * mas;
pf = [ 
 2 2 wei;  3 2 wei;  4 2 wei;  5 2 wei; 
 6 2 wei;  7 2 wei;  8 2 wei;  9 2 wei; 10 2 wei; 
11 2 wei; 12 2 wei; 13 2 wei; 14 2 wei; 15 2 wei ];

nic = 400;
mit = 10;
ccr = 0.001;
ts  = 0.01;
im  = 6;
nl  = 1;
Ga=0.25; Gd=0.5; 

loin=fopen('loadincr.m','w');
fprintf(loin,'if ic==1, peC = pe0; end; \n');
fprintf(loin,'if ic==2, peC = -pe0; end; \n');
fprintf(loin,'if ic>2, peC = 0*pe0; end; \n');
fprintf('loadincr.m','feC = fe0; \n');
fclose(loin);

matf = './mat/chain';
s1 = 'crd';
sada=fopen('savedata.m','w');
fprintf(sada,'save(savefile,s1); \n');
fprintf(sada,'tim(ic+1)=ti; \n'); 
fclose(sada);

%**********************************************************************
