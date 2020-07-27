import SwiftUI

extension View {
    func withStopSelectionSheetAnimation<Result>( _ body: () throws -> Result) rethrows -> Result {
        try withAnimation(.spring(), body)
    }
    
    func collapsed(_ isCollapsed: Bool) -> some View {
        self.frame(height: isCollapsed ? 0 : nil)
            .disabled(isCollapsed)
            .clipped()
    }
}
