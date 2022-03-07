%**********************************************************************
clear all;
delete('loadincr.m','savedata.m','updaelda.m','plotdata.m');

crd0 = [0 0; 0 0.5; 0.4 0.4; 1 0.5];
eldata = [
1 2 100000 0 1; 2 3 100000 0 1; 1 3 100000 0 1;
2 4 100000 0 1; 3 4 100000 0 1
];

pp = [1 1 0; 1 2 0; 2 1 0; 4 2 -0.0025];
%pf = [4 2 -55];
map=[];

nic=80; mit=10; ccr=1e-4; ts=0.01; im=6; Ga=0.25; Gd=0.5; nl=1;

loin=fopen('loadincr.m','w'); 
%fprintf(loin,'peC = pe0; feC = fe0*ti; \n');
fprintf(loin,'peC = pe0; \n');
fclose(loin);

matf = './mat/s1';

s1 = 'crd';
sada = fopen('savedata.m','w');
fprintf(sada,'save(savefile,s1); \n');
fprintf(sada,'tim(ic+1)=ti; \n'); 
fprintf(sada,'uy2(ic+1)=MTp(2,2); \n');
fprintf(sada,'ux4(ic+1)=MTp(4,1); \n');
fprintf(sada,'uy4(ic+1)=MTp(4,2); \n');
fclose(sada);

%plda = fopen('plotdata.m','w');
%fprintf(plda,'subplot(221);mshop = [1 1 1 0 0 0 0 0 0]; \n');
%fprintf(plda,'pmsh(mshop,lok,crd0,crd,eldaC,2); \n');
%fprintf(plda,'subplot(222);plot(tim,uy4);grid on; \n');
%fprintf(plda,'xlabel(''t'');ylabel(''u_y^{(4)} [mm]''); \n');
%fprintf(plda,'subplot(223);plot(tim,ux4);grid on; \n');
%fprintf(plda,'xlabel(''t'');ylabel(''u_x^{(4)} [mm]''); \n');
%fprintf(plda,'subplot(224);plot(tim,uy2);grid on; \n');
%fprintf(plda,'xlabel(''t'');ylabel(''u_y^{(2)} [mm]''); \n');
%fclose(plda);

%**********************************************************************
