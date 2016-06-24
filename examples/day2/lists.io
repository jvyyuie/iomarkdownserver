# 数组

arr := List clone append("# abc", "## def", "ghi", "jkl")

arr foreach(
		i,
		node,
		line := i .. " : " .. node
		line println
	   )

#filename := "/Users/mac/GitHub/iomarkdownserver/articles/index.md"
##filename println
#
#fp := File clone with(filename)
#result := if(fp exists, fp contents, nil)
#
## 将内容中的\r\n、\r、\n\r，统一替换成\n
#result := result asMutable
#result := result replaceSeq("\r\n", "\n")
#result := result replaceSeq("\n\r", "\n")
#result := result replaceSeq("\r", "\n")
#
## 将所有\n\n替换成<br />
#result := result replaceSeq("\n\n", "<br />")
#
## 并且输出到屏幕上
#result println
#
