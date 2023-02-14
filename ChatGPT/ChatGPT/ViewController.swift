//
//  ViewController.swift
//  ChatGPT
//
//  Created by Aurelio Le Clarke on 14.02.2023.
//

import UIKit


final class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate {


    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textField: UITextField!
    
    
    var models: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, !text.isEmpty {
            models.append(text)
            APICaller.shared.send(text: text) { [ weak self] result in
                switch result {
                case .success(let success):
                    self?.models.append(success)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                        self?.textField.text = nil
                    }
                   
                case .failure(let failure):
                    print("Failed \(failure)")
                }
            }
        }
     
        return true
    }
    

}


