// 二叉树

//定义数据结构
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
    }
}

// 计算最大深度
func maxDepth(root: TreeNode?) -> Int {
    guard let root = root else {
        return 0;
    }
    return max(maxDepth(root: root.left), maxDepth(root: root.right)) + 1
}

// 二叉查找树:左子树点的值都小于根节点的值,右子树的节点的值都大于根节点的值

// 如何判断一个二叉树是二叉查找树
func isValidBST(root: TreeNode?) -> Bool {
    return _helper(node: root, nil, nil)
}

private func _helper(node: TreeNode?, _ min: Int?, _ max: Int?) -> Bool {
    guard let node = node else {
        return true
    }
    if  let min = min, node.val <= min {
        return false
    }
    if let max = max, node.val >= max {
        return false
    }
    return _helper(node: node.left, min, node.val) && _helper(node: node.right, node.val, max)
}

// 二叉树的遍历: 常见的有--前序,中序,后序遍历三种

// 使用栈实现前序遍历
func perorderTraversal(root: TreeNode?) -> [Int] {
    var res = [Int]()
    var stack = [TreeNode]()
    var node = root
    while !stack.isEmpty || node != nil {
        if node != nil {
            res.append(node!.val)
            stack.append(node!)
            node = node!.left
        } else {
            node = stack.removeLast().right
        }
    }
    return res
}

// 层级遍历(广度优先遍历): 便利结果就是能够表示唯一颗确认的二叉树.(二维数组)
func levelOrder(root: TreeNode?) -> [[Int]] {
    var res = [[Int]]()
    var queue = [TreeNode]()
    if let root = root {
        queue.append(root)
    }
    while queue.count > 0 {
        let size = queue.count
        var level = [Int]()
        // 内部循环去除当前层并添加下一层的所有节点
        for _ in 0..<size {
            let node = queue.removeFirst()
            level.append(node.val)
            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }
        }
        res.append(level)
    }
    return res
}

