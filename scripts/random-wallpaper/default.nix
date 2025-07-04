{ pkgs, ... }:
pkgs.writers.writePython3 "random-wallpaper" {} ''
  from os import system, listdir
  from random import randint
  from sys import argv

  d = argv[1]
  wallpapers = []
  for folder in listdir(d):
      for image in listdir(f"{d}/{folder}"):
          wallpapers.append(f"{d}/{folder}/{image}")

  random_index = randint(0, len(wallpapers)-1)

  program = "${pkgs.swww}/bin/swww"

  system(f"{program} img --transition-type=any {wallpapers[random_index]}")
  # noqa: E501
''
