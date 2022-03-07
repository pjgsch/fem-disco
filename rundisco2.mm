%**********************************************************************
edit disco2L.m
edit disco2.m

%======================================================================
% SPRING SYSTEMS
%======================================================================

%======================================================================
% Linear Spring structure; local coordinate system;       edit IDsloc.m
%----------------------------------------------------------------------
IDsloc; disco2L; 
figure; plotmesh([100 1 1 0 0 0 0 0 0],loka,crd0,crd,eldaC,2);
%======================================================================
% large deformation of 'truss' structure;                   edit IDs1.m
%----------------------------------------------------------------------
close all; IDs1; disco2; 
figure; subplot(221);plotmesh([1 1 1 0 0 0 0 0 0],loka,crd0,crd,eldaC,2);
        subplot(222);plot(tim,uy4);grid on;xlabel('t');ylabel('u_y^{(4)} [mm]');
        subplot(223);plot(tim,ux4);grid on;xlabel('t');ylabel('u_x^{(4)} [mm]');
        subplot(224);plot(tim,uy2);grid on;xlabel('t');ylabel('u_y^{(2)} [mm]');
figure; mf=0;ax=[-1 1 -1 1];ps=0.01;plotmovie;
%======================================================================
% crank                                                  edit IDcrank.m
% M3 = mass 
%----------------------------------------------------------------------
close all;clear all; M3=0; %M3=100;
IDcrank; disco2;
FF = sqrt(Sf2y.*Sf2y + Sf2x.*Sf2x);
figure; mshop = [1 1 0 0 0 0 0 0 0];
subplot(221);load([matf num2str(10)]);plotmesh(mshop,loka,crd0,crd,eldaC,1);
subplot(221);load([matf num2str(30)]);plotmesh(mshop,loka,crd0,crd,eldaC,1);
subplot(221);load([matf num2str(40)]);plotmesh(mshop,loka,crd0,crd,eldaC,1);
subplot(221);load([matf num2str(55)]);plotmesh(mshop,loka,crd0,crd,eldaC,1);
subplot(222);plot(Sti(3:nic),Scy(3:nic),Sti(3:nic),Say(3:nic));grid on;xlabel('t [s]');ylabel('y [m]');
subplot(223);plot(Sti(3:nic),Sv3y(3:nic),Sti(3:nic),Sav(3:nic));grid on;xlabel('t [s]');ylabel('v [m/s]');
subplot(224);plot(Sti(3:nic),Sf2x(3:nic),Sti(3:nic),Sf2y(3:nic),Sti(3:nic),FF(3:nic)); 
subplot(224);plot(Sti(3:nic),FF(3:nic));grid on;xlabel('t [s]');ylabel('force [N]');
figure; mf=0;ax=[-2*R 2*R -3*R 2*R];plotmovie; 
%======================================================================
% crank in slot                                      edit IDcrankslot.m
%----------------------------------------------------------------------
close all;clear all; IDcrankslot; disco2; 
figure; mshop = [1 1 0 0 0 0 0 0 0]; 
subplot(221);load([matf num2str(10)]); plotmesh(mshop,loka,crd0,crd,eldaC,1); 
subplot(221);load([matf num2str(30)]); plotmesh(mshop,loka,crd0,crd,eldaC,1); 
subplot(221);load([matf num2str(40)]); plotmesh(mshop,loka,crd0,crd,eldaC,1); 
subplot(221);load([matf num2str(55)]); plotmesh(mshop,loka,crd0,crd,eldaC,1); 
subplot(222);plot(Sti(3:nic),Sv4y(3:nic),Sti(3:nic),Sav(3:nic)); 
             grid on;xlabel('t [s]');ylabel('v [m/s]'); 
subplot(223);plot(Sti(3:nic),Sa3y(3:nic)); 
             grid on;xlabel('t [s]');ylabel('a [m/s2]'); 
subplot(224);plot(Sti(3:nic),Sf3y(3:nic));
             grid on;xlabel('t [s]');ylabel('force [N]'); 
