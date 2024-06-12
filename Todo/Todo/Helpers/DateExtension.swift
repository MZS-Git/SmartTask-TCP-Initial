import Foundation

extension Date {
    
    /**
     Value 0 return today name
     postive vaue returns next day name 
     negative vaue returns previous day name
     */
    
    func dayName(value: Int) -> String? {
        let calendar = Calendar.current
        if let dayName = calendar.date(byAdding: .day, value: value, to: self) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, MMM d, yyyy"  // Full name of the day
            return dateFormatter.string(from: dayName)
        }
        return nil
    }
}
