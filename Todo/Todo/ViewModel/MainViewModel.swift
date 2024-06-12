import Foundation

class MainViewModel {
    
    var handleSuccess: (() -> Void)?
    var handleFailure: ((Error) -> Void)?
    
    var taskToFilter: [TaskItem] = []
    
    var tasksItems: [TaskItem] = [] {
        didSet {
            if tasksItems.count > 0 {
                tasksItems = tasksItems.sorted(by: {$0.priority ?? 0 > $1.priority ?? 0})
                if taskToFilter.count == 0 {
                    taskToFilter = tasksItems
                }
            }
        }
    }
    
    func fetchTask() {
        NetworkManager.sharedInstance.callAPI(endPoint: EndPoint.tasks, param: nil, ofType: Task.self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.tasksItems = response.tasks ?? []
                self?.handleSuccess?()
            case .failure(let error):
                self?.handleFailure?(error)
            }
        }
    }
    
}
