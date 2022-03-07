%**********************************************************************
% dsc2inizer.m : part of disco2
%
% Initialisation of nodal values.
%
% pe    :  column with prescribed incremental nodal displacements
% Dp    :  column with iterative nodal displacements
% Ip    :  column with incremental nodal displacements
% Tp    :  column with total nodal displacements
% fe    :  column with external (applied) nodal forces
% fi    :  column with internal (resulting) nodal forces
% peC   :  array with prescribed actual displacements
% feC   :  array with prescribed actual forces
%======================================================================

peC  = zeros(ndof,1);  feC   = zeros(ndof,1);

pe   = zeros(ndof,1);  pet   = zeros(ndof,1);  
p    = zeros(ndof,1);  dp    = zeros(ndof,1);  ddp   = zeros(ndof,1);  
pT   = zeros(ndof,1);  dpT   = zeros(ndof,1);  ddpT  = zeros(ndof,1);
pt   = zeros(ndof,1);  dpt   = zeros(ndof,1);  ddpt  = zeros(ndof,1); 
ptt  = zeros(ndof,1);  pttt  = zeros(ndof,1);
Dp   = zeros(ndof,1); 
DpT  = zeros(ndof,1); 
Ip   = zeros(ndof,1);  Ipt   = zeros(ndof,1);
IpT  = zeros(ndof,1); 
Tp   = zeros(ndof,1);  Tdp   = zeros(ndof,1);  Tddp  = zeros(ndof,1);  
TpT  = zeros(ndof,1);  TdpT  = zeros(ndof,1);  TddpT = zeros(ndof,1);
Tpt  = zeros(ndof,1);  Tdpt  = zeros(ndof,1);  Tddpt = zeros(ndof,1);  
Tptt = zeros(ndof,1);  Tpttt = zeros(ndof,1);  Tpet  = zeros(ndof,1);

fe   = zeros(ndof,1);  fet   = zeros(ndof,1);  
fa   = zeros(ndof,1);  fb    = zeros(ndof,1);  fc    = zeros(ndof,1); 
fr   = zeros(ndof,1);
fi   = zeros(ndof,1);  fit   = zeros(ndof,1);  
feT  = zeros(ndof,1);  fiT   = zeros(ndof,1);  
fci  = zeros(ndof,1);  fbi   = zeros(ndof,1);  fai   = zeros(ndof,1); 
ff   = zeros(ndof,1);  rs    = zeros(ndof,1);  
dfe  = zeros(ndof,1);  dfet  = zeros(ndof,1);
dfi  = zeros(ndof,1);  dfit  = zeros(ndof,1);

%**********************************************************************
