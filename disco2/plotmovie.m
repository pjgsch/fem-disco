%**********************************************************************

loka=lok;

maxx0=max(crd0(:,1)); minx0=min(crd0(:,1));
maxy0=max(crd0(:,2)); miny0=min(crd0(:,2));
maxx1=max(crd(:,1));  minx1=min(crd(:,1));
maxy1=max(crd(:,2));  miny1=min(crd(:,2));
maxx=max([maxx0 maxx1]); maxy=max([maxy0 maxy1]);
minx=min([minx0 minx1]); miny=min([miny0 miny1]);
mi  =min([minx  miny]) ; ma  =max([maxx  maxy]);

if  exist('M'),     clear M; end;
if ~exist('mf'),    mf=0; end;
if ~exist('fs'),    fs=1; end;
if ~exist('mshop'), mshop = [1 0 0 0 0 0 0 0 0]; end;
if ~exist('val'),   val=1; end;
%if ~exist('ax'),    ax = [mi ma mi ma]; end;
if ~exist('ax'),    ax = 'equal'; end;
if ~exist('ps'),    ps = 0.001; end;

if mf==1, M = moviein(ic-1); end;

load([matf '0']);
load([matf '00']);

for i=1:fs:ic-1
  load([matf num2str(i)]);
  clf;
  if prog=='plax'
    plotmesh(mshop,loka,crd0,crd,eidaB,val); 
  elseif prog=='dsc2'
    plotmesh(mshop,loka,crd0,crd,eldaB,val);
  else
    plotmesh3(mshop,loka,crd0,crd,pp,eldaC,1);view(va,vb);
  end;
  axis(ax);
  pause(ps);   
  if mf==1, M(:,i)=getframe; end;
end;

%**********************************************************************
