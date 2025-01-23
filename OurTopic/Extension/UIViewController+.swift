//
//  UIViewController+.swift
//  OurTopic
//
//  Created by 조우현 on 1/17/25.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, button: String, isCancelButton: Bool = false, buttonStyle: UIAlertAction.Style = .default ,completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let button = UIAlertAction(title: button, style: buttonStyle) { action in
            completionHandler()
        }
        // 필요한 경우에만 cancelButton 사용하기!
        if isCancelButton {
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            alert.addAction(cancel)
        }
        
        alert.addAction(button)
        
        present(alert, animated: true)
    }
    
    func changeRootViewController(vc: UIViewController, isSigned: Bool) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        
        UserDefaultsManager.shared.isSigned = isSigned
    }
}
