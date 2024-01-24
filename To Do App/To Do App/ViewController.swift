//
//  ViewController.swift
//  To Do App
//
//  Created by LinhMAC on 25/01/2024.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    private var entities: [Entity] = []
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        fetchData()
        setupTableView()
    }

    @IBAction func addBtn(_ sender: Any) {
        showAddItemAlert()
    }
    
    private func setupTableView() {
        mainTableView.dataSource = self
        mainTableView.delegate = self
        let cell = UINib(nibName: "MainTableViewCell", bundle: nil)
        mainTableView.register(cell, forCellReuseIdentifier: "MainTableViewCell")
    }
    
    func showEditItemAlert(indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Edit Item", message: nil, preferredStyle: .alert)

        alertController.addTextField { textField in
            textField.placeholder = "Title1"
            textField.text = self.entities[indexPath.row].title
        }

        alertController.addTextField { textField in
            textField.placeholder = "Description1"
            textField.text = self.entities[indexPath.row].desciption
        }

        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard let self = self else { return }

            if let title = alertController.textFields?.first?.text, !title.isEmpty {
                let editedItem = self.entities[indexPath.row]
                editedItem.title = title
                editedItem.desciption = alertController.textFields?.last?.text
                self.saveData()
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
    func showAddItemAlert() {
        let alertController = UIAlertController(title: "Add New Item", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Title1"
        }
        alertController.addTextField { textField in
            textField.placeholder = "Description1"
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let self = self else { return }
            if let title = alertController.textFields?.first?.text, !title.isEmpty {
                let newItem = Entity(context: self.context)
                newItem.title = title
                newItem.desciption = alertController.textFields?.last?.text
                self.saveData()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entities.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        let entity = entities[indexPath.row]
        cell.blinData(title: entity.title ?? "", desciption: entity.desciption ?? "")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showEditItemAlert(indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteItem(at: indexPath)
        }
    }
    
}
//MARK: - CoreData
extension ViewController {
    func fetchData() {
        do {
            entities = try context.fetch(Entity.fetchRequest())
            mainTableView.reloadData()
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
        }
    }

    func saveData() {
        do {
            try context.save()
            fetchData()
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }

    func deleteItem(at indexPath: IndexPath) {
        let entity = entities[indexPath.row]
        context.delete(entity)
        saveData()
    }
}

