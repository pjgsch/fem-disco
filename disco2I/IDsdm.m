%**********************************************************************
% Spring-dashpot-mass system.
%======================================================================

clear all;
delete('loadincr.m');delete('savedata.m');delete('updaelda.m');

% Coordinates
% crd0 : initial nodal coordinates [m]

crd0   = [ 0 0; 0 0.1; 0 0.5 ]; 

% Element data
% [ node1  node2  stiffness  damping  elementtype(=1) ]

eldata = [ 1 2 100000 0 1 ; 2 3 12500 800 1];

% Nodal masses
% map  : nodenumbers with masses  
% maw  : mass values [kg]

map    = [ 2 3 ]; 
maw    = [ 30 400 ];

% Boundary conditions
% pp   : prescribed displacements  [ node  dof  value ]
% pf   : prescribed forces  [ node  dof  value ]

pp     = [ 1 1 0; 2 1 0; 3 1 0; 1 2 0.1 ];  
pf     = [ ];

% Analysis parameters
% nic  : number of time increments
% ts   : time step = duration of one increment
% im   : integration method
% Ga   : parameter
% Gd   : parameter

nic = 50; ts = 0.05; im = 6; Ga = 0.25; Gd = 0.5;   

% Time dependent loading
% loin : file identifier for 'loadincr.m' 
% peC  : displacements for current increment
% feC  : forces for current increment
% li   : 'ip' -> peC is INCREMENTAL (default)
%      : 'tp' -> peC is TOTAL
% ti   : current time

loin=fopen('loadincr.m','w');

%----------------------------------------------------------------------
% Select a loading

%li  = 'ip';
%fprintf(loin,' if (ic==1),          peC = pe0; end; \n');
%fprintf(loin,' if (ic==25),         peC = -pe0; end; \n');
%fprintf(loin,' if (ic~=1 & ic~=25), peC = 0*pe0; end; \n');

%li  = 'ip';
%fprintf(loin,' if (ic==1),           peC = pe0; end; \n');
%fprintf(loin,' if (ti==1.25),        peC = -pe0; end; \n');
%fprintf(loin,' if (ic~=1 & ti>1.25), peC = 0*pe0; end; \n');

li  = 'tp';
fprintf(loin,' peC = pe0 - pe0 * cos(10 * ti); \n');
fprintf(loin,' if ( ic>1 & ti > 0.5 ), peC = 0*pe0; end; \n');

%----------------------------------------------------------------------
fclose(loin);

% Storage of incremental data

s1 = 'crd';
sada=fopen('savedata.m','w');
fprintf(sada,' save(savefile,s1);  \n');
fprintf(sada,' tim(ic+1) = ti;       \n');
fprintf(sada,' uy1(ic+1) = MTp(1,2); \n');
fprintf(sada,' uy2(ic+1) = MTp(2,2); \n');
fprintf(sada,' uy3(ic+1) = MTp(3,2); \n');
fprintf(sada,' vy2(ic+1) = MTdp(2,2); \n');
fprintf(sada,' vy3(ic+1) = MTdp(3,2); \n');
fprintf(sada,' ay2(ic+1) = MTddp(2,2); \n');
fprintf(sada,' ay3(ic+1) = MTddp(3,2); \n');
fprintf(sada,' fy1(ic+1) = Mfi(1,2); \n');
fprintf(sada,' ky1(ic+1) = Mfe(1,2); \n');
fclose(sada);

%**********************************************************************
