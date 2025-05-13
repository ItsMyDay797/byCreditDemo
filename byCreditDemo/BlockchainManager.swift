import Foundation
import Web3
import BigInt

class BlockchainManager {
    static let shared = BlockchainManager()
    
    private var web3: web3?
    private let sepoliaRPC = "https://sepolia.infura.io/v3/YOUR-PROJECT-ID" // Замените на ваш Project ID
    
    private init() {
        setupWeb3()
    }
    
    private func setupWeb3() {
        guard let url = URL(string: sepoliaRPC) else { return }
        web3 = web3(rpcURL: url.absoluteString)
    }
    
    // MARK: - Wallet Management
    
    func createWallet() async throws -> (address: String, privateKey: String) {
        guard let web3 = web3 else { throw BlockchainError.web3NotInitialized }
        
        let account = try await web3.eth.accounts.create()
        return (account.address, account.privateKey)
    }
    
    func importWallet(privateKey: String) async throws -> String {
        guard let web3 = web3 else { throw BlockchainError.web3NotInitialized }
        
        let account = try await web3.eth.accounts.importAccount(privateKey: privateKey)
        return account.address
    }
    
    // MARK: - Balance & Transactions
    
    func getBalance(address: String) async throws -> String {
        guard let web3 = web3 else { throw BlockchainError.web3NotInitialized }
        
        let balance = try await web3.eth.getBalance(address: address)
        return Web3.Utils.formatToEthereumUnits(balance, toUnits: .eth, decimals: 6) ?? "0"
    }
    
    func sendTransaction(
        from: String,
        to: String,
        amount: String,
        privateKey: String
    ) async throws -> String {
        guard let web3 = web3 else { throw BlockchainError.web3NotInitialized }
        
        let value = Web3.Utils.parseToBigUInt(amount, units: .eth) ?? BigUInt(0)
        let transaction = EthereumTransaction(
            from: from as! Decoder,
            to: to,
            value: value
        )
        
        let signedTransaction = try await web3.eth.signTransaction(
            transaction: transaction,
            account: web3.eth.accounts.importAccount(privateKey: privateKey)
        )
        
        let txHash = try await web3.eth.sendRawTransaction(signedTransaction)
        return txHash
    }
    
    // MARK: - Testnet Faucet
    
    func requestTestETH(address: String) async throws {
        let faucetURL = "https://sepolia-faucet.pk910.de"
        guard let url = URL(string: faucetURL) else { throw BlockchainError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["address": address]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw BlockchainError.faucetRequestFailed
        }
    }
}

// MARK: - Errors

enum BlockchainError: Error {
    case web3NotInitialized
    case invalidURL
    case faucetRequestFailed
    case transactionFailed
    case invalidPrivateKey
    case insufficientFunds
}

// MARK: - Extensions

extension BlockchainError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .web3NotInitialized:
            return "Web3 не инициализирован"
        case .invalidURL:
            return "Неверный URL"
        case .faucetRequestFailed:
            return "Не удалось получить тестовые ETH"
        case .transactionFailed:
            return "Транзакция не удалась"
        case .invalidPrivateKey:
            return "Неверный приватный ключ"
        case .insufficientFunds:
            return "Недостаточно средств"
        }
    }
}
