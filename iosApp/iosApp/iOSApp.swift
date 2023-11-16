import SwiftUI
import shared
import Datadog


@main
struct iOSApp: App {
    
    init() {
        
        // Initialize DataDog here
        
        KMPInitializer.shared.load { ktorDelegate in
            URLSession(configuration: .default, delegate: CustomDelegate(dataDogDelegate: DDURLSessionDelegate(), ktorDelegate: ktorDelegate), delegateQueue: .main)
        }
    }
    
	var body: some Scene {
		WindowGroup {
			ContentView()
		}
	}
}
