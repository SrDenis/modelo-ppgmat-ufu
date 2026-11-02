%%
%% Customizações do abnTeX2 (http://abnTeX2.googlecode.com) para o Programa de Pós Graduação em Matemática (PPGMAT) 
%% do Instituto de Matemática e Estatística da Universidade Federal de Uberlândia.
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.

\NeedsTeXFormat{LaTeX2e}
\RequirePackage{expl3}[2023-01-01]
\ProvidesClass{ppgmat-ime-dissertacao}[2025/12/07 v1.0 Modelo de Dissertação para o PPGMAT-IME-UFU]


% ===================================================================
% Variáveis e opções
% ===================================================================
\ExplSyntaxOn
\tl_new:N \g_ppgmat_grau_tl
\tl_new:N \g_ppgmat_tipo_tl
\tl_new:N \g_ppgmat_nivel_tl
\tl_new:N \g_ppgmat_preambulo_tl

\keys_define:nn {ppgmat}{
  grau .choices:nn =
    {licenciatura, bacharelado, mestrado, doutorado, qualificacao}
    {\tl_gset_eq:NN \g_ppgmat_grau_tl \l_keys_choice_tl},
  grau .initial:n = mestrado,

  unknown .code:n = {\PassOptionsToClass{\l_keys_key_str}{abntex2}}
}
\ProcessKeyOptions[ppgmat]\relax
% Hide the option from abntex2's option scanner
\exp_args:NNx \clist_remove_all:Nn \@classoptionslist { grau=\g_ppgmat_grau_tl }
\clist_remove_all:Nn \@classoptionslist { grau }

% Clean up the unused list as well
\exp_args:NNx \clist_remove_all:Nn \@unusedoptionlist { grau=\g_ppgmat_grau_tl }
\clist_remove_all:Nn \@unusedoptionlist { grau }
\ExplSyntaxOff

% ===================================================================
% Pacotes iniciais
% ===================================================================
\PassOptionsToPackage{english, brazil}{babel}
\ProcessOptions\relax
\LoadClass[12pt, openright, oneside, a4paper, english, brazil]{abntex2}

% Carrega os pacotes de fonte e encoding de acordo com o compilador
\RequirePackage{iftex}

\ifPDFTeX
  % --- COMPILAÇÃO PDFLATEX (PADRÃO) ---
  \RequirePackage[T1]{fontenc}
  \RequirePackage[utf8]{inputenc}
  \RequirePackage{lmodern}
  %  \RequirePackage{newpxtext}
  %  \RequirePackage{newpxmath}

\else
  % --- COMPILAÇÃO XELATEX OU LUALATEX ---
  \RequirePackage{fontspec}
  \RequirePackage{unicode-math}
\fi
% Pacotes restantes
\RequirePackage{mathtools}
\RequirePackage{amssymb}
\RequirePackage{indentfirst}	% Indenta o primeiro parágrafo de cada seção.
\RequirePackage{xcolor}				% Controle das cores
\RequirePackage{graphicx}			% Inclusão de gráficos
\RequirePackage{microtype} 		% para melhorias de justificação
\RequirePackage{pdfpages}     % Inserção de pdfs como a folha de aprovação
\RequirePackage{csquotes}
\RequirePackage{keytheorems}

\selectlanguage{brazil}

% ===================================================================
% Referências e citações
% ===================================================================
\RequirePackage[bibstyle=abnt-numeric, citestyle=numeric-comp, backref, justify=true]{biblatex}
\RequirePackage{zref-clever}
\zcsetup{capfirst}
%\RequirePackage{hyperref}

% ===================================================================
% Padrões por grau
% ===================================================================

\ExplSyntaxOn
% Variáveis auxiliares para injetar no abntex2
\tl_new:N \g_ppgmat_tipotrabalho_tl
\tl_new:N \g_ppgmat_grau_objetivo_tl

\str_case:Vn \g_ppgmat_grau_tl
{
    { bacharelado }
    {
      \tl_gset:Nn \g_ppgmat_tipotrabalho_tl { Trabalho~de~Conclusão~de~Curso (Bacharelado) }
      \tl_gset:Nn \g_ppgmat_grau_objetivo_tl { Bacharel~em~Matemática }
    }
    { licenciatura }
    {
      \tl_gset:Nn \g_ppgmat_tipotrabalho_tl { Trabalho~de~Conclusão~de~Curso (Licenciatura)}
      \tl_gset:Nn \g_ppgmat_grau_objetivo_tl { Licenciado~em~Matemática }
    }
    { mestrado }
    {
      \tl_gset:Nn \g_ppgmat_tipotrabalho_tl { Dissertação~de~Mestrado (Mestrado) }
      \tl_gset:Nn \g_ppgmat_grau_objetivo_tl { Mestre~em~Matemática }
    }
    { doutorado }
    {
      \tl_gset:Nn \g_ppgmat_tipotrabalho_tl { Tese~de~Doutorado (Doutorado) }
      \tl_gset:Nn \g_ppgmat_grau_objetivo_tl { Doutor~em~Matemática }
    }
    { qualificacao }
    {
      \tl_gset:Nn \g_ppgmat_tipotrabalho_tl { Exame~de~Qualificação (Doutorado) }
      \tl_gset:Nn \g_ppgmat_grau_objetivo_tl { Qualificação~em~Matemática }
    }
}
\ExplSyntaxOff

% 
% Construção do preâmbulo padrão
%

\ExplSyntaxOn

\tipotrabalho{ \tl_use:N \g_ppgmat_tipotrabalho_tl }

\preambulo{
  \tl_use:N \g_ppgmat_tipotrabalho_tl\ apresentada~ao~Instituto~de~Matematica~e~Estatística,~UFU,~como~parte~dos~
  requisitos~para~a~obtenção~do~título~de~\tl_use:N \g_ppgmat_grau_objetivo_tl.
}
\ExplSyntaxOff

% ===================================================================
% Ajustes da ABNT
% ===================================================================
% Distinção obrigatória da ABNT entre Quadros e Tabelas
\newcommand{\quadroname}{Quadro}
\newcommand{\listofquadrosname}{Lista de quadros}

\newfloat[chapter]{quadro}{loq}{\quadroname}
\newlistof{listofquadros}{loq}{\listofquadrosname}
\newlistentry{quadro}{loq}{0}

\setfloatadjustment{quadro}{\centering}
\counterwithout{quadro}{chapter}
\renewcommand{\cftquadroname}{\quadroname\space} 
\renewcommand*{\cftquadroaftersnum}{\hfill--\hfill}
\setfloatlocations{quadro}{hbtp}

% Posiciona figuras e tabelas no topo da página quando adicionadas sozinhas
\makeatletter
\setlength{\@fptop}{5pt}
\makeatother

% O tamanho do parágrafo é dado por:
\setlength{\parindent}{1.3cm}
% Controle do espaçamento entre um parágrafo e outro:
\setlength{\parskip}{0.2cm}
% NORMA ABNT NBR 14724:2024
% Os títulos das seções primárias devem figurar na parte superior da mancha gráfica e ser separados do
% texto que os sucede por um espaço de 1,5 entre as linhas. Da mesma forma, os títulos das subseções
% devem ser separados do texto que os precede e que os sucede por um espaço de 1,5 entre as linhas.
% Títulos que ocupem mais de uma linha devem ser, a partir da segunda linha, alinhados abaixo da
% primeira letra da primeira palavra do título.
% Separação entre capítulos terrível da norma ABNT
% ----------------------
% O pacote abntex2 dedide ignorar essa regra por motivos estéticos. Resolvemos seguir as recomendações dos manuais da Universidade.
%\setlength\afterchapskip{\lineskip}
% Outra diferença pra classe abntex2 vem do seguinte trecho da norma:
% --------------------------------------------
% Recomenda-se, quando o trabalho for digitado, a fonte tamanho 12 para todo o texto, inclusive a
% capa, excetuando-se citações diretas com mais de três linhas, notas de rodapé, paginação, dados
% internacionais de catalogação na publicação, fontes e legendas das ilustrações e das tabelas, que
% devem ser em tamanho menor e uniforme.
% --------------------------------------------
% O leitor astuto perceberá que a norma utiliza a expressão "recomenda-se". Dado a aparente não obrigatoriaedade, os autores da abntex2 decidiram
% por ignorar a sugestão. Porém, novamente, os manuais da instituição recomendam o uso de uma só fonte de tamanho 12 com exceção dos casos supracitados.
% Modificaremos as configurações das seções para nos adequar a essa norma.
\renewcommand{\ABNTEXchapterfont}{\rmfamily\bfseries}
\renewcommand{\ABNTEXchapterfontsize}{\Huge}

\renewcommand{\ABNTEXsectionfont}{\ABNTEXchapterfont}
\renewcommand{\ABNTEXsectionfontsize}{\normalsize}

\renewcommand{\ABNTEXsubsectionfont}{\rmfamily}
\renewcommand{\ABNTEXsubsectionfontsize}{\normalsize}

\renewcommand{\ABNTEXsubsubsectionfont}{\ABNTEXsubsectionfont}
\renewcommand{\ABNTEXsubsubsectionfontsize}{\normalsize}

% Aspecto da cor azul e metadados do PDF final
\definecolor{blue}{RGB}{41,5,195}
\makeatletter
\hypersetup{
    pdftitle={\@title}, 
    pdfauthor={\@author},
    pdfsubject={\imprimirpreambulo},
    colorlinks=true,
    linkcolor=blue,
    citecolor=blue,
    filecolor=magenta,
    urlcolor=blue,
    bookmarksdepth=4
}
\makeatother

% Altera a capa
\renewcommand{\imprimircapa}{%
  \begin{capa}%
    \center
    \ABNTEXchapterfont\Large Universidade Federal de Uberlândia

    \vspace*{1cm}

    {\ABNTEXchapterfont\large\imprimirautor}

    \vfill
    \begin{center}
      \ABNTEXchapterfont\bfseries\LARGE\imprimirtitulo
    \end{center}
    \vfill

    \large\imprimirlocal

    \large\imprimirdata

    \vspace*{1cm}
  \end{capa}
}

% Altera a folha de rosto 

\makeatletter

\renewcommand{\folhaderostocontent}{
  \begin{center}
    {\ABNTEXchapterfont\Large Universidade Federal de Uberlândia}

    \vspace*{1cm}

    {\ABNTEXchapterfont\large\imprimirautor}

    \vspace*{\fill}\vspace*{\fill}

    \begin{center}
      \ABNTEXchapterfont\bfseries\Large\imprimirtitulo
    \end{center}

    \vspace*{\fill}

    \abntex@ifnotempty{\imprimirpreambulo}{%
      \hspace{.45\textwidth}
      \begin{minipage}{.5\textwidth}
        \SingleSpacing
        \imprimirpreambulo
      \end{minipage}%
      \vspace*{\fill}
    }%

    {\large\imprimirorientadorRotulo~\imprimirorientador\par}

    \abntex@ifnotempty{\imprimircoorientador}{%
      {\large\imprimircoorientadorRotulo~\imprimircoorientador}%
    }%

    \vspace*{\fill}

    {\abntex@ifnotempty{\imprimirinstituicao}{\imprimirinstituicao\vspace*{\fill}}}

    {\large\imprimirlocal}

    \par

    {\large\imprimirdata}
    \vspace*{1cm}
  \end{center}
}

\makeatother