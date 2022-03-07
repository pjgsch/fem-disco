%**********************************************************************

function [eldaB] = dsc2incend(eldaB,elda0,eldax,lok,crd,ne,ts,MTp,Mfr);

for e=1:ne

  mat  = elda0(e,10);
  s0   = elda0(e,1)  ;  c0    = elda0(e,2)  ;  l0    = elda0(e,3)  ;
  sc0  = elda0(e,5)  ;  dc0   = elda0(e,6)  ;
  sh   = elda0(e,8)  ;  sk    = elda0(e,9)  ;  Gsv0  = elda0(e,7)  ;
  A0   = 1           ;  E     = sc0*l0/A0   ;  Gn    = 0; 

  s    = eldaB(e,1)  ;  c     = eldaB(e,2)  ;  l     = eldaB(e,3)  ;
  lt   = eldaB(e,4)  ;  sc    = eldaB(e,5)  ;  dc    = eldaB(e,6)  ;
  Gsv  = eldaB(e,7)  ;  sh    = eldaB(e,8)  ;  sk    = eldaB(e,9)  ;
  Gl   = eldaB(e,11) ;  DGl   = eldaB(e,12) ;  DGlt  = eldaB(e,13) ;
  Ge   = eldaB(e,14) ;  Ged   = eldaB(e,15) ;  Geln  = eldaB(e,16) ;
  Ns   = eldaB(e,17) ;  Nd    = eldaB(e,18) ;  N     = eldaB(e,19) ;
  Gs   = eldaB(e,20) ;

  Gep  = eldaB(e,21) ; Gepe   = eldaB(e,22) ;  Gss   = eldaB(e,23) ; 
  Gb   = eldaB(e,24) ;

  MSP1 = eldaB(e,26) ;  MSP2  = eldaB(e,27) ;  MSP3  = eldaB(e,28) ;
  MSP4 = eldaB(e,29) ;  MSP5  = eldaB(e,30) ;

  Gel  = Gl-1        ;  Geln = log(Gl)        ;  Gegl = 1/2*(Gl*Gl-1);
  Ged  = -Gn*Ge      ;  Gm   = Ged+1          ;  A    = Gm*Gm*A0;

%----------------------------------------------------------------------
  if mat==11     % Lennard-Jones potential
%----------------------------------------------------------------------
    U0 = elda0(e,8);
    r0 = elda0(e,9);
    m = 6;
    n = 12;

    aa1 = (-m*n)/(n-m) * (U0)/(r0*r0);
    aa2 = -(n+1)*(r0/l)^(n+2) + (m+1)*(r0/l)^(m+2);
    sc = aa1 * aa2;
%----------------------------------------------------------------------
  elseif mat==33, % cohesive zone for fatigue
%----------------------------------------------------------------------
    Ge    = Gel         ;
    kn    = elda0(e,5);
    czcn  = eldax(e,1);
    czm   = eldax(e,2);
    czr   = eldax(e,3);
    czGsf = eldax(e,4);
    czidn = eldax(e,5);
    czpff = eldax(e,6);
    czpfe = eldax(e,7); 
    knfin = eldax(e,8);
    Dfin  = eldax(e,9);
    ichzopntozero = eldax(e,11);
    ichznegative  = eldax(e,12);
    DB    = MSP1;
    GDB   = lt-l0; 
    TB    = Ns;
    GD    = l-l0; 

    if (ichzopntozero==0) & (GD*(GD-GDB)<0),
      idamgrowth = 0;
    else
      idamgrowth = 1;
    end;

    if (idamgrowth==1) & (ichznegative==0) & (GD<0)
      idamgrowth = 0;
    end;

    if (idamgrowth==1)
      GDD = czcn * ( 1 - DB + czr )^czm * ...
            0.5 * ( abs( (abs(TB)/(1-DB) - czGsf) ) + ...
                         (abs(TB)/(1-DB) - czGsf)   ) * abs(GD-GDB);
    else
      GDD = 0;
    end;

%    if (kn*(1-(DB+GDD))>knfin),
    if ((DB+GDD)<Dfin),
      D = DB + GDD;
    else
      D = 1 - knfin/kn + 1e-10;
    end;

    sc = sc0*(1-D);
    MSP1 = D;
%----------------------------------------------------------------------    
  end;
%----------------------------------------------------------------------

  eldaB(e,1:10)  = [s c l lt sc dc Gsv sh sk 0];
  eldaB(e,11:20) = [Gl DGl DGlt Ge Ged Geln Ns Nd N Gs];
  eldaB(e,21:30) = [Gep Gepe Gss Gb 0 MSP1 MSP2 MSP3 MSP4 MSP5];

end;

%**********************************************************************
