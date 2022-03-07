%**********************************************************************
clear all;
delete('loadincr.m');delete('savedata.m');delete('updaelda.m'); 

[crd0,lok]=mesher(5,5,0.1,0.1,1,1,1,0); crd=crd0;

eldata = [lok(:,3:4) ones(size(lok,1),1)*[10 0 1]];
pp     = [ 1 1 0; 1 2 0; 21 1 0 ];
map = [ 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25];
maw = 0.1*[ 1 1 1 1 1 1 1 1 1 1  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];

nic = 200;   
ts  = 0.01;  
im  = 6;
Ga  = 0.25;  
Gd  = 0.5;   
mit = 10;
ccr = 1e-4;
nl  = 1;

% The system is prestrained with a prescribed displacement.
pf     = [ 25 1 0 ];
loin=fopen('loadincr.m','w');
fprintf(loin,'if (ic==1), Tpt   = zeros(ndof,1); end; \n');
fprintf(loin,'if (ic==1), Tpt(49) = 0.1; end; \n');
fprintf(loin,'if (ic==1), Tdpt  = zeros(ndof,1); end; \n');
fprintf(loin,'if (ic==1), Tddpt = zeros(ndof,1); end; \n');
fprintf(loin,'if (ic>2), fe = fe0; end; \n');
fclose(loin);

% The system is prestrained with a force.
%pf     = [ 25 1 1 ];
%loin=fopen('loadincr.m','w');
%fprintf(loin,'if (ic==1), fe = fe0; else, fe = 0*fe0; end; \n');
%fclose(loin);

matf = './mat/ssmm1';
s1 = 'crd';
sada=fopen('savedata.m','w');
fprintf(sada,'save(savefile,s1); \n');
fprintf(sada,'Sti(ic+1) = ti; \n');
fprintf(sada,'Sc25x(ic+1) = crd(25,1); \n');
fprintf(sada,'Sc25y(ic+1) = crd(25,2); \n');
fprintf(sada,'Su25x(ic+1) = MTp(25,1); \n');
fprintf(sada,'Su25y(ic+1) = MTp(25,2); \n');
fprintf(sada,'Sv25x(ic+1) = MTdp(25,1); \n');
fprintf(sada,'Sv25y(ic+1) = MTdp(25,2); \n');
fclose(sada);

%**********************************************************************
