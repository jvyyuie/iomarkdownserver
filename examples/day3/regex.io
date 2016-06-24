# 正则表达式，查找与替换。下面实现的方法很不好，但是我暂时也只能这么实现了

Regex

str := "The website url is [iolanguage](http://www.iolanguage.net/), click to visit."


str println


regex := Regex with("\\[.*\\]|\\(.*\\)") extended
words := str matchesOfRegex(regex)
word := words at(0) string exSlice(1, -1)
link := words at(1) string exSlice(1, -1)

regex := Regex with("\\[.*\\]\\(.*\\)") extended
result := str matchesOfRegex(regex) replace(m, "<a href=\"" .. link .. "\">" .. word .. "</a>")

result println






