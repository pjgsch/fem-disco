%**********************************************************************
clear all;
delete('loadincr.m','savedata.m','updaelda.m','plotdata.m');

crd0 = [0 0; 1 0; 2 0; 0 1; 1 1; 2 1; 0 2; 1 2; 2 2 ];

nnod = size(crd0,1);

e=1;
for i=1:nnod
  for j=(i+1):nnod
    eldata(e,1) = i;
    eldata(e,2) = j;
    eldata(e,3:5) = [0.01 1.13 11];
    e=e+1;
  end;
end;

pp0 = [ 1 2 0; 2 1 0; 2 2 0; 3 2 0 ];
pp  = [ pp0 ];
ang=30/180*pi; frc=10;
pf  = [ 7 1 frc*cos(ang); 7 2 -frc*sin(ang) ];
map = [1 2 3 4 5 6 7 8 9];
mss = 1.0;
maw = mss*[1 1 1 1 1 1 1 1 1];

nic = 300; ts = 0.1; im  = 6; nl = 1; mit = 10; ccr = 0.0001;

matf = './mat/ms6';
S1 = 'crd';

loin = fopen('loadincr.m','w');
fprintf(loin,'if ic==1, feC = fe0; end; \n');
fprintf(loin,'if ic>1, feC = 0*fe0; end; \n');
%fprintf(loin,'peC = pe0; \n');
fclose(loin);

%upel = fopen('updaelda.m','w');
%for e=1:ne
%  k1 = eldata(e,1); k2 = eldata(e,2); x1
%fclose(upel);

sada = fopen('savedata.m','w');
fprintf(sada,'save(savefile,S1); \n');
fclose(sada);

plda = fopen('plotdata.m','w');
%fprintf(plda,'clf; crd=crd0; mshop = [1 1 1 0 0 0 0 0 -1]; \n');
%fprintf(plda,'pmsh(mshop,lok,crd0,crd,eldaC,2); \n');
fprintf(plda,'clf; mshop = [10 1 1 0 0 0 0 0 0]; \n');
fprintf(plda,'pmsh(mshop,lok,crd0,crd,eldaC,2); \n');
fclose(plda);

%**********************************************************************
