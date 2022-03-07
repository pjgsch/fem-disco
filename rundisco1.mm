%**********************************************************************
edit disco1L.m
edit disco1.m

%======================================================================
% ELECTRICAL SYSTEMS
%======================================================================

%======================================================================
% resistances, parallel and series                          edit IDrr.m
%----------------------------------------------------------------------
close all;clear all; IDrr; disco1L; 
figure; plot(Sti,SI1,Sti,SI2,Sti,SI3,Sti,SI4); 
        grid on;xlabel('t [s]');ylabel('I [A]');
figure; plot(Sti,SV1,Sti,SV2,Sti,SV3); 
        grid on;xlabel('t [s]');ylabel('V [V]');
%======================================================================
% capacitance and resistance in series                     edit IDrc2.m
%----------------------------------------------------------------------
close all;clear all; IDrc2; disco1L; 
figure; plot(tim(1:nic),iR(1:nic));
        grid on;xlabel('t [s]');ylabel('I [A]');
%======================================================================
% RC system; harmonic current;                              edit IDrc.m
%----------------------------------------------------------------------
clear all;close all; IDrc; disco1L; 
figure; subplot(221);plot(tim,i1);grid on;xlabel('t [s]');ylabel('I [A]');
        subplot(222);plot(tim,v1);grid on;xlabel('t [s]');ylabel('V [V]');
        subplot(223);plot(tim,iC);grid on;xlabel('t [s]');ylabel('I_C [A]');
        subplot(224);plot(tim,iR);grid on;xlabel('t [s]');ylabel('I_R [A]');   
C = 20e-6; R = 1e4; I_0 = 3; Go = 10;
sol =  C*R*R*I_0*Go/(C*C*R*R*Go*Go+1) * exp(-tim./(C*R)) + ...
       R*I_0/(C*C*R*R*Go*Go+1)*sin(Go*tim) - ...
       C*R*R*I_0*Go/(C*C*R*R*Go*Go+1)*cos(Go*tim);
figure; subplot(211);plot(tim,v1);grid on;xlabel('t [s]');ylabel('v1 [V]');
        subplot(212);plot(tim,sol);axis([0 2 -2e4 2e4]);grid on;
        xlabel('t [s]');ylabel('v1_{exacr} [V]');
%======================================================================
% inductance and resistance in series                      edit IDrl2.m
%----------------------------------------------------------------------
clear all;close all; IDrl2; disco1L; 
figure; plot(tim(1:nic),i1(1:nic));grid on;
        xlabel('t [s]');ylabel('I [A]'); 
%======================================================================
% RRC system; block voltage;                               edit IDrrc.m
%----------------------------------------------------------------------
clear all;close all; IDrrc; disco1L; 
figure; subplot(311);plot(tim,v1);grid on;ylabel('V [V]');xlabel('t [s]'); 
        subplot(312);plot(tim,v2);grid on;ylabel('V_{RC} [V]');xlabel('t [s]'); 
        subplot(313);plot(tim,iC);grid on;ylabel('I_C [A]');xlabel('t [s]'); 
%======================================================================
% RCL system; step voltage;                                edit IDrcl.m
%----------------------------------------------------------------------
clear all;close all; IDrcl; disco1L; 
figure; subplot(211);plot(tim,v1);grid on;ylabel('V_1 [V]');xlabel('t [s]');
        subplot(212);plot(tim,v2);grid on;ylabel('V_2 [V]');xlabel('t [s]');
%======================================================================
% diod;                                                  edit IDdiode.m
%----------------------------------------------------------------------
clear all;close all; IDdiode; disco1L; 
figure; plot(tim,v1,tim,v2,tim,v3);grid on;
        xlabel('t [s]');ylabel('V [V]');legend('V_1','V_2','V_3',0);
figure; plot(tim,iD,tim,iP,tim,iS,'--');grid on;
        xlabel('t [s]');ylabel('I [A]');legend('I_d','I_p','I_s',0);
