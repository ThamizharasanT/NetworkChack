import UIKit

import Network

@main 
class AppDelegate: UIResponder, UIApplicationDelegate {
    let monitor = NWPathMonitor()

    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Monitor()
        return true
    }
    func Monitor() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied{
                print("we are connected")
                self.hideAlert()
            }else{
                print("no connection")
                DispatchQueue.main.async {
                    self.showAlert()
                }
            }
            
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
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
//InterNet Check Function
    func showAlert() {
        DispatchQueue.main.async {
            let keyWindow = UIApplication.shared.windows.filter{$0.isKeyWindow}.first
            if var topController = keyWindow?.rootViewController{
                while let presentedViewController = topController.presentedViewController{
                    topController = presentedViewController
                }
                let mainStoryBoard = UIStoryboard(name: "InterNet", bundle: nil)
                let niv = mainStoryBoard.instantiateViewController(withIdentifier: "InterNetController") as! InterNetController
                niv.modalPresentationStyle = .fullScreen
                topController.present(niv, animated: true, completion: nil)
            }
            
        }
    }
    func hideAlert(){
        DispatchQueue.main.async {
            let keyWindow = UIApplication.shared.windows.filter{$0.isKeyWindow}.first
            if var topController = keyWindow?.rootViewController{
                while let presentedViewcontroller = topController.presentedViewController{
                    topController = presentedViewcontroller
                }
                if topController is InterNetController{
                    topController.dismiss(animated: true,completion: nil)
                }
            }
        }
    }
}

}
