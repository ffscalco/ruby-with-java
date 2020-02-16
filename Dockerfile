FROM ubuntu:latest

# for Java
RUN add-apt-repository ppa:webupd8team/java \
# accept oracle license
  && echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
  && echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections \
  && apt-get update \
# install oracle jdk 8 and make it default
  && apt-get -y install oracle-java8-installer \
  && apt-get -y install oracle-java8-set-default \
# clean up
  && apt-get clean all \
  && rm -rf /var/lib/apt/lists/*

# for Ruby
RUN apt-get -y install build-essential automake git zlib1g-dev libssl-dev libreadline6-dev libyaml-dev libxml2-dev libxslt-dev libcurl4-openssl-dev libmysqlclient-dev libffi-dev \
 && wget --no-check-certificate https://cache.ruby-lang.org/pub/ruby/ruby-2.5.3.tar.gz \
 && tar zxvf ruby-2.5.3.tar.gz \
 && cd ruby-2.5.3 \
 && ./configure && make && make install  \
 && cd ..  \
 && rm -f ruby-2.5.3.tar.gz  \
 && rm -rf ruby-2.5.3 \
 && gem install bundler

CMD "/bin/bash"
