%**********************************************************************
% function [emc,emcc,emb,efci,efbi] = dsc2elem(e,eldaC,elda0,it);
%
% Input :  e     = element number
%          eldaC = current element data
%          elda0 = initial element data
%          it    = iteration step counter 
% Output : emc   = total stiffness matrix for element
%          emcc  = geometric linear stiffness matrix
%          emb   = damping matrix for element
%          efci  = internal elastic force
%          efbi  = internal viscous force
%**********************************************************************

function [emc,emcc,emb,efci,efbi] = dsc2elem(e,eldaC,elda0,it);

  nlf=1;

  mat = elda0(e,10); 
  l0 = elda0(e,3);
  sc = eldaC(e,5);  dc = eldaC(e,6);  l = eldaC(e,3);
  Ns = eldaC(e,17); Nd = eldaC(e,18); N = eldaC(e,19); 

  if mat==5  & it==1, sc = elda0(e,5); end;
  if mat==4  & it==1, sc = elda0(e,5); end;
  if mat==71 & it==1, sc = elda0(e,5); end;
%  if mat==73 & it==1, dc = 0; end;
%  if mat==0, Ns = 0; Nd = 0; end;
  if mat==0, nlf = 0; end;

  [ML,MN,V] = geom(e,eldaC);

  emcc = sc * ML;
  emc = emcc + nlf * Ns/l * MN;
%  if mat==0, emc=emcc; end;

  emb = dc * ML;
%  emb = emb + nlf * Nd/l * MN;

  efci = Ns * V;
  efbi = Nd * V;

%======================================================================
% The linear and nonlinear geometric matrices are calculated.
% The nonlinear matrix MN is relevant for geometric nonlinear
% deformation (large strains and/or rotations).

function [ML,MN,V] = geom(e,eldaC);

  s   = eldaC(e,1) ; c  = eldaC(e,2); 

  ML  = [  c*c  c*s -c*c -c*s   
           c*s  s*s -c*s -s*s 
          -c*c -c*s  c*c  c*s 
          -c*s -s*s  c*s  s*s ];

  MN  = [  s*s -c*s -s*s  c*s 
          -c*s  c*c  c*s -c*c
          -s*s  c*s  s*s -c*s 
           c*s -c*c -c*s  c*c ];

  V   = [ -c -s c s ]';

%======================================================================


%**********************************************************************
