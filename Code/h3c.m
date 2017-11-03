% COMMAND OPTIONS
%
% P  =  H3C(OPT)
% P  =  H3C(CM,OPT)
% P  =  H3C(AH,CM,OPT)
%
%	to color HIST3 data bins according to their z-value
%
% AH	:	handle to axis with a HIST3 object
%					def:  current axis
% CM	:	n x 3 colormap		def:  current figure's colormap
%					see:  [-c] for more options
%
% OPT	:	argument	processing
% --------------------------------------------------------------------------------
% -h	:	ah		handle to axis with a HIST3 object
% -c	:			set the colormap as
%		n x 3		RGB values
%				- eg,  summer(256)
%		string		colormap M-file
%				- eg, 'summer'
%    -n	:	ncols		evaluate colormap M-file for <ncols> colors
%				- note: ncols will be adjusted with [-u]
% -u	:	-		try to assign a unique color for each z-level
%				- note: fixed  colormaps will be interpolated
%					if ncols > z-levels
%					string colormaps will be recomputed
%					look at info during run-time
% -r	:	-		invert colormap
% -p	:	{'p','v',...}	change HIST3 property values before recoloring
%				- note: graphics object is of type surface
% -a	:	alphaval	add alpha property to HIST3
%				- note: -or- set facealpha/edgealpha prop [-p]
%					changes fig renderer to opengl
% -cb	:	-		add a colorbar using H3C colormap/data range
% -cb	:	{'p','v',...}	add a colorbar and change property values
%				- note: the labels may not be evenly distributed
%					they are recomputed from existing z-levels
%					based on the number of ticks returned by
%					the colorbar
% -fr	:	renderer	change figure renderer
%				- note: must be set to opengl for certain
%					[-p] entries, eg, facealpha

% created:
%	us	12-Nov-2005
% modified:
%	us	10-Oct-2006 11:37:49

%--------------------------------------------------------------------------------
function	pp=h3c(varargin)

% NOTE
% this code is optimized for speed
% - plane offset template
% - patch offset template
% - z-val enumerating

		tim=clock;
		ver='10-Oct-2006 11:37:49';

	if	nargout
		pp=[];
	end
	if	~nargin
		help(mfilename);
		return;
	end

		p=ini(ver,tim,varargin{:});
	if	~p.hh
	if	nargout
		pp=p;
	end
		return;
	end

% known HIST3 parameters
% ... last checked: R14.SP3 18-Nov-2005
% ... patch size:
		mf=5;

% retrieve data/matrix parameters
		z=get(p.hh,'zdata');
		[mr,mc]=size(z);
		mx=mr*mc/(mf*mf);

% compute templates
% ... plane offset indices
		[vx,vy]=meshgrid(mr*(0:mf:mc-1),mf*(0:(mr-1)/mf));
		vx=vx.';
		vy=vy.';
% ... patch offset indices
		[ta,tb]=meshgrid(0:mf-1,0:mf-1);
		tt=mr*ta+tb+1;

% find unique values
		vval=z(vx+vy+mr+2);
		zs=sort(vval(:));
		zx=[true;diff(zs)>0];
		zx=zs(zx);
		zl=numel(zx);
		p.nd=zl;
		p.nu=zl;
		p.zu=zx;

% compute conversion factor
		nc=size(p.cm,1);
		zi=min(z(:));
		za=max(z(:));
		zr=za-zi;
		zf=(nc-1)/zr;
		p.zrng=[zi,za,zr];

		t0=clock;
% compute color indices
% ... re-index z plane
	if	~p.opt.uflg
		za=round(zf*(z-zi))+1;
	else
