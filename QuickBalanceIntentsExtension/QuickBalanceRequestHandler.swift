//
//  QuickBalanceRequestHandler.swift
//  QuickBalanceIntentsExtension
//
//  Created by Douglas  Goulart Nunes on 23/04/19.
//  Copyright © 2019 Douglas  Goulart Nunes. All rights reserved.
//

import Foundation
import Intents
import QuickBalance

extension Account {
    
    public var intentAccount: INPaymentAccount {
        return INPaymentAccount(nickname: INSpeakableString(spokenPhrase: self.name),
                                number: nil,
                                accountType: .unknown,
                                organizationName: nil,
                                balance: INBalanceAmount(amount: NSDecimalNumber(floatLiteral: self.balance), currencyCode: "BRL"),
                                secondaryBalance: nil)
    }
}

class QuickBalanceRequestHandler: NSObject, INSearchForAccountsIntentHandling {
    
    func handle(intent: INSearchForAccountsIntent, completion: @escaping (INSearchForAccountsIntentResponse) -> Void) {
        QuickBalanceService().quickBalanceAccounts { (accounts) in
            let response: INSearchForAccountsIntentResponse
            guard accounts.count > 0 else {
                response = INSearchForAccountsIntentResponse(code: .failureAccountNotFound, userActivity: .none)
                completion(response)
                return
            }
            response = INSearchForAccountsIntentResponse(code: .success, userActivity: .none)
            response.accounts = accounts.compactMap({ return $0.intentAccount })
            completion(response)
        }
    }
}

