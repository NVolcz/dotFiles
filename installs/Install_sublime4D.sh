#!/bin/sh

#inspired by: http://techne.btbytes.com/st3d.html
cd ~/git

git clone https://github.com/Hackerpilot/DCD.git
git clone https://github.com/Hackerpilot/Dscanner.git
git clone https://github.com/Hackerpilot/dfmt.git

#
# DCD
#
cd ~/git/DCD
dub build --build=release --config=client
dub build --build=release --config=server
ln -s `realpath dcd-server` ~/bin/dcd-server
ln -s `realpath dcd-client` ~/bin/dcd-client

#
# Dcanner
#
cd ~/git/Dscanner
git submodule update --init --recursive
dub build --build=release
ln -s `realpath dscanner` ~/bin/dscanner

#
# dfmt
#
cd ~/git/dfmt
git submodule update --init --recursive
ln -s `realpath dfmt` ~/bin/dfmt

#
# Sublime-text Packages
#
cd ~/.config/sublime-text-3/Packages
git clone https://github.com/yazd/DKit.git
git clone https://github.com/economicmodeling/SublimeLinter-dscanner.git
git clone https://github.com/dmi7ry/dfmt-sublime.git

#For fedora: cat /etc/dmd.conf
#/usr/include/dmd/phobos 
#/usr/include/dmd/druntime/import

read -d '' USER_CONFIG << EOF
{
  "dcd_path": "~/bin/",
  "dcd_port": 9166,
  "include_paths": [
    "/usr/include/dmd/phobos",
    "/usr/include/dmd/druntime/import"
  ]
}
EOF

echo $USER_CONFIG > ~/.config/sublime-text-3/Packages/User/DKit.sublime-settings

read -d '' BUILD_SYSTEM << EOF
{
    "cmd": ["dmd", "-g", "-debug", "$file"],
    "file_regex": "^(.*?)\\(([0-9]+),?([0-9]+)?\\): (.*)",
    "selector": "source.d",
    "path": "/usr/bin:/usr/local/bin",

    "variants": [
        {
            "name": "Run",
            "cmd": ["rdmd", "-g", "-debug", "$file"]
        },
        {
            "name": "unittest",
            "cmd": ["rdmd", "-g", "-debug", "-unittest", "$file"]
        },
        {
            "name": "dub",
            "working_dir": "$project_path",
            "cmd": ["dub"]
        }
    ]
}
EOF

echo $BUILD_SYSTEM > ~/.config/sublime-text-3/Packages/User/Dlang.sublime-build

#MANUAL: Install sublimelinter

