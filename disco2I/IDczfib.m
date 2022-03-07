%**********************************************************************
delete('loadincr.m');delete('savedata.m');delete('updaelda.m');
delete('plotdata.m');

crd0 = [ 0 0; 0 10e-6; 0 50e-6 ];
eldata = [ 
1 2 194 1.0e-6 3 0 0 0; 
2 3 1e12 0 1 0 0 0; 
%3 4 1e00 0 1 0 0 0;
%3 4 1e09 0 4 0 0 0
];
pp = [ 1 1 0; 1 2 0; 2 1 0; 3 1 0; ];
pp = [ pp; 3 2 3e-7 ];
map = [];

nic = 500; ts = 1; im = 5; nl = 1; mit = 50; ccr = 1e-6;
Ga = 0.25; Gd  = 0.5;

loin = fopen('loadincr.m','w');
fprintf(loin,'peC = pe0; \n');
fclose(loin);

sada = fopen('savedata.m','w');
fprintf(sada,'uy2(ic+1) = MTp(2,2); uy3(ic+1) = MTp(3,2); \n');
fprintf(sada,'fy2(ic+1) = Mfi(2,2); fy3(ic+1) = Mfi(3,2); \n');
fclose(sada);

plda = fopen('plotdata.m','w');
fclose(plda);

