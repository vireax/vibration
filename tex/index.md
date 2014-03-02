---
layout: default
title: TeX repo
---

# TeX source for thesis draft #

[https://github.com/vireax/vibration/tree/gh-pages/tex](https://github.com/vireax/vibration/tree/gh-pages/tex)

Nothing this only for backend TeX source

- chapter 1
- chapter 2
- chapter 3
- chapter 4
- chapter 5

`Main.tex`

<pre><code>
\documentclass[12pt,a4paper,oneside, final]{book}
%\usepackage{hyperref}
%\hypersetup{colorlinks=false}

\usepackage[colorlinks = true,%hidelinks,	hyperindex = true,
pdfauthor={Vireak Kim},%
pdftitle={Co-operative Co-evolutionary Genetic Algorithms for Vibration Based Damage Detection in Truss Structures},%
pagebackref=false]{hyperref}%%pdftex
\usepackage{mystyle}
%\hypersetup{colorlinks = true, linkcolor = {red}}
%\usepackage{bookmark}

%\usepackage[ampersand]{easylist}

%\renewcommand{\thesubsection}{\arabic{subsection}}
%\makeatletter
%\def\@seccntformat#1{\@ifundefined{#1@cntformat}%
%   {\csname the#1\endcsname\quad}%       default
%   {\csname #1@cntformat\endcsname}}%    enable individual control
%\newcommand\section@cntformat{}
%\makeatother
%\setcounter{secnumdepth}{2} % no effect
%\renewcommand{\thesubsection}{\thesection.\arabic{subsection}} % not neccessary

%\newcommand\startsupplement{%
%    \makeatletter 
%       \setcounter{table}{0}
%       \renewcommand{\thetable}{S\arabic\c@table}
%       \setcounter{figure}{0}
%       \renewcommand{\thefigure}{S\@arabic\c@figure}
%    \makeatother}
    
%\settocdepth{subsection}

\title{Co-operative Co-evolutionary Genetic Algorithms for Vibration Based Damage Detection in Truss Structures}
\author{%\\\begin{large}A research proposal by \end{large}\\
Vireak Kim}
\date{September 2013}

\begin{document}
\frontmatter
\maketitle
%\newpage
%\input{abstract}
%\pdfbookmark{Table of contents}{contents}
\tableofcontents
\addcontentsline{toc}{chapter}{Contents}

%\listoftables
%\addcontentsline{toc}{chapter}{List of Tables}

%\listoffigures
%\listofalgorithms
%\addcontentsline{toc}{chapter}{List of Algorithms}

\mainmatter
\input{chapter1}
\input{chapter2}
\input{chapter3}

%%%%%%%%%%%REFERENCES%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%\input{references}	
%\clearpage
%\addcontentsline{toc}{chapter}{Bibliography}

\bibliography{ref}
\bibliographystyle{apacite}

\end{document}

</code></pre>
