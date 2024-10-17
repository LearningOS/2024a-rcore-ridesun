#import "/rcore.typ": conf
#show:doc=>conf(
	[实验四报告],
	doc,
	[无],
	[无]
)
= 实现的功能
- 在```rust easy-fs```内提供反向计算inode\_id的函数
- 完成```rust fn linkat```和```rust fn unlink```，主要是在root inode中对DirEntry进行操作
- 对于link数，目前是通过遍历root inode中任何有相同inode_id的DirEntry，感觉还有其他方式可以实现

= 问答题
+ 在我们的easy-fs中，root inode起着什么作用？如果root inode中的内容损坏了，会发生什么？

  找不到子目录