//
//  DetailViewController.swift
//  Todo
//
//  Created by ZRMacbookPro on 12/06/2024.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: IBOUTLETS
    
    @IBOutlet weak var taskDescLbl: UILabel!
    @IBOutlet weak var taskTitleLbl: UILabel!
    @IBOutlet weak var taskStatusLbl: UILabel!
    @IBOutlet weak var taskDueDateLbl: UILabel!
    @IBOutlet weak var taskDaysLeftLbl: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var statusControlStack: UIStackView!
    
    var taskItem: TaskItem?
    var headingLbls: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headingLbls = [taskTitleLbl, taskDueDateLbl, taskStatusLbl,taskDaysLeftLbl]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let taskItem = taskItem {
            
            setControlVisibility(status: taskItem.status)
            setColorScheme(status: taskItem.status)
            
            taskTitleLbl.text = taskItem.title ?? "-"
            taskDueDateLbl.text = taskItem.targetDate ?? ""
            taskDescLbl.text = taskItem.description ?? ""
            taskStatusLbl.text = taskItem.status == . undefined ? TaskStatus.unresolved.rawValue : taskItem.status.rawValue
            
            if let toDate = taskItem.targetDate, let fromDate = taskItem.dueDate {
                taskDaysLeftLbl.text = fromDate.calculateDatesDifference(toDate: toDate)
            }
        }
    }
    
    private func setControlVisibility(status: TaskStatus) {
        if status == .undefined {
            statusControlStack.isHidden = false
            statusImage.isHidden = true
        } else {
            statusControlStack.isHidden = true
            statusImage.isHidden = false
            updateTaskStatus(status: status)
        }
    }
    
    private func updateTaskStatus(status: TaskStatus) {
        if status == .resolved {
            statusImage.image = UIImage(named: "btn_resolved")
        } else if status == .unresolved {
            statusImage.image = UIImage(named: "btn_unresolved")
        }
        taskStatusLbl.text = status.rawValue
    }
    
    private func setColorScheme(status: TaskStatus) {
        let statusColor = ColorManager.getColor(taskStatus: status)
        if status == .undefined {
            taskStatusLbl.textColor = statusColor
        } else {
            headingLbls.forEach { label in
                label.textColor = statusColor
            }
        }
    }
    
    
    @IBAction func resolvedAction(_ sender: Any) {
        taskItem?.status = .resolved
        setColorScheme(status: .resolved)
        setControlVisibility(status: .resolved)
    }
    
    @IBAction func cantResolvedAction(_ sender: Any) {
        taskItem?.status = .unresolved
        setColorScheme(status: .unresolved)
        setControlVisibility(status: .unresolved)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
