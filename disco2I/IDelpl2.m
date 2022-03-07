%**********************************************************************
delete('loadincr.m');delete('savedata.m');delete('updaelda.m');
delete('plotdata.m');

if ii==1, eldata = [ 2 3 100000 0 1; 1 2 5000 0 1; 1 2 250 ii 4 ]; end;
if ii==2, eldata = [ 2 3 100000 0 1; 1 2 5000 0 1; 1 2 250 ii 4 ]; end;
if ii==3, eldata = [ 2 3 100000 0 1; 1 2 5000 0 1; 1 2 250 ii 4 ]; end;

crd0   = [ 0 0; 1 0; 2 0 ];
%eldata = [ 2 3 100000 0 1; 1 2 5000 0 1; 1 2 250 2 4 ];

pp = [ 1 1 0; 1 2 0; 2 2 0; 3 2 0 ];
pp = [pp; 3 1 0.001];
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
fprintf(loin,'if abs(Tp(5))>=0.01 , fct=-fct; end; \n');
fprintf(loin,'peC = fct*pe0; \n');
fclose(loin);

s1 = 'crd';
sada=fopen('savedata.m','w');
fprintf(sada,'save(savefile,s1); \n');
x(1) = 0; y(1) = 0;
fprintf(sada,'x(ic+1) = MTp(3,1);\n');
fprintf(sada,'y(ic+1) = Mfi(3,1);\n');
fclose(sada);

plda=fopen('plotdata.m','w');
fprintf(plda,'plot(x,y,x,y,''rx''); grid on; \n');
fprintf(plda,'xlabel(''elongation''); ylabel(''force''); \n');
fclose(plda);

%**********************************************************************
