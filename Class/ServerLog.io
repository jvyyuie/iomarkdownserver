#!/usr/bin/env io

# 通过配置文件中的log地址，确定日志存储的具体位置
# 总会在日志目录中创建当前日期为文件名的日志文件
# 并将传递进来的字符串写入到日志文件中
# 每行日志文件的开始有当前写入的日期

SystemLog := Object clone
SystemLog write := method(content,
		logFile	:= "./log/" .. Date asString("%Y%m%d") .. ".log"
		file := File clone openForAppending(logFile)
		file write(Date asAtomDate, "\n", content, "\n")
		file close
		)
