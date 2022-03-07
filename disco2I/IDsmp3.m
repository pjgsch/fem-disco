%**********************************************************************
clear all;
delete('loadincr.m');delete('savedata.m');delete('updaelda.m');

crd0   = [ 0 0; 2 -2; 3 -3.5; 4 -5 ];

%esc = 1e5; edc = 1; ety = 2;
%%esc = 1e9; edc = 1e15; ety = 0;
esc = 1e9; edc = 1; ety = 1;

eldata = [ 1 2 esc edc ety; 2 3 esc edc ety; 3 4 esc edc ety ];

pp     = [ 1 1 0; 1 2 0 ];
pf     = [ 2 2 -10; 3 2 -10; 4 2 -10 ];
map    = [ 2 3 4 ];                       
maw    = [ 1 1 1 ];

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

s1 = 'crd';
sada=fopen('savedata.m','w');
fprintf(sada,'save(savefile,s1); \n');
fprintf(sada,'tim(ic+1)=ti; \n');
fprintf(sada,'cx2(ic+1)=crd(2,1); \n');
fprintf(sada,'cy2(ic+1)=crd(2,2); \n');
fprintf(sada,'ux2(ic+1)=MTp(2,1); \n');
fprintf(sada,'uy2(ic+1)=MTp(2,2); \n');
fprintf(sada,'fy2(ic+1)=Mfi(2,2); \n');
fprintf(sada,'ky2(ic+1)=Mfe(2,2); \n');
fprintf(sada,'Sf1(ic+1)=sqrt( Mfi(1,1)^2 + Mfi(1,2)^2 ); \n');
fprintf(sada,'Sit(ic+1)=it; \n');
fprintf(sada,'Snm(ic+1)=nrm; \n');
fprintf(sada,'Sll(ic+1)=eldaC(1,3); \n');
fclose(sada);


%**********************************************************************
