%\usepackage[utf8]{inputenc}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{oci}[2014/09/29 v1.0 Clase LaTeX para estandarizacion de problemas OCI]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\LoadClass[11pt]{article}

\RequirePackage{fancyhdr}
\RequirePackage{graphicx}
\RequirePackage{verbatim}
\RequirePackage{enumitem}
\RequirePackage{tabu}
\RequirePackage{color}
\RequirePackage{etoolbox}

%% Catch environment variable
\RequirePackage{catchfile}
\newcommand{\getenv}[2][]{%
  \CatchFileEdef{\temp}{"|kpsewhich --var-value #2"}{\endlinechar=-1}%
  \if\relax\detokenize{#1}\relax\temp\else\let#1\temp\fi}

%% GEOMETRY
\oddsidemargin  0.0in
\evensidemargin 0.0in
\textwidth      6.7in
\textheight     8.2in
\voffset        -0.5in
%\headsep        0in
\parindent      0.0in

%% PAGE NUMBERING
% \global\let\@pagenumber\@empty
% \getenv[\@pagenumber]{OCIMATIC_PAGE_NUMBER}
% \if\@pagenumber\@empty
% \else
% \setcounter{page}{\@pagenumber}
% \fi
% \setcounter{page}{11}


%% EXTRA
\addtolength{\parskip}{0.4\baselineskip}

%% HEADER
\global\let\@phase\@empty
\getenv[\@phase]{OCIMATIC_PHASE}
\newcommand{\phase}[1]{\def\@phase{#1}}

\setlength\headheight{54.3pt} 
\pagestyle{fancy}
\lhead{\includegraphics[height=37.5pt]{logo.eps}}
\rhead{\@phase\ \the\year}
\renewcommand{\headrulewidth}{0.2pt}

%% FOOTER
\cfoot{}

%% TITLE
\global\let\@problem\@empty
\getenv[\@problem]{OCIMATIC_PROBLEM_NUMBER}
\newcommand{\problem}[1]{\def\@problem{#1}}

\newif\ifproblemcnt%
\problemcntfalse%
\global\let\@codename\@empty
\newcommand{\codename}[1]{\def\@codename{#1}}


\newcommand{\mymaketitle}{
    \begin{center}
      {\huge\bf \sf Problema \@problem}\\
    \LARGE{\sf \@title}\\[2mm]
    \normalsize {\em nombre clave:} {\tt \@codename}
    \vspace{6pt}
    \end{center}
}

%% Sideness
\def\@sideness{oneside}
\getenv[\@sideness]{OCIMATIC_SIDENESS}

\renewcommand*{\cleardoublepage}{
  \clearpage
  \ifdefstring{\@sideness}{twoside}{%
    \ifnumodd{\c@page}{}{%
      \hbox{}%
      \thispagestyle{empty}%
      \newpage%
    }
  }{}
}

\global\let\@useblankpage\@empty
\getenv[\@useblankpage]{OCIMATIC_BLANK_PAGE}
\newcommand{\@blankpage}{%
  \ifdefstring{\@sideness}{twoside}{%
    \clearpage%
    \thispagestyle{empty}%
    \hbox{}
    \clearpage
  }{}
}

%% Secciones de description
\renewcommand{\subsection}{\@startsection{subsection}{2}{\z@}%
                                     {-1.0ex\@plus -1ex \@minus -.2ex}%
                                     {1.0ex \@plus .2ex}%
                                   {\reset@font\large\bfseries}}
\newenvironment{problemDescription}{\mymaketitle}{}
\newenvironment{inputDescription}{\subsection*{Entrada}}{\par}
\newenvironment{outputDescription}{\subsection*{Salida}}{\par}


\AtEndDocument{\ifdefempty{\@useblankpage}{\cleardoublepage}{\@blankpage}}
% \AtEndDocument{\cleardoublepage}

%% Ejemplo Input/Output

\definecolor{samplegray}{rgb}{0.3,0.3,0.3}
\newcommand{\sampleIO}[1]{%
  \begin{minipage}[c]{\textwidth}
    \begin{center}
      \begin{tabu}{|l|} 
        \taburulecolor{samplegray}
        \hline
        \begin{minipage}[t]{0.45\textwidth}
            \vskip 0.3pt
            \bf{Entrada de ejemplo}
            \vskip 12pt
\verbatiminput{#1.in}
            \vskip 4pt
        \end{minipage}
        \begin{minipage}[t]{0.45\textwidth}
            \vskip 0.3pt
            \bf{Salida de ejemplo}
            \vskip 12pt
\verbatiminput{#1.sol}
            \vskip 4pt
        \end{minipage}
        \\
        \hline
      \end{tabu}
    \end{center}
  \end{minipage}
  \vskip 12pt
}


\newenvironment{scoreDescription}{\subsection*{Subtareas y puntaje}\begin{description}[leftmargin=0pt]\itemsep 0pt}{\end{description}}
\newcommand{\score}[1]{\item[#1 puntos]}

\newenvironment{sampleDescription}{\subsection*{Ejemplos de entrada y salida}}{}


