require 'rack'
require 'byebug'
require_relative '../lib/controller_base'


class MyController < ControllerBase


  def go
    if @req.path == "/cats"
      render('cats_controller/show')
    else
      redirect_to("/cats")
    end
  end
end

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  MyController.new(req, res).go
  res.finish
end

class ControllerBase
  def initialize(req, res)
    @req = req
    @res = res
  end

  def render(template)
    # path = File.dirname(__FILE__)
    path = Dir.home
    new_path = File.join(path, 'Desktop', 'W5D3', 'skeleton', 'views', "#{template}.html.erb")
    file_content = File.read(new_path)
    erb_code = ERB.new(file_content).result(binding)
    render_content(erb_code, 'text/html')
  end

  def render_content(erb_code, content_type = 'text/html')
    @res.body(erb_code)
    @res['Content-Type'] = content_type
  end

  def redirect_to(url)
    @res['location'] = url
    @res.status = 302

  end
end

Rack::Server.start(
  app: app,
  Port: 3000
)
