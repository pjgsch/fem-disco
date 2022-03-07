%**********************************************************************
delete('loadincr.m','savedata.m','updaelda.m','plotdata.m');

crd0   = [ 0 0 ; 1 0 ];

if ii==1, eldata = [ 1 2 100000 0 5 5000 0 2500 ]; end
if ii==2, eldata = [ 1 2 100000 0 5 0 5000 2500 ]; end
if ii==3, eldata = [ 1 2 100000 0 5 5000 5000 2500 ]; end

pp     = [1 1 0 ; 1 2 0 ; 2 1 0.025 ; 2 2 0];
%pf     = [ ];
map = [];

nic = 50;  
ts  = 1;
im  = 5;   
Ga  = 0.25;  
Gd  = 0.5;
nl  = 1;   
mit = 10;    
ccr = 0.01;
part = 1;

loin=fopen('loadincr.m','w');
fprintf(loin,'if ic==1 , Ipe = pe0;end;\n');
fprintf(loin,'if ic>=6 , Ipe = -pe0;end;\n');
fprintf(loin,'if ic>=16 , Ipe = pe0;end;\n');
fprintf(loin,'if ic>=26 , Ipe = -pe0;end;\n');
fprintf(loin,'if ic>=36 , Ipe = pe0;end;\n');
fprintf(loin,'if ic>=46 , Ipe = -pe0;end;\n');
fprintf(loin,'if ic>=56 , Ipe = pe0;end;\n');
fprintf(loin,'if ic>=66 , Ipe = -pe0;end;\n');
fprintf(loin,'if ic>=76 , Ipe = pe0;end;\n');
fprintf(loin,'if ic>=86 , Ipe = -pe0;end;\n');
fprintf(loin,'if ic>=96 , Ipe = pe0;end;\n');
fprintf(loin,'if ic>=106 , Ipe = -pe0;end;\n');
fprintf(loin,'if ic>=116 , Ipe = pe0;end;\n');
fprintf(loin,'if ic>=126 , Ipe = -pe0;end;\n');
fprintf(loin,'peC = Ipe;\n');
fclose(loin);

s1 = 'crd';
sada=fopen('savedata.m','w');
fprintf(sada,'save(savefile,s1); \n');
x(1) = 0; y(1) = 0;
fprintf(sada,'x(ic+1) = MTp(2,1);\n');
fprintf(sada,'y(ic+1) = Mfi(2,1);\n');
fclose(sada);

plda=fopen('plotdata.m','w');
fprintf(plda,'plot(x,y); grid on; \n');
fprintf(plda,'xlabel(''elongation''); ylabel(''force''); \n');
fprintf(plda,' \n');
fclose(plda);


%**********************************************************************
