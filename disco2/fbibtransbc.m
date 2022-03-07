%**********************************************************************
%  Dof's may be defined in a local coordinate system in a node.
%  A transformation matrix 'Trm' is build, which is used later to 
%  transform the system matrices and columns.
%======================================================================

function [Trm] = fbibtransbc(tr,ndof,nndof);

ntr = size(tr,1);                           % number of transformations

Trm = eye(ndof);

for i=1:ntr
  trp = round(tr(i,1));            tra = tr(i,2);
  trc = cos((pi/180)*tra);         trs = sin((pi/180)*tra);
  k1  = nndof*(trp-1)+1;           k2  = nndof*(trp-1)+2;

  trm = [trc -trs ; trs trc];

  Trm([k1 k2],[k1 k2]) = trm;
end;

%**********************************************************************
