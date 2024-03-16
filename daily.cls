\LoadClass[a4paper, titlepage, fontset=fandol, punct=CCT]{ctexart}
\ProvidesClass{SYSUdaily}
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
\usepackage{unicode-math}
% \defaultfontfeatures{Mapping=tex-text}
\usepackage{fixdif}
\usepackage{xfp}
\usepackage{ulem}
\usepackage{environ}
% \usepackage{epigraph}
% \usepackage{tabularx}
% \usepackage{fontawesome5}
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
% \usepackage[noendash,italic, frenchmath]{mathastext}

\newcounter{pancounter}
\stepcounter{pancounter}

\colorlet{colorbrain}{Teal}
\definecolor{theoremcolor}{RGB}{12,12,150}
\definecolor{definitioncolor}{RGB}{220,20,60}
\definecolor{propositioncolor}{RGB}{32,115,54}
\definecolor{lemmacolor}{RGB}{0,169,153}
\definecolor{corollarycolor}{RGB}{70,130,180}
\definecolor{factcolor}{RGB}{119,136,153}
\definecolor{examplecolor}{RGB}{255,182,193}
\definecolor{thinkcolor}{RGB}{30,144,255}
\definecolor{calculatecolor}{RGB}{139,69,19}
\definecolor{tempcolor}{RGB}{52,53,65}
\def\SYSUdailyright{50pt+2mm}
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
    before skip balanced=2mm,after skip balanced=3mm,
    boxrule=1pt,left=3mm,right={\SYSUdailyright},top=1mm,bottom=1mm,
    lefttitle=0pt,righttitle=0pt,
    height from = 57.5292pt to 19cm,
    colback=#1color!3,colframe=#1color!30,coltitle=#1color,
  }
}

\newcommand{\SYSUdailytheoremname}{定理}
\newcommand{\SYSUdailydefinitionname}{定义}
\newcommand{\SYSUdailypropositionname}{命题}
\newcommand{\SYSUdailylemmaname}{引理}
\newcommand{\SYSUdailycorollaryname}{推论}
\newcommand{\SYSUdailyfactname}{事实}
\newcommand{\SYSUdailyexamplename}{例子}
\newcommand{\SYSUdailythinkname}{思考题}
\newcommand{\SYSUdailycalculatename}{计算题}
\newcommand{\SYSUdailybrainname}{脑筋急转弯}

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
\newcommand{\dateread} [8] {\smash{\fbox{{\footnotesize#5#6}\llap{{\raisebox{5pt}{{\fontsize{3.2}{4}\selectfont#1 #2 #3 #4\kern-0.5em}}}}{/\kern-0.1em#7#8}}}}

\newcommand{\putstars} [2] {%
  \begin{tcbclipinterior}
    \path [fill=none,draw=none] 
    (interior.south west) rectangle node [white] 
    { \rotatebox{-90}{\small\color{#2color} \foreach\i in {1,...,#1}{\rotatebox{90}{$\bigstar$}\,\,} } } 
    ([xshift=4mm]interior.north west);
  \end{tcbclipinterior}
  }
  \newcommand{\SYSUdailywatermark} {
    \bfseries \makebox[.79\textwidth][r]{
      \smash{\rule[-8pt]{.8pt}{8pt+\baselineskip+1pt}}\hskip2mm
      \makebox[0pt][l]{ \parbox{60pt}{ \vspace*{-.4ex}笃学笃行，\\[.1ex]不悔不倦. }}\hspace*{8pt}
    }
  }
\usepackage{xparse}


\newlength{\SYSUdailywidth}
\newlength{\SYSUdailyheight}
\setlength{\SYSUdailyheight}{52pt}
\setlength{\SYSUdailywidth}{0.8\textwidth}
\newsavebox{\SYSUdailymeasurebox}

\newtcolorbox{SYSUdaily}[4]{%
mathstyles = #1,%
title      = {{\bf\csname SYSUdaily#1name\endcsname\the\value{pancounter}\stepcounter{pancounter}：~#4}\hfill{\ifx#2\empty\else\dateread#2\fi}},%
watermark text = {\SYSUdailywatermark},%
underlay    = {\putstars{#3}{#1}},%
fonttitle = {},
}%

\NewEnviron{daily}[4]{
	\savebox{\SYSUdailymeasurebox}{%
	\begin{minipage}{\SYSUdailywidth}%
		\itshape\BODY%
	\end{minipage}%
	}
	\settoheight{\SYSUdailyheight}{\usebox{\SYSUdailymeasurebox}}
	\ifthenelse{\lengthtest{\SYSUdailyheight > 26pt}}{%
	\renewcommand{\SYSUdailywatermark}{ \bfseries 笃学笃行，不悔不倦. }%
	\def\SYSUdailyright{2mm}
	}{}
	\begin{SYSUdaily}{#1}{#2}{#3}{#4}
		\BODY
	\end{SYSUdaily}
	}