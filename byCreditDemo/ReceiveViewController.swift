import UIKit

class ReceiveViewController: UIViewController {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.1)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Получить средства"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let qrCodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "0x71C7656EC7ab88b098defB751B7401B5f6d8976F"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white.withAlphaComponent(0.7)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let copyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Копировать адрес", for: .normal)
        button.backgroundColor = .systemPurple
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        button.setImage(UIImage(systemName: "xmark.circle.fill")?
            .withConfiguration(config)
            .withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        generateQRCode()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.06, green: 0.11, blue: 0.23, alpha: 1.0)
        
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(qrCodeImageView)
        containerView.addSubview(addressLabel)
        containerView.addSubview(copyButton)
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            qrCodeImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            qrCodeImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            qrCodeImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.6),
            qrCodeImageView.heightAnchor.constraint(equalTo: qrCodeImageView.widthAnchor),
            
            addressLabel.topAnchor.constraint(equalTo: qrCodeImageView.bottomAnchor, constant: 20),
            addressLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            addressLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            copyButton.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 20),
            copyButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            copyButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            copyButton.heightAnchor.constraint(equalToConstant: 50),
            copyButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupActions() {
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        copyButton.addTarget(self, action: #selector(copyTapped), for: .touchUpInside)
    }
    
    private func generateQRCode() {
        let address = addressLabel.text ?? ""
        let data = address.data(using: .ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                qrCodeImageView.image = UIImage(ciImage: output)
            }
        }
    }
    
    @objc private func closeTapped() {
        dismiss(animated: true)
    }
    
    @objc private func copyTapped() {
        UIPasteboard.general.string = addressLabel.text
        showAlert(title: "Успешно", message: "Адрес скопирован в буфер обмена")
        
        // Создаем транзакцию для тестирования
        let transaction = Transaction(
            type: .receive,
            amount: 0.1,
            currency: "BTC",
            date: Date(),
            address: addressLabel.text ?? ""
        )
        
        // Сохраняем транзакцию (баланс обновится автоматически в UserData)
        UserData.shared.addTransaction(transaction)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
