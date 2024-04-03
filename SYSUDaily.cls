\LoadClass[a4paper, titlepage, fontset=fandol, punct=CCT]{ctexart}
\ProvidesClass{SYSUDaily}
\usepackage{ifthen}
\usepackage{amsmath}
\usepackage{amsthm}
\usepackage{fontspec}
\usepackage{xeCJK}
\usepackage[b5paper, centering, left=3cm, right = 3cm]{geometry}
\usepackage{xeCJKfntef}
\usepackage{euscript}
\usepackage{mismath}
\usepackage[svgnames]{xcolor}
\usepackage[skins,most]{tcolorbox}
\usepackage{mathtools}
% \defaultfontfeatures{Mapping=tex-text}
\usepackage{fixdif}
\usepackage{xfp}
\usepackage{ulem}
\usepackage{environ}
\usetikzlibrary {shapes.geometric}
\usepackage{xpatch}
\usepackage[
	colorlinks,
	anchorcolor = black,
	filecolor = black,
	urlcolor = black,
	citecolor = black,
	hyperfootnotes = true,
	breaklinks = true,
	bookmarks = true
]{hyperref}

\newcounter{SYSUDaily@pancounter}
\stepcounter{SYSUDaily@pancounter}


% \definecolor{emptycolor}{RGB}{0,0,0}

\def\SYSUDaily@right{50pt+2mm}
\tcbset{
	mathstyles/.style={
			before={\medskip\par\noindent},
			after = {\vspace*{-3pt}},
			enhanced,
			toprule=3pt,
			fonttitle=\bfseries,
			fontupper=\itshape,
			height from = 45pt to 1000pt,
			enhanced,
			arc=0mm,
			outer arc=0mm,
			before skip balanced=2mm,
			after skip balanced=3mm,
			boxrule=1pt,
			left=3mm,
			right={\SYSUDaily@right},
			top=1mm,
			bottom=1mm,
			lefttitle=0pt,
			righttitle=0pt,
			height from = 57.5292pt to 19cm,
			colback=#1color!3,
			colframe=#1color!30,
			coltitle=#1color,
		}
}

