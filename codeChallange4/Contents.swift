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

let string = try! String(contentsOf: url)

let lines = string.components(separatedBy: "\n\n")

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
//"hgt:176cm\niyr:2013\nhcl:#fffffd ecl:amb\nbyr:2000\neyr:2034\ncid:89 pid:934693255"


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

var validPasswordsCount = validPasswords.count
var validRulesCount = countParseAndValidate(inputList: validPasswords, regex: regex)
//var validateHcl = validateRegex(input: "#123abc", pattern: "#[0-9a-f]{6}(\n|\\s))")
//var validateIyr = validateRegex(input: "2020", pattern: "(201[0-9]|202[0])(\n|\\s)")
//var eyr =  validateRegex(input: "2020", pattern: "(202[0-9]|203[0])(\n|\\s)")




//(byr:(19[2-9][0-9]|200[0-2])(\n|\s|$))
//&
//    (iyr:(201[0-9]|2020)(\n|\s|$))
//&
//(hcl:#[0-9a-f]{6}(\n|\s|$))
//&
//    (eyr:(202[0-9]|2030)(\n|\s|$))
//&
//    (hgt:(((1[5-8][0-9]|19[0-3])cm)|((59|6[0-9]|7[0-6])in))(\n|\s|$))
//&
//    (ecl:(amb|blu|brn|gry|grn|hzl|oth))(\n|\s|$)
//     &
//        (pid:([0-9]{9})(\n|\s|$))



  
