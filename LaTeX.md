# LaTeX

```bash
# Get a nice IDE
sudo install -y texstudio
# Initialize fonts
sudo apt install -y texlive-fonts-recommended
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

