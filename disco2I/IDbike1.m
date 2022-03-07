%**********************************************************************
clear all;
delete('loadincr.m');delete('savedata.m');delete('updaelda.m');

crd0   = [ 0 0; 0 0.1; 0 0.5; 1.5 0; 1.5 0.1; 1.5 0.5; 0.5 0.2 ]; 
eldata = [ 
1 2 100000 0 1 ; 2 3 12500 800 1;
4 5 100000 0 1 ; 5 6 12500 800 1;
3 6 1e10 0 1; 3 7 1e10 0 1; 6 7 1e10 0 1;
];

map    = [ 2 3 5 6 7]; 
maw    = [ 20 30 25 50 0];

%pp     = [ 1 1 0; 1 2 0.1; 2 1 0; 5 1 0; 4 1 0; 7 1 0; 7 2 0];   
pp     = [ 1 2 -0.1; 1 1 0; 2 1 0; 3 1 0; 4 1 0; 4 2 0; 5 1 0; ];
%pp     = [pp; 7 1 0; 7 2 0];   
pf     = [ 2 2 -200; 3 2 -300; 5 2 -250; 6 2 -500; 7 2 0];

nic = 150;   
mit = 10;
ccr = 0.001;
ts  = 0.01;
im  = 6;    
Ga  = 0.25;  
Gd  = 0.5;      
nl  = 1;

loin=fopen('loadincr.m','w');
fprintf(loin,' feC = fe0; \n ');
fprintf(loin,' if (ic==1), peC = pe0; else, peC = 0*pe0; end; \n ');
%fprintf(loin,' feC = fe0; peC = 0*pe0; \n');
%fprintf(loin,' if (ic==50), peC = pe0; end; \n ');
%fprintf(loin,' if (ic==60), peC = -pe0; end; \n ');
%fprintf(loin,' if (ic~=1 & ic~=45), peC = 0*pe0; end; \n ');
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
fprintf(sada,'uy4(ic+1)=MTp(4,2); \n');
fprintf(sada,'uy5(ic+1)=MTp(5,2); \n');
fprintf(sada,'uy6(ic+1)=MTp(6,2); \n');
fprintf(sada,'fy4(ic+1)=Mfi(4,2); \n');
fprintf(sada,'ky4(ic+1)=Mfe(4,2); \n');
fclose(sada);

%**********************************************************************
