import UIKit

final class NavigationController: UINavigationController {
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController()
    }

    //MARK: - Flow functions
    private func configureNavigationController() {
        self.navigationBar.isHidden = true
    }
}
