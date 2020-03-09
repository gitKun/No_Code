// 排序和搜索

// 排序常见的有: 冒泡,选择,插入(时间 O(n^2));堆排序,归并排序,快速排序(时间 O(nlogn));桶排序(时间 O(n));

// 归并排序
func mergeSort(_ array: [Int]) -> [Int] {
    var helper = Array(repeating: 0, count: array.count), array = array
    mergeSort(&array, &helper, 0, array.count - 1)
    return array
}

func mergeSort(_ array: inout [Int], _ helper: inout [Int], _ low: Int, _ high: Int) {
    guard low < high else {
        return
    }
    let  middle = (high - low) / 2 + low
//    print("left:      middle = \(middle), low = \(low), high = \(high)")
    mergeSort(&array, &helper, low, middle)
//    print("right:     middle = \(middle), low = \(low), high = \(high)")
    mergeSort(&array, &helper, middle + 1, high)
    print("change:    middle = \(middle), low = \(low), high = \(high)")
    merge(&array, &helper, low: low, middle: middle, high: high)
}

func merge(_ array: inout [Int], _ helper: inout [Int], low: Int, middle: Int, high: Int) {
    // copy both halves into a helper array
    for i in low...high {
        helper[i] = array[i]
    }
    var helperLeft = low, helperRight = middle + 1, current = low
    
    // iterate through helper array and copy the right one to original array
    while helperLeft <= middle && helperRight <= high {
        if helper[helperLeft] <= helper[helperRight] {
            array[current] = helper[helperLeft]
            helperLeft += 1
        } else {
            array[current] = helper[helperRight]
            helperRight += 1
        }
        current += 1
    }
    // handle the rest
    guard middle - helperLeft >= 0 else {
        print("tmp = \(array) __无需再次归并!")
        return
    }
    for i in 0...middle-helperLeft {
        array[current + i] = helper[helperLeft + i]
    }
    print("tmp = \(array)")
}

 let rest = mergeSort([5, 2, 10, 7, 3, 19, 1, 9, 8])
print("归并排序结果为: \(rest)")
