%**********************************************************************
clear all;
delete('loadincr.m');delete('savedata.m');delete('updaelda.m'); 
delete('plotdata.m');

crd0 = [ 0 0; 0 30e-6 ];
eldata = [ 1 2 194 1.0e-6 3 ];
pp = [ 1 1 0; 1 2 0; 2 1 0; 2 2 1e-7 ];
map = [];

nic = 50; ts = 1; im = 6; nl = 1; mit = 10; ccr = 1e-3;

loin = fopen('loadincr.m','w');
fprintf(loin,'peC = pe0; \n;');
fclose(loin);

Tmax = (eldata(1,3)/eldata(1,4))*(1/exp(1));

sada = fopen('savedata.m','w');
fprintf(sada,'Su22(ic+1) = MTp(2,2)/eldata(1,4); \n');
%fprintf(sada,'Su22(ic+1) = MTp(2,2); \n');
%fprintf(sada,'Sf22(ic+1) = Mfi(2,2); \n');
fprintf(sada,'Sf22(ic+1) = Mfi(2,2)/Tmax; \n');
%fprintf(sada,'Sf22(ic+1) = eldaC(1,17)/Tmax; \n');
fclose(sada);

plda=fopen('plotdata.m','w');
fprintf(plda,'plot(Su22,Sf22); grid on;  \n');
fprintf(plda,'xlabel(''\\Delta/\\delta''); ylabel(''T/T_{max}''); \n');
fclose(plda);

%**********************************************************************
