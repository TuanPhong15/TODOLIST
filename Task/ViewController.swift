//
//  ViewController.swift
//  Task
//
//  Created by Phong on 23/03/2022.
//

import UIKit

class ViewController: UIViewController {
 
    @IBOutlet var tableView:UITableView!
    
    var tasks = [String]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        //Get all current save tasks
        
        self.title="Tasks"
        tableView.delegate=self
        tableView.dataSource=self
        
        //Setup
        if !UserDefaults.standard.bool(forKey: "setup") {
            UserDefaults.standard.set(true, forKey: "setup")
            UserDefaults.standard.set(0, forKey: "count")

        }

    }
    func updateTasks() {
        tasks.removeAll()
        guard let count = UserDefaults().value(forKey: "count") as? Int else  {
            return
        }
        for x in 0..<count {
            
            if  let task = UserDefaults().value(forKey: "task_\(x+1)") as? String {
                tasks.append(task)
            }
        }
        tableView.reloadData()
    }
    @IBAction func didTapApp() {
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "Điền ghi chú"
        vc.update = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard?.instantiateViewController(identifier: "task") as! TaskViewController
        vc.title = "Chi tiết ghi chú"
        vc.task=tasks[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text=tasks[indexPath.row]
        return cell;
        
    }
}
