
import UIKit




//MARK: - WelcomeModel

enum WelcomeModel {
    case chooseCloud
    case dismiss
}





protocol WelcomeViewControllerDelegate: class {
    func deinitController()
}



final class WelcomeViewController: UIViewController {
    
    weak var delegate: WelcomeViewControllerDelegate?
    
    fileprivate let bgView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "artwork-white")
        return view
    }()
    
    
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel.H1.bold
        label.text = "Welcome.title".localized
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
        label.text = "Welcome.description".localized
        label.textColor = UIColor.black
        label.font = UIFont.getTTNormsFont(type: .medium, size: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.setLineSpacing(lineSpacing: 3.0, lineHeightMultiple: 1.45)
        return label
    }()
    
    fileprivate let enterButton: UIButton = {
        
        
        let button  = UIButton.getCustomButton(label:"Welcome.btn".localized)
        button.titleLabel?.font = UIFont.getTTNormsFont(type: .medium, size: 16)
        button.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func enterButtonTapped(_ sender: UIButton) {
        navigation(.chooseCloud)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    fileprivate func setupUI() {
        
        
        self.view.alpha = 0
        view.backgroundColor = .white
        
        
        
        
        
        
        
        
        if UIDevice.current.model == "iPhone" {
//            view.addSubview(enterButton)
//            enterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
//            enterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
//            enterButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
//            enterButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
//
            
            view.addSubview(enterButton)
            enterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            enterButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
            enterButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
            enterButton.widthAnchor.constraint(equalToConstant: 343).isActive = true
            
            view.addSubview(descriptionLabel)
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
            descriptionLabel.widthAnchor.constraint(equalToConstant: 260).isActive = true
            descriptionLabel.bottomAnchor.constraint(equalTo: enterButton.topAnchor, constant: -25).isActive = true
            let descLabelHeight = UILabel.getLabelSize(text: descriptionLabel.text!, fontSize: 14, fontName: "TTNorms-Medium")
            descriptionLabel.heightAnchor.constraint(equalToConstant: (descLabelHeight.width / 260) * 40).isActive = true
            
            view.addSubview(titleLabel)
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
            titleLabel.widthAnchor.constraint(equalToConstant: 260).isActive = true
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -10).isActive = true
            
            let labelHeight = UILabel.getLabelSize(text: titleLabel.text!, fontSize: 32, fontName: "TTNorms-Bold")
            titleLabel.heightAnchor.constraint(equalToConstant: (labelHeight.width / 260) * 60).isActive = true
            
        
            
            view.addSubview(bgView)
            bgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            bgView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
            bgView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -20).isActive = true
//            bgView.heightAnchor.constraint(equalToConstant: 420).isActive = true
            bgView.widthAnchor.constraint(equalToConstant: 1194).isActive = true
        } else {
            view.addSubview(enterButton)
            enterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            enterButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
            enterButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
            enterButton.widthAnchor.constraint(equalToConstant: 343).isActive = true
            
            view.addSubview(descriptionLabel)
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            descriptionLabel.widthAnchor.constraint(equalToConstant: 220).isActive = true
            descriptionLabel.bottomAnchor.constraint(equalTo: enterButton.topAnchor, constant: -33).isActive = true
            let descLabelHeight = UILabel.getLabelSize(text: descriptionLabel.text!, fontSize: 14, fontName: "TTNorms-Medium")
            descriptionLabel.heightAnchor.constraint(equalToConstant: (descLabelHeight.width / 260) * 42).isActive = true
        
            
            view.addSubview(titleLabel)
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            titleLabel.widthAnchor.constraint(equalToConstant: 220).isActive = true
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -10).isActive = true
            let labelHeight = UILabel.getLabelSize(text: titleLabel.text!, fontSize: 32, fontName: "TTNorms-Bold")
            titleLabel.heightAnchor.constraint(equalToConstant: (labelHeight.width / 260) * 62).isActive = true
            
            
            view.addSubview(bgView)
            bgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            bgView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -45).isActive = true
            bgView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
            bgView.widthAnchor.constraint(equalToConstant: 1194).isActive = true
        }
        
        
        
        
        
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 1
        }
        
        
        
        
    }
    
    
    fileprivate func navigation(_ type: WelcomeModel) {
        switch type {
        case .chooseCloud:
            let viewController = SelectCloudViewController()
            viewController.delegate = self
            let navigationController = UINavigationController(rootViewController: viewController)
            self.present(navigationController, animated: true, completion: nil)
        case .dismiss:
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if traitCollection.userInterfaceStyle == .light {
            bgView.image = UIImage(named: "artwork-white")
            view.backgroundColor = .white
            titleLabel.textColor = UIColor.Primary.primary
            descriptionLabel.textColor = UIColor.Black.primary
        } else {
            bgView.image = UIImage(named: "artwork-black")
            view.backgroundColor = UIColor.Black.light
            titleLabel.textColor = .white
            descriptionLabel.textColor = .white
        }
        
        
        if UIDevice.current.model == "iPad" {
            if UIDevice.current.orientation == .portrait || UIDevice.current.orientation == .portraitUpsideDown {
                bgView.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
            } else {
                print("lanscape")
                bgView.transform = CGAffineTransform(scaleX: 1, y: 1)
                bgView.contentMode = .scaleAspectFit
            }
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
        delegate?.deinitController()
    }
    
    deinit {
        delegate?.deinitController()
    }
}


//MARK: - implementation of the delegate from  SelectCloudViewController

extension  WelcomeViewController: SelectCloudViewControllerDelegate {
    func deinitController() {
        if !realm.isEmpty {
            self.dismiss(animated: true, completion: nil)
        }
    }
}



extension UILabel {
    func height(constraintedWidth width: CGFloat) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = self.text
        label.font = self.font
        label.sizeToFit()
        return label.frame.height
     }
}
