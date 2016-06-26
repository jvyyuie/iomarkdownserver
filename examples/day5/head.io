content := """
GET / HTTP/1.1
Host: 127.0.0.1
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Language: zh-cn
Connection: keep-alive
Accept-Encoding: gzip, deflate
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/601.6.17 (KHTML, like Gecko) Version/9.1.1 Safari/601.6.17
"""


HeadParser := Object clone
HeadParser getUri := method(content,
	headerArray := content split("\r\n", "\r", "\n")
	headerArray foreach(i, v,
		if(v containsSeq("HTTP"),
			paramArray := v split(" ")
			return paramArray at(1)
		)
	)
)
HeadParser getMethod := method(content,
	headerArray := content split("\r\n", "\r", "\n")
	headerArray foreach(i, v,
		if(v containsSeq("HTTP"),
			paramArray := v split(" ")
			return paramArray at(0)
		)
	)
)

uri := HeadParser getUri(content)
method := HeadParser getMethod(content)
uri println
method println


#content println
#ret println
