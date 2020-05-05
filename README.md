# auth-streaming

Work with nginx rtmp server.

## Installations

The installations are for Ubuntu.

Install dependencies:

```bash
sudo apt-get update -qq && sudo apt-get -y install \
  git \
  wget

```

### nodejs

Install nvm.

```bash
cd ~ && \
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash && \
source ~/.profile

```

Install node.

```bash
nvm install node

```

Install pm2 & yarn.

```bash
npm install -g pm2 yarn

```

Download auth-streaming server code & install dependencies.

```bash
cd ~ && \
git clone https://github.com/huai17/auth-streaming.git && \
cd ~/auth-streaming && \
yarn install

```

Create `.env` file with content" `SECRET=put_your_secret_here`.

```bash
cd ~/auth-streaming && \
nano .env

```

Start auth-streaming server.

```bash
cd ~/auth-streaming && \
pm2 start index.js

```

### nginx-rtmp

Install dependencies.

```bash
sudo apt-get update -qq && sudo apt-get -y install \
  build-essential \
  libpcre3 \
  libpcre3-dev \
  libssl-dev \
  zlib1g-dev

```

Download nginx-rtmp.

```bash
sudo mkdir ~/nginx_sources && \
cd ~/nginx_sources && \
sudo git clone git://github.com/arut/nginx-rtmp-module.git

```

Download nginx.

```bash
cd ~/nginx_sources && \
sudo wget https://nginx.org/download/nginx-1.16.1.tar.gz && \
sudo tar zxf nginx-1.16.1.tar.gz

```

Build nginx.

```bash
cd ~/nginx_sources/nginx-1.16.1 && \
sudo ./configure --with-http_ssl_module --with-http_secure_link_module --add-module=../nginx-rtmp-module && \
sudo make && \
sudo make install

```

Setup nginx config and change the secret. Make sure you already download auth-streaming server.

```bash
sudo cp ~/auth-streaming/nginx.conf /usr/local/nginx/conf/nginx.conf && \
sudo nano /usr/local/nginx/conf/nginx.conf

```

Start nginx server.

```bash
sudo /usr/local/nginx/sbin/nginx

```

To restart nginx server.

```bash
sudo /usr/local/nginx/sbin/nginx -s stop && \
sudo /usr/local/nginx/sbin/nginx

```

<!-- ### ffmpeg

Install dependencies.

```bash
sudo apt-get update -qq && sudo apt-get -y install \
  autoconf \
  automake \
  build-essential \
  cmake \
  git \
  libass-dev \
  libfreetype6-dev \
  libsdl2-dev \
  libtool \
  libva-dev \
  libvdpau-dev \
  libvorbis-dev \
  libxcb1-dev \
  libxcb-shm0-dev \
  libxcb-xfixes0-dev \
  pkg-config \
  texinfo \
  wget \
  zlib1g-dev

```

Prepare workspace.

```bash
mkdir -p ~/ffmpeg_sources ~/bin

```

Install NASM assembler.

```bash
cd ~/ffmpeg_sources && \
wget https://www.nasm.us/pub/nasm/releasebuilds/2.14.02/nasm-2.14.02.tar.bz2 && \
tar xjvf nasm-2.14.02.tar.bz2 && \
cd nasm-2.14.02 && \
./autogen.sh && \
PATH="$HOME/bin:$PATH" ./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" && \
make && \
make install

```

Install Yasm assembler.

```bash
cd ~/ffmpeg_sources && \
wget -O yasm-1.3.0.tar.gz https://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz && \
tar xzvf yasm-1.3.0.tar.gz && \
cd yasm-1.3.0 && \
./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" && \
make && \
make install

```

Install libx264 liberary, an H.264 video encoder.

```bash
cd ~/ffmpeg_sources && \
git -C x264 pull 2> /dev/null || git clone --depth 1 https://code.videolan.org/videolan/x264.git && \
cd x264 && \
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --enable-static --enable-pic && \
PATH="$HOME/bin:$PATH" make && \
make install

```

Build ffmpeg.

```bash
cd ~/ffmpeg_sources && \
wget -O ffmpeg-snapshot.tar.bz2 https://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2 && \
tar xjvf ffmpeg-snapshot.tar.bz2 && \
cd ffmpeg && \
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure \
  --prefix="$HOME/ffmpeg_build" \
  --pkg-config-flags="--static" \
  --extra-cflags="-I$HOME/ffmpeg_build/include" \
  --extra-ldflags="-L$HOME/ffmpeg_build/lib" \
  --extra-libs="-lpthread -lm" \
  --bindir="$HOME/bin" \
  --enable-gpl \
  --enable-libx264 && \
PATH="$HOME/bin:$PATH" make && \
make install && \
hash -r

```

Move ffmpeg to root user.

```bash
sudo cp ~/bin/* /usr/bin/

``` -->