figure; mf=0;mshop=[1 1 0 0 0 0 0 0 0];ax=[-2*R 2*R -3*R 2*R];plotmovie; 
%======================================================================
% buckling                                               edit IDbuck1.m
%----------------------------------------------------------------------
close all; clear all; off=0.0001;
for ii=1:4
  if ii==1, off2=-off; off3=off; end;
  if ii==2, off2=-100*off; off3=100*off; end;
  if ii==3, off2=off; off3=off; end;
  if ii==4, off2=100*off; off3=100*off; end;
  IDbuck1; disco2; 
  SSfr(:,ii)=Sfr'; SSux(:,ii)=Sux';
  if ii==2, crdsym=crd; end; if ii==4, crdasy=crd; end;
end; 
figure; plot(SSux(:,1),SSfr(:,1),'r-',SSux(:,2),SSfr(:,2),'r--');hold on;
        plot(SSux(:,3),SSfr(:,3),'b-',SSux(:,4),SSfr(:,4),'b--');hold off;
        grid on;xlabel('disp [m]');ylabel('F [N]');legend('symm.perf','symm.imperf','anti-symm.perf','anti-symm.imperf','Location','West');
figure; subplot(211);plotmesh([2 1 0 0 0 0 0 0 0],loka,crd0,crdsym,eldaC,2);axis('image');%axis([-0.1 3.1 -1.1 1.2]);
        subplot(212);plotmesh([2 1 0 0 0 0 0 0 0],loka,crd0,crdasy,eldaC,2);axis('image');%axis([-0.1 3.1 -1.1 1.2]);
figure; mf=0; mshop = [2 1 0 0 0 0 0 0 0];plotmovie;
%======================================================================

%======================================================================
% SPRING-DASHPOT SYSTEMS
%======================================================================

%======================================================================
% spring-dashpot; Maxwell, step force;                  edit IDsdMAsf.m      
%----------------------------------------------------------------------
IDsdMAsf; disco2L; 
figure; subplot(211);plot(tim,kx3);grid on;ylabel('f [N]');
        subplot(212);plot(tim,ux3);grid on;ylabel('u [m]');xlabel('t [s]'); 
%======================================================================
% spring-dashpot; Maxwell, step displacement;           edit IDsdMAsd.m
%----------------------------------------------------------------------
IDsdMAsd; disco2L; 
figure; subplot(211);plot(tim,ux3);grid on;ylabel('u [m]');
        subplot(212);plot(tim,fx3);grid on;ylabel('f [N]');xlabel('t [s]');
%======================================================================
% spring-dashpot; Kelvin-Voigt, step force;             edit IDsdKVsf.m
%----------------------------------------------------------------------
IDsdKVsf; disco2L;
figure; subplot(211);plot(tim,kx2);grid on;ylabel('f [N]');
        subplot(212);plot(tim,ux2);grid on;ylabel('u [m]');xlabel('t [s]');
%======================================================================
% spring-dashpot; Standard Linear, step force;          edit IDsdSLsf.m
%----------------------------------------------------------------------
IDsdSLsf; disco2L; 
figure; subplot(211);plot(tim,kx3);grid on;ylabel('f [N]');
        subplot(212);plot(tim,ux3);grid on;xlabel('t [s]');ylabel('u [m]');
%======================================================================
% spring-dashpot; Standard Linear, step displacement;   edit IDsdSLsd.m
%----------------------------------------------------------------------
IDsdSLsd; disco2L; 
figure; subplot(211);plot(tim,ux3);grid on;ylabel('u [m]');
        subplot(212);plot(tim,fx3);grid on;xlabel('t [s]');ylabel('f [N]');
%======================================================================

%======================================================================
% SPRING-MASS SYSTEMS
%======================================================================

