#!/bin/sh

ln -f \
   .bashrc \
   .emacs \
   .xinitrc \
   ~/

mkdir -p ~/.emacs.d/lisp/
emacs -Q -batch -f batch-byte-compile rainbow-delimiters.el
ln -f rainbow-delimiters.elc ~/.emacs.d/lisp/

cp -f \
   _hae_näytöt.sh \
   kuvakaappaus \
   luo_salasana \
   monoääni \
   nuku \
   näyttö_lisää \
   näyttö_vaihda \
   pura \
   /usr/local/bin/
