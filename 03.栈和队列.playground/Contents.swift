/*
 * 栈和队列最正规的做法是使用链表来实现,以确保加入和删除的时间复杂度为O(1)
 *
 * 栈的基本操作包括: push pop isEmpty peek zie
 */



protocol Stack {
    // 持有元素
    associatedtype Element
    // 是否为空
    var isEmpty: Bool { get }
    // 栈的大小
    var size: Int { get }
    // 栈顶元素
    var peek: Element? { get }
    // 进栈
    mutating func push(_ newElement: Element)
    // 出栈
    mutating func pop() -> Element?
}

struct IntegerStack: Stack {
    typealias Element = Int
    
    private var stack = [Element]()
    
    var isEmpty: Bool { return stack.isEmpty }
    var  size: Int { return stack.count }
    var peek: Element? { return stack.last }
    mutating func push(_ newElement: Int) {
        stack.append(newElement)
    }
    mutating func pop() -> Int? {
        return stack.popLast()
    }
}

/*
 * 队列 先进先出,包括的方法: enqueue, dequeue, isEmpty, peek, size
 */

protocol Queue {
    associatedtype Element
    
    var isEmpty: Bool { get }
    var size: Int { get }
    var peek: Element? { get }
    mutating func enqueue(_ newElement: Element)
    mutating func dequeue() -> Element?
}

struct IntegerQueue: Queue {
    typealias Element = Int
    private var left = [Element]()
    private var right = [Element]()

    var isEmpty: Bool { return left.isEmpty && right.isEmpty }
    var size: Int { return left.count + right.count }
    var peek: Int? { return left.isEmpty ? right.first : left.last }
    mutating func enqueue(_ newElement: Int) {
        right.append(newElement)
    }
    mutating func dequeue() -> Int? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        return left.popLast()
    }
}

// MARK: # 栈和队列的相互转换

/*
 * 处理栈和队列的问题,最经典的思路就是使用两个栈/队列k来解决问题.
 * 在原栈/队列的基础上,用一个协助栈/队列来简化算,用空间换时间
 */

// 用栈实现队列
struct MyQueue {
    var stackA: IntegerStack
    var stackB: IntegerStack
    
    var isEmpty: Bool {
        return stackA.isEmpty && stackB.isEmpty
    }
    
    var peek: Int? {
        mutating get {
            shift()
            return stackB.peek
        }
    }
    
    var size: Int {
        get {
            return stackA.size + stackB.size
        }
    }
    
    init() {
        stackA = IntegerStack()
        stackB = IntegerStack()
    }
    
    mutating func enqueue(_ newValue: Int) {
        stackA.push(newValue)
    }
    
    mutating func dequeue() -> Int? {
        shift()
        return stackB.pop()
    }
    
    private mutating func shift() {
        if stackB.isEmpty {
            while !stackA.isEmpty {
                stackB.push(stackA.pop()!)
            }
        }
    }
}

// MARK: # 路径简化

/*
 * "/home/"             结果为 "/home"
 * a/./b/../            结果为 a
 * a/./b/../../c        结果为 c
 *
 * . 代表当前目 .. 为上级目录
 */

func simplifyPath(path: String) -> String {
    // 用数组来实现栈功能
    var pathStack = [String]()
    // 拆分路径
    let paths = path.split(separator: "/")
    
    for subPath in paths {
        guard subPath != "." else {
            continue
        }
        if subPath == ".." {
            if pathStack.count > 0 {
                pathStack.removeLast()
            }
        } else if subPath != "" {
            pathStack.append(String(subPath))
        }
        
    }
    // 将栈中的路径转换为优化后的路径
    let ref = pathStack.reduce("") { (total, dir) in
        "\(total)/\(dir)"
    }
    // 注意结果是否为空
    return ref.isEmpty ? "/" : ref
}





