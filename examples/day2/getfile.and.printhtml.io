# 获取某文件内容，经过过滤，然后分割成数组
# 遍历数组，逐行转换成html代码

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

filename := "/Users/mac/GitHub/iomarkdownserver/articles/index.md"
fp := File clone with(filename)
result := if(fp exists, fp contents, nil)

# 将内容中的\r\n、\r、\n\r，统一替换成\n
result := result asMutable
result := result replaceSeq("\r\n", "\n")
result := result replaceSeq("\n\r", "\n")
result := result replaceSeq("\r", "\n")

arrays := result split("\n")
arrays foreach(i,
	line,
	out := Parse scanline(line)
	out println
)
