import UIKit

class SettingsViewController: UIViewController {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.1)
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Настройки"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let themeSwitch: UISwitch = {
        let switchControl = UISwitch()
        switchControl.onTintColor = .systemPurple
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        return switchControl
    }()
    
    private let themeLabel: UILabel = {
        let label = UILabel()
        label.text = "Темная тема"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let languageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Язык", for: .normal)
        button.setImage(UIImage(systemName: "globe"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(white: 1, alpha: 0.1)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let currencyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Валюта", for: .normal)
        button.setImage(UIImage(systemName: "dollarsign.circle"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(white: 1, alpha: 0.1)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
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
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.06, green: 0.11, blue: 0.23, alpha: 1.0)
        
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(themeLabel)
        containerView.addSubview(themeSwitch)
        containerView.addSubview(languageButton)
        containerView.addSubview(currencyButton)
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            themeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            themeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            themeSwitch.centerYAnchor.constraint(equalTo: themeLabel.centerYAnchor),
            themeSwitch.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            languageButton.topAnchor.constraint(equalTo: themeLabel.bottomAnchor, constant: 20),
            languageButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            languageButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            languageButton.heightAnchor.constraint(equalToConstant: 50),
            
            currencyButton.topAnchor.constraint(equalTo: languageButton.bottomAnchor, constant: 20),
            currencyButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            currencyButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            currencyButton.heightAnchor.constraint(equalToConstant: 50),
            currencyButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupActions() {
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        themeSwitch.addTarget(self, action: #selector(themeChanged), for: .valueChanged)
        languageButton.addTarget(self, action: #selector(languageTapped), for: .touchUpInside)
        currencyButton.addTarget(self, action: #selector(currencyTapped), for: .touchUpInside)
    }
    
    @objc private func closeTapped() {
        dismiss(animated: true)
    }
    
    @objc private func themeChanged() {
        // TODO: Реализовать смену темы
        let alert = UIAlertController(
            title: "Смена темы",
            message: "Эта функция будет доступна в следующем обновлении",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func languageTapped() {
        let alert = UIAlertController(title: "Выберите язык", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Русский", style: .default))
        alert.addAction(UIAlertAction(title: "English", style: .default))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        
        present(alert, animated: true)
    }
    
    @objc private func currencyTapped() {
        let alert = UIAlertController(title: "Выберите валюту", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "USD ($)", style: .default))
        alert.addAction(UIAlertAction(title: "EUR (€)", style: .default))
        alert.addAction(UIAlertAction(title: "RUB (₽)", style: .default))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        
        present(alert, animated: true)
    }
}
