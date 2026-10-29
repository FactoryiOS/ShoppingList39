import Foundation
import Observation

@MainActor
@Observable
final class ErrorState {
    var message: String?

    @discardableResult
    func handle(_ operation: () throws -> Void) -> Bool {
        do {
            try operation()
            message = nil
            return true
        } catch {
            message = error.localizedDescription
            return false
        }
    }
}
