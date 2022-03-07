%**********************************************************************
delete('loadincr.m','savedata.m','updaelda.m');

  E = 1800; Gn = 0.37; Gsy0 = 37; HHH = -200; Gg = 0.001; NN = 3;
  aaa = 500; bbb = 700; ccc = 800; ddd = 30000;

crd0   = [ 0 0; 1 0; 2 0 ];
%eldata = [ 2 3 E 0 1; 1 2 37 0 71; 1 2 0.01 0 1];% 1 2 0 0 73 ];
%eldata = [ 2 3 E 0 1; 1 2 90 0 1; 1 2 37 0 71; 1 2 0 1100 1 ];
eldata = [ 2 3 100000 0 1; 1 2 5000 0 1; 1 2 250 0 71; 1 2 0 7.5e4 73 ];
eldata = [ 2 3 100000 0 1; 1 2 5000 0 1; 1 2 250 0 71; 1 2 0 0 73 ];

eldax  = [ E Gn Gsy0 HHH Gg NN aaa bbb ccc ddd ];

pp = [ 1 1 0; 1 2 0; 2 2 0; 3 2 0 ];
pp = [ pp; 3 1 0.001];
map = [];

nic = 100;  
ts  = 1;
im  = 6;   
Ga  = 0.25;  
Gd  = 0.5;
nl  = 1;   
mit = 20;    
ccr = 1e-6;
fct = 1;

loin=fopen('loadincr.m','w');
%fprintf(loin,'if abs(MTp(3,1))>=0.01 , fct=-fct; end; \n');
fprintf(loin,'peC = fct*pe0; \n');
fclose(loin);

sada=fopen('savedata.m','w');
s1 = 'crd';
fprintf(sada,'save(savefile,s1); \n');
x(1) = 0; y(1) = 0;
fprintf(sada,'x(ic+1) = MTp(3,1);\n');
fprintf(sada,'x2(ic+1) = MTp(2,1);\n');
fprintf(sada,'y(ic+1) = Mfi(3,1);\n');
fprintf(sada,'SGe1(ic+1) = eldaB(1,14);\n');
fprintf(sada,'SGs1(ic+1) = eldaB(1,20);\n');
fprintf(sada,'Snn1(ic+1) = eldaB(1,19);\n');
fprintf(sada,'Ssy2(ic+1) = eldaB(2,7);\n');
fprintf(sada,'SGe2(ic+1) = eldaB(2,14);\n');
fprintf(sada,'Ssc2(ic+1) = eldaB(2,5);\n');
fprintf(sada,'Snn2(ic+1) = eldaB(2,19);\n');
fprintf(sada,'Snn3(ic+1) = eldaB(3,19);\n');
%fprintf(sada,'SGe4(ic+1) = eldaB(4,14);\n');
%fprintf(sada,'Sdc4(ic+1) = eldaB(4,6);\n');
%fprintf(sada,'Snn4(ic+1) = eldaB(4,19);\n');
%fprintf(sada,'Sdg4(ic+1) = eldaB(4,12);\n');
%fprintf('savedata.m','Sep4(ic+1) = eldaB(4,21);\n');
fclose(sada);


%**********************************************************************
