import os
import wget

wget.download('http://www.mega-nerd.com/libsndfile/files/libsndfile-1.0.26-w64-setup.exe', 'install.exe')
os.system('install.exe')
os.remove('install.exe')