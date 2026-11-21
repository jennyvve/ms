\ProvidesClass{mscs-project}

\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{scrartcl}%
}
\ProcessOptions\relax

\LoadClass[a4paper, DIV=12]{scrartcl}

\RequirePackage{amsthm}
\RequirePackage{amsmath,amssymb}
\RequirePackage{mathtools}
\RequirePackage{array}

% Fonts and symbols
% \RequirePackage[bold-style=ISO, warnings-off={mathtools-colon,mathtools-overbracket}]{unicode-math}
% \setmonofont[Scale=MatchLowercase]{inconsolatan}
% \RequirePackage{logix}
\RequirePackage[only,lightning,llbracket, rrbracket]{stmaryrd}
\RequirePackage[prefix=tikzsym]{tikzsymbols}

\RequirePackage{babel}
\RequirePackage{csquotes}
\RequirePackage[
style=alphabetic
% ,backend=bibtex  %% Enable if you cannot use Biber
]{biblatex}

\RequirePackage{xparse}
\RequirePackage{etoolbox}
\RequirePackage[unicode]{hyperref}
\RequirePackage{bookmark}

%\newcommand*{\mathbf}[1]{\bm{\mathsf{#1}}}

\newbool{multipleAuthors}
\def\authors{}
\newcommand{\addAuthor}[2]{%
  \ifbool{multipleAuthors}{
    \appto\authors{ and #1~(#2)}
  }{
    \appto\authors{#1~(#2)}
    \booltrue{multipleAuthors}
  }
}

\AtBeginDocument{\author{\authors{}}}

\newcommand{\setProjectTopic}[1]{%
  \def\projectTopic{#1}
}

\newcommand{\setProjectPart}[1]{%
  \def\projectPart{#1}
  \title{\projectTopic{} -- Part #1}
}

\newcommand{\setCourseYear}[1]{%
  \date{Mathematical Structures in Computer Science #1}
}

\newcommand{\setProjectUrl}[1]{%
  \def\projectUrl{#1}
}

\newcommand{\makeMSCSTitle}{%
  \maketitle{}
  \paragraph{Project Repository}
  \projectUrl{}
}

\renewcommand*{\sectionformat}{%
  \usekomafont{section}%
  Problem~\projectPart{}.\thesection:
}
\newcommand{\problem}[1]{\section{#1}}

\pagestyle{headings}