%======================================================================
% spring-mass; free vibration;                            edit IDsmfv.m
%----------------------------------------------------------------------
IDsmfv; disco2L; 
figure; subplot(211);plot(tim,ux2);grid on;ylabel('u [m]');axis([0 1 -0.1 0.1]); 
        subplot(212);plot(tim,vx2);grid on;xlabel('t [s]');ylabel('v [m/s]');axis([0 1 -1 1]); 
%======================================================================
% spring-mass; harmonic force, freq = [10 20];            edit IDsmhf.m
%----------------------------------------------------------------------
clear all; freq=10; IDsmhf; disco2L; 
figure; subplot(211);plot(tim,ux2);grid on;ylabel('u [m]'); 
clear all; freq=20; IDsmhf; disco2L;         
        subplot(212);plot(tim,ux2);grid on;xlabel('t [s]');ylabel('u [m]');
%======================================================================
% spring-mass; pulse force;                               edit IDsmpf.m
%----------------------------------------------------------------------
clear all; close all; IDsmpf; disco2L; 
figure; subplot(311);plot(tim,kx2);grid on;xlabel('t [s]');ylabel('f [N]');axis([0 1 0 10]);
        subplot(312);plot(tim,ux2);grid on;xlabel('t [s]');ylabel('u [m]');axis([0 1 -0.01 0.01]);
        subplot(313);plot(tim,vx2);grid on;xlabel('t [s]');ylabel('v [m/s]');axis([0 1 -0.1 0.1]);
%======================================================================
% spring-mass-spring; series, step force;                edit IDsmssf.m
%----------------------------------------------------------------------
IDsmssf; disco2L; 
figure; subplot(311);plot(tim,kx3);grid on;ylabel('f [N]');axis([0 1 0 10]);
        subplot(312);plot(tim,ux2);grid on;ylabel('u [m]');axis([0 1 0 0.2]);
        subplot(313);plot(tim,vx2);grid on;ylabel('v [m/s]');xlabel('t [t]');axis([0 1 -1 1]);
%======================================================================
% mass movement: ballistic mass;                          edit IDsmff.m
%----------------------------------------------------------------------
close all; clear all; 
for ii=1:3, 
  IDsmff; Gf= (ii*20)*pi/180; disco2L; 
  subplot(221);plot(ux2,uy2,Axx,Ayy);grid on; 
  xlabel('u_x [m]');ylabel('u_y [m]');hold on; 
  subplot(222);plot(tim,uy2,tim,Ayy);grid on; 
  xlabel('t [s]');ylabel('u_y [m]');hold on; 
  subplot(223);plot(tim,vx2,tim,ADx);grid on; 
  xlabel('t [s]');ylabel('v_x [m]');hold on; 
  subplot(224);plot(tim,vy2,tim,ADy);grid on; 
  xlabel('t [s]');ylabel('v_y [m]');hold on; 
end; 
%======================================================================
% springs-masses;                                        edit IDssmm1.m 
%----------------------------------------------------------------------
close all; IDssmm1; disco2; 
crd=crd0; mshop = [1 1 0 0 0 0 0 0 0]; 
figure; plotmesh(mshop,loka,crd0,crd,eldaC,2); 
figure; mf=0;ax=[-0.1 0.6 -0.1 0.6];plotmovie;
%======================================================================
% mass interaction                                         edit IDms6.m
%----------------------------------------------------------------------
IDms6; disco2; 
figure; mf=0;ax=[-7 9 -1 7];mshop=[1 0 0 0 0 0 0 0 -1];plotmovie; 
%======================================================================

%======================================================================
% SPRING-DASHPOT-MASS SYSTEMS
%======================================================================

%======================================================================
% spring-dashpot-mass; series, free damped vibration;    edit IDsdmfv.m
%----------------------------------------------------------------------
IDsdmfv; eldata = [ 1 2 1000 0 1; 2 3 0 80  1]; disco2L; ux2c=ux2; save S1ux2 ux2c;         % critically damped
IDsdmfv; eldata = [ 1 2 1000 0 1; 2 3 0 20  1]; disco2L; ux2u=ux2; save S1ux2 ux2u -append; % underdamped
IDsdmfv; eldata = [ 1 2 1000 0 1; 2 3 0 200 1]; disco2L; ux2o=ux2; save S1ux2 ux2o -append; % overdamped
load S1ux2; 
figure; plot(tim,ux2c,'r',tim,ux2u,'b',tim,ux2o,'g');grid on;xlabel('t [s]');ylabel('u [m]');
        legend('b=80','b=20','b=200');axis([0 0.5 -0.2 0.3]); 
