%**********************************************************************
%======================================================================
%  Element values are read from 'elda0', eldaC' and 'eldaB'.
%  Element values are updated. 
%  Element values may be changed in the command-file 'updaelda.m';
%   be careful to use unique local variables in this file.
%  Internal forces are calculated.
%  Element values are stored.
%
%  l     =  length of element
%  s     =  direction sinus of element axis
%  c     =  direction cosinus of element axis
%  sc    =  spring stiffness
%  dc    =  damping constant
%
%  Gl    =  elongation factor
%  DGl   =  time derivative of elongation factor
%  Ge    =  linear strain
%  Geln  =  logaritmic strain
%  Ged   =  contraction strain
%
%  MSP1  =  material state parameter
%  MSP2  =  material state parameter
%  MSP3  =  material state parameter
%  MSP4  =  material state parameter
%  MSP5  =  material state parameter
%
%  Ns    =  spring force
%  Nd    =  dashpot force
%  N     =  total element force
%  Gs    =  Cauchy stress (not relevant)
%  P     =  2nd Piola-Kirchhoff stress (not relevant)
%
%  lt    =  last known element length
%  DGlt  =  last known time derivative of elongation factor
%  Gm    =  contraction factor
%  E     =  Young's modulus
%  Gn    =  Poisson's ratio
%======================================================================

function [eldaC,mty5] = elprop2(e,eldaC,elda0,eldaB,crd,lok,ts,mty5,eldax);

mat  = elda0(e,10);
s0   = elda0(e,1)  ;  c0    = elda0(e,2)  ;  l0    = elda0(e,3)  ;
sc0  = elda0(e,5)  ;  dc0   = elda0(e,6)  ;
sh   = elda0(e,8)  ;  sk    = elda0(e,9)  ;  Gsv0  = elda0(e,7)  ;

A0   = 1	   ;  E     = sc0*l0/A0   ;  Gn    = 0; 

s    = eldaC(e,1)  ;  c     = eldaC(e,2)  ;  l     = eldaC(e,3)  ;
sc   = eldaC(e,5)  ;  dc    = eldaC(e,6)  ;
sh   = eldaC(e,8)  ;  sk    = eldaC(e,9)  ;  Gsv   = eldaC(e,7)  ;

MSP1 = eldaB(e,26) ;  MSP2  = eldaB(e,27) ;  MSP3  = eldaB(e,28) ;
MSP4 = eldaB(e,29) ;  MSP5  = eldaB(e,30) ;

lt   = eldaB(e,3)  ;  DGlt  = eldaB(e,13)  ;  

k1   = lok(e,1); k2 = lok(e,2);
x1   = crd(k1,1); y1 = crd(k1,2); x2 = crd(k2,1); y2 = crd(k2,2);
l    = sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1));
s    = (y2-y1)/l; 
c    = (x2-x1)/l;

Gl   = l/l0	   ;  DGl  = (l-lt)/(ts*l0) ;
Gel  = Gl-1	   ;  Geln = log(Gl)	    ;  Gegl = 1/2*(Gl*Gl-1);
Ge   = Gel	   ;
Ged  = -Gn*Ge	   ;  Gm   = Ged+1	    ;  A    = Gm*Gm*A0;

Gep  = 0; Gepe = 0; Gss = 0; Gb = 0; %Gsv = 0;
Gevp = 0; BGevp = 0;

%----------------------------------------------------------------------
if mat==2,          % rigid chain 
%----------------------------------------------------------------------
  if     Gl==1, sc = sc0; 
  elseif Gl<1,  sc = 1e-7*sc0;
  elseif Gl>1,  sc = 1e7*sc0;
  end;
%----------------------------------------------------------------------
end;
%----------------------------------------------------------------------

Ns = sc*(l-l0);  
Nd = dc*DGl*l0;
Gs = E*Ge;  
P  = Gm*Gm*Gs/Gl; 

%----------------------------------------------------------------------
if mat==3,          % cohesive zone 
%----------------------------------------------------------------------
  Gf0 = sh; Gd = sk; GD = l - l0;
  Ns = (Gf0/Gd)*(GD/Gd)*exp(-(GD/Gd));
  sc = (Gf0/Gd)*(1/Gd)*(1-(GD/Gd))*exp(-(GD/Gd));
  dc = 0;
  if GD<0, sc = 1e2*sc0; end;
%----------------------------------------------------------------------
elseif mat==4,      % elasto-plastic material behavior
%----------------------------------------------------------------------
  GsB	= eldaB(e,20);
  GeB	= eldaB(e,14);
  GepB  = eldaB(e,21);
  GepeB = eldaB(e,22);
  GsvB  = eldaB(e,7);
  GssB  = eldaB(e,23);

  GxB  = GsB - GssB;
  Gse = eldaC(e-2,20);
  Gx  = Gse - GssB;
  Y   = Gx*Gx - GsvB*GsvB;
  if Y<=0