% ... unique   z plane colors
		msg='sufficient';
		p.mode='unique';

	if	~p.opt.mflg
		msg='recomputed';
		p.cm=feval(p.cmap,zl);
		nc=size(p.cm,1);
	end
	if	nc < zl
		msg='insufficient > interpolate';
		zx=linspace(zx(1),zx(end),nc);
		p.zu={p.zu zx.'};
		zl=numel(zx);
	end
		[za,za]=histc(z,zx);

% ... re-create colormap
		cf=max([1,fix(nc/zl)]);
		ct=p.cm(1:cf:end,:);
		ct(end,:)=p.cm(end,:);
	if	size(ct,1) > zl		% check for mismatch due to FP issue!
		dc=size(ct,1)-zl;
%		disp(sprintf('FP error: %5d %5d %5d',size(ct,1),zl,dc));
		ct=ct([1:end-dc-1,end],:);
	end
		p.cm=ct;
		nc=size(p.cm,1);
		p.nc=[p.nc nc];
		p.nu={zl numel(zx)};

		disp(sprintf('H3C> unique color mapping   : %s',p.ctyp));
		disp(sprintf('     colorspace             : %s',msg));
		disp(sprintf('     colors                 :%6d   <   %g',p.nd,p.nc(1)));
		disp(sprintf('     data                   :%6d',p.nd));
		disp(sprintf('     factor                 :%6g   <   %g',cf,nc/zl));
	end

% compute color table indices
% note to programmers: the loop IS faster than
%		vlst=za(vx+vy+mr+2);
		vval=vval(:).';
		vlst=ones(1,mx);
	for	i=1:mx
		ix=vx(i)+vy(i)+mr+2;
		vlst(i)=za(ix);
	end

% ... invert
	if	p.opt.rflg
		p.cm=p.cm(end:-1:1,:);
	end

% create RGB plane
		rgb=nan(size(z));
		rgb=permute(rgb,[3 1 2]);
	for	i=1:mx
		tx=vx(i)+vy(i)+tt;
		v=vlst(i);
		rgb(1,tx)=p.cm(v,1);
		rgb(2,tx)=p.cm(v,2);
		rgb(3,tx)=p.cm(v,3);
	end
		rgb=ipermute(rgb,[3 1 2]);
		p.runtime=etime(clock,t0);

		set(p.hh,'cdata',rgb);
		shg;

	if	p.opt.cbflg				&& ...
		size(p.cm,1) > 1
		p=mk_cb(p,vlst,vval);
	end

		[p.zval,vx]=sort(vval);
		p.np=mx;
		p.nu=numel(vx);
		p.zcol=vlst(vx);

	if	nargout
		pp=p;
	end
		return;
%--------------------------------------------------------------------------------
function	p=ini(ver,tim,varargin)

		ldis=.01;		% default min distance between labels
		flg={
			'-a'		% alpha value
			'-c'		% colormap def
			'-cb'		% colorbar
			'-fr'		% fig renderer
			'-h'		% hist3 handle
			'-m'		% colormap flag
			'-ld'		% label distance flag
			'-n'		% def nr colors
			'-u'		% unique color/level
			'-r'		% invert colormap
			'-p'		% hist3 properties
		};

		p.magic='H3C';
		p.ver=ver;
		p.msver=version;
		p.rundate=datestr(tim);
		p.runtime=0;
		p.opt=[];
		p.fh=false;
		p.ah=false;
		p.hh=false;
		p.mode='';
		p.ctyp='';
		p.cmap='';
		p.cm=[];
		p.nc=0;			% nr colors
		p.np=0;			% nr patches
		p.nd=0;			% nr unique z-levels
		p.nu=0;			% nr unique z-levels colored
		p.zrng=[];		% data range
		p.zval=[];		% z-levels
		p.zcol=[];		% corresponding color indices
		p.zu=[];		% unique z-levels

		ic=cellfun('isclass',varargin,'char');
		is=cellfun('size',varargin,2);
		is=is.*~ic;
		ic=find(ic);
	for	i=1:length(flg)
		fn=[flg{i}(2:end),'flg'];
		fv=[flg{i}(2:end),'val'];
		p.opt.(fn)=false;
		p.opt.(fv)=[];
		ix=strmatch(flg{i},varargin(ic),'exact');
	if	~isempty(ix)
		p.opt.(fn)=ic(ix(end));
	end
	end

	if	isempty(get(0,'currentfigure'))
		p.hh=false;
		disp('H3C> no figure');
		return;
	end

	if	numel(varargin{1}) == 1			&& ...
		ishandle(varargin{1})
		p.ah=varargin{1};
	elseif	p.opt.hflg
		p.ah=varargin{p.opt.hflg+1};
	else
		p.ah=gca;
	end

	if	~strcmp(get(p.ah,'type'),'axes')	|| ...
		~ishandle(p.ah)
		p.hh=false;
		disp('H3C> not a valid axis handle');
		return;
	end

		p.fh=get(p.ah,'parent');
		p.hh=findall(p.ah,'tag','hist3');
	if	isempty(p.hh)
		p.hh=false;
		disp('H3C> no HIST3 found');
		return;
	end
	if	numel(p.hh) > 1
		disp('H3C> more than one HIST3: using first handle');
	end
		p.hh=p.hh(1);

		p.opt.mflg=true;
		p.mode='scaled';
		p.ctyp='rgb data';
		p.cmap='rgb data';
	if	p.opt.cflg
		p.cm=varargin{p.opt.cflg+1};
	elseif	any(is==3)
		p.cm=varargin{find(is==3,1,'first')};
	else
		p.ctyp='rgb system';
		p.cm=get(p.fh,'colormap');
	end

	if	ischar(p.cm)
		p.opt.mflg=false;
		p.ctyp=p.cm;
		p.cmap=p.cm;
	if	p.opt.nflg
		nc=varargin{p.opt.nflg+1};
	if	isempty(nc)				|| ...
		~isnumeric(nc)				|| ...
		nc <=0
		disp('H3C> invalid color number [-n]');
		p.hh=false;
		return;
	end
	else
		cm=get(p.fh,'colormap');
		nc=size(cm,1);
	end
		p.cm=feval(p.cmap,nc);
	end

	if	p.opt.aflg
		p.opt.aval=varargin{p.opt.aflg+1};
		set(p.fh,'renderer','opengl');
		alpha(p.hh,p.opt.aval);
	end
	if	p.opt.cbflg				&& ...
		numel(varargin) >= p.opt.cbflg+1
		pval=varargin{p.opt.cbflg+1};
	if	iscell(pval)				&& ...
		size(pval,1) == 1
		p.opt.cbval=pval;
	elseif	iscell(pval)
		disp('H3C> warning: COLORBAR properties must be defined in a cell of size 1xn');
		disp(pval);
		p.hh=false;
		return;
	end
	end
	if	p.opt.frflg
		set(p.fh,'renderer','opengl');
	end
	if	p.opt.pflg
		pval=varargin{p.opt.pflg+1};
	if	iscell(pval)
		p.opt.pval=pval;
		set(p.hh,pval{:});
	else
		disp('H3C> warning: HIST3 properties must be defined in a cell');
	end
	end

% these options are not documented!
%----------------------------------
		p.opt.ldval=ldis;
	if	p.opt.ldflg				&& ...
		numel(varargin) >= p.opt.ldflg+1
		p.opt.ldval=varargin{p.opt.ldflg+1};
	end

		p.nc=size(p.cm,1);
		return;
%--------------------------------------------------------------------------------
function	p=mk_cb(p,vlst,vval)

		[ch,cl]=fix_cb(p,p.ah,p.cm);
		ct=get(ch,cl);
		cn=numel(ct);

% try to relabel x/yticks with valid z-values
%	as evenly as possible
% note:	not all z-values/colors may be represented
%	in a histogram
%	max(x/ytick) is determined by the current colorbar

		dd=sortrows([vlst.',vval.']);
		dd(end+1,:)=[dd(end,1)+1,dd(end,2)];
		ix=[1;find(diff(dd(:,1))>0)+1];

		yt=(dd(ix,1)-1)./(dd(end,1)-1);
		yl=dd(ix,2);
		yn=numel(yt);

% get labels closest to ticks returned by colorbar
	if	cn && yn
	if	yn >= cn+2
		yte=yt(end);
		yle=yl(end);
	for	i=1:cn
		[lx,lx]=min(abs(yt-ct(i)));
		yt(i)=yt(lx);
		yl(i)=yl(lx);
	end
		yt=yt(1:cn);
		yl=yl(1:cn);
	if	yt(cn) ~= yte
		yt(cn+1)=ct(end);
		yl(cn+1)=yle;
	end
	end
	end

% make sure labels are not too close (for display)
%	always keep topmost label
		yt0=yt(1);
		yl0=yl(1);
		dxo=[diff(yt)>p.opt.ldval;true];
	while	true
		dx=[diff(yt)>p.opt.ldval;true];
		yt=yt(dx);
		yl=yl(dx);
	if	isequal(dxo,dx)
		break;
	end
		dxo=dx;
	end

%	always keep lowest label
	if	yt(1) ~= yt0
		yt=[yt0;yt];
		yl=[yl0;yl];
	end
		set(ch,cl,yt);
		set(ch,[cl,'label'],yl);
		return;
%--------------------------------------------------------------------------------
function	[ch,cl]=fix_cb(p,ah,cm)

% the ML engine is used to create a colorbar template,
% which will not be changed by a new call to colorbar
% at a DIFFERENT location
% - set image to its RGB equivalent

		cl='ytick';			% Y
		fcm=colormap;
		colormap(cm);
		ch=colorbar('peer',ah);

	if	iscell(p.opt.cbval)
		set(ch,p.opt.cbval{:});
	end
		ih=findall(ch,'type','image');
		cd=get(ih,'cdata');
		[cc,cc]=size(cd);
	if	cc == 1
		cm=reshape(cm,[size(cm,1),1,3]);
	else
		cl='xtick';			% X
		cm=reshape(cm,[1,size(cm,1),3]);
	end
		set(ih,'cdata',cm);
		set(ch,'tag','FIX_Colorbar');
		colormap(fcm);
%		axes(ah);
		return;
%--------------------------------------------------------------------------------