%======================================================================
% spring-dashpot-mass; parallel, step force;             edit IDsdmsf.m
%----------------------------------------------------------------------
IDsdmsf; eldata = [ 1 2  1000  80 1 ]; disco2L; ux2c=ux2; save S2ux2 ux2c;
IDsdmsf; eldata = [ 1 2  1000  20 1 ]; disco2L; ux2u=ux2; save S2ux2 ux2u -append;
IDsdmsf; eldata = [ 1 2  1000 200 1 ]; disco2L; ux2o=ux2; save S2ux2 ux2o -append;
load S2ux2; 
figure; plot(tim,ux2c,'r',tim,ux2u,'b',tim,ux2o,'g');grid on;xlabel('t [s]');ylabel('u [m]');
        legend('b=80','b=20','b=200');axis([0 0.5 -0.02 0.04]); 
%======================================================================
% spring-dashpot-mass; parallel, harmonic force;         edit IDsdmhf.m
%----------------------------------------------------------------------
IDsdmhf; disco2L; 
figure; subplot(211);plot(tim,kx2);grid on;ylabel('f [N]');
        subplot(212);plot(tim,ux2*1000);grid on;xlabel('t [s]');ylabel('u [mm]');
%======================================================================
% dashpot-coupled oscillators                          edit IDhrmosc2.m
%----------------------------------------------------------------------
clear all; ii=1; IDhrmosc2; disco2L; 
figure; plot(Sti,Su2,Sti,Su3);grid on;
        xlabel('t [s]');ylabel('disp [m]');legend('u_2','u_3');
clear all; ii=2; IDhrmosc2; disco2L; 
figure; plot(Sti,Su2,Sti,Su3);grid on;
        xlabel('t [s]');ylabel('disp [m]');legend('u_2','u_3');
%======================================================================
% spring-coupled oscillators                           edit IDhrmosc3.m
%----------------------------------------------------------------------
clear all; ii=1; IDhrmosc3; disco2L; 
figure; plot(Sti,Su2,Sti,Su3);grid on;
        xlabel('t [s]');ylabel('disp [m]');legend('u_2','u_3');
clear all; ii=2; IDhrmosc3; disco2L;
figure; plot(Sti,Su2,Sti,Su3);grid on;
        xlabel('t [s]');ylabel('disp [m]');legend('u_2','u_3');
%======================================================================
% car suspension model; step up                        edit IDcarsus1.m
%----------------------------------------------------------------------
IDcarsus1; maw=[30 250];nic=50;ts=0.05;im=5; disco2L; 
figure; plot(tim,uy1,'b',tim,uy3,'r');hold on; 
IDcarsus1; maw=[30 400];nic=50;ts=0.05;im=5; disco2L; 
        plot(tim,uy3,'g');grid on;hold off;
        xlabel('t [s]');ylabel('u_3 [m]');
        legend('u_1 [m]','M = 250 kg','M = 400 kg');
        title('im = 5; nic = 50'); 
%----------------------------------------------------------------------
% Now for im=6 which will result in more damping
%----------------------------------------------------------------------
IDcarsus1; maw=[30 250];nic=50;ts=0.05;im=6; disco2L; 
figure; plot(tim,uy1,'b',tim,uy3,'r');hold on;
IDcarsus1; maw=[30 400];nic=50;ts=0.05;im=6; disco2L; 
        plot(tim,uy3,'g');grid on;hold off;
        xlabel('t [s]');ylabel('u_3 [m]');
        legend('u_1 [m]','M = 250 kg','M = 400 kg');
        title('im = 6; nic = 50'); 
