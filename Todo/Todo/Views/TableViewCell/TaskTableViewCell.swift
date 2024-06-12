//
//  TaskTableViewCell.swift
//  Todo
//
//  Created by ZRMacbookPro on 11/06/2024.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    //MARK: IBOUTLETS
    
    @IBOutlet weak var taskTitleLbl: UILabel!
    @IBOutlet weak var taskDueDateLbl: UILabel!
    @IBOutlet weak var taskDaysLeftLbl: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setColorScheme(status: .unresolved)
    }
    
    func setData(task: TaskItem) {
        
        if task.status != .undefined {
            setColorScheme(status: task.status)
        }
        
        taskTitleLbl.text = task.title ?? "-"
        taskDueDateLbl.text = task.targetDate ?? ""
        taskDaysLeftLbl.text = task.leftDay
    }
    
    private func setColorScheme(status: TaskStatus) {
        let statusColor = ColorManager.getColor(taskStatus: status)
        taskTitleLbl.textColor = statusColor
        taskDueDateLbl.textColor = statusColor
        taskDaysLeftLbl.textColor = statusColor
    }
}

