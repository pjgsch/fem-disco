%**********************************************************************
clear all;
delete('loadincr.m');delete('savedata.m');delete('updaelda.m'); 

crd0   = [ 0 0; 1 -1; 2 -2; 3 -3; 4 -4; 5 -5; 6 -6; 7 -7; 8 -8; 9 -9; 10 -10];

%esc = 1e15; edc = 1e15; ety = 0;
esc = 1e9; edc = 1; ety = 1;
%esc = 1; edc = 0; ety = 2;

eldata = [ 
1 2  esc edc ety; 2 3 esc edc  ety; 3 4 esc edc  ety; 4 5 esc edc  ety;
5 6  esc edc  ety; 6 7 esc edc  ety; 7 8 esc edc  ety; 8 9 esc edc  ety;
9 10  esc edc  ety; 10 11  esc edc  ety;
];

pp     = [ 1 1 0; 1 2 0 ];
pf     = [ 2 2 -100; 3 2 -200; 4 2 -300; 5 2 -400;
           6 2 -500; 7 2 -100; 8 2 -100; 9 2 -100;
           10 2 -100; 11 2 -100 ];
map    = [ 2 3 4 5 6 7 8 9 10 11];                       
maw    = [ 10 20 30 40 50 10 10 10 10 10 ];

nic = 1000;   
mit = 10;
ccr = 1e-5;
ts  = 0.01;  
im  = 6;  
Ga  = 0.25;  
Gd  = 0.5;   
nl  = 1;

loin=fopen('loadincr.m','w');
fprintf(loin,'peC = pe0; \n');
fprintf(loin,'feC = fe0; \n');
fclose(loin);

matf = './mat/smp10';
s1 = 'crd';
sada=fopen('savedata.m','w');
fprintf(sada,'save(savefile,s1); \n');
fprintf(sada,'tim(ic+1)=ti; \n');
fprintf(sada,'cxe(ic+1)=crd(11,1); \n');
fprintf(sada,'cye(ic+1)=crd(11,2); \n');
fprintf(sada,'poe(ic+1)=sqrt( crd(11,1)^2 + crd(11,2)^2 ); \n');
fprintf(sada,'uxe(ic+1)=MTp(11,1); \n');
fprintf(sada,'uye(ic+1)=MTp(11,2); \n');
fprintf(sada,'Sf1(ic+1)=sqrt( Mfi(1,1)^2 + Mfi(1,2)^2 ); \n');
fprintf(sada,'Sit(ic+1)=it; \n');
fprintf(sada,'Snm(ic+1)=nrm; \n');
fprintf(sada,'Sll(ic+1)=eldaC(1,3); \n');
fclose(sada);

%**********************************************************************
