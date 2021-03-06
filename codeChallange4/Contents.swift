import UIKit

func matches(for regex: String, in text: String) -> [String] {

    do {
        let regex = try NSRegularExpression(pattern: regex)
        let results = regex.matches(in: text,
                                    range: NSRange(text.startIndex..., in: text))
        return results.map {
            String(text[Range($0.range, in: text)!])
        }
    } catch let error {
        print("invalid regex: \(error.localizedDescription)")
        return []
    }
}
//byr:(19[2-9][0-9]|200[0-2])(\n|\s|$)
//iyr:(201[0-9]|2020)(\n|\s|$)
//hcl:#[0-9a-f]{6}(\n|\s|$)
//eyr:(202[0-9]|2030)(\n|\s|$)
//hgt:((1[5-8][0-9]|19[0-3])cm)|((59|6[0-9]|7[0-6])in)(\n|\s|$)
//ecl:(amb|blu|brn|gry|grn|hzl|oth)(\n|\s|$)
//pid:[0-9]{9}(\n|\s|$)


let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let fileInput = try! String(contentsOf: url)
let lines = fileInput.components(separatedBy: "\n\n")

func countValidPasspords(inputList:[String]) ->[String] {
    var validatedList = [String]()
    for item in inputList {
        if item.contains("hcl:") &&
            item.contains("ecl:") &&
            item.contains("hgt:") &&
            item.contains("pid:") &&
            item.contains("byr:") &&
            item.contains("eyr:") &&
            item.contains("iyr:") {
            validatedList.append(item)
        }
    }
    return validatedList
}

func countParseAndValidate(inputList: [String] ,regex: String) -> Int {
    var count = 0
    
    for item in inputList {
       let matchList = matches(for: regex, in: item)
        if matchList.count == 7 {
            count += 1
        }
    }
    return count
}

var regex = "(byr:(19[2-9][0-9]|200[0-2])(\\n|\\s|$))|(iyr:(201[0-9]|2020)(\\n|\\s|$))|(hcl:#[0-9a-f]{6}(\\n|\\s|$))|(eyr:(202[0-9]|2030)(\\n|\\s|$))|(hgt:(((1[5-8][0-9]|19[0-3])cm)|((59|6[0-9]|7[0-6])in))(\\n|\\s|$))|(ecl:(amb|blu|brn|gry|grn|hzl|oth))(\\n|\\s|$)|(pid:([0-9]{9})(\\n|\\s|$))"

var validPasswords = countValidPasspords(inputList: lines)
var validPasswordsCount = validPasswords.count //solution of part 1
var validRulesCount = countParseAndValidate(inputList: validPasswords, regex: regex) //solution of part 2



//one regex solution.//solution of part 2 with just one regex

var oneRegex =
    "(" +
        "((byr:(19[2-9][0-9]|200[0-2])(\\n|\\s|$))" + "|" +
        "(iyr:(201[0-9]|2020)(\\n|\\s|$))" + "|" +
        "(hcl:#[0-9a-f]{6}(\\n|\\s|$))" + "|" +
        "(eyr:(202[0-9]|2030)(\\n|\\s|$))" + "|" +
        "(hgt:(((1[5-8][0-9]|19[0-3])cm)" + "|" +
        "((59|6[0-9]|7[0-6])in))(\\n|\\s|$))" + "|" +
        "(ecl:(amb|blu|brn|gry|grn|hzl|oth))(\\n|\\s|$)" + "|" +
        "(pid:([0-9]{9})(\\n|\\s|$))" +
    ")" +
    "((cid:[\\S]*)[\\n|\\s|$])?)" +
    "{7}"

let fileInput2 = try! String(contentsOf: url)
var countValidatedWithOneRegex = matches(for: oneRegex, in: fileInput2).count
