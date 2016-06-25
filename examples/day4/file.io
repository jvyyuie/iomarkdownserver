# 创建文件，并向文件中写入内容

str	:= "fff"

logFile	:= "./log/" .. Date asString("%Y%m%d") .. ".log"

logFile println

file := File clone openForAppending(logFile)
file write(Date asAtomDate, "\n", str, "\n")
file close
