import UIKit

class BasicViewController: UIViewController {
    //MARK: - Properties
    let networkService = NetworkService()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addEndEditingGestureRecogniser()
    }
    
    //MARK: - Flow functions
    private func addEndEditingGestureRecogniser() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    //MARK: - Actions
    @objc private func hideKeyboard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}
