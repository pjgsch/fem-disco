%**********************************************************************
delete('loadincr.m','savedata.m','updaelda.m','plotdata.m'); 

x0 = 0; y0 = 0; Gthb = 0; Gthe = 3*360; R = 0.5; L = 1.5*R;
rad = (Gthb/180)*pi;
xb = x0 + R*cos(rad);
yb = y0 + R*sin(rad);
xe = 0;
ye = R*sin(rad)-sqrt(L*L-xb*xb);

crd0 = [ x0 y0; xb yb; xe ye ];
eldata = [ 1 2 0 0 1; 2 3 1e10 0 1 ];
pp = [ 1 1 0; 1 2 0; 2 1 1; 2 2 1; 3 1 0 ];

map = [ 3 ]; maw = [ M3 ];
nic=200; aa=nic; ts=0.1; ti=0; im=6; nl=1; mit=20; ccr=1e-8;

dGth = abs(Gthe-Gthb)/aa; sgn=1; Gth=Gthb; DGth=dGth/ts;
for iii=1:nic+1, 
  rad = (Gth/180)*pi;
  SGth(iii) = Gth;
  Srad(iii) = rad;
  x(iii) = x0 + R*cos(rad);
  y(iii) = y0 + R*sin(rad);

  av = R*((DGth/180)*pi)*cos(rad)* ...
       ( 1 - 1/sqrt( L*L - R*R*(cos(rad))^2 ) * R*sin(rad) );
  Sav(iii) = av;

  Gth = Gth + sgn*dGth;
  if rem(iii,aa)==0, sgn=-sgn; end;
end;

loin = fopen('loadincr.m','w');
fprintf(loin,'peC(3) = x(ic+1)-x(ic); \n');
fprintf(loin,'peC(4) = y(ic+1)-y(ic); \n');
fclose(loin);

matf = './mat/crank';
S1   = 'crd';

sada = fopen('savedata.m','w');
fprintf(sada,'Sti(ic+1)=ti; \n');
fprintf(sada,'Su2x(ic+1)=MTp(2,1); \n');
fprintf(sada,'Su2y(ic+1)=MTp(2,2); \n');
fprintf(sada,'Su3y(ic+1)=MTp(3,2); \n');
fprintf(sada,'if ic==2, Sv3y(1) = Tdpt(6); end; \n');
fprintf(sada,'Sv2x(ic+1)=MTdp(2,1); \n');
fprintf(sada,'Sv2y(ic+1)=MTdp(2,2); \n');
fprintf(sada,'Sv3y(ic+1)=MTdp(3,2); \n');
fprintf(sada,'Sf2x(ic+1)=Mfi(2,1); \n');
fprintf(sada,'Sf2y(ic+1)=Mfi(2,2); \n');
fprintf(sada,'Sf3x(ic+1)=Mfi(3,1); \n');
fprintf(sada,'Sf3y(ic+1)=Mfi(3,2); \n');
Scy(1) = crd0(3,2);
Say(1) = R*sin(Srad(1))-sqrt(L*L-R*R*(cos(Srad(1)))^2);
fprintf(sada,'Scy(ic+1) = crd(3,2); \n');
fprintf(sada,'Say(ic+1) = R*sin(Srad(ic+1))-sqrt(L*L-R*R*(cos(Srad(ic+1)))^2); \n');
fprintf(sada,'save(savefile,S1); \n');
fclose(sada);

%plda = fopen('plotdata.m','w');
%fprintf(plda,'FF = sqrt(Sf2y.*Sf2y + Sf2x.*Sf2x); \n');
%fprintf(plda,'clf;mshop = [1 1 0 0 0 0 0 0 0]; \n');
%fprintf(plda,'subplot(221);load([matf num2str(10)]); \n');
%fprintf(plda,'pmsh(mshop,lok,crd0,crd,eldaC,1); \n');
%fprintf(plda,'subplot(221);load([matf num2str(30)]); \n');
%fprintf(plda,'pmsh(mshop,lok,crd0,crd,eldaC,1); \n');
%fprintf(plda,'subplot(221);load([matf num2str(40)]); \n');
%fprintf(plda,'pmsh(mshop,lok,crd0,crd,eldaC,1); \n');
%fprintf(plda,'subplot(221);load([matf num2str(55)]); \n');
%fprintf(plda,'pmsh(mshop,lok,crd0,crd,eldaC,1); \n');
%fprintf(plda,'subplot(222);plot(Sti(3:nic),Scy(3:nic),Sti(3:nic),Say(3:nic)); \n');
%fprintf(plda,'grid on;xlabel(''t [s]'');ylabel(''y [m]''); \n');
%fprintf(plda,'subplot(223);plot(Sti(3:nic),Sv3y(3:nic),Sti(3:nic),Sav(3:nic)); \n');
%fprintf(plda,'grid on;xlabel(''t [s]'');ylabel(''v [m/s]''); \n');
%%fprintf(plda,'subplot(224);plot(Sti(3:nic),Sf2x(3:nic),Sti(3:nic),Sf2y(3:nic),Sti(3:nic),FF(3:nic)); \n');
%fprintf(plda,'subplot(224);plot(Sti(3:nic),FF(3:nic)); \n');
%fprintf(plda,'grid on;xlabel(''t [s]'');ylabel(''force [N]''); \n');
%fclose(plda);

%**********************************************************************



