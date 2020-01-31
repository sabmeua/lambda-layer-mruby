MRuby::Build.new do |conf|
  toolchain :gcc
  conf.gem :github => 'iij/mruby-io'
  conf.gem :github => 'iij/mruby-dir'
  conf.gem :github => 'iij/mruby-require'
  conf.gem :github => 'iij/mruby-regexp-pcre'
  conf.gem :github => 'mattn/mruby-uv'
  conf.gem :github => 'mattn/mruby-http'
  conf.gem :github => 'mattn/mruby-json'
  conf.gem :github => 'matsumotory/mruby-simplehttp'
  conf.gem :github => 'matsumotory/mruby-httprequest'
  conf.gembox 'full-core'
end
