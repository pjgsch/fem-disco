%**********************************************************************
clear all;
delete('loadincr.m','savedata.m','updaelda.m','plotdata.m');

crd0   = [ 0 0; 1 0 ; 2 0 ];
eldata = [ 1 2  1000 0 1 ; 2 3  0 20 1 ];

pp     = [ 1 1 0 ; 1 2 0 ; 2 2 0; 3 1 0 ; 3 2 0 ]; 
pf     = [ ];

map    = [ 2 ]; 
maw    = [ 1.6 ];

nic = 1000; 
ts  = 0.001; 
im  = 5; % im = 6 : to much damping
theta = 1; 
Ga  = 0.25; 
Gd  = 0.5; 
mit = 10;
ccr = 0.01;
nl  = 1;

loin=fopen('loadincr.m','w');
fprintf(loin,'if (ic==1), Tpt   = [0 0 0.25 0 0 0]''; end; \n');
fprintf(loin,'if (ic==1), Tdpt  = zeros(ndof,1); end; \n');
fprintf(loin,'if (ic==1), Tddpt = zeros(ndof,1); end; \n');
fprintf(loin,'if (ic==1), imflag = 2; dscintsys;   end; \n');
fprintf(loin,'if (ic==2), feC = fe0; end; \n');
fclose(loin);

%pf    = [ 2 1 0.1 ];
%fprintf('loadincr.m','if (ic==1), feC = fe0; end; \n');
%fprintf('loadincr.m','if (ic==2), feC = 0*fe0; end; \n');
%fprintf('loadincr.m','if (ic==2), dpt  = zeros(ndof,1); end; \n');
%fprintf('loadincr.m','if (ic==2), ddpt = zeros(ndof,1); end; \n');

s1 = 'crd';
sada=fopen('savedata.m','w');
fprintf(sada,'save(savefile,s1); \n');
fprintf(sada,'tim(ic+1)=ti; \n'); 
fprintf(sada,'ux2(ic+1)=MTp(2,1); \n');
fprintf(sada,'fx2(ic+1)=Mfi(2,1); \n');
fclose(sada);

%plda=fopen('plotdata.m','w');
%fprintf(plda,'plot(tim,ux2);grid on; \n');
%fprintf(plda,'xlabel(''t [s]'');ylabel(''u [m]'');%%chp \n');
%fprintf(plda,'ax=axis;xmin=ax(1);xmax=1;ymin=ax(3);ymax=ax(4); \n');
%fprintf(plda,'axis([xmin xmax ymin ymax]); \n');
%fprintf(plda,' \n');
%fclose(plda);

%**********************************************************************
