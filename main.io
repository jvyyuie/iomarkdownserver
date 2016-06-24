#!/usr/bin/env io
doFile("./Class/Parse.io")
doFile("./Class/LoadFile.io")

WebRequest := Object clone do(
	cache := Map clone
	handleSocket := method(socket, server,
		socket streamReadNextChunk
		if(socket isOpen == false, return)
		request := socket readBuffer betweenSeq("GET ", " HTTP")         

		data := cache atIfAbsentPut(request, LoadFile read(request))
		if(data,
			html := "" asMutable
			# 将内容中的\r\n、\r、\n\r，统一替换成\n
			data := data asMutable
			data := data replaceSeq("\r\n", "\n")
			data := data replaceSeq("\n\r", "\n")
			data := data replaceSeq("\r", "\n")

			arrays := data split("\n")
			arrays foreach(i,
				line,
				out := Parse scanline(line)
				out2 := Parse link(out)
				html = html .. out2
			)

			socket streamWrite("HTTP/1.0 200 OK\n")
			socket streamWrite("Content-Type: text/html\n\n")
			socket streamWrite("<!DOCTYPE html>")
			socket streamWrite("<html>")
			socket streamWrite("<head>")
			socket streamWrite("<meta http-equiv=\"content-type\" content=\"text/html;charset=utf-8\">")
			socket streamWrite("<title>" .. request .. "</title>")
			socket streamWrite("</head>")
			socket streamWrite("<body>")
			socket streamWrite(html)
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
	handleSocket := method(socket, WebRequest handleSocket(socket, self))
)

WebServer start
