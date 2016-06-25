[返回首页](/)


从Io官网的手册中读到如下一段文字，感觉很受启发：


Io has no keywords or statements. Everything is an expression composed entirely of messages, each of which is a runtime accessible object. The informal BNF description:


exp        ::= { message | terminator }


message    ::= symbol [arguments]


arguments  ::= "(" [exp [ { "," exp } ]] ")"


symbol     ::= identifier | number | string


terminator ::= "\n" | ";"


For performance reasons, String and Number literal messages have their results cached in their message objects. 

