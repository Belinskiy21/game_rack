require './lib/cb_rack'

app = Rack::Builder.new do
  use Rack::Reloader, 0
  use Rack::Static, urls: ['/stylesheets'], root: 'public'

  use Rack::Session::Cookie, key: 'rack.session',
  expire_after: 216_000,
  secret: '*&(^B'

  run CbRack
end

run app
