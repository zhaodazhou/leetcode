//
//  Solution.swift
//  leetcode
//
//  Created by dazhou on 2021/9/25.
//

import Foundation

extension String {
    func charAtIndex(index: Int) -> Character? {
        var cur = 0
        for char in self {
            if cur == index {
                return char
            }
            cur = cur + 1
        }
        return nil
    }
}

class Solution {
    // 快速排序，用分而治之的原理
    func quickSore(_ list:inout [Int], _ l:Int, _ r:Int) {
        if l < r {
            var i = l
            var j = r
            let x = list[i]
            
            while i < j {
                while i < j && list[j] > x {
                    j -= 1 // 从右向左找第一个小于x的数
                }
                if i < j {
                    list[i] = list[j] // i 的值已被记录在 x 中，所以不用管list[i]
                    i += 1
                }
                
                while i < j && list[i] < x {
                    i += 1 // 从左向右找第一个大于x的数
                }
                if i < j {
                    list[j] = list[i] // list[j] 中的值已在上面的语句中赋值给位置 i 处
                    j -= 1
                }
            }
            
            list[i] = x
            quickSore(&list, l, i - 1)
            quickSore(&list, i + 1, r)
        }
    }
    
    
    // 选择排序，性能O(nlogn)，找出最小的，然后插入新数组中；
    func chooseSort() -> [Int] {
        var list = [3,2,6,5,4,6,7,4,5,11,20,24,16]
        var result:[Int] = []
        for _ in 0..<list.count {
            let index = findSmallest(list: list)
            result.append(list[index])
            list.remove(at: index)
        }
        return result
    }
    
    func findSmallest(list:[Int]) -> Int {
        var small = list[0]
        var smallIndex = 0
        print(list)
        for i in 1..<list.count {
            if small > list[i] {
                small = list[i]
                smallIndex = i
            }
        }
                
        return smallIndex
    }
    
    
    func binarySearch() -> Int {
        let list = [1,2,3,4,5,11,13,16,20]
        let dest = 6
        
        var bIndex = 0, eIndex = list.count - 1
        
        while bIndex <= eIndex {
            let midIndex = (bIndex + eIndex) / 2
            
            if list[midIndex] == dest {
                return midIndex
            } else if list[midIndex] > dest {
                eIndex = midIndex - 1
            } else if list[midIndex] < dest {
                bIndex = midIndex + 1
            }
        }
        
        return -1
    }
    
    /**
     Given an integer array nums, return all the triplets [nums[i], nums[j], nums[k]] such that i != j, i != k, and j != k, and nums[i] + nums[j] + nums[k] == 0.

     Notice that the solution set must not contain duplicate triplets.

     Example 1:

     Input: nums = [-1,0,1,2,-1,-4]
     Output: [[-1,-1,2],[-1,0,1]]
     
     解决思路：
     三个数相加等于0，那选定一个基值后，另外两个数相加就等于 （0 - 该基值），
    所以，从第一个数开始，依次作为 基值，然后以该值之后的数组为一个片段，从2头取值开始相加，如果等于 （0 - 基值），则表示这3个值是合法的。
     其中，有些优化细节，比如跳过连续相等的值
     */
    var threeSumData:[Int] = [3,0,-2,-1,1,2]
    func threeSum(_ nums: [Int]) -> [[Int]] {
        let sNums = nums.sorted()
        let count = sNums.count
        var result:[[Int]] = []
        
        if count < 3 {
            return result
        }
        
        for i in 0..<count-2 {
            //为了保证不加入重复的 list,因为是有序的，所以如果和前一个元素相同，只需要继续后移就可以
            // 感觉 i > 0 这个条件不需要
            if i == 0 || (i > 0 && sNums[i] != sNums[i - 1]) {
                //两个指针,并且头指针从i + 1开始，防止加入重复的元素
                var lo = i + 1
                var hi = count - 1
                let sum = 0 - sNums[i]
                
                while lo < hi {
                    if sNums[lo] + sNums[hi] == sum {
                        result.append([sNums[i], sNums[lo], sNums[hi]])
                        //元素相同要后移，防止加入重复的 list
                        while lo < hi && sNums[lo] == sNums[lo + 1] {
                            lo += 1
                        }
                        while lo < hi && sNums[hi] == sNums[hi - 1] {
                            hi -= 1
                        }
                        lo += 1
                        hi -= 1
                    } else if sNums[lo] + sNums[hi] < sum {
                        lo += 1
                    } else {
                        hi -= 1
                    }
                }
            }
        }
        
        return result
    }
    
    /**
     Given an integer array nums of length n and an integer target, find three integers in nums such that the sum is closest to target.

     Return the sum of the three integers.

     You may assume that each input would have exactly one solution.


     Example 1:

     Input: nums = [-1,2,1,-4], target = 1
     Output: 2
     Explanation: The sum that is closest to the target is 2. (-1 + 2 + 1 = 2).
     
     寻找与给定target最近的三个数的总和
     前一题是寻找等于target的组合，这一题是寻找最接近的
     */
    var threeSumClosest_nums:[Int] = [1,1,1,0]
    var threeSumClosest_target:Int = 100
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        let sNums = nums.sorted()
        
        /**
            解决方案之一，遍历了2遍
         var sub = Int.max
         var sum = 0
         for i in 0..<sNums.count {
             var lo = i + 1
             var hi = sNums.count - 1
             while lo < hi {
                 if abs(sNums[lo] + sNums[hi] + sNums[i] - target) < sub {
                     sum = sNums[lo] + sNums[hi] + sNums[i]
                     sub = abs(sNums[lo] + sNums[hi] + sNums[i] - target)
                 }
                 if sNums[lo] + sNums[hi] + sNums[i] > target {
                     hi -= 1
                 } else {
                     lo += 1
                 }
             }
         }
         return sum
         */
        
