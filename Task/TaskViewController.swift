//
//  TaskViewController.swift
//  Task
//
//  Created by Phong on 23/03/2022.
//

import UIKit

class TaskViewController: UIViewController {
    @IBOutlet var label:UILabel!
    var task:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text=task
    }
    


}
