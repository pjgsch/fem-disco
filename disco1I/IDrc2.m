%**********************************************************************
delete('loadincr.m','savedata.m','updaelda.m'); 

CCC = 20e-6; RRR = 1e4;

%lok = [ 1 1 1 2 0; 1 1 1 2 0];
nnod = 3;

eldata = [ 1 2 1 1 CCC 0 0 ; 2 3 1 1 0 RRR 0 ];
pp     = [ 3 0 ]; 

nic = 200; ts  = 0.01; 
im  = 1;   Ga  = 0.25; Gd  = 0.5;
nl  = 1;   mit = 10;    ccr = 0.01;

loin=fopen('loadincr.m','w');
% voltage step
pp     = [ pp; 1 5 ];
fprintf(loin,'pe = pe0; \n');
% harmonic current
%pf     = [ 1 3 ];
%fprintf(loin,'fe = fe0*sin(10*ti); \n');
% voltage pulse
%pp     = [ pp; 1 5 ];
%fprintf(loin,'if ic==1, pe = pe0; else, pe = 0*pe0; end; \n'); 
fclose(loin);

sada=fopen('savedata.m','w');
fprintf(sada,' tim(ic+1)=ti;                   \n');
fprintf(sada,' v1(ic+1)=Tp(1);                 \n');
fprintf(sada,' i1(ic+1)=fe(1);                 \n');
fprintf(sada,' i2(ic+1)=fi(2);                 \n');
fprintf(sada,' iC(ic+1)=CCC*(Tp(1)-Tpt(1))/ts; \n');
fprintf(sada,' iC(ic+1)=CCC*(Tdp(1)-Tdp(2));   \n');
fprintf(sada,' iR(ic+1)=(1/RRR)*(Tp(2)-Tp(3)); \n');
fclose(sada);

%**********************************************************************
