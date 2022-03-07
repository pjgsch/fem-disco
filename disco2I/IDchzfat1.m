%**********************************************************************
delete('loadincr.m');delete('savedata.m');delete('updaelda.m'); 
delete('plotdata.m');

thn0  = 0.01;             % initial thickness
czkn  = 1e9;%3.75e8;      % initial stiffness

freq  = 1/5;              % frequency [Hz]
frad  = 2*pi*freq;
ncyc  = 2;                % number of cycles
ttot  = ncyc/freq;
ampl  = 2e-4;%0.005;      % amplitude

czcn  = 2.5e-4; %100 %300000;
czm   = 3;%3.18;
czr   = 1e-3; %1e-07;
czGsf = 0;
czid  = 0;
czpff = 10;
czpfe = 1;
kfin  = 1.0e3;
Dfin  = 0.999999;
ichzopntozero = 0;
ichznegative  = 0;

eldax = [ 
czcn czm czr czGsf czid czpff czpfe kfin Dfin 0 ...
ichzopntozero ichznegative
];

crd0 = [ 0 0; 0 thn0 ];
%crd0 = [ 0 0; 0 thn0; 0 1 ];
eldata = [ 1 2 czkn 0 33 ];
%eldata = [ 1 2 czkn 0 33; 2 3 1e6 0 1 ];
pp = [ 1 1 0; 1 2 0; 2 1 0; 2 2 ampl ];
%pp = [ 1 1 0; 1 2 0; 2 1 0; 3 1 0; 3 2 ampl ];
map = [];

nic = ncyc*36; ts = ttot/nic; 
%ts = ttot/100; nic=ttot/ts;
im = 6; nl = 1; mit = 10; ccr = 1e-3;

loin = fopen('loadincr.m','w');
fprintf(loin,'peC = pe0*(sin(frad*ti)-sin(frad*(ti-ts))); \n;');
fclose(loin);

%Tmax = (eldata(1,3)/eldata(1,4))*(1/exp(1));

sada = fopen('savedata.m','w');
fprintf(sada,'Sti(ic+1) = ti; \n');
%fprintf(sada,'Su22(ic+1) = MTp(2,2)/eldata(1,4); \n');
%fprintf(sada,'Sf22(ic+1) = Mfi(2,2)/Tmax; \n');
fprintf(sada,'Su22(ic+1) = MTp(2,2); \n');
fprintf(sada,'Sf22(ic+1) = Mfi(2,2); \n');
fprintf(sada,'Sdam(ic+1) = eldaB(1,26); \n');
%fprintf(sada,'Su32(ic+1) = MTp(2,2); \n');
%fprintf(sada,'Sf22(ic+1) = Mfi(2,2); \n');
fclose(sada);

plda=fopen('plotdata.m','w');
fprintf(plda,'if ii==1 \n');
fprintf(plda,'plot(Sti,Su22);grid on; \n');
fprintf(plda,'axis([0 ttot -ampl ampl]); \n');
fprintf(plda,'xlabel(''time [s]'');ylabel(''opening [mm]''); chp; \n');
fprintf(plda,'end; \n');
fclose(plda);


%**********************************************************************
