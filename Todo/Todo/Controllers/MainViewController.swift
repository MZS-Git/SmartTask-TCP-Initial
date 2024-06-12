import UIKit

class MainViewController: UIViewController {
    
    //MARK: Note
    /*Calculation made on assumptions i.e
     - API mock data starting from month of August so that why, to meet the task requirement I choosen this approch
     - if day left is 0 it considered as today task
     - if day left is 1 it considered as next day task
     - if day left is -1 it considered as previous day task
     */
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var taskListTableView: UITableView!
    
    private let viewModel = MainViewModel()
    var lastIndexPath: IndexPath?
    var day = 0 {
        didSet {
            filterAndRefreshTasks(ofDay: day)
            taskListTableView.reloadData()
            if day == 0 {
                titleLbl.text = "Today"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskListTableView.registerCell(type: TaskTableViewCell.self)
        setTableViewBG()
        initViewModel()
        viewModel.fetchTask()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let lastIndexPath =  lastIndexPath {
            taskListTableView.reloadRows(at: [lastIndexPath], with: .automatic)
        }
    }
    
    private func initViewModel() {
        viewModel.handleSuccess = {
            DispatchQueue.main.async { [weak self] in
                if (self?.viewModel.tasksItems.count) ?? 0 > 0 {
                    self?.taskListTableView.backgroundView = nil
                }
                self?.taskListTableView.reloadData()
            }
        }
    }
    
    private func setTableViewBG(image: String? = "no_task.png") {
        taskListTableView.backgroundView = UIImageView(image: UIImage(named: image ?? ""))
    }
    
    private func filterAndRefreshTasks(ofDay: Int) {
        viewModel.tasksItems = viewModel.taskToFilter.filter({Int($0.leftDay) == ofDay})
        if viewModel.tasksItems.count == 0 {
            setTableViewBG()
        } else {
            setTableViewBG(image: nil)
        }
    }
    
    @IBAction func previousDaysTasksAction(_ sender: Any) {
        day -= 1
        if day != 0, let name = Date().dayName(value: day) {
            titleLbl.text = name
        }
    }
    
    @IBAction func nextDayTasksAction(_ sender: Any) {
        day += 1
        if day != 0, let name = Date().dayName(value: day) {
            titleLbl.text = name
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tasksItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let taskCell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as? TaskTableViewCell {
            taskCell.setData(task: viewModel.tasksItems[indexPath.row])
            return taskCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = DetailViewController.instantiate() as? DetailViewController {
            lastIndexPath = indexPath
            detailVC.taskItem = viewModel.tasksItems[indexPath.row]
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
}

