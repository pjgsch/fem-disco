%**********************************************************************
%clear all
delete('loadincr.m');delete('savedata.m');delete('updaelda.m'); 

crd0 = [ 0 0; 1 off2; 2 off3; 3 0; 1 -1; 2 -1 ];
eldata = [ 1 2 1e7 0 1; 2 3 1e7 0 1; 3 4 1e7 0 1; 2 5 1 0 1; 3 6 1 0 1];
pp = [ 1 1 0; 1 2 0; 4 2 0; 5 2 0; 6 2 0 ];
pp = [ pp; 5 1 0; 6 1 0 ];
pp = [ pp; 4 1 -0.0001 ];
map = [];

nic = 200;
mit = 10;
ccr = 1e-4;
ts  = 0.01;  
im  = 6;
Ga  = 0.25;  
Gd  = 0.5;   
nl  = 1;

loin=fopen('loadincr.m','w');
fprintf(loin,'peC = pe0; \n');
fclose(loin);

matf = './mat/buck1';

Sfr(1)=0; Sux(1)=0;
s1 = 'crd';
sada = fopen('savedata.m','w');
fprintf(sada,'save(savefile,s1); \n');
fprintf(sada,'Sfr(ic+1) = Mfi(4,1); \n');
fprintf(sada,'Sux(ic+1) = MTp(4,1); \n');
fclose(sada);

%plda=fopen('plotdata.m','w');
%fprintf(plda,'if ii>0,  plot(Sux,Sfr,col);grid on;hold on; end; \n');
%fprintf(plda,'if ii==0, xlabel(''disp'');ylabel(''F''); end; \n');
%fprintf(plda,'if ii==0, legend(''symm.perf'',''symm.imperf'',''anti-symm."perf"'',''anti-symm.imperf''); end; \n');
%fprintf(plda,'if ii<0,  figure; end; \n');
%fprintf(plda,'if ii<0,  subplot(211); mshop = [2 1 0 0 0 0 0 0 0]; end; \n');
%fprintf(plda,'if ii<0,  plotmesh(mshop,loka,crd0,crdsym,eldaC,2);axis([0 5 -1.2 0.5]); end; \n');
%fprintf(plda,'if ii<0,  subplot(212); mshop = [2 1 0 0 0 0 0 0 0]; end;  \n');
%fprintf(plda,'if ii<0,  plotmesh(mshop,loka,crd0,crdasy,eldaC,2);axis([0 5 -1.2 0.5]); end; \n');
%fprintf(plda,' \n');
%fprintf(plda,' \n');
%fprintf(plda,' \n');
%fclose(plda);

%**********************************************************************
