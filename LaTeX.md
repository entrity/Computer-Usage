# LaTeX

## Do you _need_ to run this locally?
[Overleaf](https://www.overleaf.com/) is an awesome option for web editing.

## Command line
```bash
pdflatex myfile.tex
```

## Tex

```latex
% Absolute positioning
\vspace{-2cm}
\hspace{4cm}

% Background
\usepackage{background}
\usepackage{graphicx}
\backgroundsetup{
scale=1,
color=black,
opacity=1,
angle=0,
contents={%
  \includegraphics[width=\paperwidth,height=\paperheight]{MyImg}
  }%
}
```

### Fillable forms
Cf. https://tex.stackexchange.com/questions/14842/creating-fillable-pdfs
Cf. http://mirrors.ibiblio.org/CTAN/macros/latex/contrib/hyperref/doc/manual.html
<details><summary>Example .tex</summary>

```latex
\documentclass{article}
\usepackage{hyperref}
\begin{document}
\begin{Form}[action={http://your-web-server.com/path/receiveform.cgi}]
  \vspace{-2cm}
  \hspace{4cm}
  \TextField[name=bar,value=Foo,maxlen=4,height=9px]{}

  \CheckBox[checked,name=check1]{}
  \CheckBox[name=check2]{}
  \TextField[borderstyle=U,name=baz,value=Litte]{WING}
  \TextField[borderwidth=0,name=abc,width=33px,value=wer goi'ng]{}

  \vspace{1cm}
  \hspace{8cm}
  \TextField[name=poit,value=gnosh]{}
\end{Form}
\end{document}
```
</details>


## Setup
<details><summary>Installation, configuration</summary>

#### Ubuntu
```bash
# Install 
sudo apt install -y texlive-latex
# Install decrompression tool s.t. tlmgr will work
sudo apt-get install xzdec
# Get a nice IDE
sudo apt install -y texstudio \
  texlive-fonts-recommended \
  texlive-latex-recommended \
  texlive-latex-extra
```
#### Centos
```bash
sudo yum install -y texlive-texlive.infra.noarch \
  texlive-datatool.noarch \
  texlive-collection-fontsrecommended.noarch \
  texlive-collection-latexrecommended.noarch
```
</details>

### Troubleshooting
<details><summary>Problems & Solutions</summary>

#### Problem
`Font TS1/ntxtlf/m/n/12=ts1-qtmr at 12.0pt not loadable: Metric (TFM) file not found`
#### Solution
Install the missing package (containing `ts1-qtmr`, in this case)

#### Problem
```bash
/usr/bin/tlmgr: Initialization failed (in setup_unix_one):
```
#### Solution
Don't even use `tlmgr`. It isn't available on all platforms. Try to use your distro package manager (e.g. `apt`, `yum`).
</details>
