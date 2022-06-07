#!/bin/sh

ln -f \
   .bashrc \
   .emacs \
   .xinitrc \
   ~/

mkdir -p ~/.emacs.d/lisp/
emacs -Q -batch -f batch-byte-compile rainbow-delimiters.el
ln -f rainbow-delimiters.elc ~/.emacs.d/lisp/

[ -f taustavaloksi ] && [ `stat taustavaloksi.c -c "%Z"` -lt `stat taustavaloksi -c "%Z"` ] \
	|| gcc -O2 taustavaloksi.c -o taustavaloksi

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
   taustavaloksi \
   /usr/local/bin/

chmod u+s /usr/local/bin/taustavaloksi
