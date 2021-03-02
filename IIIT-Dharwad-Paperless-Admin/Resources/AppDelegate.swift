//
//  AppDelegate.swift
//  IIIT-Dharwad-Paperless-Admin
//
//  Created by Souvik Das on 22/02/21.
//

import UIKit
import Firebase
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    var window: UIWindow?
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            print("here \(error)")
            return
        }
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        let email = user.profile.email
        UserDefaults.standard.setValue(email, forKey: "email")
        
        AuthManager.shared.userExists(with: email!, completion: { exists in
            guard !exists else {
                Auth.auth().signIn(with: credential) { (authResult, error) in
                    if let error = error {
                        print("authentication error \(error.localizedDescription)")
                    }
                    else{
                        NotificationCenter.default.post(name: .didLogInNotification, object: nil)
                    }
                }
                return
            }
            let user = AppUser(emailAddress: email!)
            AuthManager.shared.insertUser(with: user, completion: { success in
                if (success){
                    Auth.auth().signIn(with: credential) { (authResult, error) in
                        if let error = error {
                            print("authentication error \(error.localizedDescription)")
                        }
                        else{
                            NotificationCenter.default.post(name: .didLogInNotification, object: nil)
                        }
                    }
                }
            })
        })
        
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = "962654203909-9jhf3lud7gff2cmjdkne2aje5oe8m4nc.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self  // If AppDelegate conforms to GIDSignInDelegate
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = LoginViewController()
        window.makeKeyAndVisible()
        self.window = window
        
        
        return true
    }
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}



