%**********************************************************************
delete('loadincr.m');delete('savedata.m');delete('updaelda.m');

nnod = 4;

eldata=[
1 2  1 1 0  0       3.8e5
2 3  1 1 0  7.7e6   0
3 4  1 1 0  1.1e8   0
2 4  1 1 0  1e11    0
];
nodata = [ 3 8.3e-9; 4 1.8e-9];

pp  = [ 4 0 ]; 

nic = 600; ts = 0.01; im = 1; Ga = 1/4; Gd = 1/2; mit=1; ccr=0.01;

loin=fopen('loadincr.m','w');
if exfl==1               % prescribed flow
pf  = [ 1 50/1000/60 ];
fprintf(loin,'pe = pe0; \n');
fprintf(loin,'fe = sin(6*(ti)) * fe0; \n');
fprintf(loin,'if fe(1)<0.0, fe(1)=0.0; end; \n');
ii=1;
end;
if expr==1               % prescribed pressure
pp  = [ pp; 1 15000 ];
fprintf(loin,'pe = sin(6*(ti)) * pe0; \n');
fprintf(loin,'if pe(1)<=0.0, pe(1)=0.0; end; \n');
ii=2;
end;
fclose(loin);

sada=fopen('savedata.m','w');
fprintf(sada,'tim(ic+1)=ti; \n');
fprintf(sada,'p1(ic+1)=Tp(1); \n');
fprintf(sada,'p1g(ic+1)=1/2*(Tp(1)+Tpt(1)); \n');
fprintf(sada,'fi1(ic+1)=fi(1); \n');
fprintf(sada,'fe1(ic+1)=fe(1)*1000*60; \n');
fclose(sada);

%**********************************************************************
