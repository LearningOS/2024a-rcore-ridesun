#import "/rcore.typ": conf
#show:doc=>conf(
	[实验五报告],
	doc,
	[无],
	[无]
)
= 实现的功能
- 将相关数组与判断方法集中到```rust struct DeadlockDetect```中
- 分别实现了互斥锁和信号量的银行家算法

= 问答题
+ 在我们的多线程实现中，当主线程 (即 0 号线程) 退出时，视为整个进程退出， 此时需要结束该进程管理的所有线程并回收其资源。 
  - 需要回收的资源有哪些？ 



  - 其他线程的 TaskControlBlock 可能在哪些位置被引用，分别是否需要回收，为什么？

  对比以下两种 Mutex.unlock 的实现，二者有什么区别？这些区别可能会导致什么问题？

  ```rust
    impl Mutex for Mutex1 {
      fn unlock(&self) {
          let mut mutex_inner = self.inner.exclusive_access();
          assert!(mutex_inner.locked);
          mutex_inner.locked = false;
          if let Some(waking_task) = mutex_inner.wait_queue.pop_front() {
              add_task(waking_task);
          }
      }
  }

  impl Mutex for Mutex2 {
      fn unlock(&self) {
          let mut mutex_inner = self.inner.exclusive_access();
          assert!(mutex_inner.locked);
          if let Some(waking_task) = mutex_inner.wait_queue.pop_front() {
              add_task(waking_task);
          } else {
            mutex_inner.locked = false;
          }
      }
  }
  ```

    区别在于Mutex1先释放锁再唤醒线程，Mutex2先唤醒再释放锁 \
    Mutex1无论是否有等待的线程，都立即释放锁 \
    Mutex2如果没有等待欸线程，将不会再释放锁，减少操作