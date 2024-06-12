import Foundation

extension String {
    
    func calculateDatesDifference(toDate: String?) -> Self  {
        
        if let toDate = toDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            
            if let now = formatter.date(from: toDate), let then = formatter.date(from: self)  {
                let calendar = Calendar.current
                let components = calendar.dateComponents([.day], from: now, to: then)
                if let dayDifference = components.day {
                    return "\(dayDifference)"
                }
            } else {
                print("Invalid date format")
            }
        }
        
        return "n/a"
    }
}
