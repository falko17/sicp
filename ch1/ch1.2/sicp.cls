\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sicp}[2024/08/26 Basic template for SICP exercises]

\LoadClass[12pt,a4paper]{article}

\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[english]{babel}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage[a4paper, total={7in, 10in}]{geometry}
\RequirePackage{hyperref}
\RequirePackage{csquotes}
\RequirePackage{fouriernc}
\RequirePackage[p]{zlmtt}
\RequirePackage{xspace}
\RequirePackage{soul}
\RequirePackage{textcomp}
\RequirePackage{amsmath}
\let\openbox\relax
\RequirePackage{amsthm}
\RequirePackage{xstring}
\RequirePackage{tcolorbox}
\RequirePackage{tikz}
\RequirePackage{listings}
\RequirePackage{inconsolata}

\renewcommand{\maketitle}{%
	\begin{center}
		{\LARGE \@title \par}
		\vskip 1em
			{\large \@date}
	\end{center}
}

\renewenvironment{displayquote}{
	\begin{tcolorbox}[
			colback=gray!15,
			colframe=gray!75,
			boxrule=0.5pt,
			left=5pt,
			right=5pt,
			top=5pt,
			bottom=5pt
		]
		}{
	\end{tcolorbox}
}

\newcommand{\formatEx}[1]{%
	\def\tempstring{#1}%
	\StrBehind*{\tempstring}{ex}[\tempstring]%
	\StrSubstitute{\tempstring}{-}{.}[\tempstring]%
	\tempstring
}

\lstset{
	language=Lisp,
	basicstyle=\ttfamily\small,
	keywordstyle=\color{blue},
	commentstyle=\color{green!60!black},
	stringstyle=\color{red},
	% numbers=left,
	% numberstyle=\tiny\color{gray},
	backgroundcolor=\color{gray!10},
	frame=single,
	framesep=5pt,
	breaklines=true,
	showstringspaces=false
}

\newcommand{\TODO}{\textbf{\textcolor{red}{TODO!}}\\}
\hypersetup{
	colorlinks=true,
	citecolor=PineGreen,
	urlcolor=blue}

\title{SICP: Exercise \formatEx{\jobname}}
\author{Falko Galperin}
