%**********************************************************************
clear all; 

g  = 9.81;
v0 = 20;
Gf = (1*20)*pi/180;
s  = sin(Gf);
c  = cos(Gf);
te = (2*v0/g)*sin(Gf);

nic = 100
dt = te/nic;
t = 0;

for i=1:nic
  t = t + dt;
  x = v0*t*c;
  y = -(g/2)*t*t + v0*t*s;
  Dx = v0*c;
  Dy = -g*t + v0*s;
  St(i) = t; Sx(i) = x; Sy(i) = y; SDx(i) = Dx; SDy(i) = Dy;
  i = i + 1;
end;

clf;
subplot(221);plot(Sx,Sy);grid on;xlabel('u_x [m]');ylabel('u_y [m]');hold on;
subplot(222);plot(St,SDx);grid on;xlabel('t [s]');ylabel('v_x [m]');hold on;
subplot(223);plot(St,SDy);grid on;xlabel('t [s]');ylabel('v_y [m]');hold on;
subplot(224);plot(St,-g);grid on;xlabel('t [s]');ylabel('a_y [m]');hold on;

%**********************************************************************