        /* 方案二，借鉴了threeSum的算法，找到第一个离target最近的值，算法性能还可以；
         而且性能比上面的还好一些，应该是和数据有关
         */
        var result:[[Int]] = []
        let maxLoop = abs(sNums.count + target) // 10000
        for index in 0..<maxLoop {
            // 找到一个就 break，所以这个 maxLoop 是应该是可以优化的，比如最大为数组的 count 即可
            result = matchTarget(sNums, target: target + index)
            if result.count > 0 {
                break
            }
            result = matchTarget(sNums, target: target - index)
            if result.count > 0 {
                break
            }
        }

        if result.isEmpty {
            return sNums[0] + sNums[1] + sNums[2]
        }
        let first = result[0]
        return first[0] + first[1] + first[2]
    }
    
    func matchTarget(_ sNums: [Int], target:Int) -> [[Int]] {
        let count = sNums.count
        var result:[[Int]] = []
        
        if count < 3 {
            return result
        }
        
        for i in 0..<count-2 {
            if i == 0 || (i > 0 && sNums[i] != sNums[i - 1]) {
                var lo = i + 1
                var hi = count - 1
                let sum = target - sNums[i]
                
                while lo < hi {
                    if sNums[lo] + sNums[hi] == sum {
                        result.append([sNums[i], sNums[lo], sNums[hi]])
                        while lo < hi && sNums[lo] == sNums[lo + 1] {
                            lo += 1
                        }
                        while lo < hi && sNums[hi] == sNums[hi - 1] {
                            hi -= 1
                        }
                        lo += 1
                        hi -= 1
                    } else if sNums[lo] + sNums[hi] < sum {
                        lo += 1
                    } else {
                        hi -= 1
                    }
                }
            }
        }
        
        return result
    }
    
    
    /**
     Given an array nums of n integers, return an array of all the unique quadruplets [nums[a], nums[b], nums[c], nums[d]] such that:

     0 <= a, b, c, d < n
     a, b, c, and d are distinct.
     nums[a] + nums[b] + nums[c] + nums[d] == target
     You may return the answer in any order.
     之前是3个数字等于target，现在是4个数字
     */
    var fourSum_data = [1,0,-1,0,-2,2]
    var fourSum_target = 0
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        let sNums = nums.sorted()
        let count = sNums.count

        
        var result:[[Int]] = []
        if count < 4 {
            return result
        }
        
        for j in 0..<count - 3 {
            if j == 0 || (j > 0 && sNums[j] != sNums[j - 1]) {
                for i in j+1..<count-2 {
                    //防止重复的，不再是 i == 0 ，因为 i 从 j + 1 开始
                    if (i == j + 1 || sNums[i] != sNums[i - 1]) {
                        var lo = i + 1
                        var hi = count - 1
                        let sum = target - sNums[j] - sNums[i]
                        while lo < hi {
                            if sNums[lo] + sNums[hi] == sum {
                                result.append([sNums[j], sNums[i], sNums[lo], sNums[hi]])
                                while lo < hi && sNums[lo] == sNums[hi] {
                                    lo += 1
                                }
                                while lo < hi && sNums[hi] == sNums[hi - 1] {
                                    hi -= 1
                                }
                                lo += 1
                                hi -= 1
                            } else if sNums[lo] + sNums[hi] < sum {
                                lo += 1
                            } else {
                                hi -= 1
                            }
                        }
                    }
                }
            }
        }
        
        return result
    }
    
    
    
    
    /**
     给定一串数字，对应手机按键，然后返回按键上对应的所有的字符串（每个按键上取一个字符）
     */
    var letterCombinations_data = "234"
    func letterCombinations(_ digits: String) -> [String] {
        if digits.count == 0 {
            return []
        }
        let nums = ["2", "3", "4", "5", "6", "7", "8", "9"]
        let alphabet = [["abc"], ["def"], ["ghi"], ["jkl"], ["mno"], ["pqrs"], ["tuv"], ["wxyz"]]
        
        var tmp:[[String]] = []
        for digit in digits {
            let index = nums.firstIndex(of: String(digit))!
            let chars = alphabet[index]
            tmp.append(chars)
        }
        
        
        var resultList:[String] = []
        let str = tmp.first!.first!

        // 1. 先取第一个字符串放入数组中
        for char in str {
            resultList.append(String(char))
        }

        // 2. 从第二个开始，取每一个与 resultList 中的每一个字符串相关后，生产新的数组，再赋值给 resultList
        for i in 1..<tmp.count {
            let str = tmp[i].first!
    
            var tmpList:[String] = []
            for re in resultList {
                for char in str {
                    let t = re + String(char) 
                    tmpList.append(t)
                }
            }
            resultList = tmpList
        }
        
        return resultList
    }
    
    let  KEYS:[String] = ["", "", "abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"]

    // 递归的方式试试
    func letterCombinations_1(_ digits: String) -> [String] {
        if digits.count == 0 {
            return []
        }
        
        var resultList:[String] = []
        combination(prefix: "", digits: digits, offset: 0, ret: &resultList)
        
        return resultList
    }
    
    func combination(prefix:String, digits:String, offset:Int, ret:inout [String]) {
        // 基准条件
        if offset == digits.count {
            ret.append(prefix)
            return
        }
        
        let char = digits.charAtIndex(index: offset)
        let str = String(char!)
        let index = Int(str)!
        let letters = KEYS[index]

        for i in 0..<letters.count {
            let char = letters.charAtIndex(index: i)
            let str = String(char!)
            
            combination(prefix: prefix + str, digits: digits, offset: offset + 1, ret: &ret)
        }
    }
    
    
    
    
    /**
     Given the head of a linked list, remove the nth node from the end of the list and return its head.
     移除倒数第n个节点，并将其返回
     */
    var removeNthFromEnd_data = [1,2]
    var removeNthFromEnd_n = 2
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        var list:[Int] = []
        var tHead = head
        while tHead != nil {
            list.append(tHead!.val)
            tHead = tHead?.next
        }
        
        let index = list.count - n
        list.remove(at: index)
        
        /**
         这种方式有点尴尬，不如直接遍历出列表的长度后计算出位置，然后再遍历到该位置，这样就不用创建新的列表了。
         但从提交的结果来看，这种方式执行速度会快一点。
         如：removeNthFromEnd_1
         */
        
        return createNthHead(data: list)
    }
    
    func removeNthFromEnd_1(_ head: ListNode?, _ n: Int) -> ListNode? {
        let dummy = ListNode()
        dummy.next = head
        
        var count = 0
        var first = head
        while first != nil { // 先计算出链表的总长度
            count += 1
            first = first?.next
        }
        /**
         如果长度等于 1 和删除头结点的时候需要单独判断，其实我们只需要在 head 前边加一个空节点，就可以避免单独判断。
         */
        
        var length = count - n
        first = dummy
        while length > 0 {
            length -= 1
            first = first?.next
        }
        
        first?.next = first?.next?.next
        
        return dummy.next
    }
    
    func removeNthFromEnd_2(_ head: ListNode?, _ n: Int) -> ListNode? {
        /**
         只遍历一次的方式，定义2个指针，间隔n个距离，然后走下去。
         这种算法，速度更快
         */
        let dummy = ListNode()
        dummy.next = head
        var first:ListNode? = dummy
        var second:ListNode? = dummy
        
        for _ in 0...n {
            first = first?.next
        }
        while first != nil {
            first = first?.next
            second = second?.next
        }
        
        second?.next = second?.next?.next

        
        return dummy.next
    }
    
    func removeNthFromEnd_3(_ head: ListNode?, _ n: Int) -> ListNode? {
        /**
         这种算法不如removeNthFromEnd_2快，但思想比较有意思
         先把 listnode 按顺序加入一个数组中，然后通过数组下表的方式，定位到要被 remove 的元素，操作 listnode 的指针，进行操作
         */
        var list:[ListNode] = []
        var h = head
        var len = 0
        while h != nil {
            list.append(h!)
            h = h?.next
            len += 1
        }
        if len == 1 {
            return nil
        }
        
        let remove = len - n
        if remove == 0 {
            return head?.next
        }
        
        let r = list[remove - 1]
        r.next = r.next?.next
        
        
        return head
    }
    
    func createNthHead(data:[Int]) -> ListNode? {
        var head:ListNode? = nil
        var tail:ListNode? = nil

        for item in data {
            let t = ListNode(item)
            if head == nil {
                head = t
            }
            
            if let tTail = tail {
                tTail.next = t
            }
            tail = t
        }
        return head
    }
    
    /**
     Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.

     An input string is valid if:

     Open brackets must be closed by the same type of brackets.
     Open brackets must be closed in the correct order.
     */
    var isValid_s = "([{}]"
    func isValid(_ s: String) -> Bool {
        var list:[Character] = []
        
        for item in s {
            switch item {
            case "(", "[", "{":
                list.append(item)
            case ")", "]", "}":
                let t = list.popLast()
//                list.removeLast() 与 popLast 的区别，前者如果是操作empty数组，那会crash；后者不会
                if t == nil {
                    return false
                }
                
                
                if (t == "(" && item == ")") ||
                    (t == "[" && item == "]") ||
                    (t == "{" && item == "}")
                {
                    continue
                } else {
                    return false
                }
            default:
                continue
            }
        }
        
        if list.isEmpty {
            return true
        }
        
        return false
    }
    
    /**
     Merge two sorted linked lists and return it as a sorted list. The list should be made by splicing together the nodes of the first two lists.
     */
    var mergeTwoLists_l1 = [-9, 3]
    var mergeTwoLists_l2 = [5, 7]
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        /**
         Input: l1 = [1,2,4], l2 = [1,3,4]
         Output: [1,1,2,3,4,4]
         */
        
        if l1 == nil {
            return l2
        }
        if l2 == nil {
            return l1
        }
        
        let head:ListNode = ListNode()
        var tail:ListNode?
        var first = l1
        var second = l2
        while first != nil && second != nil {
            if tail == nil {
                tail = head
            }
            if first!.val <= second!.val {
                tail?.next = ListNode(first!.val)
                first = first?.next
            } else  {
                tail?.next = ListNode(second!.val)
                second = second?.next
            }
            tail = tail?.next
        }
        
        while first != nil {
            tail?.next = ListNode(first!.val)
            first = first?.next
            tail = tail?.next
        }
        
        while second != nil {
            tail?.next = ListNode(second!.val)
            second = second?.next
            tail = tail?.next
        }
        
        return head.next
    }
    
    func mergeTwoLists_2(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        /**
         与mergeTwoLists相比，主要优化在空间优化、与最后一步的判断方式
         */
        if l1 == nil {
            return l2
        }
        if l2 == nil {
            return l1
        }
        
        var head:ListNode = ListNode(0)
        let ans = head
        var first = l1
        var second = l2
        while first != nil && second != nil {
            if first!.val <= second!.val {
                head.next = first
                head = head.next!
                first = first!.next
            } else  {
                head.next = second
                head = head.next!
                second = second!.next
            }
        }
        
        if first == nil {
            head.next = second
        }
        if second == nil {
            head.next = first
        }
        
        return ans.next
    }
    
    func mergeTwoLists_1(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        /**
        递归解法
         */
        
        if l1 == nil {
            return l2
        }
        if l2 == nil {
            return l1
        }
        
        if l1!.val < l2!.val {
            l1?.next = mergeTwoLists_1(l1!.next, l2)
            return l1
        } else {
            l2?.next = mergeTwoLists_1(l1, l2!.next)
            return l2
        }
    }
    
    /**
     Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.
     Input: n = 3
     Output: ["((()))","(()())","(())()","()(())","()()()"]
     */
    var generateParenthesis_n = 3
    func generateParenthesis(_ n: Int) -> [String] {
        let orignal = LeafNode()
        createParenthTree(parentNode: orignal, n: n * 2)
        
        var result:[String] = []
        depthSearch(parentNode: orignal.leftNext, sign: "", value: 0, result: &result)
        depthSearch(parentNode: orignal.rightNext, sign: "", value: 0, result: &result)
        
        return result
    }
    
    /**
     这种算法没太看懂
     */
    func generateParenthesis_1(_ n: Int) -> [String] {
        var result:[String] = []
        if n == 0 {
            result.append("")
            return result
        }
        
        for a in 0..<n {
            for leftV in generateParenthesis_1(a) {
                for rightV in generateParenthesis_1(n - 1 - a) {
                    result.append("(" + leftV + ")" + rightV)
                }
            }
        }
        
        
        return result
    }
    
    func depthSearch(parentNode:LeafNode?, sign: String, value:Int, result: inout [String]) {
        if value > 0 {
            return
        }
        if parentNode == nil {
            if value == 0 {
                if !result.contains(sign) {
                    result.append(sign)
                }
            }
            return
        }
        
        depthSearch(parentNode: parentNode?.leftNext, sign: sign + "(", value: value - 1, result: &result)
        depthSearch(parentNode: parentNode?.rightNext, sign: sign + ")", value: value + 1, result: &result)
    }
    
    func createParenthTree(parentNode:LeafNode, n:Int) {
        if n <= 0 {
            return
        }
        
        let leftNode = LeafNode()
        leftNode.val = -1
        leftNode.sign = "("
        
        let rightNode = LeafNode()
        rightNode.val = 1
        rightNode.sign = ")"
        
        parentNode.leftNext = leftNode
        parentNode.rightNext = rightNode
        
        
        createParenthTree(parentNode: leftNode, n: n - 1)
        createParenthTree(parentNode: rightNode, n: n - 1)
    }
    
    /**
     You are given an array of k linked-lists lists, each linked-list is sorted in ascending order.

     Merge all the linked-lists into one sorted linked-list and return it.
     */
    let mergeKLists_data = [1,4,5]
    let mergeKLists_data1 = [1,3,4]
    let mergeKLists_data2 = [2,6]
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        var lists1 = lists
        var minIndex = 0
        let head = ListNode()
        var h = head
        
        while true {
            var isBreak = true
            
            var min = LONG_MAX
            for i in 0..<lists1.count {
                if let item = lists1[i] {
                    if item.val < min {
                        minIndex = i
                        min = item.val
                    }
                    
                    isBreak = false
                }
            }
            
            if isBreak {
                break
            }
            
            h.next = lists1[minIndex]
            h = h.next!
            lists1[minIndex] = lists1[minIndex]?.next
        }
        
        h.next = nil
            
        return head.next
    }
    
    /**
     Given a linked list, swap every two adjacent nodes and return its head. You must solve the problem without modifying the values in the list's nodes (i.e., only nodes themselves may be changed.)
     */
    let swapPairs_data = [1,2,3,4]
    func swapPairs(_ head: ListNode?) -> ListNode? {
        let dump = ListNode()
        dump.next = head
        
        var point:ListNode? = dump
        
        while point?.next != nil && point?.next?.next != nil {
            let swap1 = point?.next
            let swap2 = point?.next?.next
            
            point?.next = swap2
            swap1?.next = swap2?.next
            swap2?.next = swap1
            
            point = swap1
        }
        
        return dump.next
    }
    
    // 递归解法
    func swapPairs_1(_ head: ListNode?) -> ListNode? {
        if head == nil || head?.next == nil {
            return head
        }
        
        let n = head?.next
        head?.next = swapPairs_1(head?.next?.next)
        n?.next = head
        
        return n
    }
    
    /**
     Given the head of a linked list, reverse the nodes of the list k at a time, and return the modified list.

     k is a positive integer and is less than or equal to the length of the linked list. If the number of nodes is not a multiple of k then left-out nodes, in the end, should remain as it is.

     You may not alter the values in the list's nodes, only nodes themselves may be changed.

        swap相邻的k个元素，上面是转换相邻的2个元素
     */
    let reverseKGroup_data = [1,2,3,4,5]
    func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
        if head == nil {
            return nil
        }
        
        let head1 = head
        var point = head1
        
        // find sub list trail
        var i = k
        while i - 1 > 0 {
            point = point?.next
            if point == nil {
                return head1
            }
            i = i - 1
        }
        
        let temp = point?.next
        point?.next = nil
        
        let newHead = reverse(head1)
        
        head1?.next = reverseKGroup(temp, k)
        return newHead
    }
    
    func reverse(_ head: ListNode?) -> ListNode? {
        var head1 = head
        var currentHead:ListNode? = nil
        while head1 != nil {
            let next = head1?.next
            head1?.next = currentHead
            currentHead = head1
            head1 = next
        }
        return currentHead
    }
    
    var removeDuplicates_data = [1,1,2]
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        
        var i = 0
        while i < nums.count && i + 1 < nums.count {
            if nums[i] == nums[i + 1] {
                nums .remove(at: i + 1)
            } else {
                i = i + 1
            }
        }
    
        return nums.count
    }
    
    /**
     快慢指针的方式
     */
    func removeDuplicates_1(_ nums: inout [Int]) -> Int {
        if nums.count == 0 {
            return 0
        }
        
        var i = 0
        for j in 1..<nums.count {
            if nums[j] != nums[i] {
                i = i + 1
                nums[i] = nums[j]
            }
        }
    
        return i + 1
    }
    
    /**
     移除指定值的元素
     解法思路：将尾部的元素按次赋值给需要删除的元素
     */
    var removeElement_data = [0,1,2,2,3,0,4,2]
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var i = 0
        var n = nums.count
        while i < n {
            if nums[i] == val {
                nums[i] = nums[n - 1]
                n = n - 1
            } else {
                i = i + 1
            }
        }
        
        return n
    }
    
    
    func strStr(_ haystack: String, _ needle: String) -> Int {
        for i in 0...haystack.count {
            for j in 0...needle.count {
                if j == needle.count {
                    return i
                }
                
                if i + j == haystack.count {
                    return -1
                }
                
                if needle.charAtIndex(index: j) != haystack.charAtIndex(index: i + j) {
                    break
                }
            }
        }
        return -1
    }
    
    func strStr_1(_ haystack: String, _ needle: String) -> Int {
        if needle.count == 0 {
            return 0
        }
        
        var j = 0
        var i = 0
       
        while i < haystack.count {
            if haystack.charAtIndex(index: i) == needle.charAtIndex(index: j) {
                j = j + 1
                if j == needle.count {
                    return i - j + 1
                }
            } else {
                i = i - j // 将已比较的位置回溯回去
                j = 0
            }
            i = i + 1
        }
    
        return -1
    }
    
    /**
     Divide Two Integers
     */
    func divide(_ dividend: Int, _ divisor: Int) -> Int {
        // 求出符号
        let neg1 = dividend < 0 ? -1 : 1
        let neg2 = divisor  < 0 ? -1 : 1
        
        // 特例判断
        if abs(dividend) == abs(divisor) {
            // case：绝对值相等
            return 1 * neg1 * neg2
        } else if abs(divisor) == 1 { // 被除数绝对值为1
            if abs(dividend) == (1 << 31) && neg2 > 0 {
                // 除数的绝对值为最大值，且被除数为 1
                return abs(dividend) * neg1 * neg2
            } else if abs(dividend) == (1 << 31) {
                // 除数的绝对值为最大值，且被除数为 -1
                return (abs(dividend) - 1) * neg1 * neg2
            }
            return abs(dividend) * neg1 * neg2
        }
        
        let a: Int64 = Int64(abs(dividend))
        let b: Int64 = Int64(abs(divisor))
        
        return Int(divide(a,b)) * neg1 * neg2
    }
    
    func divide(_ a: Int64, _ b: Int64) -> Int64 {
        if a < b {
            return 0
        }
        
        var times: Int64 = 1
        var c: Int64 = b
        while (c + c) <= a {
            c = c + c
            times = times + times
        }
        
        return times + divide(a - c, b)
    }
    

    /**
     You are given a string s and an array of strings words of the same length.
     Return all starting indices of substring(s) in s that is a concatenation of each word in words exactly once,
     in any order, and without any intervening characters.

     You can return the answer in any order.
     
     解题思路：words 中每个字符都是一样长的，比如 wordLength，所以可以一次性移动 wordLength
     */
    func findSubstring(_ s: String, _ words: [String]) -> [Int] {
        if words.count == 0 || s.count == 0 {
            return []
        }
        
        // 将 words 中各个词出现的次数保存在 dict 中
        var dict = [String: Int]()
        words.forEach { dict[$0, default: 0] += 1 }
        
        var res = [Int]()
        let wordLength = words.first!.count
        let totalChars = (wordLength * words.count)
        let lastIdxToCheck = s.count-totalChars+1 // 不需要匹配到最后一个字符
        var i = 0
        
        while i<lastIdxToCheck {
            
            let start = String.Index.init(utf16Offset: i, in: s)
            let end = String.Index.init(utf16Offset: i+totalChars, in: s)
            let subStr = String(s[start..<end]) // 截取待比较的子字符串
            var dict2 = dict
            var k = 0
            
            while k < totalChars {
                let start = String.Index.init(utf16Offset: k, in: subStr)
                let end = String.Index.init(utf16Offset: k+wordLength, in: subStr)
                let subStr1 = String(subStr[start..<end]) // 取出一个字符串进行比较
                
                if dict2[subStr1] == nil {// 如果不存在字段中，则表示 subStr 不可能匹配，进入下一个逻辑
                    break
                }
                if dict2[subStr1]!>0 {
                    dict2[subStr1]! -= 1
                    if dict2[subStr1] == 0 {
                        dict2[subStr1] = nil
                    }
                }
                k += wordLength // 步长不是 1
            }
            if dict2.isEmpty {
                res.append(i)
            }
            i += 1
        }
        return res
    }
    
    /**
     题目的意思是给定一个数，然后将这些数字的位置重新排列，得到一个刚好比原数字大的一种排列。如果没有比原数字大的，就升序输出。
     */
    func nextPermutation(_ nums: inout [Int]) {
        var breakPoint = -1
        // 尝试找到相邻的 低位数 大于 高位数，比如 个位数的值 大于 十位数的值
        for i in stride(from: nums.count - 1, to: 0, by: -1) {
            if nums[i] > nums[i-1] {
                breakPoint = i - 1
                break
            }
        }
        // 如果找不到，则说明数组中的数字是降序的，这种情况只需要逆转排序即可
        if breakPoint < 0 {
            nums = nums.reversed()
            return
        }
        
        // 如果找到了，则先将 breakPoint 与 第一个比大的数进行 swap
        // 然后将 breakPoint + 1 之后的数字排列一下，从小到大
        // 这样得到的数组就是第一个大于 原数组的了
        for i in stride(from: nums.count - 1, to: 0, by: -1) {
            if nums[breakPoint] < nums[i] {
                nums.swapAt(breakPoint, i)
                nums[(breakPoint+1)...].reverse()
                break
            }
        }
    }
    
    // 动态规划
    func longestValidParentheses(_ s: String) -> Int {
        if s.count == 0 {
            return 0
        }
        var maxans = 0
        var dp:[Int] = [Int](repeating: 0, count: s.count)
        
        for i in 1..<s.count {
            if s.charAtIndex(index: i) == ")" {
                if s.charAtIndex(index: i - 1) == "(" {
                    dp[i] = (i >= 2 ? dp[i - 2] : 0) + 2
                } else if i - dp[i - 1] > 0 && s.charAtIndex(index: i - dp[i - 1] - 1) == "(" {
                    dp[i] = dp[i - 1] + ((i - dp[i - 1]) >= 2 ? dp[i - dp[i - 1] - 2] : 0) + 2
                }
                
                maxans = max(maxans, dp[i])
            }
        }
        
        return maxans
    }
    
    // 遍历
    func longestValidParentheses_1(_ s: String) -> Int {
        var left = 0, right = 0, maxlength = 0
        // 从左到右计算一遍
        for i in 0..<s.count {
            if s.charAtIndex(index: i) == "(" {
                left += 1
            } else {
                right += 1
            }
            
            if left == right {
                maxlength = max(maxlength, 2 * right)
            } else if right >= left {
                left = 0
                right = 0
            }
        }
        
        left = 0
        right = 0
        
        // 从右到左计算一遍
        var i = s.count - 1
        while i >= 0 {
            if s.charAtIndex(index: i) == "(" {
                left += 1
            } else {
                right += 1
            }
            
            if left == right {
                maxlength = max(maxlength, 2 * left)
            } else if left >= right {
                left = 0
                right = 0
            }
            
            i -= 1
        }
        
        
        return maxlength
    }
    
    // 栈方式
    func longestValidParentheses_2(_ s: String) -> Int {
        var value = 0, start = 0, stack = [Int]()
        
        for (i, ch) in s.enumerated() {
            switch ch == "(" {
            case true:
                // 如果是 ( ，则直接进栈
                stack.append(i)
                
            default:
                // 如果是 ) , 且 栈为空，表示是第一个 ) ,则 start = i + 1，
                // 因为这个肯定是不会合法的，马上要进入下一个 Loop 了
                if stack.isEmpty {
                    start = i + 1
                } else {
                    // 如果栈不为空，则先移除一个 ( , 再判断栈是否为空，
                    stack.removeLast()
                    if let last = stack.last {
                        // 栈不为空，则计算当前 ) 与 栈中 ( 之间的距离，这即为当前的有效长度;
                        // 之后再取最大值
                        value = max(value, i - last)
                    } else {
                        // 栈为空，则与 start 比较，进行计算
                        value = max(value, i - start + 1)
                    }
                }
            }
        }
        return value
    }
    
    /**
     
     */
    func search(_ nums: [Int], _ target: Int) -> Int {
        var left = 0, right = nums.count - 1, mid = 0
        
        while left <= right {
            mid = (right - left) / 2 + left
            let numMid = nums[mid], numLeft = nums[left]
            if numMid == target {
                return mid
            }
            
            if numMid >= numLeft { // numLeft 到 numMid 之间还是升序的
                if numMid > target && target >= numLeft {
                    right = mid - 1
                } else {
                    left = mid + 1
                }
            } else { // numLeft 到 numMid 之间 遇到转折点了
                if (numMid < target && target <= nums[right]) {
                    left = mid + 1
                } else  {
                    right = mid - 1
                }
            }
        }
        return -1
    }
    
    /**
     Find First and Last Position of Element in Sorted Array
     */
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        var result = [Int](repeating: -1, count: 2)
        
        if nums.count == 0 {
            return result
        }
        
        var start = 0, end = nums.count - 1
        var mid = -1
        while start <= end {
            mid = (start + end) / 2
            if nums[mid] == target {
                break
            } else if nums[mid] < target {
                start = mid + 1
            } else {
                end = mid - 1
            }
        }
        
        if mid == -1 || target != nums[mid] {
            return result
        }
        
        if nums.count == 1 {
            return [mid, mid]
        }
        
        var min = mid
        while min - 1 >= 0 && target == nums[min - 1] {
            min = min - 1
        }
        
        var max = mid
        while max + 1 < nums.count && target == nums[max + 1] {
            max += 1
        }
        result = [min, max]

        
        return result
    }
    
    /**
     给定一个有序数组，依旧是二分查找，不同之处是如果没有找到指定数字，需要返回这个数字应该插入的位置。
     */
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        if nums.count == 0 {
            return 0
        }
        
        var start = 0, end = nums.count - 1
        var mid = -1
        while start <= end {
            mid = (start + end) / 2
            if nums[mid] == target {
                break
            } else if nums[mid] < target {
                start = mid + 1
            } else {
                end = mid - 1
            }
        }
        
        if target < nums[mid] {
            return mid
        }
        
        if target > nums[mid] {
            return mid + 1
        }
    
        return mid
    }
    
    
    func isValidSudoku(_ board: [[String]]) -> Bool {
        var map = [String : Bool]()
        for i in 0..<9 {
            for j in 0..<9 {
                let number = board[i][j]
                if number != "." {
                    let rowStr = String(number) + " in row " + String(i)
                    let columnStr = String(number) + " in column " + String(j)
                    let blockStr = String(number) + " in block " + String(i/3) + " - " + String(j/3)

                    if map.updateValue(Bool.init(true), forKey: rowStr) != nil {
                        return false
                    }
                    if map.updateValue(Bool.init(true), forKey: columnStr) != nil {
                        return false
                    }
                    if map.updateValue(Bool.init(true), forKey: blockStr) != nil {
                        return false
                    }
                }
            }
        }
        
        return true
    }
    
    /**
     回溯法
     */
    func solveSudoku(_ board: inout [[Character]]) {
        guard board.count != 0 || board[0].count != 0 else { return }
        helper(&board)
    }
    
    private func helper(_ board: inout [[Character]]) -> Bool {
        func isValid(_ i: Int, _ j: Int, _ num: Character) -> Bool {
            let m = board.count, n = board[0].count
            // row
            for x in 0..<n where board[i][x] == num { return false }
            // col
            for y in 0..<m where board[y][j] == num { return false }
            // square
            for x in i / 3 * 3..<i / 3 * 3 + 3 {
                for y in j / 3 * 3..<j / 3 * 3 + 3 where board[x][y] == num { return false }
            }
            return true
        }
        
        for i in 0..<board.count {
            for j in 0..<board[0].count where board[i][j] == "." {
                for num in 1...9 where isValid(i, j, Character("\(num)")) {
                    board[i][j] = Character("\(num)")
                    if helper(&board) {
                        return true
                    } else {
                        board[i][j] = "."
                    }
                }
                return false
            }
        }
        return true
    }
    
    
    /**
     Given an array of distinct integers candidates and a target integer target, return a list of all unique combinations of candidates where the chosen numbers sum to target. You may return the combinations in any order.

     The same number may be chosen from candidates an unlimited number of times. Two combinations are unique if the frequency of at least one of the chosen numbers is different.

     It is guaranteed that the number of unique combinations that sum up to target is less than 150 combinations for the given input.
     
     给几个数字，一个目标值，输出所有和等于目标值的组合。
     解法思路：用回溯法，
     */
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        func backtrack(_ list:inout [[Int]], _ tempList:inout [Int], _ nums:[Int], _ remain:Int, _ start: Int) {
            if remain < 0 {
                return
            }
            if remain == 0 {
                list.append(tempList)
            } else {
                for i in start..<nums.count {
                    tempList.append(nums[i])
                    backtrack(&list, &tempList, nums, remain - nums[i], i)
                    tempList.remove(at: tempList.count - 1)
                }
            }
        }
        
        var list = [[Int]]()
        var tmp = [Int]()
        backtrack(&list, &tmp, candidates, target, 0)
        return list
    }
    
    
    
    /**
     Given a collection of candidate numbers (candidates) and a target number (target), find all unique combinations in candidates where the candidate numbers sum to target.

     Each number in candidates may only be used once in the combination.

     Note: The solution set must not contain duplicate combinations.
     和上一道题非常像了，区别在于这里给的数组中有重复的数字，每个数字只能使用一次，然后同样是给出所有和等于 target 的情况。
     */
    func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
        func backtrack2(_ list:inout [[Int]], _ tempList:inout [Int], _ nums:[Int], _ remain:Int, _ start: Int) {
            if remain < 0 {
                return
            }
            if remain == 0 {
                list.append(tempList)
            } else {
                for i in start..<nums.count {
                    // 跳过重复的
                    if i > start && nums[i] == nums[i - 1] {
                        continue
                    }
                    tempList.append(nums[i])
                    backtrack2(&list, &tempList, nums, remain - nums[i], i + 1)
                    tempList.remove(at: tempList.count - 1)
                }
            }
        }
        
        let t = candidates
        var list = [[Int]]()
        var tmp = [Int]()
        // 进行排序
        backtrack2(&list, &tmp, t.sorted(), target, 0)
        return list
    }
    
    /**
     Given an unsorted integer array nums, return the smallest missing positive integer.

     You must implement an algorithm that runs in O(n) time and uses constant extra space.
     给一串数字，找出缺失的最小正数。限制了时间复杂度为 O（n），空间复杂度为 O（1）
     */
    func firstMissingPositive(_ nums: [Int]) -> Int {
        let tmpNums = nums.sorted()
        
        var minP = 1
        
        for i in 0..<tmpNums.count {
            if tmpNums[i] > 0 {
                if i + 1 < tmpNums.count && tmpNums[i] == tmpNums[i + 1] {
                    continue
                }
                if minP == tmpNums[i] {
                    minP += 1
                } else {
                    return minP
                }
            }
        }
        
        return minP
    }
    
    func firstMissingPositive_1(_ nums: [Int]) -> Int {
        var nums = nums
        var containsOne = false
        
        for num in nums {
            if num == 1 {
                containsOne = true
                break
            }
        }
        
        if !containsOne {
            return 1
        }
        
        for i in 0..<nums.count {
            // 缺少的最小正数，必然 小于 nums.count
            if nums[i] <= 0 || nums[i] > nums.count {
                nums[i] = 1
            }
        }
        
        for num in nums {
            let index = abs(num)
            if index == nums.count {
                nums[0] = -nums[0]
            } else {
                nums[index] = -abs(nums[index])
            }
        }
        
        for i in 1..<nums.count {
            if nums[i] > 0 {
                return i
            }
        }
        
        if nums[0] > 0 {
            return nums.count
        }
        
        return nums.count + 1
    }
    
    
    func firstMissingPositive_2(_ nums: [Int]) -> Int {
        guard nums.isEmpty == false else {
            return 1
        }
        let set = Set(nums)
        var index = 1
        let max = nums.max() ?? 0
        if max <= 0 {
            return 1
        }
        while index < max {
            if !set.contains(index) {
                return index
            }
            index += 1
        }
        return max + 1
    }
    
    /**
     收集雨水
     动态规划方式
     */
    func trap(_ height: [Int]) -> Int {
        var sum = 0
        var maxLeft = [Int](repeating: 0, count: height.count)
        var maxRight = [Int](repeating: 0, count: height.count)
        
        for i in 1..<height.count - 1 {
            maxLeft[i] = max(maxLeft[i - 1], height[i - 1])
        }
        
        var i = height.count - 2
        while i >= 0 {
            maxRight[i] = max(maxRight[i + 1], height[i + 1])
            i -= 1
        }
        
        for i in 1..<height.count - 1 {
            let min = min(maxLeft[i], maxRight[i])
            if min > height[i] {
                sum += (min - height[i]) // 关键之处
            }
        }
        
        return sum
    }
    
    func trap_1(_ height: [Int]) -> Int {
        if height.isEmpty { return 0 }
        
        var leftHeights = Array(repeating: 0, count: height.count)
        var rightHeights = Array(repeating: 0, count: height.count)
        
        var highestLeftHeightSoFar = 0
        var highestRightHeightSoFar = 0
        
        for i in 0..<leftHeights.count {
            leftHeights[i] = highestLeftHeightSoFar
            highestLeftHeightSoFar = max(highestLeftHeightSoFar, height[i])
        }
        
        for j in (0..<rightHeights.count).reversed() {
            rightHeights[j] = highestRightHeightSoFar
            highestRightHeightSoFar = max(highestRightHeightSoFar, height[j])
        }
        
        var total = 0
        
        for i in 0..<height.count {
            let minOfLeftvsRightAtIndex = min(leftHeights[i], rightHeights[i])
            if height[i] < minOfLeftvsRightAtIndex {
                total += minOfLeftvsRightAtIndex - height[i]
            }
        }
        
        return total
    }
    
    /**
     108. Convert Sorted Array to Binary Search Tree
     */
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        return sortedArrayToBST(nums: nums, start: 0, end: nums.count)
    }
    
    func sortedArrayToBST(nums:[Int], start:Int, end:Int) -> TreeNode? {
        if start == end {
            return nil
        }
        
        let mid = (start + end) / 2
        let root = TreeNode(nums[mid])
        root.left = sortedArrayToBST(nums: nums, start: start, end: mid)
        root.right = sortedArrayToBST(nums: nums, start: mid + 1, end: end)
        return root
    }
    
    /**
     这个可以先将链表转换为数组，再按照 sortedArrayToBST 的方式求解
     但下面用另一种实现
     */
    var cur:ListNode? = nil
    func sortedListToBST(_ head: ListNode?) -> TreeNode? {
        var t = head
        cur = head
        var end = 0
        while (t != nil) {
            end += 1
            t = t?.next
        }
        return sortedListToBSTHelper(start: 0, end: end)
    }
    
    func sortedListToBSTHelper(start:Int, end:Int) -> TreeNode? {
        if start == end {
            return nil
        }
        
        let mid = (start + end) / 2
        let left = sortedListToBSTHelper(start: start, end: mid)
        
        let root = TreeNode(cur!.val)
        root.left = left
        
        cur = cur?.next
         
        let right = sortedListToBSTHelper(start: mid + 1, end: end)
        root.right = right
        return root
    }
    
    /**
     判断是否对称
     */
    func isSymmetric(_ root: TreeNode?) -> Bool {
        if root == nil {
            return true
        }
         
        var list = [Int]()
        midOrder(root, &list)
        
        var first = 0
        var end = list.count - 1
        while first < end {
            if list[first] == list[end] {
                first += 1
                end -= 1
            } else {
                return false
            }
        }
        
        if first == end || first == end + 1{
            return true
        }
        
        return false
    }
    
    /**
     中序遍历
     */
    func midOrder(_ root: TreeNode?, _ list:inout [Int]) {
        if root == nil {
            return
        }
        
        midOrder(root?.left, &list)
        list.append(root!.val)
        midOrder(root?.right, &list)
    }
    
    /**
     层次遍历
     */
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        var ans = [[Int]]()
        dfs(root, 0, &ans)
        return ans
    }
    
    func dfs(_ root:TreeNode?, _ level:Int, _ ans:inout [[Int]]) {
        guard let root = root else {
            return
        }
        
        // 先初始化赋值
        if ans.count <= level {
            ans.append([Int]())
        }
        
        // 一层一层遍历的方式
        ans[level].append(root.val)
        
        // ZIGZAG遍历的方式
//        if level % 2 == 0 {
//            ans[level].append(root.val)
//        } else {
//            ans[level].insert(root.val, at: 0)
//        }
        
        dfs(root.left, level + 1, &ans)
        dfs(root.right, level + 1, &ans)
    }
    
    /**
     最小深度
     */
    func minDepth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        
        if root?.left == nil && root?.right == nil {
            return 1
        }
        
        if root?.left == nil {
            return minDepth(root?.right) + 1
        }
        
        if root?.right == nil {
            return minDepth(root?.left) + 1
        }
        
        return min(minDepth(root?.left), minDepth(root?.right)) + 1
    }
    
    
    func isMatch(_ str: String, _ pattern: String) -> Bool {
        var s = 0, p = 0, match = 0, starIdx = -1
    
        while s < str.count {
            if p < pattern.count && (pattern.charAtIndex(index: p) == "?"
                                     || str.charAtIndex(index: s) == pattern.charAtIndex(index: p)) {
                s += 1
                p += 1
            } else if p < pattern.count && pattern.charAtIndex(index: p) == "*" {
                starIdx = p
                match = s
                p += 1
            } else if starIdx != -1 {
                p = starIdx + 1
                match += 1
                s = match
            } else {
                return false
            }
        }
        
        while p < pattern.count && pattern.charAtIndex(index:p) == "*" {
            p += 1
        }
        
        return p == pattern.count
    }
    
    /**
     45: 从数组的第 0 个位置开始跳，跳的距离小于等于数组上对应的数。求出跳到最后个位置需要的最短步数。
     */
    func jump(_ nums: [Int]) -> Int {
        var end = 0
        var maxPosition = 0
        var steps = 0
        for i in 0..<nums.count - 1 {
            //找能跳的最远的、
            maxPosition = max(maxPosition, nums[i] + i)
            if i == end {//遇到边界，就更新边界，并且步数加一
                end = maxPosition
                steps += 1
            }
        }
       
        return steps
    }
    
    /**
     46: 给定几个数，然后输出他们所有排列的可能。
     */
    func permute(_ nums: [Int]) -> [[Int]] {
        return []
    }
}

class TrieNode {
    var word: String?
    var children = [Character: TrieNode]()
}

public class LeafNode {
    public var val: Int = 0
    public var totalVal: Int = 0
    public var sign: String = ""
    public var totalSign:String = ""
    public var leftNext: LeafNode?
    public var rightNext: LeafNode?
 }

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 }


public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}




