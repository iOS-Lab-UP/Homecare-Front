//
//  NetworkManager.swift
//  Homecare-Front
//
//  Created by Luis Cedillo M on 09/02/24.
//

//

import Foundation
import Alamofire
import KeychainSwift




struct APIResponse<T: Decodable>: Decodable {
    let success: Bool
    let status: Int?
    let message: String?
    let error: String?
    let data: T? // This remains generic and can be 'Bool', 'User', or any other Decodable type
}

struct Phrase: Decodable {
    let phrase: String
    let success: Bool
}



/// `APIEndpoints` provides full URL strings for network requests to the various endpoints of the Genesis API.
/// This struct constructs URLs by appending specific path components to the base URL.
struct APIEndpoints {
    /// The base URL for the Luis Home Server API.
    static let baseURL = "https://api.luishomeserver.com"

   static let predict = baseURL + "/predict"
    
    static let advicePrompt = baseURL + "/generate-motivational-phrase"
    
    static let uploadImage = baseURL + "/generate"
}

/// `NetworkManager` handles all network calls to the Genesis API.
/// It includes functions for signing up, verifying identity, resending verification codes, logging in, getting user data, and uploading images.
class NetworkManager:ObservableObject {
    
    // MARK: - Properties
    
    /// Shared instance for the network manager, used for singleton setup.
    static let shared = NetworkManager()
    
    /// A six-digit code which might be used for certain authentication processes.
    var sixDigitCode: String?
    
    /// The JWT token used for authenticated requests.
    var jwtToken: String?
    
    /// A flag indicating whether the user is authenticated.
    @Published var isAuthenticated: Bool?
    
    private let keychain = KeychainSwift()

    
    
    // Private initializer for singleton.
    private init() {}
    
    // MARK: - Network Operations
    
        
    // Add your methods like `signUp`, `verifyIdentity`, `resendVerificationCode`, `login`, `getUserData`, and `uploadImage` here,
    // replacing string concatenations for URLs with references to your `APIEndpoints` properties.
    // Example:
    // URL(string: APIEndpoints.baseURL + "/sign_up") becomes URL(string: APIEndpoints.signUp)

    // ...
}

extension NetworkManager {
    // Save the JWT token to the Keychain
    func saveToken(_ token: String) {
        keychain.set(token, forKey: "com.Genesis.jwtToken")
    }

    // Retrieve the JWT token from the Keychain
    func retrieveToken() -> String? {
        return keychain.get("com.Genesis.jwtToken")
    }

    // Delete the JWT token from the Keychain (useful for sign out)
    func deleteToken() {
        keychain.delete("com.Genesis.jwtToken")
    }
    

    
}






