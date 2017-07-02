require './lib/cb_rack'

use Rack::Reloader, 0
use Rack::Static, urls: ['/stylesheets'], root: 'public'

use Rack::Session::Cookie

run CbRack
