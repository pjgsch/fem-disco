%**********************************************************************
delete('updaelda.m'); delete('loadincr.m'); delete('savedata.m');
delete('plotdata.m');

crd0 = [ 0 0; 5 0; 10 0; 10 -1.5; 10 -3; 11 -3; 12 -3; 12 0; 12 3; 12 3.1; 12 3.2 ];
%lok  = [1 2 1; 2 3 1];
nnod = size(crd0,1); 
crd  = crd0;
%ne   = size(lok,1);  

eta  = 8.9e-4;  % viscosity water in Pa.s at 25 C
diamp = 0.01;
areap = (pi/4)*(diamp)^2;
diamn = 0.001;
arean = (pi/4)*(diamn)^2;
dens = 1000;

R1 = (128*eta*100)/(pi*diamp^4);
L1 = 100*dens/areap;
R2 = (128*eta*3)/(pi*diamp^4);
L2 = 3*dens/areap;
R3 = (128*eta*2)/(pi*diamp^4);
L3 = 2*dens/areap;
R4 = (128*eta*6)/(pi*diamp^4);
L4 = 6*dens/areap;
R5 = (128*eta*0.2)/(pi*diamn^4);
L5 = 0.2*dens/arean;
%R5 = (128*eta*0.2)/(pi*diamn^4);
%L5 = 0.2*dens/((pi/4)*diamn^2);

eldata = [
 1  2 1 1 0 R1 0;
 2  3 1 1 0 0  L1;
 3  4 1 1 0 R2 0;
 4  5 1 1 0 0  L2;
 5  6 1 1 0 R3 0;
 6  7 1 1 0 0  L3;
 7  8 1 1 0 R4 0;
 8  9 1 1 0 0  L4;
 9 10 1 1 0 R5 0;
10 11 1 1 0 0  L5;
];

%CCC = 1e-18; 
%nodata = [ 3 CCC; 5 CCC; 7 CCC; 9 CCC; ];

% inlet pressure = 1 bar = 1e5 Pa
pp = [ 1 1e5; 11 0 ];

nic = 600; ts = 0.0025; im = 1; nl = 1;
%nic = 600; ts = 0.1; im = 1; nl = 0;
mit=1; ccr=0.01;

loin=fopen('loadincr.m','w');
fprintf(loin,'pe = pe0; \n');
fclose(loin);

sada=fopen('savedata.m','w');
fprintf(sada,'Sti(ic+1) = ti; \n');
fprintf(sada,'Sp1(ic+1) = Tp(1); \n');
fprintf(sada,'Sp2(ic+1) = Tp(2); \n');
fprintf(sada,'Sp3(ic+1) = Tp(3); \n');
fprintf(sada,'Sp6(ic+1) = Tp(6); \n');
fprintf(sada,'Sp8(ic+1) = Tp(8); \n');
fprintf(sada,'Sp10(ic+1) = Tp(10); \n');
fprintf(sada,'Sq2(ic+1) = (1/R1)*(Tp(1)-Tp(2)); \n');
fprintf(sada,'Sq6(ic+1) = (1/R3)*(Tp(5)-Tp(6)); \n');
fprintf(sada,'Sq10(ic+1) = (1/R5)*(Tp(9)-Tp(10)); \n');
fprintf(sada,'x = [0 5 10 11.5 13 14 15 18 21 ]; \n');
fprintf(sada,'y = [Tp(1) Tp(2) Tp(3) Tp(4) Tp(5) Tp(6) Tp(7) Tp(8) Tp(9) ]; \n');
fprintf(sada,'xx = [0 10  13  15  21 ]; \n');
fprintf(sada,'yy = [Tp(1) Tp(2) Tp(4) Tp(6) Tp(8) ]; \n');
fclose(sada);

%**********************************************************************


