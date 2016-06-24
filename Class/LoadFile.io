#!/usr/bin/env io

# 指定文件名，返回文件内容
LoadFile := Object clone
LoadFile read := method(filename,
	articlePath := "/Users/mac/GitHub/iomarkdownserver/articles"
	extName := ".md"
	filePath := articlePath .. filename .. extName

	f := File clone with(filePath)
	if(f exists, f contents, nil)
)
