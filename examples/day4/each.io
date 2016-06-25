# 对于一行字符串，循环遍历，进行内容的替换操作（成对替换）

P := Object clone
P strong := method(line,
		words := line split("**", "--")
		if(words size == 1, return line)
		return P strongfill(words))
P em := method(line,
		words := line split("*", "-")
		if(words size == 1, return line)
		return P emfill(words))
P strongfill := method(lists,
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
P emfill := method(lists,
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



# 没有必要进行替换
str := "hello world what can I do for you"
ret := P strong(str)
ret println

str := "hello **world** what can I do for you"
ret := P strong(str)
ret println

str := "hello --world-- what **can** I do for you"
ret := P strong(str)
ret println


str := "hello *world* what can I do for you"
ret := P em(str)
ret println

str := "hello -world- what *can* I do for you"
ret := P em(str)
ret println

