//
//  ViewController.swift
//  leetcode
//
//  Created by dazhou on 2021/9/25.
//

import UIKit

struct OptModel {
    var title:String
    var block:()->()
}

class ViewController: UIViewController {
        
    var dataArr:[OptModel]!
    var tableView:UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createData()
        createViews()
    }
    
    func createData() {
        let s = Solution()
        dataArr = []
        var
        
        
        model = OptModel(title: "109. Convert Sorted List to Binary Search Tree") {
            let t = s.createNthHead(data: [-10,-3,0,5,9])
            print(s.sortedListToBST(t))
        }
        dataArr.append(model)
        
        
        model = OptModel(title: "108. Convert Sorted Array to Binary Search Tree") {
            print(s.sortedArrayToBST([-10,-3,0,5,9]))
        }
        dataArr.append(model)
        
        model = OptModel(title: "42. Trapping Rain Water") {
            print(s.trap([4,2,0,3,2,5]))
        }
        dataArr.append(model)
        
        model = OptModel(title: "41. First Missing Positive") {
            print(s.firstMissingPositive_2([0,2,2,1,1]))
        }
        dataArr.append(model)
        
        model = OptModel(title: "40. Combination Sum II") {
            print(s.combinationSum2([10,1,2,7,6,1,5], 8))
        }
        dataArr.append(model)
        
        model = OptModel(title: "39. Combination Sum") {
            print(s.combinationSum([1,2,3,4,6,8,9], 9))
        }
        dataArr.append(model)
        
        
        model = OptModel(title: "37. Sudoku Solver") {
            var board:[[Character]] =
            [[".",".","4",".",".",".","6","3","."],
             [".",".",".",".",".",".",".",".","."],
             ["5",".",".",".",".",".",".","9","."],
             [".",".",".","5","6",".",".",".","."],
             ["4",".","3",".",".",".",".",".","1"],
             [".",".",".","7",".",".",".",".","."],
             [".",".",".","5",".",".",".",".","."],
             [".",".",".",".",".",".",".",".","."],
             [".",".",".",".",".",".",".",".","."]]
            s.solveSudoku(&board)
            print(board)
        }
        dataArr.append(model)
        
        model = OptModel(title: "36. Valid Sudoku") {
            let board =
            [[".",".","4",".",".",".","6","3","."],
             [".",".",".",".",".",".",".",".","."],
             ["5",".",".",".",".",".",".","9","."],
             [".",".",".","5","6",".",".",".","."],
             ["4",".","3",".",".",".",".",".","1"],
             [".",".",".","7",".",".",".",".","."],
             [".",".",".","5",".",".",".",".","."],
             [".",".",".",".",".",".",".",".","."],
             [".",".",".",".",".",".",".",".","."]]
            print(s.isValidSudoku(board))
        }
        dataArr.append(model)
        
        model = OptModel(title: "35. Search Insert Position") {
            print(s.searchInsert([1,3,5,6]
                                 ,2))
        }
        dataArr.append(model)
        
        model = OptModel(title: "34. Find First and Last Position of Element in Sorted Array") {
            print(s.searchRange([3,3,3], 3))
        }
        dataArr.append(model)
        
        model = OptModel(title: "33. Search in Rotated Sorted Array") {
            print(s.longestValidParentheses_2("(())()"))
        }
        dataArr.append(model)
        
        model = OptModel(title: "32. Longest Valid Parentheses") {
            print(s.longestValidParentheses_2("(())()"))
        }
        dataArr.append(model)
        
        model = OptModel(title: "31. Next Permutation") {
            var t = [1,2,3]
            print(s.nextPermutation(&t))
        }
        dataArr.append(model)
        
        model = OptModel(title: "30. Substring with Concatenation of All Words") {
            print(s.findSubstring("barfoothefoobarman", ["foo","bar"]))
        }
        dataArr.append(model)

        model = OptModel(title: "29. Divide Two Integers") {
            print(s.divide(10, 3))
        }
        dataArr.append(model)
        
        model = OptModel(title: "28. Implement strStr()") {
            print(s.strStr("hello", "ll"))
        }
        dataArr.append(model)
        
        model = OptModel(title: "27. Remove Element") {
            print(s.removeElement(&s.removeElement_data, 3))
        }
        dataArr.append(model)

        model = OptModel(title: "3Sum") {
            print(s.threeSum(s.threeSumClosest_nums))
        }
        dataArr.append(model)
        
        model = OptModel(title: "3Sum Closest") {
            print(s.threeSumClosest(s.threeSumClosest_nums, s.threeSumClosest_target))
        }
        dataArr.append(model)
        
        model = OptModel(title: "18-4Sum") {
            print(s.fourSum(s.fourSum_data, s.fourSum_target))
        }
        dataArr.append(model)
        
        model = OptModel(title: "0314-1:二分查找法") {
            print(s.binarySearch())
        }
        dataArr.append(model)
        
        model = OptModel(title: "0314-2:选择排序") {
            print(s.chooseSort())
        }
        dataArr.append(model)

        
        
        model = OptModel(title: "17-Letter Combinations of a Phone Number") {
            print(s.letterCombinations(s.letterCombinations_data))
        }
        dataArr.append(model)
        
        
        
        model = OptModel(title: "19: Remove Nth Node From End of List") {
            let t = s.createNthHead(data: s.removeNthFromEnd_data)
            print(s.removeNthFromEnd_1(t, s.removeNthFromEnd_n))
        }
        dataArr.append(model)
        
        model = OptModel(title: "20: Valid Parentheses") {
            print(s.isValid(s.isValid_s))
        }
        dataArr.append(model)
        
        model = OptModel(title: "21: Merge Two Sorted Lists") {
            let t = s.createNthHead(data: s.mergeTwoLists_l1)
            let t1 = s.createNthHead(data: s.mergeTwoLists_l2)
            print(s.mergeTwoLists_2(t, t1))
        }
        dataArr.append(model)
        
        model = OptModel(title: "22. Generate Parentheses") {
            print(s.generateParenthesis_1(s.generateParenthesis_n))
        }
        dataArr.append(model)
        
        model = OptModel(title: "23. Merge k Sorted Lists") {
            let t = s.createNthHead(data: s.mergeKLists_data)
            let t1 = s.createNthHead(data: s.mergeKLists_data1)
            let t2 = s.createNthHead(data: s.mergeKLists_data2)
            let arr = [t, t1, t2]
            print(s.mergeKLists(arr))
        }
        dataArr.append(model)
        
        
        model = OptModel(title: "24. Swap Nodes in Pairs") {
            let t = s.createNthHead(data: s.swapPairs_data)
            print(s.swapPairs(t))
        }
        dataArr.append(model)

        
        model = OptModel(title: "25. Reverse Nodes in k-Group") {
            let t = s.createNthHead(data: s.reverseKGroup_data)
            let r = s.reverseKGroup(t, 2)!
            print(r)
        }
        dataArr.append(model)
        
        
        model = OptModel(title: "26. Remove Duplicates from Sorted Array") {
            let r = s.removeDuplicates(&s.removeDuplicates_data)
            print(r)
        }
        dataArr.append(model)
    }
    
    func createViews() {
        view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let model = dataArr[indexPath.row]
        cell?.textLabel?.text = model.title
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataArr[indexPath.row]
        model.block()
    }
    
}

