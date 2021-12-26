//
//  ChooseVC.swift
//  jsonCurrency
//
//  Created by Igor Abovyan on 01.12.2021.
//

import UIKit

protocol SecondVCDelegate {
    func getData(isFavourites: [DataJson])
}


class ChooseVC: UITableViewController {
    
    var dataArray = [DataJson]()
    var dataDelegate = [DataJson]()
    var myDelegate: SecondVCDelegate!
}

//MARK: - Life cycle
extension ChooseVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.config()
    }
}

//MARK: Config
extension ChooseVC {
    private func config() {
        self.getJsonData()
        self.addTitle()
    }
    
    private func addTitle() {
        navigationItem.title = "Cryptocurrency"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

//MARK: - Get json
extension ChooseVC {
    private func getJsonData() {
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=50"
        
        guard let url = URL.init(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
            }
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder.init()
                self.dataArray = try decoder.decode([DataJson].self, from: data)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }catch {
                fatalError("error\(error)")
            }
        }.resume()
    }
}

//MARK: - Table view Data source
extension ChooseVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? Cell_custom
        if cell == nil {
            cell = Cell_custom.init(style: .value1, reuseIdentifier: identifier)
        }
        var currencyData = dataArray[indexPath.row]
        cell?.textLabel?.text = currencyData.name
        cell?.detailTextLabel?.text = String(currencyData.current_price)
        
        let img = URL(string:"\(currencyData.image)")
        let data = try? Data(contentsOf: img!)
        if let imgData = data {
            cell?.imageView?.image = UIImage.init(data: imgData)
            
            if currencyData.isFavorites == false {
                currencyData.isFavorites = true
                cell?.accessoryType = .checkmark
            }else {
                currencyData.isFavorites = false
                cell?.accessoryType = .none
            }
        }
        return cell!
    }
}

//MARK: Table view Delegate
extension ChooseVC {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Cell_custom.height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        
        if dataArray[indexPath.row].isFavorites == true {
            dataArray[indexPath.row].isFavorites = false
            cell?.accessoryType = .none
        }else {
            dataArray[indexPath.row].isFavorites = true
            dataDelegate.append(dataArray[indexPath.row])
            self.myDelegate.getData(isFavourites: dataDelegate)
            cell?.accessoryType = .checkmark
        }
    }
}
