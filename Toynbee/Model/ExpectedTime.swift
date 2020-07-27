import Foundation

/// ExpectedTime represented by scheduled date and delay
struct ExpectedTime: Codable {
    let delay: DateComponents
    let date: Date
    // Parsing of string times returned by the API - we
    init?(time: String, delay delayString: String?, calendar: Calendar, baseDate: Date, baseComponents: DateComponents, baseTimeZone: TimeZone) {
        var trimmedTime = time.lowercased()
        let isPM = trimmedTime.contains("pm")
        trimmedTime = time.trimmingCharacters(in: .nonDigits)
        let splitTime = trimmedTime.components(separatedBy: ":")
        guard splitTime.count > 1 else {
            return nil
        }
        var hour = Int(splitTime[0]) ?? 0
        let minutes = Int(splitTime[1]) ?? 0
        if hour < 12 && isPM {
            hour += 12
        } else if hour == 12 && !isPM {
            hour = 0
        }
        
        var mutableComponents = baseComponents
        var mutableDate = baseDate
        guard let currentHour = mutableComponents.hour else {
            return nil
        }
        var components = DateComponents()
        if let delayString = delayString?.trimmingCharacters(in: .nonDigits) {
            components.minute = Int(delayString) ?? 0
        }
        delay = components
        let adjustedHour = hour + ((minutes + Int(delay.minute ?? 0)) / 60)
        if adjustedHour < currentHour {
            mutableDate = mutableDate.addingTimeInterval(86400)
            mutableComponents = calendar.dateComponents(in: baseTimeZone, from: mutableDate)
        }
        mutableComponents.hour = hour
        mutableComponents.minute = minutes
        mutableComponents.second = 0
        date = calendar.date(from: mutableComponents)!
    }
}

fileprivate extension CharacterSet {
    static let nonDigits: CharacterSet = CharacterSet.decimalDigits.inverted
}
