%**********************************************************************
%  fbiblcase.m
%
%  lc#     :  loadcase : maximum 5+1 loadcases at this moment
%  pe0     :  array with prescribed initial displacements
%  fe0     :  array with prescribed initial forces
%======================================================================

if exist('npdof'),  clear npdof; end;
if exist('npfor'),  clear npfor; end;
if exist('npl'),    clear npl;   end;
if exist('npr'),    clear npr;   end;
if exist('nudof'),  clear nudof; end;
if exist('ppc'),    clear ppc;   end;
if exist('ppv'),    clear ppv;   end;
if exist('pfc'),    clear pfc;   end;
if exist('pfv'),    clear pfv;   end;
if exist('plc'),    clear plc;   end;
if exist('prc'),    clear prc;   end;
if exist('pa'),     clear pa;    end;
if exist('pu'),     clear pu;    end;
if exist('prs'),    clear prs;   end;

%======================================================================

if lc==1
  if exist('pp'),   clear pp;  end;  if exist('pf'),   clear pf;  end;
  if exist('pl'),   clear pl;  end;  if exist('pr'),   clear pr;  end;
  if exist('lim'),  clear lim; end;  if exist('lif'),  clear lif; end;
  if exist('pp1'),  pp  = pp1; end;  if exist('pf1'),  pf  = pf1; end;
  if exist('pl1'),  pl  = pl1; end;  if exist('pr1'),  pr  = pr1; end;
  if exist('lim1'), lim = lim1; end; if exist('lif1'), lif = lif1; end;
end;
if lc==2
  if exist('pp'),   clear pp;  end;  if exist('pf'),   clear pf;  end;
  if exist('pl'),   clear pl;  end;  if exist('pr'),   clear pr;  end;
  if exist('lim'),  clear lim; end;  if exist('lif'),  clear lif; end;
  if exist('pp2'),  pp  = pp2; end;  if exist('pf2'),  pf  = pf2; end;
  if exist('pl2'),  pl  = pl2; end;  if exist('pr2'),  pr  = pr2; end;
  if exist('lim2'), lim = lim2; end; if exist('lif2'), lif = lif2; end;
end;
if lc==3
  if exist('pp'),   clear pp;  end;  if exist('pf'),   clear pf;  end;
  if exist('pl'),   clear pl;  end;  if exist('pr'),   clear pr;  end;
  if exist('lim'),  clear lim; end;  if exist('lif'),  clear lif; end;
  if exist('pp3'),  pp  = pp3; end;  if exist('pf3'),  pf  = pf3; end;
  if exist('pl3'),  pl  = pl3; end;  if exist('pr3'),  pr  = pr3; end;
  if exist('lim3'), lim = lim3; end; if exist('lif3'), lif = lif3; end;
end;
if lc==4
  if exist('pp'),   clear pp;  end;  if exist('pf'),   clear pf;  end;
  if exist('pl'),   clear pl;  end;  if exist('pr'),   clear pr;  end;
  if exist('lim'),  clear lim; end;  if exist('lif'),  clear lif; end;
  if exist('pp4'),  pp  = pp4; end;  if exist('pf4'),  pf  = pf4; end;
  if exist('pl4'),  pl  = pl4; end;  if exist('pr4'),  pr  = pr4; end;
  if exist('lim4'), lim = lim4; end; if exist('lif4'), lif = lif4; end;
end;
if lc==5
  if exist('pp'),   clear pp;  end;  if exist('pf'),   clear pf;  end;
  if exist('pl'),   clear pl;  end;  if exist('pr'),   clear pr;  end;
  if exist('lim'),  clear lim; end;  if exist('lif'),  clear lif; end;
  if exist('pp5'),  pp  = pp5; end;  if exist('pf5'),  pf  = pf5; end;
  if exist('pl5'),  pl  = pl5; end;  if exist('pr5'),  pr  = pr5; end;
  if exist('lim5'), lim = lim5; end; if exist('lif5'), lif = lif5; end;
end;

%======================================================================
%  npdof   :  number of prescribed nodal point variables
%  npfor   :  number of prescribed nodal flow variables
%  nudof   :  number of unknown degrees of freedom 

if exist('pp'), npdof = size(pp,1); else, npdof = 0; pp = zeros(1,3); end; 
if exist('pf'), npfor = size(pf,1); else, npfor = 0; pf = zeros(1,3); end; 
if exist('tr'), ntr   = size(tr,1); else, ntr = 0; end;

if ~exist('pl'),  pl  = []; plc = []; end;
if ~exist('pr'),  pr  = []; prc = []; end;
if ~exist('lim'), lim = []; end;
npl = size(pl,1);
if ~exist('lif'), lif = zeros(1,npl); end;
npr = size(pr,1);

nudof = ndof-npdof;

%======================================================================
%  Information for partitioning the system of equations associated
%  with prescribed boundary conditions is made available in the arrays
%  ppc, ppv, pfc  and  pfv.
%----------------------------------------------------------------------

%ppc = [nndof*(round(pp(:,1))-1)+round(pp(:,2))]; 
%ppv = pp(:,nndof+1);
%if npfor==0, 
%  pf = []; pfc = [];
%  pfv = [];
%else
%  pfc = [nndof*(round(pf(:,1))-1)+round(pf(:,2))]; 
%  pfv = pf(:,nndof+1);
%end;

if     nndof==1, 
  ppc = [round(pp(:,1))]; 
  ppv = pp(:,2);
elseif nndof==2, 
  ppc = [nndof*(round(pp(:,1))-1)+round(pp(:,2))]; 
  ppv = pp(:,2+1);
elseif nndof==3, 
  ppc = [nndof*(round(pp(:,1))-1)+round(pp(:,2))]; 
  ppv = pp(:,2+1);
end;

if npfor==0, 
  pf = []; pfc = [];
  pfv = [];
else
  if     nndof==1, 
    pfc = [round(pf(:,1))]; 
    pfv = pf(:,2);
  elseif nndof==2, 
    pfc = [nndof*(round(pf(:,1))-1)+round(pf(:,2))]; 
    pfv = pf(:,2+1);
  elseif nndof==3, 
    pfc = [nndof*(round(pf(:,1))-1)+round(pf(:,2))]; 
    pfv = pf(:,2+1);
  end;
end;

if prog=='dsc1' | prog=='dsc3'
  if nnd>0   , ndp = [round(nodata(:,1))]; ndv = nodata(:,2); end;
end;

%======================================================================
%  Information for partitioning the system of equations associated
%  with linked degrees of freedom is made available in the arrays
%  plc  and  prc.
%----------------------------------------------------------------------

if npl>0
if nndof>1
plc = [nndof*(round(pl(:,1))-1)+round(pl(:,2))];
prc = [nndof*(round(pr(:,1))-1)+round(pr(:,2))];
elseif nndof==1
plc = pl;
prc = pr;
end;
else, plc = []; prc = []; end;

%======================================================================
%  Some extra arrays are made for later use.
%----------------------------------------------------------------------

pa  = 1:ndof;
pu  = 1:ndof;
%pt  = 1:ndof;
prs = 1:ndof;
%pt(plc) = [];
pu([ppc' plc']) = [];
prs([ppc' pfc' plc']) = [];

%======================================================================
%  Columns with prescribed iterative displacement and force
%  components are made.
%----------------------------------------------------------------------

pe0 = zeros(ndof,1); pe0(ppc(1:npdof)) = ppv(1:npdof);
fe0 = zeros(ndof,1); fe0(pfc(1:npfor)) = pfv(1:npfor);

%**********************************************************************
