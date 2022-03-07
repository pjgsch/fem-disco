%**********************************************************************
% function [elda0,eldaB,eldaC,mty5] = dsc2inidat(ne,eldata,lok,crd0);
%**********************************************************************

function [elda0,eldaB,eldaC,mty5] = dsc2inidat(ne,eldata,lok,crd0);

%======================================================================
%  Initialisation of integration point data
%
%  elda0 :  initial element data 
%   (e,1:10)  = [s0 c0 l0 0 sc0 dc0 Gsv0 sh sk mat];
%  eldaC :  current element data
%   (e,1:10)  = [s c l lt sc dc Gsv sh sk 0];
%   (e,11:20) = [Gl DGl DGlt Ge Ged Geln Ns Nd N Gs];
%   (e,21:30) = [Gep Gepe Gss Gb 0 MSP1 MSP2 MSP3 MSP4 MSP5];
%  eldaB :  begin (end) increment element data
%
%  s0    :  initial direction sinus of element axis
%  c0    :  initial direction cosinus of element axis
%  l0    :  initial length of element
%
%  mty5  :  count of elasto-plastic elements
%======================================================================

elda0 = zeros(ne,30); eldaB = zeros(ne,30); eldaC = zeros(ne,30);

mty5 = 0;

for e=1:ne
  sc0  = eldata(e,3);      
  dc0  = eldata(e,4);
  mat  = eldata(e,5);
  sh   = 0; 
  sk   = 0; 
  Gsv0 = 0; 

  k1   = lok(e,1); k2 = lok(e,2);
  x10  = crd0(k1,1); y10 = crd0(k1,2); x20 = crd0(k2,1); y20 = crd0(k2,2);
  l0   = sqrt((x20-x10)*(x20-x10)+(y20-y10)*(y20-y10));
  Gl0  = 1;
  s0   = (y20-y10)/l0;
  c0   = (x20-x10)/l0;

%----------------------------------------------------------------------
  if     mat==1     % a normal spring and dashpot element
%----------------------------------------------------------------------
  elseif mat==3     % cohesive zone fiber model
%----------------------------------------------------------------------
    Gf0 = eldata(e,3);
    Gd  = eldata(e,4);
    Ns  = 0;
    sc0 = (Gf0/Gd)*(1/Gd);
    dc0 = 0;
    sh  = Gf0;
    sk  = Gd;
%----------------------------------------------------------------------
  elseif mat==4     % friction spring
%----------------------------------------------------------------------
    sh = 0; sk = 0;
    Gsv0 = eldata(e,3);
    hamo = eldata(e,4);
    if hamo==1, sh = 1; end;
    if hamo==2, sk = 1; end;
    if hamo==3, sh = 1; sk = 1; end;
    sc0 = 1e10;
    dc0 = 0;
%----------------------------------------------------------------------
  elseif mat==5     % elasto-plastic material behavior
%----------------------------------------------------------------------
    mty5 = mty5 + 1;
    sh = eldata(e,6); sk = eldata(e,7); Gsv0 = eldata(e,8);
%----------------------------------------------------------------------
  elseif mat==6,
%----------------------------------------------------------------------
    elda0(e,30) = eldata(e,3);
%----------------------------------------------------------------------
  elseif mat==11,   % Lennard-Jones potential
%----------------------------------------------------------------------
    U0 = eldata(e,3);
    r0 = eldata(e,4);
    m = 6; 
    n = 12;
    l = l0;

    aa1 = (-m*n)/(n-m) * (U0)/(r0*r0);
    aa2 = -(n+1)*(r0/l)^(n+2) + (m+1)*(r0/l)^(m+2);
    sc0 = aa1 * aa2;
    dc0 = 0;
    sh = U0;
    sk = r0;
%----------------------------------------------------------------------
  elseif mat==71
%----------------------------------------------------------------------
    sh = 0; sk = 0;
    Gsv0 = eldata(e,3);
    sc0  = 1e10;
    dc0 = 0;
%----------------------------------------------------------------------
  elseif mat==72
%----------------------------------------------------------------------
    sc0  = eldata(e,3);
%----------------------------------------------------------------------
  elseif mat==73
%----------------------------------------------------------------------
    dc0  = eldata(e,4);
%----------------------------------------------------------------------
  end;
%----------------------------------------------------------------------

  elda0(e,1:10)   = [s0 c0 l0 0 sc0 dc0 Gsv0 sh sk mat];
end;

eldaC = elda0; 
eldaB = eldaC;

%======================================================================
