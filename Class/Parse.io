#!/usr/bin/env io

# 加粗有问题，如果闭口符号后面没有其他内容，则会不进行闭口操作

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

Parse link := method(
		line,
		regex := Regex with("\\[.*\\]|\\(.*\\)") extended
		words := line matchesOfRegex(regex)
		if(words at(0) and words at(1),
			word := words at(0) string exSlice(1, -1)
			link := words at(1) string exSlice(1, -1)
			regex := Regex with("\\[.*\\]\\(.*\\)") extended
			result := line matchesOfRegex(regex) replace(m, "<a href=\"" .. link .. "\">" .. word .. "</a>")
			return result
			,
			return line
		  )
		)

Parse strong := method(line,
		words := line split("**", "--")
		if(words size == 1, return line)
		return Parse strongfill(words))
Parse em := method(line,
		words := line split("*", "-")
		if(words size == 1, return line)
		return Parse emfill(words))
Parse strongfill := method(lists,
		ret := List clone
		isleft := true
		parts := lists size
		step := 0
		lists foreach(m,
			step := step+1
			if(isleft==true,
				ret append(m)
				if(step != parts,
					ret append("<strong>")
				  )
				isleft := false
				,
				ret append(m)
				if(step != parts,
					ret append("</strong>")
				  )
				isleft := true
			  )
			)
		return ret join
		)
Parse emfill := method(lists,
		ret := List clone
		isleft := true
		parts := lists size
		step := 0
		lists foreach(m,
			step := step+1
			if(isleft==true,
				ret append(m)
				if(step != parts,
					ret append("<em>")
				  )
				isleft := false
				,
				ret append(m)
				if(step != parts,
					ret append("</em>")
				  )
				isleft := true
			  )
			)
		return ret join
		)
