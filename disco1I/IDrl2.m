%**********************************************************************
clear all;
delete('loadincr.m');delete('savedata.m');delete('updaelda.m');

LLL = 20e2; RRR = 1e4;

%lok = [ 1 1 1 2 0; 1 1 1 2 0];
nnod = 3;

eldata = [ 1 2 1 1 0 0 LLL ; 2 3 1 1 0 RRR 0 ];
pp     = [ 3 0 ]; 

nic = 40; ts  = 0.05; 
im  = 1;   Ga  = 0.25; Gd  = 0.5;
nl  = 0;   mit = 10;    ccr = 0.01;

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
fprintf(sada,'tim(ic+1)=ti; \n');
fprintf(sada,'v1(ic+1)=Tp(1); \n');
fprintf(sada,'i1(ic+1)=fi(1); \n');
fprintf(sada,'iL(ic+1)=(1/LLL)*(sumv(1)-sumv(2)); \n');
fprintf(sada,'iR(ic+1)=(1/RRR)*(Tp(2)-Tp(3)); \n');
fclose(sada);

%fprintf('plotdata.m','plot(tim(1:nic),iL(1:nic));grid on; \n');
%fprintf('plotdata.m','plot(tim(1:nic),iR(1:nic));grid on; \n');
%fprintf('plotdata.m','subplot(221); plot(tim(1:nic),i1(1:nic)); grid on;ylabel('I [A]'); \n');
%fprintf('plotdata.m','subplot(222); plot(tim(1:nic),v1(1:nic)); grid on;ylabel('V [V]'); \n');
%fprintf('plotdata.m','subplot(223); plot(tim(1:nic),iL(1:nic)); grid on;ylabel('I_L [A]'); \n');
%fprintf('plotdata.m','subplot(224); plot(tim(1:nic),iR(1:nic)); grid on;ylabel('I_R [A]'); \n');

%**********************************************************************
