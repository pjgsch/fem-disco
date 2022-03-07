%**********************************************************************
delete('loadincr.m');delete('savedata.m');delete('updaelda.m');
%% PET
% E   = 2400;             Gn   = 0.35;     G   = E/(2*(1+Gn));
% Gk  = E/(3*(1-2*Gn));   GW   = 15;       Gh  = 1e10;
% h   = 13;               Dinf = 11;       A0  = 3.8568E-27;
% GDH = 2.617E+05;        Gm   = 0.0625;   Gt0 = 0.927;
%% PC
 E   = 2305;             Gn   = 0.37;     G   = E/(2*(1+Gn));
 Gk  = E/(3*(1-2*Gn));   GW   = 29;       Gh  = 1e10;
 h   = 270;              Dinf = 19 ;      A0  = 9.7573e-27;
 GDH = 2.9e5;            Gm   = 0.06984;  Gt0 = 0.72;

eldax = [ h Dinf A0 GDH Gm Gt0 ];

AAA = G * 2/3 * (1+Gn);      BBB = Gk * (1-2*Gn);  
CCC = GW * 2/3 * (1+Gn);     HHH = Gh;

%temp  = 300;

crd0   = [ 0 0 ; 1 0 ; 2 0 ];
eldata = [ 1 2 AAA+BBB 0 1; 2 3 temp HHH 6; 1 3 CCC 0 1];
pp     = [ 1 1 0; 1 2 0; 2 2 0; 3 2 0 ] 
pp     = [ pp; 3 1 0.001];
map=[];

fct   = 1; 

nic   = 300 ; ts    = 0.01;
im    = 6;    alfa  = 0.25;    delta = 0.5; 
nl    = 1;    mit   = 50;      ccr   = 1e-6;

loin=fopen('loadincr.m','w');
%fprintf(loin,' if abs(MTp(3,1))>0.1, fct = -sign(fct); end; \n');
fprintf(loin,' peC = fct*pe0; \n');
fclose(loin);

sada=fopen('savedata.m','w');
fprintf(sada,' tim(ic+1)=ti; \n');
fprintf(sada,' ux3(ic+1)=MTp(3,1); \n');
fprintf(sada,' fx3(ic+1)=-Mfi(1,1); \n');
fprintf(sada,' Ght(ic+1)=eldaC(2,6);  %% viscosity \n');
fprintf(sada,' DGL(ic+1)=eldaC(2,12);  %% elongation rate \n');
fprintf(sada,' fee(ic+1)=eldaC(2,18); %% dashpot force \n');
fclose(sada);

%**********************************************************************
