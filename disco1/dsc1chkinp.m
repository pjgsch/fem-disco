%**********************************************************************
% The input is checked and default parameter values are provided.

prog = 'dsc1';                                           % program name

nndof = 1;                         % number of nodal degrees of freedom 

% The following files have to be provided as part of the input.
% These files can be made separately or written in the input file.
% The load history 'loadincr.m' is also made by the file 'mloin.m'.
%
% loadincr.m  :  prescribes the load history
% savedata.m  :  saves incremental data
% printout.m  :  prints data to a file
% updaelda.m  :  updates element data

if ~exist('loadincr.m'), 
loin=fopen('loadincr.m','w'); fprintf(loin,'\n'); fclose(loin); end;
if ~exist('savedata.m'), 
sada=fopen('savedata.m','w'); fprintf(sada,'\n'); fclose(sada); end;
if ~exist('printout.m'),
prnt=fopen('printout.m','w'); fprintf(prnt,'\n'); fclose(prnt); end;
if ~exist('updaelda.m'),
prnt=fopen('updaelda.m','w'); fprintf(prnt,'\n'); fclose(prnt); end;

% The parameter 'li' indicates the way (nodal) point values are
% prescribed.
% If 'li' is 'tp', the total value is prescribed as a function of time.
% If 'li' is 'ip', incremental values are prescribed.

if ~exist('li')
  if prog=='dsc1', li='tp'; end;
end;

lok = [round(eldata(:,1:2))];

if ~exist('matf'), matf  = './mat/defmat'; end;
if ~exist('outf'), outf  = 'defout'; end;

if ~exist('nl'),     nl     = 0;        end;
if ~exist('nic'),    nic    = 1;        end;
if ~exist('mit'),    mit    = 1;        end;
if ~exist('ccr'),    ccr    = 0.01;     end;
if ~exist('deltat'), deltat = 0;        end;
if ~exist('ts'),     ts     = 0;        end;
if ~exist('GDt'),    GDt    = deltat;   end; GDt0 = GDt;
if ~exist('cnm'),    cnm    = 1;        end;
if ~exist('vrs'),    vrs    = 1;        end;
if  exist('fat')~=1, fat    = 0;        end; 
if ~exist('tol'),    tol    = 0;        end;
if ~exist('res'),    res    = 0;        end;
if ~exist('slw'),    slw    = 1;        end;
if ~exist('mm'),     mm     = [];       end;
%if ~exist('tr'),     tr = []; end;
if  exist('tr'),     ntr    = size(tr,1); else, ntr = 0; tr = []; end;
%if ~exist('eldalivi'),  eldalivi = []; end;
if ~exist('eldax'),  eldax  = zeros(1,20); end;
if ~exist('nodata'), nodata = [];	end;
if ~exist('map'),    map    = [];       end;
if ~exist('maw'),    maw    = [];       end;
if ~exist('im'),     im	    = 5;	end;
if ~exist('Ga'),     Ga	    = 0.25;     end;
if ~exist('Gd'),     Gd	    = 0.5;      end;

if im==4, mit=1; end;

%  Calculation of some parameters from the input data.

%nnod  = size(crd0,1);           % number of nodes
nel   = size(lok,1);             % number of elements
nenod = size(lok,2);             % number of element nodes 
ndof  = nnod*nndof;              % number of system degrees of freedom
nedof = nndof*nenod;             % number of element degrees of freedom 
nnd   = size(nodata,1);          % number of nodal data
%nma   = size(map,2);

% Location array for the degrees of freedom 'lokvg' is generated
% from the nodal point location array 'lok'.

lokvg(1:nel,:) = ...
    [ nndof*(lok(1:nel,1)-1)+1 nndof*(lok(1:nel,2)-1)+1 ];

% The loadcase number is set to the initial value 0.

lc=0;

%**********************************************************************
