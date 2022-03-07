%**********************************************************************
%  discoh : discrete system computation : 2-dimensional, harmonic
%======================================================================

%prog = 'dsc3'; 
%checkinput;                                              % checkinput.m
%lc=0; lcase;                                                  % lcase.m
%[Trm] = transbc(tr,ndof,nndof);                             % transbc.m
%initialzero;                                            % initialzero.m
%[elda0,eldaB,eldaC,mty5] = eldata3(ne,eldata,lok,crd0);     % eldata3.m

dsc2chkinp;                                              % dsc2chkinp.m
fbiblcase;                                                % fbiblcase.m
[Trm] = fbibtransbc(tr,ndof,nndof);                     % fbibtransbc.m
dsc2inizer;                                              % dsc2inizer.m
[elda0,eldaB,eldaC,mty5] = ...                           % dsc2inidat.m
                           dsc2inidat(nel,eldata,lok,crd0);     

save([matf num2str(0)]);
crdB = crd0; crd = crd0;

pea  = zeros(ndof,1); peb  = zeros(ndof,1);  
paa  = zeros(ndof,1); pbb  = zeros(ndof,1); 
Tpa  = zeros(ndof,1); Tpb  = zeros(ndof,1); 
MTpa = zeros(nnod,2); MTpb = zeros(nnod,2); 
%======================================================================
%  Incremental calculation
%======================================================================
ic = 1; ti = 0; ts2 = ts*ts; Go = Gob;

while ic<=nic 
%----------------------------------------------------------------------
ti = ti + ts; Go = Go + GDGo; loadincr; rs = fe; 
%======================================================================
%  System matrices are assembled from element matrices
%  System matrices are transformed for local nodal coord.sys.
%======================================================================
smc=zeros(ndof); smb=zeros(ndof); sma=zeros(ndof); 

for e=1:nel,
  [emc,emcc,emb,efci,efbi] = dsc2elem(e,eldaC,elda0,1);    % dsc2elem.m
  smc(lokvg(e,:),lokvg(e,:)) = smc(lokvg(e,:),lokvg(e,:)) + emc;
  smb(lokvg(e,:),lokvg(e,:)) = smb(lokvg(e,:),lokvg(e,:)) + emb;
end;
for i=1:nma
  sma(2*map(i)-1,2*map(i)-1) = maw(i); 
  sma(2*map(i)  ,2*map(i)  ) = maw(i);
end;

if ntr>0
  smc=Trm'*smc*Trm; smb=Trm'*smb*Trm; sma=Trm'*sma*Trm;
end;
%======================================================================
%  Links and boundary conditions are taken into account.
%  The reduced (partioned) system of equations is generated.
%======================================================================
rh = rs; 
if npl>0, rh = rh - smc(:,plc) * lif'; end;
rhh = rh;
[sma,rh] = fbibpartit(1,sma,rhh,ndof,pa,ppc,plc,prc,pe,lim);% fbibpartit.m
[smb,rh] = fbibpartit(1,smb,rhh,ndof,pa,ppc,plc,prc,pe,lim);% fbibpartit.m
[smc,rh] = fbibpartit(1,smc,rhh,ndof,pa,ppc,plc,prc,pe,lim);% fbibpartit.m
%======================================================================
MH1  = - (Go^2)*sma + smc;         
MH1i = inv(MH1);
MH2  = ((Go)*smb)*MH1i*((Go)*smb);
aa   = inv(MH1 + MH2) * rh;
bb   = - MH1i*(Go*smb) * aa;

pea = zeros(ndof,1);  pea(pu) = aa;
peb = zeros(ndof,1);  peb(pu) = bb;
if npl>0, pea(plc) = lim*pea(prc) + lif'; end;    paa = pea;
if npl>0, peb(plc) = lim*peb(prc) + lif'; end;    pbb = peb;
%======================================================================
%  Update displacement and calculate derivatives.
%======================================================================
Tpa = paa; Tpb = pbb; 
crd = crd0;
%======================================================================
smc=zeros(ndof); smb=zeros(ndof); mty5=0;
%fci=zeros(ndof,1); fbi=zeros(ndof,1); 

for e=1:nel                                              % dsc2elprop.m
  [eldaC,mty5] = dsc2elprop(e,eldaC,elda0,eldaB,crd,lok,ts,mty5,eldax);
  updaelda;                                                % updaelda.m
  [emc,emcc,emb,efci,efbi] = dsc2elem(e,eldaC,elda0,2);    % dsc2elem.m
  smc(lokvg(e,:),lokvg(e,:)) = smc(lokvg(e,:),lokvg(e,:)) + emc;
  smb(lokvg(e,:),lokvg(e,:)) = smb(lokvg(e,:),lokvg(e,:)) + emb;
%  fci(lokvg(e,:)) = fci(lokvg(e,:)) + efci;
%  fbi(lokvg(e,:)) = fbi(lokvg(e,:)) + efbi;
end;
for i=1:nma
  sma(2*map(i)-1,2*map(i)-1) = maw(i); 
  sma(2*map(i)  ,2*map(i)  ) = maw(i);
end;

if ntr>0
  smc=Trm'*smc*Trm; smb=Trm'*smb*Trm; sma=Trm'*sma*Trm; 
%  fci=Trm'*fci; fbi=Trm'*fbi;
end;
%======================================================================
%  Calculate residual force 
%======================================================================
%rs = fe - fi; 
%======================================================================
%  Transformation nodal forces from local to global nodal coord.sys.
%======================================================================
if ntr>0
  feT = Trm * fe; faT = Trm * fa; fbT = Trm * fb; fcT = Trm * fc;
  frT = Trm * fr; fiT = Trm * fi; ffT = Trm * ff; rsT = Trm * rs;
else
  feT = fe; faT = fa; fbT = fb; fcT = fc;
  frT = fr; fiT = fi; ffT = ff; rsT = rs;
end;
%======================================================================
%  Update and store values
%======================================================================
%col2mat;                                                    % col2mat.m
fbibcol2mat2;                                          % fbibcol2mat2.m
MTpa = reshape(Tpa,nndof,nnod)';     
MTpb = reshape(Tpb,nndof,nnod)';     
crdB = crd; eldaB = eldaC; 
[eldaB] = dsc2incend(eldaB,elda0,eldax,lok,crd,nel,ts,MTp,Mfr);% dsc2incend.m
eldaC = eldaB;
savefile = [matf num2str(ic)]; savedata;                   % savedata.m

ic = ic + 1;
disp(nic+1-ic)
save([matf '00'],'ic');

%----------------------------------------------------------------------
end; %ic

%**********************************************************************



