%**********************************************************************
clear all;
delete('loadincr.m','savedata.m','updaelda.m','plotdata.m'); 

crd0   = [ 0 0; 1 0 ];                
eldata = [ 1 2  100 0 1 ];
map    = [ 2 ];                       
maw    = [ 1 ];

nic = 1000;   
ts  = 0.001;  
im  = 6;
Ga  = 0.25;  
Gd  = 0.5;   
mit = 1;
ccr = 0.01;
nl  = 1;

%----------------------------------------------------------------------
% Two loadcases are used.
% In the first loadcase the mass is given a displacement: prestraining.
% In the second loadcase the mass is released and free vibration starts.
% NB: error with im=5 (Newmark).
%
%pp     = [ 1 1 0 ; 1 2 0 ; 2 1 0.1; 2 2 0 ];   
%pp1    = [ 1 1 0 ; 1 2 0 ; 2 2 0 ];   
%pf1    = [ 2 1 0 ];
%
%fprintf('loadincr.m','if (ic==1), peC = pe0; end; \n');
%fprintf('loadincr.m','if (ic>1), peC = 0*pe0; end; \n');
%fprintf('loadincr.m','if (ic==3), lc=1; lcase; end; \n');
%fprintf('loadincr.m','if (ic>2), feC = fe0; end; \n');
%----------------------------------------------------------------------
% One loadcase is used.
% The initial displacement, velocity and acceleration are prescribed.

pp    = [ 1 1 0 ; 1 2 0 ; 2 2 0 ];   
pf    = [ 2 1 0 ];

loin=fopen('loadincr.m','w');
fprintf(loin,'if (ic==1), Tpt   = [0 0 0.1 0]''; end; \n');
fprintf(loin,'if (ic==1), Tdpt  = zeros(ndof,1); end; \n');
fprintf(loin,'if (ic==1), Tddpt = zeros(ndof,1); end; \n');
fprintf(loin,'if (ic>2), feC = fe0; end; \n');
fclose(loin);
%----------------------------------------------------------------------

s1 = 'crd';
sada=fopen('savedata.m','w');
fprintf(sada,'save(savefile,s1); \n');
fprintf(sada,'tim(ic+1)=ti; \n');
fprintf(sada,'ux2(ic+1)=MTp(2,1); vx2(ic+1)=MTdp(2,1); \n');
fprintf(sada,'fx2(ic+1)=Mfi(2,1); kx2(ic+1)=Mfe(2,1); \n');
fclose(sada);

%plda=fopen('plotdata.m','w');
%fprintf(plda,'subplot(211); plot(tim,ux2); grid on; \n');
%fprintf(plda,'xlabel(''t [s]'');ylabel(''u [m]'');%%chp; \n');
%fprintf(plda,'axis([0 1 -0.1 0.1]); \n');
%fprintf(plda,'subplot(212); plot(tim,vx2); grid on; \n');
%fprintf(plda,'xlabel(''t [s]'');ylabel(''v [m/s]'');chp; \n');
%fprintf(plda,'axis([0 1 -1 1]); \n');
%fprintf(plda,' \n');
%fprintf(plda,' \n');
%fclose(plda);

%**********************************************************************
