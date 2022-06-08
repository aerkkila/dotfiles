#!/bin/sh

ln -f \
   .bashrc \
   .emacs \
   .xinitrc \
   ~/

mkdir -p ~/.emacs.d/lisp/
emacs -Q -batch -f batch-byte-compile rainbow-delimiters.el
ln -f rainbow-delimiters.elc ~/.emacs.d/lisp/

[ -f taustavalo ] && [ `stat taustavalo.c -c "%Z"` -lt `stat taustavalo -c "%Z"` ] \
	|| gcc -O2 taustavalo.c -o taustavalo

cp -f \
   _hae_näytöt.sh \
   kuvakaappaus \
   luo_salasana \
   monoääni \
   nuku \
   nuku_lukiten \
   näyttö_lisää \
   näyttö_vaihda \
   pura \
   taustavalo \
   /usr/local/bin/

chmod u+s /usr/local/bin/taustavalo