%    Ge = GeB;
    Gep = GepB; Gepe = GepeB; Gs = Gse; Gss = GssB; Gsv = GsvB;
    sc = sc0;
    Ns = eldaC(e-2,17);
  else
%    Ge = eldaC(e-2,14);
%    Gb   = abs(sign(Ge-GeB)*GsvB - GxB)/abs(Gx - GxB);
%    Gef  = GeB + Gb*(Ge - GeB);
%    Gep = Gef;
    Gep = Ge;
    Gepe = GepeB + abs(Gep - GepB);
    Gss  = GssB + sk*elda0(e-1,5)*(Gep - GepB);
    Gsv  = GsvB + sh*elda0(e-1,5)*(Gepe - GepeB);
    sc  = 0;
    Ns = Gss+sign(eldaC(e-2,14)-eldaB(e-2,14))*Gsv;
  end;
%----------------------------------------------------------------------
elseif mat==41 
%----------------------------------------------------------------------
%----------------------------------------------------------------------
elseif mat==5       % elasto-plastic material behavior
%----------------------------------------------------------------------
  GeB = eldaB(e,14) ;  GepB = eldaB(e,21) ; GepeB = eldaB(e,22) ;
  GsB = eldaB(e,20) ;  GsvB = eldaB(e,7) ;  GssB  = eldaB(e,23) ;

  mty5 = mty5 + 1;
  GxB  = GsB - GssB;
  Gse  = GsB + sc0*(Ge - GeB);
  Gx   = Gse - GssB;
  Y    = Gx*Gx - GsvB*GsvB;

  if Y<=0
    Gb   = 1;
    Gep  = GepB;  Gepe = GepeB;
    Gs   = Gse;   Gss  = GssB;   Gsv = GsvB;
    C	 = sc0;
  else
    Gb   = abs(sign(Ge-GeB)*GsvB - GxB)/abs(Gx - GxB);
    Gef  = GeB + Gb*(Ge - GeB);
    Gep  = GepB + sc0/(sc0+sh+sk)*(Ge - Gef);
    Gepe = GepeB + abs(Gep - GepB);
    Gs   = GsB + Gb*(Gse - GsB) + sc0*(sh+sk)/(sc0+sh+sk)*(Ge - Gef);
    Gss  = GssB + sk*(Gep - GepB);
    Gsv  = GsvB + sh*(Gepe - GepeB);
    C	 = sc0*(sh+sk)/(sc0+sh+sk);
  end;
  sc = (Gs - GsB)/(Ge - GeB);
  Ns = A * Gs;
%----------------------------------------------------------------------
elseif mat==6       % Leonov material behavior
%----------------------------------------------------------------------
  R	  = 8.314;

  MPh	 = eldax(1);
  MPDinf = eldax(2);
  MPA0   = eldax(3);
  MPGDH  = eldax(4);
  MPGm   = eldax(5);
  MPGt0  = eldax(6);

  % leonov material state parameters
  GevB = MSP1; BGevB = MSP2; DB = MSP3; temp = MSP5;
  % updating of damping value

  BGs	 = abs(eldaB(e-1,17)+eldaB(e+1,17));
%  BGs    = abs(eldaB(e-1,17));

  Gev	 = Ge;
  BGev   = BGevB + abs(Gev-GevB);
  GDBGev = BGev - BGevB;
  CC	 = GDBGev;
  D	 = (DB + MPh*CC)/(MPDinf + MPh*CC) * MPDinf;
  p	 = -(BGs)/3;

  AA	 = MPA0 * exp( MPGDH/(R*temp) + MPGm*p/MPGt0 - D );
  if BGs>0, dcc = AA * BGs/(sqrt(3)*sinh(BGs/(sqrt(3)*MPGt0)));
  else,     dcc = dc0;
  end;
  dc=dcc;
  % store the material state parameters
  MSP1 = Gev; MSP2 = BGev; MSP3 = D; MSP5 = temp;
%----------------------------------------------------------------------
elseif mat==7       % viscoplastic (Perzyna)
%----------------------------------------------------------------------
  GeB = eldaB(e-1,14); 
  GevpB = eldaB(e,21); BGevpB = eldaB(e,22);
  GsB = eldaB(e,20); GsyB = eldaB(e,7); GlB = eldaB(e,11); Gst = GsB;

  GDt = ts;

  Gsy0 = eldax(3);
  H = eldax(4);
  Gg = eldax(5);
  N = eldax(6);
  a = eldax(7); b = eldax(8); c = eldax(9); d = eldax(10);
  E = elda0(e-1,3);
  Ge = eldaC(e-1,14);

  Gs  = GsB + E * (Ge - GeB);
  BGs = abs(Gs);
  F   = BGs - GsyB;

  if F<0
    Gsy   = GsyB;
    Gevp  = GevpB;
    BGevp = BGevpB;
    Gl    = GlB;
  else

    ccr = 1e-5; nrm = 100; mit = 10; it = 1; GDGl = 0;

    while ((nrm > ccr) & (it < mit))
      Gf    = (F/Gsy0);
      Gf    = 1/2*(Gf + abs(Gf));
      Gf    = Gf^N; % (F/Gsy0)^N; 
      GDGl  = GDt*Gg*Gf;
