#!/usr/bin/env io

# 指定文件名，返回文件内容
LoadFile := Object clone
LoadFile read := method(filename,
		# will not use below method to set the articles path.
		# articlePath := "/Users/mac/GitHub/iomarkdownserver/articles"
		# 当前脚本所在目录 fix #1
		applicationPath := System launchPath
		articlePath := applicationPath .. "/articles"

		extName := ".md"
		filePath := articlePath .. filename .. extName

		f := File clone with(filePath)
		if(f exists, f contents, nil)
		)
