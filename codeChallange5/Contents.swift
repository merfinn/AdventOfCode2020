import UIKit

let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let fileInput = try! String(contentsOf: url)
let lines = fileInput.components(separatedBy: "\n")

func convertToIds(inputList:[String]) ->[Int] {
    var validatedList = [Int]()
    for item in inputList {
        validatedList.append(findRow(item: item) * 8 + findColumn(item: item))
    }
    return validatedList
}

func findRow(item:String) -> Int{
    var lowerBound = 1
    var upperBound = 128
    var effect = 64
    
    for index in 0...7 {
        if Array(item)[index] == "F"{
            upperBound -= effect
        } else {
            lowerBound += effect
        }
        effect /= 2
    }
    return lowerBound - 1
}

func findColumn(item:String) -> Int{
    var lowerBound = 1
    var upperBound = 8
    var effect = 4
    
    for index in 7...9 {
        if Array(item)[index] == "L"{
            upperBound -= effect
        } else {
            lowerBound += effect
        }
        effect /= 2
    }
    return lowerBound - 1
}

var a = findRow(item: "BFFFBBFRRR")
var b = findColumn(item: "BFFFBBFRRR")


var seatId = findRow(item: "BBFFBBFRLL") * 8 + findColumn(item: "BBFFBBFRLL")

//var max = convertToIds(inputList: lines).max()
var idList = convertToIds(inputList: lines)
//var max = idList.max()
var sort = idList.sorted()

func missingId(list: [Int]) -> Int {
    
    for index in 126...1023 {
        if !list.contains(index) {
            return index
        }
    }
    return 0
}

var missing = missingId(list: sort)
