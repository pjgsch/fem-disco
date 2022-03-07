%**********************************************************************
clear all;
delete('loadincr.m','savedata.m','updaelda.m'); 

L = 4;
M = 1;
g = 9.81;
Gf = 0*(pi/180);

crd0   = [ 0 0; L*cos(Gf) L*sin(Gf) ];

%esc = 1e9; edc = 1e15; ety = 0;
esc = 1e6; edc = 0 ; ety = 1;  % pendulum, use im=5
%esc = 1; edc = 0 ; ety = 2;  % chain, use im=6

eldata = [ 1 2  esc edc ety ];
pp     = [ 1 1 0; 1 2 0 ];
pf     = [ 2 2 -M*g ];
map    = [ 2 ];                       
maw    = [ M ];

%nic = 2000;   
nic = 500;   
mit = 10;
ccr = 1e-8;
ts  = 0.025;  
im  = 5;  % im = 6 : damping
Ga  = 0.25;  
Gd  = 0.5;   
nl  = 1;

loin=fopen('loadincr.m','w');
fprintf(loin,'peC = pe0; \n');
fprintf(loin,'feC = fe0; \n');
fclose(loin);

matf = './mat/smp1';
s1 = 'crd';
sada=fopen('savedata.m','w');
fprintf(sada,'save(savefile,s1); \n');
fprintf(sada,'Sti(ic+1)=ti; \n');
fprintf(sada,'SGf(ic+1)=sign(crd(2,2))*(180/pi)*(acos(crd(2,1)/L)); \n');
fprintf(sada,'cx2(ic+1)=crd(2,1); \n');
fprintf(sada,'cy2(ic+1)=crd(2,2); \n');
fprintf(sada,'ux2(ic+1)=MTp(2,1); \n');
fprintf(sada,'uy2(ic+1)=MTp(2,2); \n');
fprintf(sada,'fy2(ic+1)=Mfi(2,2); \n');
fprintf(sada,'ky2(ic+1)=Mfe(2,2); \n');
fprintf(sada,'Sfi1(ic+1)=sqrt( Mfi(1,1)^2 + Mfi(1,2)^2 ); \n');
%fprintf(sada,'Sfr1(ic+1)=sqrt( Mfr(1,1)^2 + Mfr(1,2)^2 ); \n');
fprintf(sada,'Af1(ic+1)=M*g*(2*sin(Gf)-3*crd(2,2)/L); \n');
fprintf(sada,'Sit(ic+1)=it; \n');
fprintf(sada,'Snm(ic+1)=nrm; \n');
fprintf(sada,'Sll(ic+1)=eldaC(1,3); \n');
fclose(sada);

Gth0 = pi/2 + Gf;
Tper = 2*pi*sqrt(L/g)*( 1 + (1/4)*(sin(Gth0/2))^2 + (9/64)*(sin(Gth0/2))^4 );

%**********************************************************************
