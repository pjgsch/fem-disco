%**********************************************************************
delete('loadincr.m','savedata.m','updaelda.m','plotdata.m'); 

crd0   = [ 0 0; 1 0; 2 0; 3 0 ];
eldata = [ 1 2 1e3 0 1; 2 3 0 1e0 1; 3 4 1e3 0 1 ];
pp     = [ 1 1 0; 1 2 0; 2 2 0; 3 2 0; 4 1 0; 4 2 0 ];
pf     = [ 2 1 100 ];
map    = [ 2 3 ];
maw    = [ 1 1 ];

nic = 300; 
ts  = 0.01; 
im  = 5; 
Ga  = 0.25; 
Gd  = 0.5; 
mit = 10;
ccr = 0.01;
nl  = 0;

loin=fopen('loadincr.m','w');
% pulse force -> free vibration
if ii==1
fprintf(loin,'if (ic==1), feC = fe0; end; \n');
fprintf(loin,'if (ic==2), feC = 0*fe0; end; \n');
end;
% harmonic force
if ii==2
fprintf(loin,'feC = fe0*sin(10*ti); \n');
end;
fclose(loin);

sada=fopen('savedata.m','w');
fprintf(sada,'Sti(ic+1)=ti; \n'); 
fprintf(sada,'Su2(ic+1)=MTp(2,1); \n');
fprintf(sada,'Su3(ic+1)=MTp(3,1); \n');
fclose(sada);

%plda=fopen('plotdata.m','w');
%fprintf(plda,'plot(Sti,Su2,Sti,Su3);grid on; \n');
%fprintf(plda,'xlabel(''time [s]'');ylabel(''disp [m]''); \n');
%fprintf(plda,'legend(''u_2'',''u_3''); \n');
%fprintf(plda,' \n');
%fprintf(plda,' \n');
%fprintf(plda,' \n');
%fclose(plda);

%**********************************************************************