%      Gs    = (1/(1+E*GDGl)) * (GsB + E*Ge - E*GeB);
      Gs    = (GsB + E*Ge - E*GeB) - E*GDGl*sign(Gs);
      Gevp  = GevpB + GDGl*sign(Gs);
      BGevp = BGevpB + abs(Gevp - GevpB);
      Gsy   = Gsy0 + H*BGevp;
      Gsy   = Gsy + a*BGevp^2 + b*BGevp^3 + c*BGevp^4 + d*BGevp^7;
      BGs   = abs(Gs);
      F     = BGs - Gsy;
      nrm   = max( abs((Gs - Gst)/Gs) ); Gst   = Gs;
      it    = it+1;
    end;
  end;

%  Gee = Ge - Gevp;
  Gsv = Gsy;
%----------------------------------------------------------------------
elseif mat==70      % 
%----------------------------------------------------------------------
  Gs   = GsB + E * (Ge - GeB);
%  lccr = 1e-5; lnrm = 100; mlit = 10; lit = 1; GDGl = 0;
%----------------------------------------------------------------------
elseif mat==71      % 
%----------------------------------------------------------------------
  GsB    = eldaB(e,20);
  GeB    = eldaB(e,14);
  GevpB  = eldaB(e,21); GepB  = GevpB;
  BGevpB = eldaB(e,22); GepeB = BGevpB;
  GsvB   = eldaB(e,7) ; GsyB  = GsvB;

  Gse  = eldaC(e-2,20); BGs = abs(Gse); 
  F    = BGs - GsyB;
%  Gsy0 = Gsv0; 
  HHH = eldax(4); 
  aaa = eldax(7); bbb = eldax(8); ccc = eldax(9); ddd = eldax(10); 
  sh = F;

  if F<=0
    Gevp = GevpB; BGevp = BGevpB; Gs = Gse; Gsy = GsyB;  
    sc = sc0; 
    Ns = eldaC(e-2,17);
  else
    Gevp = Ge;
    BGevp = BGevpB + abs(Gevp - GevpB);
%    BGevp = eldaC(e+2,22);
    DBGevp = BGevp - BGevpB;
    Gsy = GsyB + elda0(e-1,5)*DBGevp;
%    Gsy = GsyB + HHH*DBGevp;
%    Gsy = Gsy + aaa*DBGevp^2 + bbb*DBGevp^3 + ccc*DBGevp^4 + ddd*DBGevp^7;
    sc = 0;
    Ns = sign(eldaC(e-2,14)-eldaB(e-2,14))*Gsy;
%    Gs = Ns;
  end;
  Gsv=Gsy;Gep=Gevp;Gepe=BGevp;
%----------------------------------------------------------------------
elseif mat==72      % 
%----------------------------------------------------------------------
%  evp = eldaC(e-1,6);
%  if evp>0
%    Ns = eldaC(e+1,18);
%  end;
%----------------------------------------------------------------------
elseif mat==73      % 
%----------------------------------------------------------------------
  GsB    = eldaB(e,20);
  GeB    = eldaB(e,14);
  GevpB  = eldaB(e,21); GepB  = GevpB;
  BGevpB = eldaB(e,22); GepeB = BGevpB;
  GsvB   = eldaB(e,7) ; GsyB  = GsvB;

  NN = eldax(6); Gg = eldax(5); 
  Gsy0 = elda0(e-1,7); Gsy = eldaC(e-1,7);
  F = eldaC(e-1,8);
  Gse  = eldaC(e-3,20);

  if F<=0
    Gevp = GevpB; BGevp = BGevpB; Nd = 0; 
  else
    Gevp = Ge;
    BGevp = BGevpB + abs(Gevp - GevpB);
    Gf = (F/Gsy0);
    Gf = 1/2*(Gf + abs(Gf));
    Gf = Gf^NN; % (F/Gsy0)^NN; 
%    DGevp = ts*Gg*Gf;
%    Gevp = GevpB + DGevp;
%    BGevp = BGevpB + abs(Gevp - GevpB);
%    dc = (Gse-Gsy)/(Gg*Gf);
    Nd   = dc*Gg*Gf;  
  end;
  Gep=Gevp;Gepe=BGevp;
%----------------------------------------------------------------------
end;
%----------------------------------------------------------------------

N = Ns + Nd;

% if mat~=4 & mat~=5
%   Gep = 0; Gepe = 0; Gss = 0; Gb = 0; Gsv = 0;
% end;

eldaC(e,1:10)  = [s c l lt sc dc Gsv sh sk 0];
eldaC(e,11:20) = [Gl DGl DGlt Ge Ged Geln Ns Nd N Gs];
eldaC(e,21:30) = [Gep Gepe Gss Gb 0 MSP1 MSP2 MSP3 MSP4 MSP5];

%**********************************************************************
