// MARK: # 定义链表结构

class ListNode<T> {
    var val: T
    var next: ListNode?
    init(_ val: T) {
        self.val = val
        next = nil
    }
}

class List<T> {
    var head: ListNode<T>?
    var tail: ListNode<T>?
    // 尾插法
    func appendToTail(_ val: T) {
        if  tail == nil {
            tail = ListNode(val)
            head = tail
        }else {
            tail!.next = ListNode(val)
            tail = tail!.next
        }
    }
    // 头插法
    func appendToHead(_ val: T) {
        if head == nil {
            head = ListNode(val)
            tail = head
        }else {
            let tmp = ListNode(val)
            tmp.next = head;
            head = tmp
        }
    }
}


// MARK: # 分割元素

/* list: 1->5->3->2->4->1, x = 3 处理结果为 1->2->1->5->3->4 */

/*
// 1. 尾插法获得 left

func getLeftList(_ head: ListNode<Int>?, _ x: Int) -> ListNode<Int>? {
    let dummy = ListNode(0)
    var pre = dummy, node = head
    while node != nil {
        if node!.val < x {
            pre.next = node
            pre = node!
        }
        node = node!.next
    }
    // 防止构成环结构
    pre.next = nil
    return dummy.next
}

func getRightList(_ head: ListNode<Int>?, _ x: Int) -> ListNode<Int>? {
    let dummy = ListNode(0)
    var pre = dummy, node = head
    while node != nil {
        if node!.val >= x {
            pre.next = node
            pre = node!
        }
        node = node!.next
    }
    // 防止构成环结构
    pre.next = nil
    return dummy.next
}
 */


func partition(_ head: ListNode<Int>?, _ x: Int) -> ListNode<Int>? {
    // 引用 dummy 节点
    let prevDummy = ListNode(0), postDummy = ListNode(0)
    var prev = prevDummy, post = postDummy
    
    var node = head
    
    while node != nil {
        if node!.val < x {
            prev.next = node
            prev = node!
        } else {
            post.next = node
            post = node!
        }
        node = node!.next
    }
    // 纺织成环
    post.next = nil
    // 左右拼接
    prev.next = postDummy.next
    
    return prevDummy.next
}


// MARK: # 检测链表成环

/*
 使用2指针同事访问链表一个移动速度是另一个的两倍 如果他们变得相等了那么就成环了
 */

func hasCycle(_ head: ListNode<Int>?) -> Bool {
    var slow = head
    var fast = head
    
    while fast != nil && fast!.next != nil {
        slow = slow!.next
        fast = fast!.next!.next
        if slow === fast {
            return true
        }
    }
    return false
}


// MARK: # 删除倒数第n个节点(n <= list.length)

/*
 * 思路:还是2个指针p和q, 指针q起始位置为指针p后的n个节点,两只镇同时移动,当q移动到尾部时,指针p所对应的元素就是要删除的元素
 */

func removeNthFromEnd(head: ListNode<Int>?, _ n: Int) -> ListNode<Int>? {
    guard let head = head else {
        return nil
    }
    let dummy = ListNode(0)
    dummy.next = head
    var prev: ListNode? = dummy
    var post: ListNode? = dummy
    
    for _ in 0..<n {
        if post == nil {
            // n 大于了 list 的长度
            return nil
        }
        post = post!.next
    }
    // 同时移动前后节点
    while post != nil && post!.next != nil {
        prev = prev!.next
        post = post!.next
    }
    // 删除节点
    prev!.next = prev!.next!.next
    return dummy.next
}




