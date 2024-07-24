todo:

sudo apt install -y xfce4 xserver-xephyr make

Test:
Xephyr :1 -fullscreen


git clone https://github.com/budRich/xwmplay.git
cd  xwmplay
make 
sudo make install


xwmplay --i3-socket=/tmp/test i3
