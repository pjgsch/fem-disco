%**********************************************************************
clear all;
delete('loadincr.m');delete('savedata.m');delete('updaelda.m'); 

nnn = 20;

[crd0,lok]=mesher(nnn,nnn,0.1,0.1,1,1,1,0); crd=crd0;
eldata = [lok(:,3:4) ones(size(lok,1),1)*[10 0 1]];

for i=1:nnn
  j1 = (i-1)*2+1; j2 = (i-1)*2+2;
  pp(j1,1) = i; pp(j1,2) = 1; pp(j1,3) = 0;
  pp(j2,1) = i; pp(j2,2) = 2; pp(j2,3) = 0;
end;

%pp = [ 
% 1 1 0;  1 2 0;  2 1 0;  2 2 0;  3 1 0;  3 2 0;  4 1 0;  4 2 0;  5 1 0;  5 2 0; 
% 6 1 0;  6 2 0;  7 1 0;  7 2 0;  8 1 0;  8 2 0;  9 1 0;  9 2 0; 10 1 0; 10 2 0; 
%11 1 0; 11 2 0; 12 1 0; 12 2 0; 13 1 0; 13 2 0; 14 1 0; 14 2 0; 15 1 0; 15 2 0; 
%16 1 0; 16 2 0; 17 1 0; 17 2 0; 18 1 0; 18 2 0; 19 1 0; 19 2 0; 20 1 0; 20 2 0; 
%21 1 0; 21 2 0; 22 1 0; 22 2 0; 23 1 0; 23 2 0; 24 1 0; 24 2 0; 25 1 0; 25 2 0; 
%];

%pp = [ pp; nnn*nnn 1 0.05; nnn*nnn 2 0.0 ];
pf = [ nnn*nnn 1 0.1; nnn*nnn 2 0.0 ];
map=[];

nic = 100;
ts  = 0.1;
im  = 6;
mit = 10;
ccr = 1e-1;
nl  = 1;

loin=fopen('loadincr.m','w');
%fprintf(loin,'if (ic==1), peC = pe0; else, peC = 0*pe0; end; \n');
fprintf(loin,'feC = fe0; \n');
fclose(loin);

upda=fopen('updaelda.m','w');
fprintf(upda,'if (eldaB(e,14)>0.01) & (eldaB(e,14)<0.075) & (eldaB(e,5)>0.1), eldaC(e,5)=0.95*eldaB(e,5); end; \n');
fclose(upda);

sada=fopen('savedata.m','w');
matf = './mat/stadam1';
s1 = 'crd'; s2 = 'eldaC';
fprintf(sada,'save(savefile,s1,s2); \n');
fprintf(sada,'Sti(ic+1) = ti; \n');
fprintf(sada,'Sfx(ic+1) = Mfr(nnn*nnn,1); \n');
fprintf(sada,'Sfy(ic+1) = Mfr(nnn*nnn,2); \n');
fprintf(sada,'Sux(ic+1) = MTp(nnn*nnn,1); \n');
fprintf(sada,'Suy(ic+1) = MTp(nnn*nnn,2); \n');
fclose(sada);


%**********************************************************************
