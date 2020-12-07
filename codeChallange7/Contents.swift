import UIKit

let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let fileInput = try! String(contentsOf: url).replacingOccurrences(of: "bags", with: "").replacingOccurrences(of: "bag", with: "").replacingOccurrences(of: "contain", with: ",").replacingOccurrences(of: ".", with: "").replacingOccurrences(of: " ", with: "")
let lines = fileInput.components(separatedBy: "\n")

//horizontal

func countContainers(inputList:[String], search:String) ->Int {

    var bags = Set([String]())
    var bagsTemp = Set([String]())
    var searched = search
    repeat {
        for luggages in inputList {
            if luggages.count < 1 { break }
            let allBags = luggages.components(separatedBy:",")
            let container = allBags[0]
            
            for index in 1...allBags.count-1 {
                let currentbag = allBags[index].dropFirst()
                if currentbag == searched {
                    bags.insert(String(container))
                    bagsTemp.insert(String(container))
                }
            }
        }
        bags.remove(searched)
        searched = bags.first ?? ""
        print(bagsTemp)

    } while bags.count >= 1
    return bagsTemp.count
}

struct Luggage {
    var name: String
    var inside: [(Int,Luggage)]
}
//vertical
func insiders(inputList:[String], search:String) -> Luggage {

    for luggages in inputList {
        if luggages.count < 1 { break }
        //shiny gold bags contain 2 dark red bags.

        let allBags = luggages.components(separatedBy:",")
        let container = allBags[0]
        if container  == search {
            var tupleList = [(Int,Luggage)]()
            for index in 1...allBags.count-1 {
                let number = Int(String(allBags[index].first!)) ?? 0
                let currentbag = allBags[index].dropFirst()
                tupleList.append((number,insiders(inputList: inputList, search: String(currentbag))))
            }
            return Luggage(name:container,inside: tupleList)
        }
    }
    return Luggage(name: search, inside:[])
}

var c = insiders(inputList: lines, search: "shinygold") //first solution

func calculateTotalBagsInside(tree:Luggage) -> Int {
    var sum = 1
    
    for number in tree.inside {
        sum += number.0 * calculateTotalBagsInside(tree: number.1)
    }
    return sum
}

var t = calculateTotalBagsInside(tree: c) - 1 //solution 2