%----------------------------------------------------------------------
% Now again for im = 6 but with smaller times step : less damping
%----------------------------------------------------------------------
IDcarsus1; maw=[30 250];nic=500;ts=0.005;im=6; disco2L; 
figure; plot(tim,uy1,'b',tim,uy3,'r');hold on; 
IDcarsus1; maw=[30 400];nic=500;ts=0.005;im=6; disco2L; 
        plot(tim,uy3,'g');grid on;hold off;
        xlabel('t [s]');ylabel('u_3 [m]');
        legend('u_1 [m]','M = 250 kg','M = 400 kg');
        title('im = 6; nic = 500'); 
%======================================================================
% car suspension model; step up/down                   edit IDcarsus2.m
%----------------------------------------------------------------------
clear all; 
IDcarsus2; maw=[30 250];nic=50;ts=0.05;im=5; disco2L; 
figure; plot(tim,uy1,'b',tim,uy3,'r');hold on;
IDcarsus2; maw=[30 400];nic=50;ts=0.05;im=5; disco2L; 
        plot(tim,uy3,'g');grid on;hold off;
        xlabel('t [s]');ylabel('u_3 [m]');
        legend('u_1 [m]','M = 250 kg','M = 400 kg'); 
%----------------------------------------------------------------------
% car suspension model; step up/down                   edit IDcarsus3.m
%----------------------------------------------------------------------
figure; 
k1=100000;b1=0;k2=12500;b2=800;k3=1000;b3=5;m2=30;m3=400;m4=200; 
IDcarsus3; disco2L; plot(tim,uy1,'b',tim,uy3,'r');hold on;
k1=100000;b1=0;k2=12500;b2=800;k3=1000;b3=5;m2=30;m3=400;m4=100; 
IDcarsus3; disco2L; plot(tim,uy3,'g');hold on;
k1=100000;b1=0;k2=12500;b2=800;k3=1000;b3=5;m2=30;m3=400;m4=50; 
IDcarsus3; disco2L; plot(tim,uy3,'g');hold on;
k1=100000;b1=0;k2=12500;b2=800;k3=1000;b3=5;m2=30;m3=400;m4=10; 
IDcarsus3; disco2L; plot(tim,uy3,'g');hold on;
k1=100000;b1=0;k2=12500;b2=800;k3=1000;b3=5;m2=30;m3=400;m4=1; 
IDcarsus3; disco2L; plot(tim,uy3,'m');hold off;
grid on;xlabel('t [s]');ylabel('u_3 [m]');
%======================================================================
% human body                                             edit IDbody1.m
%----------------------------------------------------------------------
close all;clear all; IDbody1; disco2L; 
figure; plot(Sti,Sv1,Sti,Sv4,Sti,Sv5,Sti,Sv6); 
        if loadcase=='step', axis([0.01 0.1 -0.013 -0.0075]); end; 
        grid on; 
        xlabel('time [s]');ylabel('disp [m]'); 
        legend('feet','abdm','trso','head'); 
%======================================================================
% mass suspended by four Maxwell elements;                edit IDm4sd.m
%----------------------------------------------------------------------
figure;
IDm4sd; eldata = [ 1 5 1 0   1 ; 2 5 2 0   1 ; 3 5 3 0   1 ; 4 5 4 0   1]; 
disco2; plot(ux5,uy5,'r');hold on;
IDm4sd; eldata = [ 1 5 1 0.1 1 ; 2 5 2 0.1 1 ; 3 5 3 0.1 1 ; 4 5 4 0.1 1]; 
disco2; plot(ux5,uy5,'b');
IDm4sd; eldata = [ 1 5 1 1   1 ; 2 5 2 1   1 ; 3 5 3 1   1 ; 4 5 4 1   1]; 
disco2; plot(ux5,uy5,'g');hold off;
grid on;xlabel('m5_1');ylabel('m5_2');legend('b = 0','b = 0.1','b = 1');
IDm4sd; eldata = [ 1 5 1 0   1 ; 2 5 2 0   1 ; 3 5 3 0   1 ; 4 5 4 0   1]; 
nic=250;ts=0.01; disco2L;
figure; mf=0;mshop=[5 1 0 0 0 0 0 0 0];ax=[-2 2 -2 2];plotmovie;
%======================================================================

