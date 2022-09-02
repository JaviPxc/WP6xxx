# https://www.linuxfromscratch.org/blfs/view/svn/general/git.html
# https://www.linuxfromscratch.org/blfs/view/svn/basicnet/curl.html

# Create temporary 
mkdir -p /home/root/install_tmp/

# Install curl (git dependency)
cd /home/root/install_tmp/
wget https://curl.se/download/curl-7.84.0.tar.xz
tar xvf curl-7.84.0.tar.xz
cd curl-7.84.0

./configure --prefix=/usr                           \
            --disable-static                        \
            --with-openssl                          \
            --enable-threaded-resolver              \
            --with-ca-path=/etc/ssl/certs &&
make

make install &&
rm -rf docs/examples/.deps &&
find docs \( -name Makefile\* -o -name \*.1 -o -name \*.3 \) -exec rm {} \; &&
install -v -d -m755 /usr/share/doc/curl-7.84.0 &&
cp -v -R docs/*     /usr/share/doc/curl-7.84.0


# Install git
cd /home/root/install_tmp/
curl -LO https://www.kernel.org/pub/software/scm/git/git-2.37.2.tar.xz
tar xvf git-2.37.2.tar.xz
cd git-2.37.2
./configure --prefix=/usr                    \
            --with-gitconfig=/etc/gitconfig  \
            --with-python=python3 &&
make

make perllibdir=/usr/lib/perl5/5.36/site_perl install

# Remove temporary folder
rm -rf /home/root/install_tmp/



