#!/usr/bin/env io

Parse := Object clone
Parse scanline := method(
		line,
		line := line asMutable
		if(line compare("")==0) then(
			return "<br />"
		) elseif(line exSlice(0, 6) compare("##### ")==0) then(
			return line replaceSeq("##### ", "<h5>") .. "</h5>"
		) elseif(line exSlice(0, 5) compare("#### ")==0) then(
			 return line replaceSeq("#### ", "<h4>") .. "</h4>"
		) elseif(line exSlice(0, 4) compare("### ")==0) then(
			  return line replaceSeq("### ", "<h3>") .. "</h3>"
		) elseif(line exSlice(0, 3) compare("## ")==0) then(
			   return line replaceSeq("## ", "<h2>") .. "</h2>"
		) elseif(line exSlice(0, 2) compare("# ")==0) then(
			    return line replaceSeq("# ", "<h1>") .. "</h1>"
		) else (
			     return line
		     )
		)



# 指定文件名，返回文件内容
LoadFile := Object clone
LoadFile read := method(filename,
	articlePath := "/Users/mac/GitHub/iomarkdownserver/articles"
	extName := ".md"
	filePath := articlePath .. filename .. extName

	f := File clone with(filePath)
	if(f exists, f contents, nil)
)







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
				html = html .. out
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
