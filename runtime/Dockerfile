FROM lambci/lambda:build-ruby2.5 AS bld

WORKDIR /tmp

RUN git clone https://github.com/mruby/mruby.git -b stable

WORKDIR /tmp/mruby/

COPY build_config.rb .

RUN gem install rake

RUN rake

RUN cp -r build/host/bin /opt

FROM lambci/lambda:build-provided

WORKDIR /opt

COPY --from=bld /opt/bin/ ./bin
COPY bootstrap /opt
COPY lib /opt/lib

RUN  for f in $(ls /opt/lib/*.rb); do /opt/bin/mrbc $f; done
