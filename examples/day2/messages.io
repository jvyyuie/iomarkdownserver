# 构建类、通过类构建实例（原型继承）、调用类中的方法

Parse := Object clone
Parse scanline := method(
		line,
		line := line asMutable
		if(line exSlice(0, 6) compare("##### ")==0) then(
			line replaceSeq("##### ", "<h5>")
			return line .. "</h5>"
		) elseif(line exSlice(0, 5) compare("#### ")==0) then(
			 line replaceSeq("#### ", "<h4>")
			 return line .. "</h4>"
		) elseif(line exSlice(0, 4) compare("### ")==0) then(
			  line replaceSeq("### ", "<h3>")
			  return line .. "</h3>"
		) elseif(line exSlice(0, 3) compare("## ")==0) then(
			   line replaceSeq("## ", "<h2>")
			   return line .. "</h2>"
		) elseif(line exSlice(0, 2) compare("# ")==0) then(
			    line replaceSeq("# ", "<h1>")
			    return line .. "</h1>"
		) else (
			     return line
		     )
		)

arr := List clone append(
		"### abcaaaa",
		"# abcaaaa",
		"## defaaaa",
		"other jklaaaa",
		"#### abcaaaa",
		"##### abcaaaa",
		"normal ghiaaaa"
		)
arr foreach(
		i,
		line,
		out := Parse scanline(line)
		out println
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
