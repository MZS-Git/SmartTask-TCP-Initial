import Foundation

// MARK: - Welcome
class Task: Codable {
    
    var tasks: [TaskItem]?
    
    enum CodingKeys: String, CodingKey {
        case tasks = "tasks"
    }
}

// MARK: - Task
class TaskItem: Codable {
    var id: String?
    var targetDate: String?
    var dueDate: String?
    var title: String?
    var description: String?
    var priority: Int?
    var status: TaskStatus = .undefined
    
    var leftDay: String {
        dueDate?.calculateDatesDifference(toDate: targetDate) ?? "0"
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case targetDate = "TargetDate"
        case dueDate = "DueDate"
        case title = "Title"
        case description = "Description"
        case priority = "Priority"
    }
}
