%**********************************************************************
clear all;
delete('loadincr.m','savedata.m','updaelda.m'); 

%lok = [ 1 1 1 2; 1 1 1 3; 1 1 2 3 ];
nnod = 3;

PRR = 1e4; % parallel resistance
SRR = 1e4; % serial resistance
DRL = 1e4; % diode resistance low

eldata = [ 
1 2 2 1 0 DRL 0 ; 
1 3 1 1 0 PRR 0 ; 
2 3 1 1 0 SRR 0]; % 1 2 1 1 CCC 0 0 ];
pp     = [ 3 0 ]; 

nic = 50; ts  = 0.01; 
im  = 1;   Ga  = 0.25; Gd  = 0.5;
nl  = 0;   mit = 10;    ccr = 0.01;

loin=fopen('loadincr.m','w');
% harmonic current
%pf     = [ 1 3 ];
%fprintf(loin,'fe = fe0*sin(20*ti); \n');
% harmonic voltage
pp     = [ 1 1 ; 3 0]; 
fprintf(loin,'pe = pe0*sin(20*ti); \n');
fclose(loin);

sada=fopen('savedata.m','w');
fprintf(sada,'tim(ic+1)=ti; \n');
fprintf(sada,'v1(ic+1)=Tp(1); \n');
fprintf(sada,'v2(ic+1)=Tp(2); \n');
fprintf(sada,'v3(ic+1)=Tp(3); \n');
fprintf(sada,'ie1(ic+1)=fe(1); \n');
fprintf(sada,'ii1(ic+1)=fi(1); \n');
fprintf(sada,'ii2(ic+1)=fi(2); \n');
fprintf(sada,'ii3(ic+1)=fi(3); \n');
fprintf(sada,'iD(ic+1)=(Tp(1)-Tp(2))/eldaC(1,7); \n');
fprintf(sada,'iP(ic+1)=(Tp(1)-Tp(3))/eldaC(2,7); \n');
fprintf(sada,'iS(ic+1)=(Tp(2)-Tp(3))/eldaC(3,7); \n');
fprintf(sada,'RR(ic+1)=eldaC(1,7); \n');
fclose(sada);

%fprintf('plotdata.m','figure; \n');
%fprintf('plotdata.m','plot(tim,v1,tim,v2,tim,v3); \n');
%fprintf('plotdata.m','legend(''V_1'',''V_2'',''V_3'',0);grid on; \n');
%fprintf('plotdata.m','xlabel(''t [s]'');ylabel(''V [V]''); \n');
%fprintf('plotdata.m','figure; \n');
%fprintf('plotdata.m','plot(tim,iD,tim,iP,tim,iS,''--''); \n');
%fprintf('plotdata.m','legend(''I_d'',''I_p'',''I_s'',0);grid on; \n');
%fprintf('plotdata.m','xlabel(''t [s]'');ylabel(''I [A]''); \n');

%**********************************************************************
