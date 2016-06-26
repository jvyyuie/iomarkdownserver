#uri := HeadParser getUri(content)
#method := HeadParser getMethod(content)

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
