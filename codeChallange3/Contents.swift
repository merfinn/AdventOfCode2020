import UIKit



func findTheTreesOnTheWay(right:Int, down:Int) -> Int{
    var input: [String] = [String]()

    let fileReader = try! LineFileReader(Bundle.main.url(forResource: "input", withExtension: "txt")!)

    while let line = fileReader.next() {
        var a:String = line
        a = a.replacingOccurrences(of: "\n", with: "")
        input.append(a)
    }
    
    var trees = 0
    var index2 = 0
    for index1 in stride(from: down, to: input.count, by: down) {
        index2 += right
        if( index2 >= Array(input[index1]).count ){
            while index2 >= Array(input[index1]).count {
                input[index1] += input[index1]
            }
        }
        if Array(input[index1])[index2] == "#" {
            trees += 1
        }
    }
    return trees
}
/*
Right 1, down 1.
Right 3, down 1. (This is the slope you already checked.)
Right 5, down 1.
Right 7, down 1.
Right 1, down 2. */

func multiplication() -> Int {
     return findTheTreesOnTheWay(right: 1, down: 1) *
        findTheTreesOnTheWay(right: 3, down: 1) *
        findTheTreesOnTheWay(right: 5, down: 1) *
        findTheTreesOnTheWay(right: 7, down: 1) *
        findTheTreesOnTheWay(right: 1, down: 2)
}

var c = multiplication()
