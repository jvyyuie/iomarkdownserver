#!/usr/bin/env io
doFile("./Config/Config.io")
doFile("./Class/Parse.io")
doFile("./Class/LoadFile.io")
doFile("./Class/ServerLog.io")
WebRequest := Object clone do(
	cache := Map clone
	handleSocket := method(socket, server,
		socket streamReadNextChunk
		if(socket isOpen == false, return)
		SystemLog write(socket readBuffer)
		# 下面这一行，要利用新的类，具体通过Header信息分析出来
		request := socket readBuffer betweenSeq("GET ", " HTTP")         
		# 修复request是空（HEAD）的问题，不过这个修复不是正确的机制。
		# 更合理的是，上面的第10行，进行各处非GET类处理
		if(request == nil, request := "/index")
		# 专门处理没有输入uri的情况
		if(request compare("/")==0, request := "/index")
		data := cache atIfAbsentPut(request, LoadFile read(request))
		if(data,
			# 将内容中的\r\n、\r、\n\r，统一替换成\n，然后根据\n分割成数组，再一行行进行处理、扫描、转换
			arrays := data asMutable replaceSeq("\r\n", "\n") replaceSeq("\n\r", "\n") replaceSeq("\r", "\n") split("\n")
			htmlArray := List clone
			arrays foreach(i,
				line,
				out1 := Parse scanline(line)	# 逐行扫描，处理每一行中的标题符号
				out2 := Parse link(out1)	# 逐行扫描，处理每行中的link链接
				out3 := Parse strong(out2)	# 逐行扫描，处理每行的**、__符号
				out4 := Parse em(out3)		# 逐行扫描，处理每行的*、_符号
				htmlArray append(out4)
			)
			socket streamWrite("HTTP/1.0 200 OK\n")
			socket streamWrite("Server: " .. Config ServerName .. "/" .. Config ServerVersion .. "\n")
			socket streamWrite("Date: " .. Date asAtomDate .. "\n")
			socket streamWrite("Content-Type: text/html\n\n")
			socket streamWrite("<!DOCTYPE html>")
			socket streamWrite("<html>")
			socket streamWrite("<head>")
			socket streamWrite("<meta http-equiv=\"content-type\" content=\"text/html;charset=utf-8\">")
			socket streamWrite("<title>" .. request .. "</title>")
			socket streamWrite("</head>")
			socket streamWrite("<body>")
			socket streamWrite(htmlArray join)
			socket streamWrite("</body>")
			socket streamWrite("</html>")
			,
			socket streamWrite("HTTP/1.0 404 OK\n")
			socket streamWrite("Server: " .. Config ServerName .. "/" .. Config ServerVersion .. "\n")
			socket streamWrite("Date: " .. Date asAtomDate .. "\n")
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
	requests	:= List clone
	handleSocket	:= method(socket, WebRequest handleSocket(socket, self))
)

Config ServerName println
Config ServerVersion println
Config Author println
Config Github println
WebServer start

