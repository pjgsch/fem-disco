%**********************************************************************
clear all;
delete('loadincr.m','savedata.m','updaelda.m','plotdata.m');

crd0   = [ 0 0; 1 0 ];
eldata = [ 1 2  1000 100 1 ];
pp     = [ 1 1 0 ; 1 2 0 ; 2 2 0 ];  
pf     = [ 2 1 200 ];
map    = [ 2 ];   
maw    = [ 1.6 ];

pp1 = [ 1 1 0 ; 1 2 0 ; 2 2 0 ]; 

nic = 50; 
ts  = 0.01; 
im  = 5; 
Ga  = 0.25; 
Gd  = 0.5; 
mit = 10;
ccr = 0.01;
nl  = 1;

loin=fopen('loadincr.m','w');
%fprintf(loin,'if (ic>1), lc=1; lcase; end; \n');
%fprintf(loin,'if (ic==1), Tpt   = [0 0 0.25 0 ]''; end; \n');
%fprintf(loin,'if (ic==1), Tdpt  = zeros(ndof,1); end; \n');
%fprintf(loin,'if (ic==1), Tddpt = zeros(ndof,1); end; \n');
%fprintf(loin,'if (ic==1), imflag = 2; dscintsys;   end; \n');

fprintf(loin,'if (ic>=1), feC = fe0; end; \n');
fprintf(loin,'if (ic==1), feC = fe0; end; \n');
%fprintf(loin,'if (ic>1),  feC = 0*fe0; end; \n');
fclose(loin);

s1 = 'crd';
sada=fopen('savedata.m','w');
fprintf(sada,'save(savefile,s1); \n');
fprintf(sada,'tim(ic+1)=ti; \n'); 
fprintf(sada,'ux2(ic+1)=MTp(2,1); \n');
fprintf(sada,'vx2(ic+1)=MTdp(2,1); \n');
fprintf(sada,'fx2(ic+1)=Mfi(1,1); \n');
fprintf(sada,'kx2(ic+1)=Mfe(2,1); \n');
fclose(sada);

%plda=fopen('plotdata.m','w');
%fprintf(plda,'if ii==1, plot(tim,ux2,''r''); hold on; end; \n');
%fprintf(plda,'if ii==2, plot(tim,ux2,''b''); hold on; end; \n');
%fprintf(plda,'if ii==3, plot(tim,ux2,''g''); hold off; end; \n');
%fprintf(plda,'grid on;xlabel(''t [s]'');ylabel(''u [m]'');%%chp; \n');
%%fprintf(plda,'axis([0 0.5 0 0.03]); \n');
%fprintf(plda,'legend(''b=80'',''b=20'',''b=200''); \n');
%fclose(plda);

%**********************************************************************
