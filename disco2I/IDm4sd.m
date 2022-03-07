%**********************************************************************
clear all;
delete('loadincr.m');delete('savedata.m');delete('updaelda.m');

crd0   = [ 0 -1; -1 0; 0 1; 1 0; 0 0];
eldata = [ 1 5 1 0.01 1 ; 2 5 2 0.01 1 ; 3 5 3 0.01 1 ; 4 5 4 0.01 1];
map    = [ 5 ]; 
maw    = [ 0.1 ];

pp     = [ 1 1 0; 1 2 0; 2 1 0; 2 2 0; 3 1 0; 3 2 0; 4 1 0; 4 2 0 ];

nic = 50; 
mit = 1; 
ccr = 0.001; 
ts  = 0.05; 
im  = 5;  % with im = 6 there is more damping
Ga  = 0.25; 
Gd  = 0.5; 
nl  = 1;

loin=fopen('loadincr.m','w');
fprintf(loin,'if (ic==1), Tpt   = [0 0 0 0 0 0 0 0 0.1 0.1]''; end; \n');
fprintf(loin,'if (ic==1), Tdpt  = zeros(ndof,1); end; \n');
fprintf(loin,'if (ic==1), Tddpt = zeros(ndof,1); end; \n');
fprintf(loin,'if (ic==2), feC = fe0; end; \n');
fclose(loin);

s1 = 'crd';
sada=fopen('savedata.m','w');
fprintf(sada,'save(savefile,s1); \n');
fprintf(sada,' tim(ic+1)=ti; \n');
fprintf(sada,' ux5(ic+1)=MTp(5,1); \n');
fprintf(sada,' uy5(ic+1)=MTp(5,2); \n');
fprintf(sada,' uy5(ic+1)=MTp(5,2); \n');
fclose(sada);

%**********************************************************************
