%**********************************************************************
clear all;
delete('loadincr.m');delete('savedata.m');delete('updaelda.m'); 
delete('plotdata.m');

SSS = 500000;
DDD = 10000;

voetM = 5;
kuitS = 5*SSS; dijbS = 5*SSS; beenD = DDD; beenM = 15; heupM = 5;
buikS = SSS/10; buikD = 5*DDD; buikM = 10;
ruggS = 5*SSS;
brstS = SSS/2; brstD = 3*DDD; brstM = 10;
halsS = 5*SSS; halsD = DDD;
headM = 5;
armsS = SSS/2; armsD = DDD; armsM = 5;

crd0   = [ 0 0; 0 0.5; 0 1; 0 1.25; 0 1.5; 0 1.75; 0 1.25 ];
eldata = [ 
1 2 kuitS  0      1;
1 3 0      beenD  1;
2 3 dijbS  0      1;
3 4 buikS  buikD  1;
3 5 ruggS  0      1;
4 5 brstS  brstD  1;
5 6 halsS  halsD  1;
5 7 armsS  armsD  1
];

pp     = [ 1 1 0; 2 1 0; 3 1 0; 4 1 0; 5 1 0; 6 1 0; 7 1 0 ];
map    = [ 1     2     3     4     5     6     7     ];
maw    = [ voetM beenM heupM buikM brstM headM armsM];

nic = 200; 
ts  = 0.0005; 
im  = 5; 
Ga  = 0.25; 
Gd  = 0.5; 
mit = 1;
ccr = 0.01;
nl  = 1;

loin=fopen('loadincr.m','w');
%----------------------------------------------------------------------
% pulse force -> free vibration
%pp = [ pp; 1 2 0 ]; pf = [ 6 2 1 ];
%fprintf(loin,'if (ic==1), feC = fe0; end; \n');
%fprintf(loin,'if (ic==2), feC = 0*fe0; end; \n');

% gravity and harmonic displacement on feet
% freq = (100*pi)/(2*pi) = 50 Hz
loadcase='harm';
pp = [ pp; 1 2 1 ];
pf = [ 1 2 -10; 2 2 -10; 3 2 -10; 4 2 -10; 5 2 -10; 6 2 -10; 7 2 -10 ];
fprintf(loin,'feC=fe0; \n');
fprintf(loin,'if (ti>0.01), peC=0.001*pe0*(sin(100*pi*ti)-sin(100*pi*(ti-ts))); end; \n');

% gravity and step displacement of feet 
%loadcase = 'step';
%pp = [ pp; 1 2 1 ];
%pf = [ 1 2 -10; 2 2 -10; 3 2 -10; 4 2 -10; 5 2 -10; 6 2 -10; 7 2 -10 ];
%fprintf(loin,'feC=fe0; \n');
%fprintf(loin,'if (ti>0.01)&(ti<=0.01+0.01), peC=-ts*pe0; else, peC=0*pe0; end; \n');

% harmonic force on torso
%pp = [ pp; 6 2 0 ]; pf = [ 5 2 1 ]; nic = 1000; ts = 0.005
%fprintf(loin,'fe = fe0*sin(2*pi*ti); \n');
%----------------------------------------------------------------------
fclose(loin);

matf = './mat/body1';
s1 = 'crd';
sada=fopen('savedata.m','w');
fprintf(sada,'save(savefile,s1); \n');
fprintf(sada,'Sti(ic+1)=ti; \n'); 
fprintf(sada,'Sv1(ic+1)=MTp(1,2); \n');
fprintf(sada,'Sv2(ic+1)=MTp(2,2); \n');
fprintf(sada,'Sv3(ic+1)=MTp(3,2); \n');
fprintf(sada,'Sv4(ic+1)=MTp(4,2); \n');
fprintf(sada,'Sv5(ic+1)=MTp(5,2); \n');
fprintf(sada,'Sv6(ic+1)=MTp(6,2); \n');
fprintf(sada,'Sv7(ic+1)=MTp(7,2); \n');
fprintf(sada,'Sa1(ic+1)=MTddp(1,2); \n');
fprintf(sada,'Sfe(ic+1)=Mfe(5,2); \n');
fclose(sada);

plda = fopen('plotdata.m','w');
%fprintf(plda,'plot(Sti,Sv1,Sti,Sv2); \n');
%fprintf(plda,'plot(Sti,Sfe,Sti,Sv1*1e7); \n');
%fprintf(plda,'plot(Sti,Sv1,Sti,Sv2,Sti,Sv3,Sti,Sv4,Sti,Sv5,Sti,Sv6,Sti,Sv7); \n');
%fprintf(plda,'plot(Sti,Sv1,Sti,Sv4,Sti,Sv5,Sti,Sv6); \n');
fprintf(plda,'plot(Sti,Sv1,Sti,Sv4,Sti,Sv5,Sti,Sv6); \n');
fprintf(plda,'if loadcase==''step'', axis([0.01 0.1 -0.013 -0.0075]); end; \n');
fprintf(plda,'grid on; \n');
fprintf(plda,'xlabel(''time [s]'');ylabel(''disp [m]''); \n');
%fprintf(plda,'legend(''feet'',''knee'',''hips'',''abdm'',''trso'',''head'',''arms''); \n');
%fprintf(plda,'legend(''feet'',''abdm'',''trso'',''head''); \n');
fprintf(plda,'legend(''feet'',''abdm'',''trso'',''head''); \n');
fprintf(plda,' \n');
fclose(plda);

%**********************************************************************
