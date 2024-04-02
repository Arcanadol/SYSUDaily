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
% \usepackage[noendash,italic, frenchmath]{mathastext}

\newcounter{pancounter}
\stepcounter{pancounter}


% \definecolor{emptycolor}{RGB}{0,0,0}

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

\ExplSyntaxOn
\clist_new:N \c_math_styles_clist
% \clist_set:Nn \c_math_styles_clist {empty}
\NewDocumentCommand{\Addmathstyles}{mO{}O{0,0,0}}{
\clist_put_right:Nn \c_math_styles_clist { #1 }
\cs_new:cpn { SYSUdaily#1name } { #2 }
\definecolor{#1color}{RGB}{ #3 }
}
\NewDocumentCommand{\ShowSYSUdailyname}{m}{\use:c { SYSUdaily#1name } }
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
\newcommand{\SYSUdailywatermark} {
  \bfseries \makebox[.79\textwidth][r]{
    \smash{\rule[-8pt]{.8pt}{8pt+\baselineskip+1pt}}\hskip2mm
    \makebox[0pt][l]{ \parbox{60pt}{ \vspace*{-.4ex}笃学笃行，\\[.1ex]不悔不倦. }}\hspace*{8pt}
  }
}


\newlength{\SYSUdailywidth}
\newlength{\SYSUdailyheight}
\setlength{\SYSUdailyheight}{52pt}
\setlength{\SYSUdailywidth}{0.8\textwidth}
\newsavebox{\SYSUdailymeasurebox}

\newtcolorbox{SYSUdaily}[4]{%
  mathstyles = #1,%
  title      = {\bfseries\IfBlankTF{#4}{\vphantom{空}}{%
        \ShowSYSUdailyname{#1}\the\value{pancounter}\stepcounter{pancounter}：#4%
      }\hfill{\ifx#2\empty\else\expandafter\SYSUdailyParameterDate\fi}},%
  watermark text = {\SYSUdailywatermark},%
  underlay    = {\putstars{#3}{#1}},%
  fonttitle = {},
}%

% \NewEnviron{daily}[4]{
%   \savebox{\SYSUdailymeasurebox}{%
%     \begin{minipage}{\SYSUdailywidth}%
%       \itshape\BODY%
%     \end{minipage}%
%   }
%   \settoheight{\SYSUdailyheight}{\usebox{\SYSUdailymeasurebox}}
%   \ifthenelse{\lengthtest{\SYSUdailyheight > 26pt}}{%
%     \renewcommand{\SYSUdailywatermark}{ \bfseries 笃学笃行，不悔不倦. }%
%     \def\SYSUdailyright{2mm}
%   }{}
%   \begin{SYSUdaily}{#1}{#2}{#3}{#4}
%     \BODY
%   \end{SYSUdaily}
% }
\ExplSyntaxOn

\def\SYSUdailyParameterMathStyles{proposition}\csname c@month\endcsname
\expandafter\expandafter\def\expandafter\SYSUdailyParameterDate{\the\year\ifnum\month<10{0}\the\month\else\the\month\fi\ifnum\day<10{0}\the\day\else\the\day\fi}
\def\SYSUdailyParameterDifficulty{0}
\def\SYSUdailyParameterTitle{}


\NewDocumentCommand{\SYSUdailycheck}{mm}{
  \clist_if_in:NnTF \c_math_styles_clist {#1}
  { \cs_set:cpn { #2check } { MathStyles } }
  {
    \regex_match:nnTF { ^[+-]?\d+$ } {#1}
    {
      \cs_set:cpn { #2check } { Title }
      \int_compare:nTF {
        #1 > 10000000
        % #1 < 100000000
      }
      { \cs_set:cpn { #2check } { Date } }
      {
        \int_compare:nTF {
          #1 < 5
        }
        { \cs_set:cpn { #2check } { Difficulty } }
        { }
      }
    }
    { \cs_set:cpn { #2check } { Title } }
  }
}
\NewDocumentEnvironment{daily}{oooo+b}{

  \IfNoValueTF{#4}{
    \IfNoValueTF{#3}{
      \IfNoValueTF{#2}{
        \IfNoValueTF{#1}{}{
          \def\SYSUdailyParameters{1}
        }
      }{ \def\SYSUdailyParameters{2} }
    }{ \def\SYSUdailyParameters{3} }
  }{ \def\SYSUdailyParameters{4} }

  \ifnum\SYSUdailyParameters=1
    \SYSUdailycheck{ #1 }{ I }
    \cs_set:cpn { SYSUdailyParameter \use:c { Icheck } }{ #1 }
  \else
  \fi

  \ifnum\SYSUdailyParameters=2
    \SYSUdailycheck{ #1 }{ I }
    \SYSUdailycheck{ #2 }{ II }
    \cs_set:cpn { SYSUdailyParameter \use:c { IIcheck } }{ #2 }
    \cs_set:cpn { SYSUdailyParameter \use:c { Icheck } }{ #1 }
  \else
  \fi

  \ifnum\SYSUdailyParameters=3
    \SYSUdailycheck{ #1 }{ I }
    \SYSUdailycheck{ #2 }{ II }
    \SYSUdailycheck{ #3 }{ III }
    \cs_set:cpn { SYSUdailyParameter \use:c { IIIcheck } }{ #3 }
    \cs_set:cpn { SYSUdailyParameter \use:c { IIcheck } }{ #2 }
    \cs_set:cpn { SYSUdailyParameter \use:c { Icheck } }{ #1 }
  \else
  \fi

  \ifnum\SYSUdailyParameters=4
    \SYSUdailycheck{ #1 }{ I }
    \SYSUdailycheck{ #2 }{ II }
    \SYSUdailycheck{ #3 }{ III }
    \SYSUdailycheck{ #4 }{ IV }
    \cs_set:cpn { SYSUdailyParameter \use:c { IVcheck } }{ #4 }
    \cs_set:cpn { SYSUdailyParameter \use:c { IIIcheck } }{ #3 }
    \cs_set:cpn { SYSUdailyParameter \use:c { IIcheck } }{ #2 }
    \cs_set:cpn { SYSUdailyParameter \use:c { Icheck } }{ #1 }
  \else
  \fi

  \hbox_set:Nn \l_tmpa_box {
    \begin{minipage}{\SYSUdailywidth}
      \itshape #5
    \end{minipage}
  }

  \dim_set:Nn \l_tmpa_dim {\box_ht:N \l_tmpa_box}

  \dim_compare:nTF {\l_tmpa_dim > 26pt} {
    \renewcommand{\SYSUdailywatermark}{\bfseries 笃学笃行，不悔不倦。}
    \def\SYSUdailyright{2mm}
  }{}
  \SYSUdaily{\SYSUdailyParameterMathStyles}{\SYSUdailyParameterDate}{\SYSUdailyParameterDifficulty}{\SYSUdailyParameterTitle}
  #5
}
{ \endSYSUdaily }
\ExplSyntaxOff