
function [crd0,lok] = mesher(nc,nr,dx,dy,h,v,d,u)

nn=nc*nr;ne=(nc-1)*(nr)+nc*(nr-1);
vec = 1:nn;
%arr = reshape(1:nn,nc,nr)';

crd0(vec,1) = ((rem(vec-1,nc)+1)*dx)';
crd0(vec,2) = ((ceil(vec/(nc)))*dy)';
%crd0

e=0;
%%%%% horizontal
if h==1
for j=1:nr
for i=2:nc
e=e+1;
lok(e,1) = i-1+(j-1)*(nc); 
lok(e,2) = i+(j-1)*(nc);
end;end;end
%%%%% vertical
if v==1
for i=1:nc
for j=2:nr
e=e+1;
lok(e,1) = i+(j-2)*(nc); 
lok(e,2) = i+(j-1)*(nc); 
end;end;end;
%%%%% down
if d==1
for j=1:nr-1
for i=1:nc-1
e=e+1;
lok(e,1) = i+(j-1)*(nc);
lok(e,2) = i+1+(j)*(nc);
end;end;end;
%%%%% up
if u==1
for j=1:nr-1
for i=2:nc
e=e+1;
lok(e,1) = i+(j-1)*(nc);
lok(e,2) = i-1+(j)*(nc);
end;end;end;
%arr, lok

lok = [lok diag(eye(size(lok,1)))];
ne=size(lok,1); lok = [ 9*ones(ne,1) ones(ne,1) lok(:,1:2) ];

%======================================================================
