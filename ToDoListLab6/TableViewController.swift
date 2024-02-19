//
//  TableViewController.swift
//  ToDoListLab6
//
//  Created by user235217 on 2/18/24.
//

import UIKit

struct ListItem	: Codable{
    var label :String
}
class TableViewController: UITableViewController {

    
    var listItems = [ListItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }
    @IBAction func AddItem(_ sender: Any) {
        showAddAlert()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
               let todoItem = listItems[indexPath.row]
               cell.textLabel?.text = todoItem.label
               return cell
           }
    
    private func saveItems() {
        let data = try? JSONEncoder().encode(listItems)
        UserDefaults.standard.set(data, forKey: "todoItems")
    }
           
          
    private func loadItems() {
        if let data = UserDefaults.standard.data(forKey: "todoItems"),
        let savedItems = try? JSONDecoder().decode([ListItem].self, from: data) {
            listItems = savedItems
        }
    }
    
    private func showAddAlert() {
        let alertController = UIAlertController(title: "Add Todo", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Enter todo item"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            if let textField = alertController.textFields?.first, let text = textField.text, !text.isEmpty {
                let newTodoItem = ListItem(label: text)
                self?.listItems.append(newTodoItem)
                self?.saveItems()
                self?.tableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            listItems.remove(at: indexPath.row)
            saveItems()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
