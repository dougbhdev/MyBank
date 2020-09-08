//
//  IntentHandler.swift
//  QuickBalanceIntentsExtension
//
//  Created by Douglas  Goulart Nunes on 23/04/19.
//  Copyright © 2019 Douglas  Goulart Nunes. All rights reserved.
//

import Intents
import LocalAuthentication

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any? {
        
        authenticationWithTouchID()
        
        if intent is INSearchForAccountsIntent {
            return QuickBalanceRequestHandler()
        }
        return .none
    }
    
    
    func authenticationWithTouchID() {
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.localizedFallbackTitle = "Use Passcode"
        var authError: NSError?
        let reasonString = "To access the secure data"
        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString) { success, evaluateError in
                if success {
                    //TODO: User authenticated successfully, take appropriate action
                    
                } else {
                    //TODO: User did not authenticate successfully, look at error and take appropriate action
                    guard let error = evaluateError else {
                        return
                    }
                    //print(self.evaluateAuthenticationPolicyMessageForLA(errorCode: error._code))
                    //TODO: If you have choosen the 'Fallback authentication mechanism selected' (LAError.userFallback). Handle gracefully
                    
                }
            }
        } else {
            guard let error = authError else {
                return
            }
            //TODO: Show appropriate alert if biometry/TouchID/FaceID is lockout or not enrolled
            //print(self.evaluateAuthenticationPolicyMessageForLA(errorCode: error.code))
        }
    }
}