%======================================================================
% bridge or Graetz ; AC-DC voltage converter            edit IDbridge.m
%----------------------------------------------------------------------
clear all; ii=1; IDbridge; disco1L; 
figure; plot(tim,v1,'--',tim,v3-v4);grid on;
        xlabel('t [s]');ylabel('V [V]');axis([0 0.5 -1.1 1.1]);
clear all; ii=2; IDbridge; disco1L; 
figure; plot(tim,v1,'--',tim,v3-v4);grid on;
        xlabel('t [s]');ylabel('V [V]');axis([0 0.5 -1.1 1.1]);
%======================================================================

%======================================================================
% FLUIDIAL SYSTEMS
%======================================================================

%======================================================================
% Puls duplicator system;                              edit IDpudufl1.m
%----------------------------------------------------------------------
clear all;close all; expr=0; exfl=1; IDpudufl1; disco1L; 
figure; subplot(211);plot(tim,fe1);grid on;ylabel('Q [l/min]'); 
        subplot(212);plot(tim,p1g);grid on;ylabel('p [Pa]');xlabel('t [s]'); 
clear all;           expr=1; exfl=0; IDpudufl1; disco1L; 
figure; subplot(211);plot(tim,p1g);grid on;ylabel('p [Pa]');
        subplot(212);plot(tim,fi1);grid on;ylabel('Q [l/min]');xlabel('t [s]');
%======================================================================
% Pipe system                                          edit IDflpipe1.m
%----------------------------------------------------------------------
clear all;close all; IDflpipe1; disco1; 
figure; plot(Sti,Sp1,Sti,Sp3,Sti,Sp6,Sti,Sp10);grid on;
        xlabel('time [s]');ylabel('pressure [Pa]');
        legend('p_{inlet}','p_3','p_6','p_{10}');
figure; plot(Sti,Sp1,Sti,Sp3,Sti,Sp6,Sti,Sp10);grid on;
        xlabel('time [s]');ylabel('pressure [Pa]');
        legend('p_{inlet}','p_3','p_6','p_{10}');
        axis([0.75 1 9.2e4 10.0e4]);
figure; plot(Sti,Sq2,Sti,Sq6,Sti,Sq10);grid on;
        xlabel('time [s]');ylabel('flow [m^3/s]'); 
%======================================================================
% extruder (pump) + die                               edit IDextruder.m
%----------------------------------------------------------------------
clear all;close all; Next=2; IDextruder; Ghpm = 2000; disco1; 
figure; plot(Sti,pmax*ones(nic+1,1),'k',Sti,Sp3);grid on;
        xlabel('time [s]');ylabel('pressure [Pa]');
        legend('p_{max}','p_{extr}'); 
figure; plot(Sti,Qmax*ones(nic+1,1),'k',Sti,Sq3);grid on;
        xlabel('time [s]');ylabel('flow [m^3/s]');
        legend('q_{max}','q_{extr}'); 
figure; plot(Sp3,Qmax*ones(nic+1,1),'k',Sp3,Sq3);grid on;
        xlabel('pressure [Pa]');ylabel('flow [m^3/s]');
        legend('q_{max}','q_{extr}'); 
%======================================================================

%======================================================================
% THERMAL SYSTEMS
%======================================================================

%======================================================================
% Thermal flow                                           edit IDthfl1.m
%----------------------------------------------------------------------
close all; IDthfl1; disco1L;
figure; plot(tim/3600,STe,tim/3600,STge,tim/3600,STgi,tim/3600,STi);
        grid on;xlabel('time [hrs]');ylabel('temp [^oC]');
        legend('T_{outside}','T_{glass-ext}','T_{glass-int}','T_{inside}'); 
figure; plot(tim/3600,Sqi);text(0.08,-2000,['final heat flow   ' num2str(Sqi(nic)) ' [W]']);
        grid on;xlabel('time [hrs]');ylabel('heat flow [W]');
%======================================================================

%**********************************************************************
