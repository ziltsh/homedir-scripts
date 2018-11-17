# homedir-scripts

make install
- adds ~/.bashrc.common 
- adds ~/.bashrc-availabled.d/ with some login script segments
- adds some symlinks to ~/.bashrc-enabled.d/, which is where ~/.bashrc.common
  expects the login script segments

and you
- add a line to ~/.bashrc to source ~/.bashrc.common