%======================================================================
% PENDULUMS AND CHAINS
%======================================================================

%======================================================================
% restricted mass movement: pendulum, 1 mass              edit IDsmp1.m 
%----------------------------------------------------------------------
IDsmp1; disco2; 
figure; subplot(221);load([matf num2str(50)]); plotmesh([1 1 0 0 0 0 0 0 0],loka,crd0,crd,eldaC,1);
        subplot(221);load([matf num2str(250)]);plotmesh([1 1 0 0 0 0 0 0 0],loka,crd0,crd,eldaC,1);
        subplot(221);load([matf num2str(500)]);plotmesh([1 1 0 0 0 0 0 0 0],loka,crd0,crd,eldaC,1);
        subplot(222);plot(SGf(2:nic+1),Af1(2:nic+1),SGf(2:nic+1),Sfi1(2:nic+1));grid on;xlabel('\\phi [deg]');ylabel('F [N]');
        subplot(212);plot(Sti,cx2);grid on;xlabel('t [s]');ylabel('y_m [m]');
figure; mf=0;mshop=[1 1 1 0 0 0 0 0 0];ax=[-5 5 -5 5];plotmovie;
%======================================================================
% restricted mass movement: pendulum, 2 mass              edit IDsmp2.m 
%----------------------------------------------------------------------
IDsmp2; disco2;
figure; subplot(211);load([matf num2str(40)]); plotmesh([1 1 0 0 0 0 0 0 0],loka,crd0,crd,eldaC,1);
        subplot(211);load([matf num2str(150)]);plotmesh([1 1 0 0 0 0 0 0 0],loka,crd0,crd,eldaC,1);
        subplot(211);load([matf num2str(500)]);plotmesh([1 1 0 0 0 0 0 0 0],loka,crd0,crd,eldaC,1);
        subplot(212);plot(tim,Sve);grid on;xlabel('t [s]');ylabel('V_e [m/s]');
figure; mf=0;mshop=[1 1 1 0 0 0 0 0 0];ax=[-10 10 -10 5];plotmovie;
%======================================================================
% restricted mass movement: pendulum, 3 mass              edit IDsmp3.m 
%----------------------------------------------------------------------
IDsmp3; disco2; 
figure; subplot(211);load([matf num2str(500)]);plotmesh([1 1 0 0 0 0 0 0 0],loka,crd0,crd,eldaC,1);
        subplot(212);plot(tim,cy2);grid on;
figure; mf=0;mshop=[1 1 1 0 0 0 0 0 0];ax=[-10 10 -15 2];plotmovie;
%======================================================================
% restricted mass movement: pendulum, 10 mass            edit IDsmp10.m 
IDsmp10; disco2; 
%----------------------------------------------------------------------
figure; subplot(311);load([matf num2str(50)]); plotmesh([1 1 0 0 0 0 0 0 0],loka,crd0,crd,eldaC,1);
        subplot(311);load([matf num2str(150)]);plotmesh([1 1 0 0 0 0 0 0 0],loka,crd0,crd,eldaC,1);
        subplot(311);load([matf num2str(350)]);plotmesh([1 1 0 0 0 0 0 0 0],loka,crd0,crd,eldaC,1);
        subplot(312);plot(tim,poe);grid on;xlabel('t [s]');ylabel('R [m]');
        subplot(313);plot(tim,Sf1);grid on;xlabel('t [s]');ylabel('F [N]'); 
