//
//  QuickBalanceService.swift
//  QuickBalance
//
//  Created by Douglas  Goulart Nunes on 23/04/19.
//  Copyright © 2019 Douglas  Goulart Nunes. All rights reserved.
//

import Foundation

open class QuickBalanceService {
    public init() {}
    public func quickBalanceAccounts(_ completion: @escaping ((_ accounts: [Account]) -> Void)) {
        var accounts = [Account]()
        let account1 = Account(name: "Conta principal", balance: 150.0)
        let account2 = Account(name: "Conta DTVM", balance: 300.0)
        accounts.append(account1)
        accounts.append(account2)
        sleep(3)
        completion(accounts)
    }
}
