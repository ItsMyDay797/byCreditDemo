import Foundation
import UIKit

class UserData {
    static let shared = UserData()
    
    private(set) var balance: Double = 1000.0 {
        didSet {
            NotificationCenter.default.post(name: .balanceDidChange, object: nil)
        }
    }
    private(set) var transactions: [Transaction] = []
    var avatarImage: UIImage? = nil
    
    private init() {
        // Инициализация с дефолтными значениями
    }
    
    var name: String = "Иван Иванов"
    var email: String = "ivan@example.com"
    
    func addTransaction(_ transaction: Transaction) {
        // Добавляем транзакцию в начало списка
        transactions.insert(transaction, at: 0)
        
        // Обновляем баланс в зависимости от типа транзакции
        switch transaction.type {
        case .receive:
            balance += transaction.amount
        case .send:
            balance -= (transaction.amount + getNetworkFee(for: transaction.currency))
        case .exchange:
            // Для обмена баланс обновляется отдельно
            break
        case .loan:
            // Для займа баланс обновляется отдельно
            break
        }
        
        // Отправляем уведомление об изменении списка транзакций
        NotificationCenter.default.post(name: .transactionsDidChange, object: nil)
    }
    
    func clearTransactions() {
        transactions.removeAll()
        NotificationCenter.default.post(name: .transactionsDidChange, object: nil)
    }
    
    private func getNetworkFee(for currency: String) -> Double {
        switch currency {
        case "BTC": return 0.0001
        case "ETH": return 0.001
        case "USDT": return 1.0
        case "BNB": return 0.0005
        default: return 0.0
        }
    }
}

extension Notification.Name {
    static let balanceDidChange = Notification.Name("balanceDidChange")
    static let userDidLogout = Notification.Name("userDidLogout")
    static let transactionsDidChange = Notification.Name("transactionsDidChange")
    static let avatarDidChange = Notification.Name("avatarDidChange")
}

struct ExchangeDetails {
    let fromAmount: Double
    let fromCurrency: String
    let toAmount: Double
    let toCurrency: String
    let rate: Double
    let fee: Double
}

struct Transaction {
    enum TransactionType {
        case send
        case receive
        case exchange
        case loan
    }
    
    let type: TransactionType
    let amount: Double
    let currency: String
    let date: Date
    let address: String
    let details: ExchangeDetails?
    let loanDetails: LoanDetails?
    
    init(type: TransactionType, amount: Double, currency: String, date: Date, address: String, details: ExchangeDetails? = nil, loanDetails: LoanDetails? = nil) {
        self.type = type
        self.amount = amount
        self.currency = currency
        self.date = date
        self.address = address
        self.details = details
        self.loanDetails = loanDetails
    }
}

struct LoanDetails {
    let term: Int
    let collateral: Double
    let collateralCurrency: String
}
