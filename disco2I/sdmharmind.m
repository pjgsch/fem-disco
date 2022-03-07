%**********************************************************************
delete('loadincr.m');delete('savedata.m');delete('updaelda.m');

lok    = [ 1 2  1 ]; 
crd0   = [ 0 0; 0.1 0 ];
eldata = [ 1 2 116 b 1];
pp     = [ 1 1 0 ; 1 2 0 ; 2 2 0 ];  
pf     = [ 2 1 f0 ];
map    = [ 2 ];   
maw    = [ 236e-6 ];

nic = 100; 
ts  = 0.01; 
Gob  = 0; 
Goe  = 1200; 
GDGo = (Goe-Gob)/nic;
%nl  = 0;

loin=fopen('loadincr.m','w');
fprintf(loin,'fe = fe0;\n');
fclose(loin);

%s1 = 'crd';
sada=fopen('savedata.m','w');
%fprintf(sada,'save(savefile,s1); \n');
fprintf(sada,'MGo(ic)=Go; \n'); 
fprintf(sada,'aaa=paa(3); \n'); 
fprintf(sada,'bbb=pbb(3); \n'); 
fprintf(sada,'Mcc(ic)=sqrt(aaa*aaa + bbb*bbb)/f0; \n'); 
fprintf(sada,'MGd(ic)=-180/pi*atan(aaa/bbb); \n'); 
fclose(sada);

%**********************************************************************
