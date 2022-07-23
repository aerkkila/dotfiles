#!/bin/sh
. ./tilapalkki.config
cp tilapalkki.sh.in .tilapalkki_dwl.sh
sed -i 's/CONFIGURE_AMIXER_VAI_PACTL_KAIUTIN/'"${amixer_vai_pactl_kaiutin}"'/g' .tilapalkki_dwl.sh
sed -i 's/CONFIGURE_AMIXER_VAI_PACTL_MIKROFONI/'"${amixer_vai_pactl_mikrofoni}"'/g' .tilapalkki_dwl.sh
sed -i 's/CONFIGURE_AMIXER_DEVICE/'"${amixer_device}"'/g' .tilapalkki_dwl.sh
cp .tilapalkki_dwl.sh .tilapalkki_dwm.sh
sed -i 's/CONFIGURE_dwm_vai_dwl/dwl/g' .tilapalkki_dwl.sh
sed -i 's/CONFIGURE_dwm_vai_dwl/dwm/g' .tilapalkki_dwm.sh
