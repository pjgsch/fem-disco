%**********************************************************************
% A pick-and-place robot moves a gripper along the $x$- and $y$-axis.
% Maximum free distances in both directions ar 1 and 0.5 m respectively.
% The mass of the gripper, including the product is Mg [kg].
% The gripper moves along a slider, which moves in $x$-direction.
% The mass of the slider is Ms [kg].
% The motion of the gripper and its load is prescribed as a function of
% time.
% The actuators for $x$- and $y$-motion exert reacton forces on the 
% robot frame.
% The stiffness of this frame in $x$- and $y$-direction is Cx and Cy [N/m]
% respectively.
% The deformation of the frame represents the deviation of the prescribed
% position of the gripper.
% In the extended model, a pendulum is attached to the gripper, having a
% mass Mp [kg].

clear all;
delete('loadincr.m');delete('savedata.m');delete('updaelda.m'); 

xemax = 1; yemax = 0.5; Mg = 150; Ms = 400; Mg = 100; Cx = 1e6; Cy = 1e6;

xb = 0.001; yb = 0.001; 

crd0 = [ 0 0; xb 0; xb yb ];
eldata = [ 1 2 0 0 1; 2 3 0 0 1];
pp0 = [ 1 1 0; 1 2 0; 2 2 0];
pp = [ pp0; 2 1 1; 3 2 1];
map = [ 2 3 ]; maw = [ Mg+Ms Mg ];
pl = [ 3 1 ]; pr = [ 2 1 ]; lim = [ 1 ];

crd0 = [ crd0; 1 0; 1.1 0; xb 0.5; xb 0.6 ];
eldata = [ 2 4 0 0 1; 3 6 0 0 1];
eldata = [ eldata; 4 5 Cx 0 1; 6 7 Cy 0 1];
pp = [ pp; 4 2 0; 5 1 0; 5 2 0; 7 2 0];
pl = [ pl; 6 1; 7 1]; lim = [ 1 1 1 ]';

%crd0 = [ crd0; 0.1 0.1 ];
%eldata = [ eldata; 3 8 1e7 0 1 ];
%map = [map 8]; maw = [maw Mg];

nic = 200; ts = 0.01; im  = 6; nl = 1; mit = 10; ccr = 0.0001;

CX = [ 
 1  20 0.00 0.70  0  0; 
21  30 0.70 0.50  0  0;
31  50 0.50 0.80  0  0;
51 nic 0.80 0.80  0  0
];

CY = [
 1  20 0.00 0.30  0  0; 
21  50 0.30 0.40  0  0;
51 nic 0.40 0.40  0  0
];

for xxyy=1:2

if xxyy==1, CC = CX; elseif xxyy==2, CC=CY; end;

for nnn=1:size(CC,1)
ib = CC(nnn,1); ie = CC(nnn,2); tb = (ib-1)*ts; te = ie*ts;
xb = CC(nnn,3); xe = CC(nnn,4); vb = CC(nnn,5); ve = CC(nnn,6);
MM = [ 1 tb tb^2 tb^3;   1 te te^2 te^3; 
       0 1  2*tb 3*tb^2; 0 1  2*te 3*te^2 ];
RR = [ xb xe vb ve ]'; AA = inv(MM) * RR;
a0 = AA(1); a1 = AA(2); a2 = AA(3); a3 = AA(4);
iii = ib-1;

for t=tb:ts:te
  iii=iii+1; TT(iii)=t; 
  if t>=tb & t<=te, PP(iii) = a0 + a1*t + a2*t^2 + a3*t^3; end;
end;
end;

if xxyy==1, XX=PP; elseif xxyy==2, YY=PP; end;

end;

%plot(TT,XX,TT,YY); grid on;
%xlabel('t [s]'); ylabel('disp [mm]'); legend('x','y');

loin = fopen('loadincr.m','w');
fprintf(loin,'xxB = XX(ic); xxE = XX(ic+1); peC(3) = xxE-xxB; \n');
fprintf(loin,'yyB = YY(ic); yyE = YY(ic+1); peC(6) = yyE-yyB; \n');
fprintf(loin,'feC(7) = -fr(3); feC(12) = -fr(6); \n');
fclose(loin);

matf = './mat/lath2m';
S1   = 'crd';

sada = fopen('savedata.m','w');
fprintf(sada,'Sti(ic) = ti; \n');
fprintf(sada,'Su2x(ic) = MTp(2,1); \n');
fprintf(sada,'Su3x(ic) = MTp(3,1); \n');
fprintf(sada,'Su3y(ic) = MTp(3,2); \n');
fprintf(sada,'Sv2x(ic) = MTdp(2,1); \n');
fprintf(sada,'Sv3y(ic) = MTdp(3,2); \n');
fprintf(sada,'Sa2x(ic) = MTddp(2,1); \n');
fprintf(sada,'Sa3y(ic) = MTddp(3,2); \n');
fprintf(sada,'Sf2x(ic) = Mfi(2,1); \n');
fprintf(sada,'Sf2y(ic) = Mfi(2,2); \n');
fprintf(sada,'Sf3x(ic) = Mfi(3,1); \n');
fprintf(sada,'Sf3y(ic) = Mfi(3,2); \n');

fprintf(sada,'Sf6y(ic) = Mfi(6,2); \n');
fprintf(sada,'Sf7y(ic) = Mfi(7,2); \n');
fprintf(sada,'Sf4x(ic) = Mfi(4,1); \n');
fprintf(sada,'Sf5x(ic) = Mfi(5,1); \n');
fprintf(sada,'Su4x(ic) = MTp(4,1); \n');
fprintf(sada,'Su5x(ic) = MTp(5,1); \n');
fprintf(sada,'Su6y(ic) = MTp(6,2); \n');
fprintf(sada,'Su7y(ic) = MTp(7,2); \n');

fprintf(sada,'Snrm(ic) = nrm; \n');

fprintf(sada,'save(savefile,S1); \n');
fclose(sada);
