# 字符串需要先转换成可变字符串，否则不可变字符串无法调用replaceSeq方法
str := "My name is ningning" asMutable
str println

str replaceSeq("ningn", "ShangN")
str println