figure; mf=0;mshop=[1 1 0 0 0 0 0 0 0];ax=[-15 15 -18 2];plotmovie;
%======================================================================
% pendulum on tower                                     edit IDpentow.m
%----------------------------------------------------------------------
close all; IDpentow; disco2;
figure; mf=0;mshop=[1 1 0 0 0 0 0 0 0];ax=[-5 5 0 10];plotmovie;
%======================================================================
% chain                                                  edit IDchain.m
%----------------------------------------------------------------------
close all; IDchain; disco2;
figure; plot(crd(1:15,1),crd(1:15,2));
figure; mf=0;mshop=[1 1 0 0 0 0 0 0 0];ax=[-0.01 0.32 -0.1 0.1];plotmovie;
%======================================================================
% pendulum/chain, 1 mass                                 edit IDsmpc1.m 
%----------------------------------------------------------------------
close all;
clear all; ii=1; IDsmpc1; disco2; 
figure; plot(Sti,cx2);grid on;xlabel('t [s]');ylabel('y_m [m]');
clear all; ii=2; IDsmpc1; disco2; 
figure; plot(Sti,cx2);grid on;xlabel('t [s]');ylabel('y_m [m]');
figure; mf=0;fs=2;mshop=[1 1 0 0 0 0 0 0 0];ax=[-5 5 -5 5];plotmovie;
%======================================================================
% chain suspended;                                       edit IDsmch1.m
%----------------------------------------------------------------------
close all; IDsmch1; disco2; 
figure; plot(tim,f1);grid on;xlabel('t [s]');ylabel('F^{(1)} [N]'); 
figure; mshop=[1 1 0 0 0 0 0 0 0];ax=[-1 1.5 -1 1];plotmovie;
%======================================================================
% chain on rail;                                         edit IDsmch3.m
%----------------------------------------------------------------------
close all; IDsmch3; disco2; plotdata; 
figure; mshop=[1 1 0 0 0 0 0 0 0];ax=[-1 1.5 -1 1];ps=0.01;plotmovie;;
%======================================================================
% chain falling;                                         edit IDsmch2.m
%----------------------------------------------------------------------
close all; IDsmch2; disco2; plotdata;
figure; mf=0;mshop=[1 1 0 0 0 0 0 0 0];ax=[-2 2 -2 2];plotmovie;
%======================================================================

%======================================================================
% MATERIAL MODELS
%======================================================================

%======================================================================
% elastoplastic element, cyclic loading                  edit IDelpl1.m
%----------------------------------------------------------------------
clear all; ii=1; IDelpl1; disco2; 
figure; plot(x,y);grid on;xlabel('elongation');ylabel('force');
clear all; ii=2; IDelpl1; disco2; 
figure; plot(x,y);grid on;xlabel('elongation');ylabel('force');
clear all; ii=3; IDelpl1; disco2; 
figure; plot(x,y);grid on;xlabel('elongation');ylabel('force');
%======================================================================
% elastoplastic material behaviour                       edit IDelpl2.m
%----------------------------------------------------------------------
clear all; ii=1; IDelpl2; disco2; 
figure; plot(x,y,x,y,'rx');grid on;xlabel('elongation');ylabel('force'); 
clear all; ii=2; IDelpl2; disco2; 
figure; plot(x,y,x,y,'rx');grid on;xlabel('elongation');ylabel('force'); 
clear all; ii=3; IDelpl2; disco2; 
figure; plot(x,y,x,y,'rx');grid on;xlabel('elongation');ylabel('force'); 
%======================================================================
% linear visco-elastic material; Multimode Maxwell       edit IDviel1.m
%----------------------------------------------------------------------
clear all; lll=1; mmm=2; IDviel1; disco2; 
figure; plot(tim,ux3);grid on;xlabel('t [s]');ylabel('u [mm]'); 
clear all; lll=2; mmm=2; IDviel1; disco2; 
figure; plot(tim,fx3);grid on;xlabel('t [s]');ylabel('f [N]'); 
%======================================================================
% viscoplastic material behaviour                        edit IDvipl1.m
%----------------------------------------------------------------------
clear all; ii=1; IDvipl1; disco2; 
figure; plot(x,y,x,y,'rx');grid on;xlabel('elongation');ylabel('force');
clear all; ii=2; IDvipl1; disco2; 
figure; plot(x,y,x,y,'rx');grid on;xlabel('elongation');ylabel('force');
%======================================================================
% cohesive zone models
IDchz1; disco2;                % cohesive zone spring     edit IDchz1.m
figure; plot(Su22,Sf22);grid on;
        xlabel('\Delta/\delta');ylabel('T/T_{max}'); 

