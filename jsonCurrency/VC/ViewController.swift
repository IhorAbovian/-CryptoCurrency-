//
//  ViewController.swift
//  jsonCurrency
//
//  Created by Igor Abovyan on 01.12.2021.
//

import UIKit

class ViewController: UITableViewController {
    
    var dataDelegate = [DataJson]()
}

//MARK: - Life cycle
extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.config()
    }
}

//MARK: - Config
extension ViewController {
    private func config() {
        self.addButton()
        self.addTitle()
    }
    
    private func addTitle() {
        navigationItem.title = "Tracking"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func addButton() {
        let button = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(createChooseVC))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private func createChooseVC() {
        let vc = ChooseVC.init()
        vc.myDelegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: Table view data source
extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataDelegate.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? Cell_custom
        if cell == nil {
            cell = Cell_custom.init(style: .value1, reuseIdentifier: identifier)
        }
        
        let task = dataDelegate[indexPath.row]
        cell?.textLabel?.text = task.name
        cell?.detailTextLabel?.text = String(task.current_price)
        let img = URL(string:"\(task.image)")
        let data = try? Data(contentsOf: img!)
        if let imgData = data {
            cell?.imageView?.image = UIImage.init(data: imgData)
        }
        return cell!
    }
}

//MARK: Table view Delegate
extension ViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Cell_custom.height
    }
}

//MARK: Delegate
extension ViewController: SecondVCDelegate {
    func getData(isFavourites: [DataJson]) {
        dataDelegate = isFavourites
        
        self.tableView.reloadData()
    }
}
