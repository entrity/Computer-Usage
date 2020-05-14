# LaTeX

## Do you need to run this locally?
[Overleaf](https://www.overleaf.com/) is an awesome option for web editing.

## Setup
```bash
# Install 
sudo apt install -y texlive-latex
# Get a nice IDE
sudo apt install -y texstudio
# Initialize fonts
sudo apt install -y texlive-fonts-recommended
```

## Command line
```bash

```

## Fillable forms
See https://tex.stackexchange.com/questions/14842/creating-fillable-pdfs
```latex
\documentclass{article}
\usepackage{hyperref}
\begin{document}
\begin{Form}[action={http://your-web-server.com/path/receiveform.cgi}]
\begin{tabular}{l}
    \TextField{Name} \\\\
    \CheckBox[width=1em]{Check} \\\\
    \Submit{Submit}\\
\end{tabular}
\end{Form}
\end{document}
```

### Troubleshooting

#### Problem
`Font TS1/ntxtlf/m/n/12=ts1-qtmr at 12.0pt not loadable: Metric (TFM) file not found`
#### Solution
Install the missing package (containing `ts1-qtmr`, in this case)

#### Problem
`Cannot determine type of tlpdb from /home/markham/texmf!`
#### Solution
Try looking for the package you want with `apt`

