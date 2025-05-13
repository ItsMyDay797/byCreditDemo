import Foundation
import Web3
import BigInt

struct Wallet: Codable {
    let address: String
    let privateKey: String
    var balance: String
    var transactions: [Transaction]
    
    struct Transaction: Codable {
        let hash: String
        let from: String
        let to: String
        let value: String
        let timestamp: Date
        let status: TransactionStatus
        
        enum TransactionStatus: String, Codable {
            case pending
            case completed
            case failed
        }
    }
}

class WalletManager {
    static let shared = WalletManager()
    
    private let blockchainManager = BlockchainManager.shared
    private var currentWallet: Wallet?
    
    private init() {}
    
    // MARK: - Wallet Operations
    
    func createNewWallet() async throws -> Wallet {
        let (address, privateKey) = try await blockchainManager.createWallet()
        let balance = try await blockchainManager.getBalance(address: address)
        
        let wallet = Wallet(
            address: address,
            privateKey: privateKey,
            balance: balance,
            transactions: []
        )
        
        currentWallet = wallet
        return wallet
    }
    
    func importWallet(privateKey: String) async throws -> Wallet {
        let address = try await blockchainManager.importWallet(privateKey: privateKey)
        let balance = try await blockchainManager.getBalance(address: address)
        
        let wallet = Wallet(
            address: address,
            privateKey: privateKey,
            balance: balance,
            transactions: []
        )
        
        currentWallet = wallet
        return wallet
    }
    
    // MARK: - Balance & Transactions
    
    func updateBalance() async throws -> String {
        guard let wallet = currentWallet else {
            throw WalletError.noWallet
        }
        
        let address = EthereumAddress(wallet.address)
        let web3 = try await Web3(rpcURL: "https://sepolia.infura.io/v3/YOUR-PROJECT-ID")
        let balance = try await web3.eth.getBalance(address: address)
        currentWallet?.balance = balance
        return balance
    }
    
    func sendTransaction(to: String, amount: String) async throws -> String {
        guard let wallet = currentWallet else {
            throw WalletError.noWallet
        }
        
        let txHash = try await blockchainManager.sendTransaction(
            from: wallet.address,
            to: to,
            amount: amount,
            privateKey: wallet.privateKey
        )
        
        // Добавляем транзакцию в историю
        let transaction = Wallet.Transaction(
            hash: txHash,
            from: wallet.address,
            to: to,
            value: amount,
            timestamp: Date(),
            status: .pending
        )
        
        currentWallet?.transactions.append(transaction)
        return txHash
    }
    
    // MARK: - Testnet Operations
    
    func requestTestETH() async throws {
        guard let wallet = currentWallet else {
            throw WalletError.noWallet
        }
        
        let web3 = try await Web3(rpcURL: "https://sepolia.infura.io/v3/YOUR-PROJECT-ID")
        try await blockchainManager.requestTestETH(address: wallet.address)
    }
}

// MARK: - Errors

enum WalletError: Error {
    case noWallet
    case invalidAmount
    case invalidAddress
}

extension WalletError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noWallet:
            return "Кошелек не создан"
        case .invalidAmount:
            return "Неверная сумма"
        case .invalidAddress:
            return "Неверный адрес"
        }
    }
}
