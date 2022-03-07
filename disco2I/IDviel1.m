%**********************************************************************
delete('loadincr.m','savedata.m','updaelda.m','plotdata.m');

crd0   = [ 0 0; 0.5 0; 1 0];

if     mmm==1
eldata = [ 
1 2  2.4e-7 0 1 ; 2 3  0 1.0e+4*2.4e-7 1 
1 2  2.7e-5 0 1 ; 2 3  0 7.2e+2*2.7e-5 1 
1 2  4.5e-3 0 1 ; 2 3  0 5.1e+1*4.5e-3 1 
1 2  9.0e-1 0 1 ; 2 3  0 2.3e+0*9.0e-1 1 
1 2  1.7e+3 0 1 ; 2 3  0 9.8e-2*1.7e+3 1 
1 2  1.9e+4 0 1 ; 2 3  0 1.3e-2*1.9e+4 1 
1 2  5.3e+4 0 1 ; 2 3  0 1.2e-3*5.3e+4 1 
1 2  7.6e+4 0 1 ; 2 3  0 9.8e-5*7.6e+4 1 
1 3  0 0 1
];
if lll==1, tsm = 0.00025; elseif lll==2, tsm = 0.00025; end;
disamp = 0.1; 
foramp = 0.1;
elseif mmm==2
eldata = [ 
1 2  1.0e+3 0 1 ; 2 3  0 1.0e+4*1.0e+3 1 
1 2  1.8e+2 0 1 ; 2 3  0 1.0e+3*1.8e+2 1 
1 2  3.3e+1 0 1 ; 2 3  0 1.0e+2*3.3e+1 1 
1 2  1.0e+1 0 1 ; 2 3  0 9.9e+0*1.0e+1 1 
1 2  2.8e+2 0 1 ; 2 3  0 8.1e-1*2.8e+2 1 
1 2  5.3e+2 0 1 ; 2 3  0 8.2e-2*5.3e+2 1 
1 2  1.1e+3 0 1 ; 2 3  0 4.9e-3*1.1e+3 1 
1 2  2.9e+3 0 1 ; 2 3  0 3.3e-4*2.9e+3 1 
1 2  1.9e+4 0 1 ; 2 3  0 6.8e-5*1.9e+4 1 
1 3  9.6e+2 0 1
];
tsm  = 250;
disamp = 0.1;
foramp = 0.1;
elseif mmm==3
eldata = [ 
1 2  1.2e+4 0 1 ; 2 3  0 2.2e+3*1.2e+4 1 
1 2  8.0e+3 0 1 ; 2 3  0 2.3e+2*8.0e+3 1 
1 2  1.7e+4 0 1 ; 2 3  0 2.4e+1*1.7e+4 1 
1 2  3.3e+4 0 1 ; 2 3  0 2.5e+0*3.3e+4 1 
1 2  3.7e+4 0 1 ; 2 3  0 2.5e-1*3.7e+4 1 
1 2  7.6e+4 0 1 ; 2 3  0 2.6e-2*7.6e+4 1 
1 2  2.3e+5 0 1 ; 2 3  0 2.7e-3*2.3e+5 1 
1 2  1.3e+6 0 1 ; 2 3  0 2.8e-4*1.3e+6 1 
1 2  5.4e+6 0 1 ; 2 3  0 2.9e-5*5.4e+6 1 
1 2  3.9e+6 0 1 ; 2 3  0 3.0e-6*3.9e+6 1 
1 2  1.4e+6 0 1 ; 2 3  0 3.0e-7*1.4e+6 1 
1 2  3.0e+6 0 1 ; 2 3  0 3.1e-8*3.0e+6 1 
1 3  2.5e+5 0 1
];
tsm  = 0.25;
disamp = 0.1;
foramp = 0.1;
end;

pp  = [ 1 1 0 ; 1 2 0 ; 2 2 0 ; 3 2 0 ]; 
map=[];

nic = 100;  
ts  = tsm;
im  = 5;   
Ga  = 0.25;  
Gd  = 0.5; 
mit = 10;
ccr = 0.01;
nl  = 1;

loin=fopen('loadincr.m','w');
if     lll==1          % force step -> creep
  pf  = [ 3 1 foramp ];
  fprintf(loin,'feC = fe0; peC = pe0; \n');
elseif lll==2          % displacement step -> relaxation
  pp  = [ pp ; 3 1 disamp ];
  fprintf(loin,'if (ic==1), peC = pe0; else, peC = 0*pe0; end; \n');
end;
fclose(loin);


s1 = 'crd';
sada=fopen('savedata.m','w');
fprintf(sada,'save(savefile,s1); \n');
fprintf(sada,'tim(ic+1)=ti; \n'); 
fprintf(sada,'ux3(ic+1)=MTp(3,1); \n');
fprintf(sada,'fx3(ic+1)=Mfi(3,1); \n');
fprintf(sada,'kx3(ic+1)=Mfe(3,1); \n');
fclose(sada);

plda=fopen('plotdata.m','w');
fprintf(plda,'if lll==1, subplot(211);plot(tim,ux3);grid on; end; \n');
fprintf(plda,'if lll==1, xlabel(''t [s]'');ylabel(''u [mm]''); end; \n');
fprintf(plda,' \n');
fprintf(plda,'if lll==2, subplot(212);plot(tim,fx3);grid on; end; \n');
fprintf(plda,'if lll==2, xlabel(''t [s]'');ylabel(''f [N]''); end; \n');
fprintf(plda,' \n');
fclose(plda);

%**********************************************************************
