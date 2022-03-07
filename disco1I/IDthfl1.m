%**********************************************************************
clear all;
delete('updaelda.m'); delete('loadincr.m'); delete('savedata.m');

qsun = 100*1e-3;   % W/m2  : heat flow from the sun in W-Europe
A    = 1;          % m2
d    = 5e-3;       % m
% data for window glass
Gl   = 0.96;       % W/mK
Rtl  = d/(Gl*A);   % K/W
Gr   = 2500;       % kg/m3
Cp   = 840;        % J/kgK
Ct   = Cp*A*d*Gr;  % J/K
% data for space between the two window panes
Ga   = 1e-1;        % W/m2K
Rta  = 1/(Ga*A);   % K/W

nnod=4;

eldata = [ 1 2 1 1 0 Rtl 0; 2 3 1 1 0 Rta 0; 3 4 1 1 0 Rtl 0 ];
%eldata = [ eldata; 2 5 1 1 Ct 0 0; 3 6 1 1 Ct 0 0];
nodata = [ 2 Ct; 3 Ct ];

DT=0;

pp = [ 4 27+DT ];
%pp = [ pp; 5 0; 6 0 ];
%pf = [ 1 qsun*A ];
pp = [ pp; 1 -10+DT ];

nic = 500; ts = 1; im = 1; Ga = 1/4; Gd = 1/2; mit=1; ccr=0.01;

loin=fopen('loadincr.m','w');
fprintf(loin,'pe = pe0;\n');
fprintf(loin,'fe = fe0;\n');
%fprintf(loin,'if ic>nic/2, fe = -fe0; end;\n');
% initial temperature does not work properly
%fprintf(loin,'if ic==1, Tpt   = [10+DT 15+DT 20+DT 0 0 0]''; end; \n');
%fprintf(loin,'if ic==1, Tdpt  = zeros(ndof,1); end; \n');
%fprintf(loin,'if ic==1, Tddpt = zeros(ndof,1); end; \n');
fclose(loin);

sada=fopen('savedata.m','w');
fprintf(sada,'tim(ic+1)=ti; \n');
fprintf(sada,'STe(ic+1)=Tp(1)-DT; \n');
fprintf(sada,'STge(ic+1)=Tp(2)-DT; \n');
fprintf(sada,'STgi(ic+1)=Tp(3)-DT; \n');
fprintf(sada,'STi(ic+1)=Tp(4)-DT; \n');
fprintf(sada,'Sqi(ic+1)=1/Rtl*(Tp(3)-Tp(4)); \n');
fclose(sada);

%fprintf('plotdata.m','figure; \n');
%fprintf('plotdata.m','plot(tim/3600,STe,tim/3600,STge,tim/3600,STgi,tim/3600,STi); \n');
%fprintf('plotdata.m','grid on;xlabel(''time [hrs]'');ylabel(''temp [^oC]''); \n');
%fprintf('plotdata.m','legend(''T_{outside}'',''T_{glass-ext}'',''T_{glass-int}'',''T_{inside}''); \n');
%fprintf('plotdata.m','figure; \n');
%fprintf('plotdata.m','plot(tim/3600,Sqi); \n');
%fprintf('plotdata.m','text(0.08,-2000,[''final heat flow   '' num2str(Sqi(nic)) '' [W]'']); \n');
%fprintf('plotdata.m','grid on;xlabel(''time [hrs]'');ylabel(''heat flow [W]''); \n');
%fprintf('plotdata.m',' \n');
%fprintf('plotdata.m',' \n');
%fprintf('plotdata.m',' \n');
%fprintf('plotdata.m',' \n');


%**********************************************************************

