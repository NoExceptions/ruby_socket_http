require "socket"
require_relative 'pageProvider'


server = TCPServer.open(8088)
loop do
	Thread.fork(server.accept) do |client|
		path = client.gets
		begin
			path = path.split(" ")[1]
			pageAns = PageProvider.getResponseByPath(path)
			msg =  "HTTP/1.1 200 OK\r\n" +
		         "Content-Type: text/html\r\n" +
		         "Content-Length: #{pageAns.bytesize}\r\n" +
		         "Connection: close\r\n\r\n"
			client.print msg
			client.print pageAns
		rescue
			fullpath = __dir__+"/pages/404.html"
			pageAns = File.read(fullpath)
			msg =  "HTTP/1.1 404 NotFound\r\n" +
		         "Content-Type: text/html\r\n" +
		         "Content-Length: #{pageAns.bytesize}\r\n" +
		         "Connection: close\r\n\r\n"

			client.print msg
			client.print pageAns

		ensure
			client.close
		end
	end
end
