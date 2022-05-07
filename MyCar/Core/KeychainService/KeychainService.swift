//
//  KeychainService.swift
//  KeychainService
//
//  Created by Denis Kuzmin on 07.05.2022.
//

import Foundation

class KeychainService {
    
    static let standart = KeychainService()
    
    private let serviceName: String
    private let accessGroup: String?
    
    private static let defaultServiceName: String = {
        return Bundle.main.bundleIdentifier ?? "KeychainService"
    }()
   
    init(serviceName: String, accessGroup: String? = nil) {
        self.serviceName = serviceName
        self.accessGroup = accessGroup
    }
    
    private convenience init() {
        self.init(serviceName: Self.defaultServiceName)
    }
    
    //MARK: Public methods
    
    @discardableResult func set(_ value: String, forKey key: String, isSynchronizable: Bool = false) -> Bool {
        if let data = value.data(using: .utf8) {
            return set(data, forKey: key)
        } else {
            return false
        }
    }
    
    
    @discardableResult func set(_ value: Data, forKey key: String, isSynchronizable: Bool = false) -> Bool {
        var keychainQueryDictionary: [String: Any] = setupKeychainQueryDictionary(forKey: key,  isSynchronizable: isSynchronizable)
        
        keychainQueryDictionary[kSecValueData as String] = value
        
        let status: OSStatus = SecItemAdd(keychainQueryDictionary as CFDictionary, nil)
        
        if status == errSecSuccess {
            return true
        } else if status == errSecDuplicateItem {
            return update(value, forKey: key, isSynchronizable: isSynchronizable)
        } else {
            return false
        }
    }
    
    
    func string(forKey key: String, isSynchronizable: Bool = false) -> String? {
        guard let keychainData = data(forKey: key,  isSynchronizable: isSynchronizable) else {
            return nil
        }
        
        return String(data: keychainData, encoding: String.Encoding.utf8) as String?
    }
    
    func data(forKey key: String, isSynchronizable: Bool = false) -> Data? {
        var keychainQueryDictionary = setupKeychainQueryDictionary(forKey: key, isSynchronizable: isSynchronizable)
        
        keychainQueryDictionary[kSecMatchLimit as String] = kSecMatchLimitOne
        
        keychainQueryDictionary[kSecReturnData as String] = kCFBooleanTrue
        
        var result: AnyObject?
        let status = SecItemCopyMatching(keychainQueryDictionary as CFDictionary, &result)
        
        return status == noErr ? result as? Data : nil
    }
    
    @discardableResult func removeAllKeys() -> Bool {
        var keychainQueryDictionary: [String: Any] = [kSecClass as String: kSecClassGenericPassword]
        
        keychainQueryDictionary[kSecAttrService as String] = serviceName
        
        if let accessGroup = self.accessGroup {
            keychainQueryDictionary[kSecAttrAccessGroup as String] = accessGroup
        }
        
        let status: OSStatus = SecItemDelete(keychainQueryDictionary as CFDictionary)
        
        if status == errSecSuccess {
            return true
        } else {
            return false
        }
    }
    
    @discardableResult func removeData(forKey key: String, isSynchronizable: Bool = false) -> Bool {
        let keychainQueryDictionary: [String: Any] = setupKeychainQueryDictionary(forKey: key, isSynchronizable: isSynchronizable)
        
        let status: OSStatus = SecItemDelete(keychainQueryDictionary as CFDictionary)

        if status == errSecSuccess {
            return true
        } else {
            return false
        }
    }
    
    //MARK: Private methods
    
    private func setupKeychainQueryDictionary(forKey key: String, isSynchronizable: Bool = false) -> [String:Any] {
        var keychainQueryDictionary: [String: Any] = [kSecClass as String: kSecClassGenericPassword]
        
        keychainQueryDictionary[kSecAttrService as String] = serviceName
 
        if let accessGroup = self.accessGroup {
            keychainQueryDictionary[kSecAttrAccessGroup as String] = accessGroup
        }
        
        let encodedIdentifier: Data? = key.data(using: String.Encoding.utf8)
        keychainQueryDictionary[kSecAttrGeneric as String] = encodedIdentifier
        keychainQueryDictionary[kSecAttrAccount as String] = encodedIdentifier
        keychainQueryDictionary[kSecAttrSynchronizable as String] = isSynchronizable ? kCFBooleanTrue : kCFBooleanFalse
        
        return keychainQueryDictionary
    }
    
    private func update(_ value: Data, forKey key: String, isSynchronizable: Bool = false) -> Bool {
        let keychainQueryDictionary: [String: Any] = setupKeychainQueryDictionary(forKey: key, isSynchronizable: isSynchronizable)
        let updateDictionary = [kSecValueData as String: value]
        
        // Update
        let status: OSStatus = SecItemUpdate(keychainQueryDictionary as CFDictionary, updateDictionary as CFDictionary)
        
        if status == errSecSuccess {
            return true
        } else {
            return false
        }
    }
}
