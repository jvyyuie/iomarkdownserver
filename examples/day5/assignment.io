# 等号和冒号等号的区别
# operator	action
# ::=	Creates slot, creates setter, assigns value
# :=	Creates slot, assigns value
# =	Assigns value to slot if it exists, otherwise raises exception
# These operators are compiled to normal messages whose methods can be overridden. For example:
# 
# source	compiles to
# a ::= 1	newSlot("a", 1)
# a := 1	setSlot("a", 1)
# a = 1	updateSlot("a", 1)


str := Object clone
str a = "hello1"

str a println
/*
str ::= "hello1"
str println

str := "hello2"
str println

str = "hello3"
str println
*/
