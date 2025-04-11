import UIKit

class LoginViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "arrow.up.circle.fill")?
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 60, weight: .medium))
            .withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Build your future"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Децентрализованные займы на блокчейне"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white.withAlphaComponent(0.7)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let joinButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Join Us", for: .normal)
        button.backgroundColor = .systemPurple
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var loginPopupView: LoginPopupView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        setupAnimation()
        setupNotifications()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.06, green: 0.11, blue: 0.23, alpha: 1.0)
        
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(joinButton)
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            logoImageView.widthAnchor.constraint(equalToConstant: 120),
            logoImageView.heightAnchor.constraint(equalToConstant: 120),
            
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            joinButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            joinButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            joinButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            joinButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        joinButton.addTarget(self, action: #selector(joinButtonTapped), for: .touchUpInside)
    }
    
    private func setupActions() {
        // No additional actions needed for the existing setup
    }
    
    private func setupAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        animation.values = [0, -10, 0]
        animation.keyTimes = [0, 0.5, 1]
        animation.duration = 1.5
        animation.repeatCount = .infinity
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        logoImageView.layer.add(animation, forKey: "bounce")
    }
    
    @objc private func joinButtonTapped() {
        showLoginPopup()
    }
    
    private func showLoginPopup() {
        loginPopupView = LoginPopupView(frame: view.bounds)
        loginPopupView?.alpha = 0
        
        if let loginPopupView = loginPopupView {
            loginPopupView.onLogin = { [weak self] (login, password) in
                self?.hideLoginPopup {
                    let dashboardVC = DashboardViewController()
                    dashboardVC.modalPresentationStyle = .fullScreen
                    self?.present(dashboardVC, animated: true)
                }
            }
            
            loginPopupView.onCancel = { [weak self] in
                self?.hideLoginPopup()
            }
            
            view.addSubview(loginPopupView)
            
            UIView.animate(withDuration: 0.3) {
                loginPopupView.alpha = 1
            }
        }
    }
    
    private func hideLoginPopup(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.3, animations: {
            self.loginPopupView?.alpha = 0
        }) { _ in
            self.loginPopupView?.removeFromSuperview()
            self.loginPopupView = nil
            completion?()
        }
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(userDidLogout),
            name: .userDidLogout,
            object: nil
        )
    }
    
    @objc private func userDidLogout() {
        // Возвращаемся на начальный экран
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            let viewController = LoginViewController()
            window.rootViewController = viewController
            window.makeKeyAndVisible()
        }
    }
}
