#!/bin/bash
git reset --hard
chmod +x *
git pull > tmp

while read -r row; do
echo "$row"
done < tmp

if [ $row="Already up to date." ]
then
clear
echo "PRoot-distro ve Rosa zaten güncel."
rm tmp
else
echo "Gerekli yamalar yükleniyor..."
git pull
sleep 2
./install.sh
echo "Eski veriler yedekleniyor. Eğer yedeklenmez ise yeni sistem kurulduğu zaman bütün verileriniz kayıp olur."
sleep 2
proot-distro backup rosa --output rosa_old.tar.xz
echo "Eski sistem siliniyor."
sleep 2
proot-distro remove rosa
echo "Güncel sistem indiriliyor."
sleep 2
proot-distro install rosa
echo "Eski verileriniz yeni sisteme aktarılıyor."
tar -xf --skip-old-files rosa_old.tar.xz -C $HOME/../usr/var/lib/proot-distro/installed-rootfs/rosa/
echo "Önbellek siliniyor..."
rm tmp
rm rosa_old.tar.xz
clear
echo "PRoot ve Rosa başarıyla güncellendi! Şimdi kullanabilirsiniz."
exit
fi
exit
