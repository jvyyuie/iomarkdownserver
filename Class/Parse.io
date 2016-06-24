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