IDchz5a; disco2; epsp='chz5a'; % rigid coating           edit IDchz5a.m
IDchz5b; disco2; epsp='chz5b'; % deformable coating      edit IDchz5b.m 

figure; mshop = [1 1 1 0 0 0 0 0 0];  
        plotmesh(mshop,loka,crd0,crd,eldaC,1);

figure; plot(Su11y,Sf11y); grid on; 
        xlabel('disp [\mum]'); ylabel('force [N]');
figure; plot(SD1,ST1); grid on; 
        xlabel('\Delta/\delta'); ylabel('T/T_{max}');
figure; plot(SD2,ST2); grid on; 
        xlabel('\Delta/\delta'); ylabel('T/T_{max}');
figure; plot(SD5,ST5); grid on; 
        xlabel('\Delta/\delta'); ylabel('T/T_{max}');

figure; plot(Su11y,ST1,Su11y,ST2,Su11y,ST3,Su11y,ST4,Su11y,ST5); 
        grid on; xlabel('disp'); ylabel('T/T_{max}'); 
  
figure; mf=0;mshop=[1 1 0 0 0 0 0 0 0];ax=[-2 12 -2 12]*1e-5;plotmovie; 
%======================================================================
% cohesive zone in series with elastic spring          edit IDchzfat2.m
%----------------------------------------------------------------------
close all; IDchzfat2; disco2; plotdata; 
%======================================================================
% nonlinear viscoelastic material;                        edit IDleon.m
%----------------------------------------------------------------------
clear all; temp = 275; IDleon; disco2; plot(ux3,fx3); grid on; hold on; 
clear all; temp = 300; IDleon; disco2; plot(ux3,fx3); grid on; hold on; 
clear all; temp = 325; IDleon; disco2; plot(ux3,fx3); grid on; hold on; 
clear all; temp = 350; IDleon; disco2; plot(ux3,fx3); grid on; hold off; 
legend('T=275','T=300','T=325','T=350',0)
title('Polycarbonate');xlabel('elongation [mm]');ylabel('force [N}'); 
%======================================================================
% viscoplastic Perzyna                                   edit IDperz1.m
%----------------------------------------------------------------------
clear all; IDperz1; disco2; plot(x,y); grid on;
%======================================================================

%======================================================================
% HARMONIC ANALYSIS                                       edit discoh.m
%======================================================================

%======================================================================
% Spring-dashpot-mass, harmonic force;                   edit IDharm1.m
%----------------------------------------------------------------------
clear all; close all;
b = 0.008; f0 = 1; IDharm1; discoh;
figure; plot(MGo,Mcc);xlabel('\omega');ylabel('|u_0/f_0|');grid on;
figure; plot(MGo,MGd);xlabel('\omega');ylabel('-(\pi/2 - \phi)');grid on;

%======================================================================
% Spring-dashpot-mass, harmonic force;                   edit IDharm1.m
%----------------------------------------------------------------------
clear all; close all;
figure(1);clf; hold on; 
figure(2);clf; hold on;
for b=[0.05 0.01 0.1 1]
  f0 = 1;
  IDharm1; discoh;
  figure(1); plot(MGo,Mcc); grid on; axis([0 1200 0 0.05]);
  figure(2); plot(MGo,MGd); grid on;
end;
figure(1); hold off; 
figure(2); hold off;
figure(1); xlabel('\omega'); ylabel('|u_0/f_0|'); 
figure(2); xlabel('\omega'); ylabel('-(\pi/2 - \phi)'); 

%======================================================================

%**********************************************************************
