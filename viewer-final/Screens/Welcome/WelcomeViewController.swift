
import UIKit

final class WelcomeViewController: UIViewController {
    
    
    
    
    fileprivate let bgView: UIView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "artwork")
        return view
    }()
    
    
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel.H1.bold
        label.text = "Welcome to ARQ Viewer"
        label.textColor = UIColor.Primary.primary
        label.font = UIFont.getTTNormsFont(type: .bold, size: 32)
        label.textColor = UIColor.Primary.primary
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "View and display your projects. Share them. See statistics and manage your account. To create the projects you need login ARQ Editor"
        label.textColor = UIColor.black
        label.font = UIFont.getTTNormsFont(type: .medium, size: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.setLineSpacing(lineSpacing: 4.0)
        return label
    }()
    
    fileprivate let enterButton: UIButton = {
        let button  = UIButton.getCustomButton(label: "Login")
        button.titleLabel?.font = UIFont.getTTNormsFont(type: .medium, size: 16)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    fileprivate func setupUI() {
        
        self.view.alpha = 0
        view.backgroundColor = .white
        
        

        
        view.addSubview(enterButton)
        enterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        enterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        enterButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        enterButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        view.addSubview(descriptionLabel)
        descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        descriptionLabel.widthAnchor.constraint(equalToConstant: 220).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: enterButton.topAnchor, constant: -33).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        view.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 220).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        
        
        view.addSubview(bgView)
        bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 45).isActive = true
        bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -45).isActive = true
        bgView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -50).isActive = true
        bgView.heightAnchor.constraint(equalToConstant: 380).isActive = true
        
//        bgView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        
        
        
        
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 1
            
        }
    }
    
    
    // MARK: settings Navigation bar
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
