%**********************************************************************
delete('updaelda.m','loadincr.m','savedata.m');

crd0 = [ 0 0; 0 -1; 1 0; 2 0; 3 0 ];
nnod = size(crd0,1); 
crd  = crd0;

Ghpm = 100;         % viscocity polymer melt [Pa.s]

Dext = 75e-3;       % extruder barrel diameter [m]
Lext = 1.5;         % extruder barrel length [m]
%Next = 1;           % extruder rotation rate [rev/s]
dchn = 6e-3;        % screw channel depth [m]
Ascr = 20/360*2*pi; % screw pitch angle [rad]

Qmax = (pi^2)/2 * Dext^2 * Next * dchn * sin(Ascr) * cos(Ascr);
pmax = (1/dchn^2) * 6*pi * Dext * Next * Lext * cot(Ascr) * Ghpm;
Rpa  = pmax/Qmax;
Rpb  = 1e-3*Rpa;

Ldie = 25e-3;       % die length [m]
Ddie = 6e-3;        % die diameter (circular) [m]
Rdie = 128*Ghpm*Ldie/(pi*Ddie^2);

Lm1  = 100e-3;      % mold length [m]
Dm1  = 1e-3;        % mold diameter [m]
Rm1  = 128*Ghpm*Lm1/(pi*Dm1^2);

eldata = [
1 2 1 1 0 Rpa  0;
1 3 1 1 0 Rpb  0;
3 4 1 1 0 Rdie 0;
4 5 1 1 0 Rm1  0;
];

pp = [ 2 0 ];
pp = [ pp; 5 1 ];
%pp = [ pp; 5 0 ];

pf = [ 1 Qmax ];

nic = 300; ts = 0.005; im = 1; nl = 1; mit=1; ccr=0.01;

loin=fopen('loadincr.m','w');
fprintf(loin,'peT = (ti^3)*(1e7*pe0); \n');
fprintf(loin,'if peT<=pmax, pe = peT; else, pe=pet; end; \n');
fprintf(loin,'fe = fe0; \n');
fclose(loin);

sada=fopen('savedata.m','w');
fprintf(sada,'Sti(ic+1) = ti; \n');
fprintf(sada,'Sp1(ic+1) = Tp(1); \n');
fprintf(sada,'Sp3(ic+1) = Tp(3); \n');     % die inlet 
fprintf(sada,'Sp4(ic+1) = Tp(4); \n');
fprintf(sada,'Sp5(ic+1) = Tp(5); \n');
fprintf(sada,'Sq2(ic+1) = (1/Rpa)*(Tp(1)-Tp(2)); \n'); 
fprintf(sada,'Sq3(ic+1) = (1/Rpb)*(Tp(1)-Tp(3)); \n');  % die inlet
fprintf(sada,'Sq4(ic+1) = (1/Rdie)*(Tp(3)-Tp(4)); \n');
fprintf(sada,'Sq5(ic+1) = (1/Rm1)*(Tp(4)-Tp(5)); \n');
fclose(sada);

%**********************************************************************

