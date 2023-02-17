#!/bin/bash
git reset --hard
git pull > tmp
git reset --hard

while read -r row; do
echo "$row"
done < tmp

if [ $row="Already up to date." ]
then
git reset --hard
clear
echo "PRoot-distro ve Rosa zaten güncel."
else
clear
sleep 2
git reset --hard
echo "[*] Gerekli yamalar yükleniyor..."
git pull
chmod +x *
sleep 2
./install.sh
clear
echo "[*] Eski veriler yedekleniyor. Eğer yedeklenmez ise yeni sistem kurulduğu zaman bütün verileriniz kayıp olur."
sleep 2
proot-distro backup rosa --output $HOME/rosa_old.tar.xz
clear
echo "[*] Eski sistem siliniyor."
sleep 2
proot-distro remove rosa
clear
echo "[*] Güncel sistem indiriliyor."
sleep 2
proot-distro install rosa
clear
echo "[*] Eski verileriniz yeni sisteme aktarılıyor."
tar -xf --skip-old-files $HOME/rosa_old.tar.xz -C $HOME/../usr/var/lib/proot-distro/installed-rootfs/rosa/
clear
echo "Önbellek siliniyor..."
rm tmp
rm $HOME/rosa_old.tar.xz
clear
echo "PRoot ve Rosa başarıyla güncellendi! Şimdi kullanabilirsiniz."
exit
fi
exit
