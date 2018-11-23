FROM node:8

ADD ./docker-entrypoint.sh /

RUN yarn global add shadowsocks-manager pm2 \
  && sh -c 'printf "deb http://deb.debian.org/debian jessie-backports main\n" > /etc/apt/sources.list.d/jessie-backports.list' \
  && sh -c 'printf "deb http://deb.debian.org/debian jessie-backports-sloppy main" >> /etc/apt/sources.list.d/jessie-backports.list' \
  && apt-get update \
  && apt-get -t jessie-backports-sloppy install -y shadowsocks-libev \
  && apt-get clean -y \
  && apt-get autoclean -y \
  && apt-get autoremove -y \
  && rm -rf /usr/share/locale/* \
  && rm -rf /var/cache/debconf/*-old \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /usr/share/doc/* \
  && echo "Asia/Shanghai" > /etc/timezone \
  && rm /etc/localtime \
  && dpkg-reconfigure -f noninteractive tzdata \
  && mkdir /root/.ssmgr

WORKDIR /root/.ssmgr

CMD ["/docker-entrypoint.sh"]
