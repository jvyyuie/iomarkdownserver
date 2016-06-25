#!/usr/bin/env io
doFile("./Class/Parse.io")
doFile("./Class/LoadFile.io")

WebRequest := Object clone do(
	cache := Map clone
	handleSocket := method(socket, server,
		socket streamReadNextChunk
		if(socket isOpen == false, return)
		request := socket readBuffer betweenSeq("GET ", " HTTP")         

		# 专门处理没有输入uri的情况
		if(request compare("/")==0, request := "/index")

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
				out1 := Parse scanline(line)	# 逐行扫描，处理每一行中的标题符号
				out2 := Parse link(out1)	# 逐行扫描，处理每行中的link链接
				out3 := Parse strong(out2)	# 逐行扫描，处理每行的**、__符号
				out4 := Parse em(out3)		# 逐行扫描，处理每行的*、_符号
				html = html .. out4
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
	setPort(80)
	socket setHost("0.0.0.0")
	requests := List clone
	handleSocket := method(socket, WebRequest handleSocket(socket, self))
)

WebServer start
