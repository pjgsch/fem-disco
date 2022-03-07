%**********************************************************************
delete('loadincr.m','savedata.m','updaelda.m','plotdata.m','printout.m');

crd0 = [ 0 0 ; 0 2 ]; crd0 = [ crd0; 0 1 ];
nnod = size(crd0,1); 
crd  = crd0;

%R1 = 680000; R2 = 3300; R3 = 101500; R4 = 1e20;
%R1 = 680000; R2 = 3300; R3 = 1e20; R4 = 101500;
%R1 = 1500; R2 = 560000; R3 = 1e20; R4 = 100000;
%R1 = 1500; R2 = 560000; R3 = 1e20; R4 = 1e20;
R1 = 1500; R2 = 680000; R3 = 15; R4 = 1e20;

eldata = [ 1 3 1 1 0 R1 0; 3 2 1 1 0 R2 0; 
           3 1 1 1 0 R3 0; 3 2 1 1 0 R4 0 ];
pp = [ 1 0; 2 4.5 ];

nic = 10; ts = 0.01; im = 1; mit=10;

loin = fopen('loadincr.m','w');
fprintf(loin,' pe = pe0;                \n');
fclose(loin);

sada = fopen('savedata.m','w');
fprintf(sada,' Sti(ic+1)=ti;            \n');
fprintf(sada,' I1=(1/R1)*(Tp(3)-Tp(1)); \n');
fprintf(sada,' I2=(1/R2)*(Tp(2)-Tp(3)); \n');
fprintf(sada,' I3=(1/R3)*(Tp(3)-Tp(1)); \n');
fprintf(sada,' I4=(1/R4)*(Tp(2)-Tp(3)); \n');
fprintf(sada,' SI1(ic+1)=I1;            \n');
fprintf(sada,' SI2(ic+1)=I2;            \n');
fprintf(sada,' SI3(ic+1)=I3;            \n');
fprintf(sada,' SI4(ic+1)=I4;            \n');
fprintf(sada,' V1=Tp(1);                \n');
fprintf(sada,' V2=Tp(2);                \n');
fprintf(sada,' V3=Tp(3);                \n');
fprintf(sada,' SV1(ic+1)=V1;            \n');
fprintf(sada,' SV2(ic+1)=V2;            \n');
fprintf(sada,' SV3(ic+1)=V3;            \n');
fclose(sada);

%**********************************************************************
