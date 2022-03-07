%**********************************************************************
clear all;
delete('loadincr.m','savedata.m','updaelda.m','plotdata.m');

crd0    = [ 
0.0 0.0; 
0.1 0.1; 0.2 0.1; 0.3 0.1; 0.4 0.1; 0.5 0.1; 
0.6 0.1; 0.7 0.1; 0.8 0.1; 0.9 0.1; 1.0 0.1; 
1.1 0.0 
];

esc = 1; edp = 1; ety = 2;
%esc = 1e7; edp = 0; ety = 1;
eldata  = [ 
1 2 esc 1e3 ety; 
2 3 esc edp ety; 3 4 esc edp ety; 4 5 esc edp ety; 5 6 esc edp ety;
6 7 esc edp ety; 7 8 esc edp ety; 8 9 esc edp ety; 9 10 esc edp ety; 
10 11 esc edp ety; 11 12 esc 1e3 ety;
];
pp      = [ 1 1 0; 1 2 0; 12 1 0; 12 2 0 ];
pf      = [ 
2 2 -10; 3 2 -10; 4 2 -10; 5 2 -10; 6 2 -10; 
7 2 -10; 8 2 -10; 9 2 -10; 10 2 -10; 11 2 -10;
];
map     = [ 2 3 4 5 6 7 8 9 10 11 ];
maw     = [ 1 1 1 1 1 1 1 1 1 1 ];

nic = 250; 
mit = 10;
ccr = 1e-6;
ts  = 0.01;
im  = 6;   
Ga  = 0.25; 
Gd  = 0.5; 
nl  = 1;

loin=fopen('loadincr.m','w');
%fprintf(loin,'if (ic==1), fe = fe0; else, fe = 0*fe0; end; \n');
fprintf(loin,'peC = pe0; \n');
fprintf(loin,'feC = fe0; \n');
fclose(loin);

matf = './mat/smch1';
s1 = 'crd';
sada=fopen('savedata.m','w');
fprintf(sada,'save(savefile,s1); \n');
fprintf(sada,'tim(ic+1)=ti; \n'); 
fprintf(sada,'fx1(ic+1)=Mfi(1,1); \n');
fprintf(sada,'fy1(ic+1)=Mfi(1,2); \n');
fprintf(sada,'fx6(ic+1)=Mfi(12,1); \n');
fprintf(sada,'fy6(ic+1)=Mfi(12,2); \n');
fprintf(sada,'f1(ic+1) =sqrt(Mfi(1,1)^2 + Mfi(1,2)^2); \n');
fprintf(sada,'l10(ic+1) =elda0(1,3); \n');
fprintf(sada,'l1C(ic+1) =eldaC(1,3); \n');
fclose(sada);

plda=fopen('plotdata.m','w');
fprintf(plda,'clf; mshop = [1 1 0 0 0 0 0 0 0]; \n');
fprintf(plda,'axis([-1 1.5 -1 1]); \n');
fprintf(plda,'subplot(121);load([matf num2str(20)]); \n');
fprintf(plda,'plotmesh(mshop,loka,crd0,crd,eldaC,2); \n');
fprintf(plda,'subplot(121);load([matf num2str(50)]); \n');
fprintf(plda,'plotmesh(mshop,loka,crd0,crd,eldaC,2); \n');
fprintf(plda,'subplot(121);load([matf num2str(250)]); \n');
fprintf(plda,'plotmesh(mshop,loka,crd0,crd,eldaC,2); \n');
fprintf(plda,'subplot(122);plot(tim,f1);grid on; \n');
fprintf(plda,'xlabel(''t [s]'');ylabel(''F^{(1)} [N]''); \n');
fprintf(plda,' \n');
fprintf(plda,' \n');
fclose(plda);

%**********************************************************************
