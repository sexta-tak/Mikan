git clone https://github.com/uchan-nos/mikanos-build.git $HOME/src/osbook
curl -L https://github.com/uchan-nos/mikanos-build/releases/download/v2.0/x86_64-elf.tar.gz | tar xzvf - -C $HOME/src/osbook/devenv
export PATH='$HOME/src/osbook/devenv:${PATH}'
sed -e 's/$HOME/$HOME\/src/g' $HOME/src/osbook/devenv/buildenv.sh