\ExplSyntaxOn
\clist_new:N \c_math_styles_clist
\NewDocumentCommand{\Addmathstyles}{mO{}O{0,0,0}}{
\clist_put_right:Nn \c_math_styles_clist { #1 }
\cs_new:cpn { SYSUDaily@#1name } { #2 }
\definecolor{#1color}{RGB}{ #3 }
}
\NewDocumentCommand{\ShowSYSUDaily@name}{m}{\use:c { SYSUDaily@#1name } }
\ExplSyntaxOff

\Addmathstyles{theorem}[定理][12,12,150]
\Addmathstyles{definition}[定义][220,20,60]
\Addmathstyles{proposition}[命题][32,115,54]
\Addmathstyles{lemma}[引理][0,169,153]
\Addmathstyles{corollary}[推论][70,130,180]
\Addmathstyles{fact}[事实][119,136,153]
\Addmathstyles{example}[例子][255,182,193]
\Addmathstyles{think}[思考题][30,144,255]
\Addmathstyles{calculate}[计算题][139,69,19]
\Addmathstyles{brain}[脑筋急转弯][0,127,127]

\newlength{\tempwaterrightskip}
% \newcommand\textoverset[2]{%
%   \leavevmode
%   \vbox{\offinterlineskip
%     \halign{%
%       \hfil##\hfil\cr % center
%       \dynscriptsize\strut#1\cr
%       \noalign{\kern-.3ex}
%       \strut#2\cr
%     }%
%   }%
% }
% \textoverset{}
\setlength{\fboxrule}{0.2pt}
% \newcommand{\dateread} [8] {#5#6/#1#2#3#4/#7#8}

\newcommand{\putstars} [2] {%
	\begin{tcbclipinterior}
		\path [fill=none,draw=none]
		(interior.south west) rectangle node [white]
			{
				\rotatebox{-90}{\small\color{#2color}%
					\ifnum #1>0
						\foreach\i in {1,...,#1}{%
								\makebox[2ex]{\rotatebox{90}{%
										\scalebox{.3}{\tikz{\node[star, star point ratio=2.5, draw, fill=#2color]at (1,1) {};}}}%
								}%
							}%
					\else\fi%
				}%
			}%
		([xshift=4mm]interior.north west);
	\end{tcbclipinterior}
}
\newcommand{\SYSUDaily@watermark} {
	\bfseries \makebox[.79\textwidth][r]{
		\smash{\rule[-8pt]{.8pt}{8pt+\baselineskip+1pt}}\hskip2mm
		\makebox[0pt][l]{ \parbox{60pt}{ \vspace*{-.4ex}笃学笃行，\\[.1ex]不悔不倦. }}\hspace*{8pt}
	}
}

\newlength{\SYSUDaily@width}
\newlength{\SYSUDaily@height}
\setlength{\SYSUDaily@height}{52pt}
\setlength{\SYSUDaily@width}{0.8\textwidth}
\newsavebox{\SYSUDaily@measurebox}



\newtcolorbox{SYSUDaily@}[4]{%
	mathstyles = #1,%
	title      = {\bfseries\expandafter\IfBlankTF{#4}{\ShowSYSUDaily@name{#1}}{%
				\ShowSYSUDaily@name{#1}\the\value{SYSUDaily@pancounter}\stepcounter{SYSUDaily@pancounter}：#4%
			}\hfill{\ifx#2\empty\else\expandafter\SYSUDaily@ParameterDate\fi}},%
	watermark text = {\SYSUDaily@watermark},%
	underlay    = {\putstars{#3}{#1}},%
	fonttitle = {},
}%

\ExplSyntaxOn
\def\SYSUDaily@ParameterMathStyles{proposition}
% \def\SYSUDaily@ParameterDate{\the\year\ifnum\month<10{0}\the\month\else\the\month\fi\ifnum\day<10{0}\the\day\else\the\day\fi}
\def\SYSUDaily@ParameterDate{\today}
\def\SYSUDaily@ParameterDifficulty{0}
\let\SYSUDaily@ParameterTitle\empty
\NewDocumentCommand{\SYSUDaily@check}{m}{
	\clist_if_in:NnTF \c_math_styles_clist {#1}
	{
		\cs_set:cpn { SYSUDaily@ParameterMathStyles } { #1 }
	}
	{
		\regex_match:nnTF { ^[+-]?\d+$ } {#1}
		{
			\PackageWarning{SYSUDaily}{check:~#1}
			\int_compare:nTF {
				#1 > 100
			}
			{
				\SYSUDaily_set_date_format:n {#1}
				% \cs_set:cpn { SYSUDaily@ParameterDate } { #1 } 
			}
			{
				\int_compare:nTF {
					#1 < 5
				}
				{
					\cs_set:cpn { SYSUDaily@ParameterDifficulty } { #1 }
				}
				{ }
			}
		}
		{
			\cs_set:cpn { SYSUDaily@ParameterTitle } { #1 }
		}
	}
}
\cs_new:Npn \SYSUDaily_set_date_format:n #1 {
	\int_compare:nTF { #1 > 999999 } {
		\SYSUDaily_set_date_format_eight:n  #1 
	} {
		\int_compare:nTF { #1 > 9999 } {
			\SYSUDaily_set_date_format_six:n  #1 
		} {
			\SYSUDaily_set_date_format_four:n  #1 
		}
	}
}
\cs_new:Npn \SYSUDaily_set_leading_zero:n #1#2 {
  \int_compare:nTF { #1 = 0 } {
      #2
    } {
      #1#2
    }
}
\cs_new:Npn \SYSUDaily_set_date_format_eight:n #1#2#3#4#5#6#7#8 {
  \cs_set:cpn { SYSUDaily@ParameterDate } {
    #1#2#3#4 年\SYSUDaily_set_leading_zero:n {#5}{#6} 月\SYSUDaily_set_leading_zero:n {#7}{#8} 日
  }
}
\cs_new:Npn \SYSUDaily_set_date_format_six:nnnnnn #1#2#3#4#5#6 {
  \cs_set:cpn { SYSUDaily@ParameterDate } {
    #1#2 年\SYSUDaily_set_leading_zero:n {#3}{#4} 月\SYSUDaily_set_leading_zero:n {#5}{#6} 日
  }
}
\cs_new:Npn \SYSUDaily_set_date_format_four:nnnn #1#2#3#4 {
  \cs_set:cpn { SYSUDaily@ParameterDate } {
    \SYSUDaily_set_leading_zero:n {#1}{#2} 月\SYSUDaily_set_leading_zero:n {#3}{#4} 日
  }
}

\NewDocumentEnvironment{daily}{ O{} +b } {
	\clist_set:Nn \l_tmpa_clist {#1}
	\clist_map_inline:Nn \l_tmpa_clist {
		\PackageWarning{SYSUDaily}{check: ##1}
		\SYSUDaily@check {##1}
	}
	\hbox_set:Nn \l_tmpa_box {
    \begin{minipage}{\SYSUDaily@width}
      \itshape #2
    \end{minipage}
  }

  \dim_set:Nn \l_tmpa_dim {\box_ht:N \l_tmpa_box}

  \dim_compare:nTF {\l_tmpa_dim > 26pt} {
    \def\SYSUDaily@watermark{\bfseries 笃学笃行，不悔不倦。}
    \def\SYSUDaily@right{2mm}
	}{}
	\begin{SYSUDaily@}{\SYSUDaily@ParameterMathStyles}{\SYSUDaily@ParameterDate}{\SYSUDaily@ParameterDifficulty}{\SYSUDaily@ParameterTitle}
		#2
	\end{SYSUDaily@}
}{}
\ExplSyntaxOff
