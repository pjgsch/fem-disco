%**********************************************************************
clear all;
delete('loadincr.m','savedata.m','updaelda.m','plotdata.m'); 

C = 0.05e-6;

%lok = [ 1 1 1 2; 1 1 2 3 ];
nnod = 3;

eldata = [ 1 2 1 1 0 20000 0 ; 2 3 1 1 C 20000 0 ];
pp     = [ 1 10 ; 3 0 ]; 
%pf     = [ 1 3 ];

nic = 500; ts  = 0.00001; 
im  = 1;   Ga  = 0.25; Gd  = 0.5;
nl  = 1;   mit = 1;    ccr = 0.001;

loin=fopen('loadincr.m','w');
fprintf(loin,'if ic>=1   & ic<50, pe = pe0; end;\n');
fprintf(loin,'if ic>=50  & ic<100, pe = 0*pe0; end;\n');
fprintf(loin,'if ic>=100 & ic<150, pe = pe0; end;\n');
fprintf(loin,'if ic>=150 & ic<200, pe = 0*pe0; end;\n');
fprintf(loin,'if ic>=200 & ic<250, pe = pe0; end;\n');
fprintf(loin,'if ic>=250, pe = 0*pe0; end;\n');
fclose(loin);

sada=fopen('savedata.m','w');
fprintf(sada,'tim(ic+1)=ti; \n');
fprintf(sada,'v1(ic+1)=Tp(1); \n');
fprintf(sada,'v2(ic+1)=Tp(2); \n');
fprintf(sada,'iC(ic+1)=C*(Tdp(2)-Tdp(3)); \n');
fclose(sada);

%fprintf('plotdata.m','subplot(311); plot(tim,v1); grid on; \n');
%fprintf('plotdata.m','ylabel(''V [V]''); \n');
%fprintf('plotdata.m','subplot(312); plot(tim,v2); grid on; \n');
%fprintf('plotdata.m','ylabel(''V_{RC} [V]''); \n');
%fprintf('plotdata.m','subplot(313); plot(tim,iC); grid on; \n');
%fprintf('plotdata.m','xlabel(''t [s]'');ylabel(''I_C [A]''); \n');

%**********************************************************************
