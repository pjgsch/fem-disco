%**********************************************************************
clear all; 
delete('loadincr.m','savedata.m','updaelda.m','plotdata.m');

crd0   = [ 0 0 ; 1 0 ];
eldata = [ 1 2  1 1 1 ];

%pp     = [ 1 1 0 ; 1 2 0 ; 2 2 0 ; 2 1 0.1 ];
pp     = [ 1 1 0 ; 1 2 0 ; 2 2 0 ];
pf     = [ 2 1 0.1 ];
map    = [];

nic=50; ts=0.1; im=6; Ga=0.25; Gd=0.5; nl=1; mit=1; ccr=0.01; nl=1;

loin=fopen('loadincr.m','w');
fprintf(loin,'if (ic==1), peC = pe0; end; \n');
%fprintf(loin,'if (ic>1),  peC = pe0; end; \n');
fprintf(loin,'if (ic==1), feC = fe0; end; \n');
fprintf(loin,'if (ic>1),  feC = fe0; end; \n');
fclose(loin);

s1 = 'crd';
sada=fopen('savedata.m','w');
fprintf(sada,'save(savefile,s1); \n');
fprintf(sada,'tim(ic+1)=ti; \n'); 
fprintf(sada,'ux2(ic+1)=MTp(2,1); \n');
fprintf(sada,'fx2(ic+1)=Mfi(2,1); \n');
fprintf(sada,'kx2(ic+1)=Mfe(2,1); \n');
fclose(sada);

%plda=fopen('plotdata.m','w');
%fprintf(plda,'subplot(211); plot(tim,kx2); grid on; \n');
%fprintf(plda,'xlabel(''t [s]'');ylabel(''f [N]'');%%chp; \n');
%fprintf(plda,'subplot(212); plot(tim,ux2); grid on; \n');
%fprintf(plda,'xlabel(''t [s]'');ylabel(''u [m]'');%%chp; \n');
%%fprintf(plda,'subplot(211);plot(tim,ux2); grid on; \n');
%%fprintf(plda,'xlabel(''t [s]'');ylabel(''u [mm]'');%%chp; \n');
%fprintf(plda,' \n');
%fprintf(plda,' \n');
%fclose(plda);

%**********************************************************************
