%**********************************************************************
clear all;
delete('loadincr.m','savedata.m','updaelda.m','plotdata.m');

crd0   = [ 0 0; 1 0; 2 0];
eldata = [ 1 2  1 0 1 ; 2 3  0 1 1 ; 1 3  1 0 1 ];
pp     = [ 1 1 0 ; 1 2 0 ; 2 2 0 ; 3 2 0 ];
%pp     = [ pp ; 3 1 0.1 ];
pf     = [ 3 1 0.1 ];
map    = [];

nic=50; ts=0.1; im=6; Ga=0.25; Gd=0.5; mit=10; ccr=0.01; nl=1;

loin=fopen('loadincr.m','w');
fprintf(loin,'peC = pe0; feC = fe0; \n');
fclose(loin);

sada=fopen('savedata.m','w');
fprintf(sada,'s1 = ''crd'';save(savefile,s1); \n');
fprintf(sada,'tim(ic+1)=ti; \n'); 
fprintf(sada,'ux3(ic+1)=MTp(3,1); \n');
fprintf(sada,'fx3(ic+1)=Mfi(3,1); \n');
fprintf(sada,'kx3(ic+1)=Mfe(3,1); \n');
fclose(sada);

%plda=fopen('plotdata.m','w');
%fprintf(plda,'subplot(211); plot(tim,kx3); grid on; \n');
%fprintf(plda,'xlabel(''t [s]'');ylabel(''f [N]'');%%chp; \n');
%fprintf(plda,'subplot(212); plot(tim,ux3); grid on; \n');
%fprintf(plda,'xlabel(''t [s]'');ylabel(''u [m]'');%%chp; \n');
%fclose(plda);

%**********************************************************************
