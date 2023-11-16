import SwiftUI
import shared
import KMPNativeCoroutinesAsync

class ViewModel: ObservableObject {
    
    private let performer = Dependencies.shared.getApiPerformer()
    
    @Published var text: String = "Loading...."
    
    @MainActor
    func perform() async {
        
        do {
            text = try await asyncFunction(for: performer.perform())
        } catch {
            text = "Error"
        }
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()

	var body: some View {
        Text(viewModel.text).task {
            await viewModel.perform()
        }
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
