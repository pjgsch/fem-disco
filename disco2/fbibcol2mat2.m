%**********************************************************************

Mp  = reshape(p,nndof,nnod)';   
MDp = reshape(Dp,nndof,nnod)';   MIp = reshape(Ip,nndof,nnod)';
MTp = reshape(Tp,nndof,nnod)';    
Mfi = reshape(fi,nndof,nnod)';   Mfe = reshape(fe,nndof,nnod)';
Mrs = reshape(rs,nndof,nnod)';

if ntr>=1
MTpT = reshape(TpT,nndof,nnod)';
MfiT = reshape(fiT,nndof,nnod)'; MfeT = reshape(feT,nndof,nnod)';
MrsT = reshape(rsT,nndof,nnod)';
end;

if prog=='dsc1' | prog=='dsc3' | prog=='dsc2'
Mp     = reshape(p,nndof,nnod)';     
Mdp    = reshape(dp,nndof,nnod)';    
Mddp   = reshape(ddp,nndof,nnod)';   
MpT    = reshape(pT,nndof,nnod)';    
MdpT   = reshape(dpT,nndof,nnod)';   
MddpT  = reshape(ddpT,nndof,nnod)';  
MTp    = reshape(Tp,nndof,nnod)';     
MTdp   = reshape(Tdp,nndof,nnod)';    
MTddp  = reshape(Tddp,nndof,nnod)';   
MTpT   = reshape(TpT,nndof,nnod)';     
MTdpT  = reshape(TdpT,nndof,nnod)';    
MTddpT = reshape(TddpT,nndof,nnod)';   

Mfe  = reshape(fe,nndof,nnod)';   
Mfm  = reshape(fa,nndof,nnod)';   
Mfb  = reshape(fb,nndof,nnod)';   
Mfk  = reshape(fc,nndof,nnod)';   
Mfr  = reshape(fr,nndof,nnod)';   
Mfi  = reshape(fi,nndof,nnod)';   
Mff  = reshape(ff,nndof,nnod)';   
Mrs  = reshape(rs,nndof,nnod)';   

MfeT = reshape(feT,nndof,nnod)';
MfaT = reshape(faT,nndof,nnod)';   MfmT=MfaT;
MfbT = reshape(fbT,nndof,nnod)';   
MfcT = reshape(fcT,nndof,nnod)';   MfkT=MfcT;
MfrT = reshape(frT,nndof,nnod)';
MfiT = reshape(fiT,nndof,nnod)';  
MffT = reshape(ffT,nndof,nnod)';  
MrsT = reshape(rsT,nndof,nnod)';

uuu = MTp;  vvv = MTdp;  aaa = MTddp;
uuT = MTpT; vvT = MTdpT; aaT = MTddpT;
kkk = Mfe;  fff = Mff;   rrr = Mrs;

end;
%**********************************************************************
