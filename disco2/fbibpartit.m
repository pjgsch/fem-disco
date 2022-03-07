%**********************************************************************
% fbibpartit.m
%
% Partitioning of the system of equations.
% This implies that links and boundary conditions are
% taken into account.
% The result is a smaller system of equations from which the unknown
% degrees of freedom can be slved.
%
%**********************************************************************

function [sm,rs] = fbibpartit(it,sm,rs,ndof,pa,ppc,plc,prc,pe,lim);

%======================================================================
% The structural system matrix and right hand residual vector 
% are partitionated.
% Deoendencies between degrees of freedom (links) are taken 
% into account
%======================================================================

% The matrix (nsm) and column (nrs) are initialised.
% They are used to implement the link relations.

nsm = zeros(ndof);
nrs = zeros(ndof,1);

% The original structural matrix 'sm' is copied into the matrix 'nsm'.

nsm(pa,pa)   = sm(pa,pa);

% The link relations are taken into accout by multiplying a selected
% part of 'sm' with 'lim'.

nsm(pa,prc)  = sm(pa,prc) + sm(pa,plc)*lim;
nsm(prc,pa)  = sm(prc,pa) + lim'*sm(plc,pa);
nsm(prc,prc) = sm(prc,prc) + sm(prc,plc)*lim + ...
               lim'*sm(plc,prc) + lim'*sm(plc,plc)*lim;

% The original residual column 'rs' is copied into the column 'nrs'.

nrs(pa)      = rs(pa);

% The link relations are taken into account.

nrs(prc)     = rs(prc) + lim'*rs(plc);

% Now that the dependencies between degrees of freedom are taken
% care of, the temporary matrix 'nsm' and column 'nrs' are
% copied into the original variables.

sm = nsm;
rs = nrs;

% The system is now partitioned.
% First the prescribed degrees of freedom are taken into account.
% This is only needed and allowed in the first iteration step
% of an incremental analysis.

if it==1, rs = rs - sm(:,ppc) * pe(ppc); end;

% Selected components of 'sm' and 'rs' are eliminated,
% resulting in the partitioned system.

sm(:,[plc' ppc']) = [];
if size(sm,1)>0, sm([plc' ppc'],:) = []; end;
rs([plc' ppc']) = [];

%**********************************************************************
