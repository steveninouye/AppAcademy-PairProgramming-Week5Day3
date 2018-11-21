require 'rack'

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  res['Content-Type'] = 'text/html'

  if req.path == '/appacademy'
    res.write('Thank god A04 is over')
  else
    res.location = '/appacademy'
  end
  res.finish
end

Rack::Server.start(
  app: app,
  Port: 3000
)
