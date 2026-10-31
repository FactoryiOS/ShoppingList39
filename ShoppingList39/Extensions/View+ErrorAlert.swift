import SwiftUI

extension View {
    func errorAlert(_ title: LocalizedStringKey, state: ErrorState) -> some View {
        let message = state.message ?? ""
        let isPresented = Binding(
            get: { state.message != nil },
            set: { _ in state.message = nil }
        )
        return alert(title, isPresented: isPresented) {
            Button("ОК", role: .cancel) {}
        } message: {
            Text(message)
        }
    }
}
