%**********************************************************************
clear all
delete('loadincr.m');delete('savedata.m');delete('updaelda.m'); 
delete('plotdata.m');

x0 = 0; y0 = 0; Gthb = 0; Gthe = 3*360; R = 0.3; 
radb = (Gthb/180)*pi;
xb = x0 + R*cos(radb);
yb = y0 + R*sin(radb);

crd0 = [ x0 y0; xb yb; 0 -0.1; 0 -0.5 ];
eldata = [ 1 2 0 0 1; 3 4 1e10 0 1 ];
pp = [ 1 1 0; 1 2 0; 2 1 1; 2 2 1; 3 1 0; 4 1 0 ];

pl = [ 3 2 ];
pr = [ 2 2 ];
lim = [ 1 ];

M4 = 500;
map = [ 4 ]; maw = [ M4 ];
nic=200; aa=nic; ts=0.03; ti=0; im=6; nl=1; mit=20; ccr=1e-6;

dGth = abs(Gthe-Gthb)/aa; sgn=1; Gth=Gthb; DGth=dGth/ts;
for iii=1:nic+1, 
  rad = (Gth/180)*pi;
  SGth(iii) = Gth;
  Srad(iii) = rad;
  x(iii) = x0 + R*cos(rad);
  y(iii) = y0 + R*sin(rad);

  av = R*((DGth/180)*pi)*cos(rad);
  Sav(iii) = av;

  Gth = Gth + sgn*dGth;
  if rem(iii,aa)==0, sgn=-sgn; end;
end;

loin = fopen('loadincr.m','w');
fprintf(loin,'peC(3) = x(ic+1)-x(ic); \n');
fprintf(loin,'peC(4) = y(ic+1)-y(ic); \n');
fclose(loin);

matf = './mat/crankslot';
S1   = 'crd';

sada = fopen('savedata.m','w');
fprintf(sada,'Sti(ic+1)=ti; \n');
fprintf(sada,'Su2x(ic+1)=MTp(2,1); \n');
fprintf(sada,'Su2y(ic+1)=MTp(2,2); \n');
fprintf(sada,'Su3y(ic+1)=MTp(3,2); \n');
fprintf(sada,'Su4y(ic+1)=MTp(4,2); \n');
fprintf(sada,'if ic==2, Sv4y(1) = Tdpt(8); end; \n');
fprintf(sada,'Sv2x(ic+1)=MTdp(2,1); \n');
fprintf(sada,'Sv2y(ic+1)=MTdp(2,2); \n');
fprintf(sada,'Sv4y(ic+1)=MTdp(4,2); \n');
fprintf(sada,'Sa3y(ic+1)=MTddp(3,2); \n');
fprintf(sada,'Sf2x(ic+1)=Mfi(2,1); \n');
fprintf(sada,'Sf2y(ic+1)=Mfi(2,2); \n');
fprintf(sada,'Sf3x(ic+1)=Mfi(3,1); \n');
fprintf(sada,'Sf3y(ic+1)=Mfi(3,2); \n');
fprintf(sada,'Sf4x(ic+1)=Mfi(4,1); \n');
fprintf(sada,'Sf4y(ic+1)=Mfi(4,2); \n');
Scy(1) = crd0(3,2);
fprintf(sada,'Scy(ic+1) = crd(3,2); \n');

fprintf(sada,'save(savefile,S1); \n');
fclose(sada);

%**********************************************************************
