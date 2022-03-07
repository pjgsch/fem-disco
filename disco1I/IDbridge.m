%**********************************************************************
delete('loadincr.m'); delete('savedata.m'); delete('updaelda.m'); 

nnod = 4;

CCC = 1e-7; % capacity 
DAL = 1e4; % diode A resistance low
DBL = 1e4; % diode B resistance low
DCL = 1e4; % diode C resistance low
DDL = 1e4; % diode D resistance low

eldata = [ 
1 3 2 1 0 DAL 0 ; 
4 1 2 1 0 DBL 0 ; 
4 2 2 1 0 DCL 0 ;
2 3 2 1 0 DDL 0];
if ii==2,                                  % add capacitance -> real DC 
  eldata = [ eldata; 3 4 1 1 CCC 0 0 ]; 
end; 
pp = [ 2 0 ];

nic = 500; ts  = 0.001; 
im  = 1;   Ga  = 0.25; Gd  = 0.5;
nl  = 0;   mit = 1;    ccr = 0.01;

loin=fopen('loadincr.m','w');
% harmonic voltage
pp     = [ pp; 1 1 ]; 
fprintf(loin,'pe = pe0*sin(20*ti); \n');
% harmonic current
%pf     = [ 1 1e-3 ];
%fprintf(loin,'fe = fe0*sin(20*ti); \n');
fclose(loin);

sada=fopen('savedata.m','w');
fprintf(sada,'tim(ic+1)=ti; \n');
fprintf(sada,'v1(ic+1)=Tp(1); \n');
fprintf(sada,'v2(ic+1)=Tp(2); \n');
fprintf(sada,'v3(ic+1)=Tp(3); \n');
fprintf(sada,'v4(ic+1)=Tp(4); \n');
%fprintf(sada,'ie1(ic+1)=fe(1); \n');
%fprintf(sada,'ii1(ic+1)=fi(1); \n');
%fprintf(sada,'ii2(ic+1)=fi(2); \n');
%fprintf(sada,'ii3(ic+1)=fi(3); \n');
fprintf(sada,'iA(ic+1)=(Tp(1)-Tp(3))/eldaC(1,7); \n');
fprintf(sada,'iB(ic+1)=(Tp(4)-Tp(1))/eldaC(2,7); \n');
fprintf(sada,'iC(ic+1)=(Tp(4)-Tp(2))/eldaC(3,7); \n');
fprintf(sada,'iD(ic+1)=(Tp(2)-Tp(3))/eldaC(4,7); \n');
%fprintf(sada,'iR(ic+1)=(Tp(3)-Tp(4))/eldaC(5,7); \n');
fclose(sada);

%**********************************************************************
