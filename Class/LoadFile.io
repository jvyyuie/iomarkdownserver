LoadFile := Object clone

# 指定文件名，返回文件内容
LoadFile read := method(filename,
		articlePath	:= (System launchPath) .. "/articles"
		filePath	:= articlePath .. filename .. ".md"
		fp := File clone with(filePath)
		if(fp exists, fp contents, nil)
		)
