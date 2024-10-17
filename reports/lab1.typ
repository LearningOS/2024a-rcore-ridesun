#import "/rcore.typ": conf
#show:doc=>conf(
	[实验一报告],
	doc,
	[无],
	[无]
)

= 实现的功能
为了实现课程要求，考虑到需要在每个任务被调用时增加syscall计数与更新被调用时间，做了如下改动：
- 在TaskControlBlock中新增了```rust task_syscall_times```与```rust task_time```，并在初始化TASK\_MANAGER时初始化这两个字段。
- 当第一个任务被执行与切换到新任务时，更新当前任务时间与初始化下一个任务时间。
- 在TaskManager中新增相关方法，并暴露到对全局变量操作。
- 在syscall方法调用时增加当前任务的syscall_times。
- 完善process.rs中的方法，完成课程要求。


= 问答题
+ 正确进入 U 态后，程序的特征还应有：使用 S 态特权指令，访问 S 态寄存器后会报错。 请同学们可以自行测试这些内容（运行 三个 bad 测例 (ch2b_bad\_\*.rs) ）， 描述程序出错行为，同时注意注明你使用的 sbi 及其版本。
	```bash
	[kernel] PageFault in application, bad addr = 0x0, bad instruction = 0x804003a4, kernel killed it.
	[kernel] IllegalInstruction in application, kernel killed it.
	[kernel] IllegalInstruction in application, kernel killed it.
	```
	```[rustsbi] RustSBI version 0.4.0-alpha.1, adapting to RISC-V SBI v2.0.0```

+ 深入理解 trap.S 中两个函数 \_\_alltraps 和 \_\_restore 的作用，并回答如下问题:
	- *L40：刚进入 \_\_restore 时，a0 代表了什么值。请指出 \_\_restore 的两种使用情景。*

	

	- *L43-L48：这几行汇编代码特殊处理了哪些寄存器？这些寄存器的的值对于进入用户态有何意义？请分别解释。*
		```asm
		ld t0, 32*8(sp)
		ld t1, 33*8(sp)
		ld t2, 2*8(sp)
		csrw sstatus, t0
		csrw sepc, t1
		csrw sscratch, t2
		```
	- *L50-L56：为何跳过了 x2 和 x4？*
		```asm
		ld x1, 1*8(sp)
		ld x3, 3*8(sp)
		.set n, 5
		.rept 27
		LOAD_GP %n
		.set n, n+1
		.endr
		```
	- *L60：该指令之后，sp 和 sscratch 中的值分别有什么意义？*

		```asm
		csrrw sp, sscratch, sp
		```
	- *\_\_restore：中发生状态切换在哪一条指令？为何该指令执行之后会进入用户态？*

	- *L13：该指令之后，sp 和 sscratch 中的值分别有什么意义？*

		```asm
		csrrw sp, sscratch, sp
		```
	- *从 U 态进入 S 态是哪一条指令发生的？*

