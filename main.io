#!/usr/bin/env io

WebRequest := Object clone do(
	cache := Map clone
	handleSocket := method(socket, server,
		socket streamReadNextChunk
		if(socket isOpen == false, return)
		request := socket readBuffer betweenSeq("GET ", " HTTP")         

		data := cache atIfAbsentPut(request,
			articlePath := "/Users/mac/GitHub/iomarkdownserver/articles"
			extName := ".md"
			filePath := articlePath .. request .. extName
filePath println
			f := File clone with(filePath)
			if(f exists, f contents, nil)
		)
		if(data,
			socket streamWrite("HTTP/1.0 200 OK\n")
			socket streamWrite("Content-Type: text/html\n\n")
			socket streamWrite("<!DOCTYPE html>")
			socket streamWrite("<html>")
			socket streamWrite("<head>")
			socket streamWrite("<meta http-equiv=\"content-type\" content=\"text/html;charset=utf-8\">")
			socket streamWrite("<title>" .. request .. "</title>")
			socket streamWrite("</head>")
			socket streamWrite("<body>")
			socket streamWrite(data)
			socket streamWrite("</body>")
			socket streamWrite("</html>")
			,
			socket streamWrite("HTTP/1.0 404 OK\n")
			socket streamWrite("Content-Type: text/html\n\n")
			socket streamWrite("Not Found")
		)                                                                
		socket close
		server requests append(self)
	)
)                                                                        

WebServer := Server clone do(
	setPort(8000)
	socket setHost("127.0.0.1")
	requests := List clone
	handleSocket := method(socket,
		WebRequest handleSocket(socket, self)
	)
)

WebServer start
