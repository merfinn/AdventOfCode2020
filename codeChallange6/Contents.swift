import UIKit

let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let fileInput = try! String(contentsOf: url)
let lines = fileInput.components(separatedBy: "\n\n")


func sumOfAnsweredYes(inputList:[String]) ->Int {
    var sum = 0
    for item in inputList {
       let item1 = item.replacingOccurrences(of: "\n", with: "")
        let set = Set(Array(item1))
        sum += set.count
    }
    return sum
}

func intersectionSumOfAllAnsweredYes(inputList:[String]) ->Int {
    var sum = 0
    for item in inputList {
        let people =  item.components(separatedBy:"\n")
        var intersectionSet = Set(Array(people[0]))
        for person in people {
            let currentSet = Set(Array(person))
            intersectionSet = intersectionSet.intersection(currentSet)
            print(intersectionSet)
        }
        print(intersectionSet.count)
        sum += intersectionSet.count

    }
    return sum
}


//var result1 = sumOfAnsweredYes(inputList: lines)
var result2 = intersectionSumOfAllAnsweredYes(inputList: lines) //3360
