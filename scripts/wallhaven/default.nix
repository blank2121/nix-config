{ lib, pkgs, ...}:
pkgs.writers.writeBash "wallhaven" ''
      pgs=$(curl "https://wallhaven.cc/user/blank2/favorites/1734488?purity=110&page=2" | ${pkgs.pup}/bin/pup "h2:contains(\"/\")" | tail -n 2 | head -n 1 | awk -F '/' '{print $2}' | awk '{print $1}')

      rand_num=$(( (RANDOM % pgs) + 1 ))

      rand=$(curl "https://wallhaven.cc/user/blank2/favorites/1734488?purity=110&page=$rand_num" | ${pkgs.pup}/bin/pup "a.preview attr{href}" | shuf -n 1)

      img=$(curl "$rand" | ${pkgs.pup}/bin/pup "img#wallpaper attr{src}")

      curl "$img" --output /tmp/wallhaven-paper.png

      ${pkgs.swww}/bin/swww img --transition-type=any /tmp/wallhaven-paper.png
''
