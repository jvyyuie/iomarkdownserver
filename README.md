# iomarkdownserver
IO语言入门

直接运行io即可，无需使用参数。即：

无需使用io main.io启动程序。当前目录中包含main.io的时候，会以这个文件作为入口开始程序的执行。



1、标题设置

第一种：通过在文字下方添加“=”和“-”，他们分别表示一级标题和二级标题。

一级标题
========

二级标题
--------

第二种：在文字开头加上 “#”，通过“#”数量表示几级标题。（一共只有1~6级标题，1级标题字体最大）

# 一级标题

## 二级标题

### 三级标题

2. 块注释（blockquote）

通过在文字开头添加“>”表示块注释。（当>和文字之间添加五个blank时，块注释的文字会有变化。）

> 整块代码注释第1行
> 整块代码注释第2行
> 整块代码注释第3行

>     整块代码注释第1行
>     整块代码注释第2行
>     整块代码注释第3行

3. 斜体

将需要设置为斜体的文字两端使用1个“*”或者“_”夹起来

*斜体文字内容*

_斜体文字内容_

4. 粗体

将需要设置为斜体的文字两端使用2个“*”或者“_”夹起来

**粗体文字内容**

__粗体文字内容__

5. 无序列表

在文字开头添加(*, +, and -)实现无序列表。但是要注意在(*, +, and -)和文字之间需要添加空格。（建议：一个文档中只是用一种无序列表的表示方式）

* 无序列表
* 无序列表
* 无序列表
* 无序列表


6. 有序列表

7. 链接（Links）

行列式：This is [an example](http://www.iolanguage.net/ "Title") inline link.

参考式：[This link](http://www.iolanguage.net/) has no title attribute.

8. 图片（Images）

9. 代码（HTML中所谓的Code）

10. 脚注（footnote）

11. 下划线
