import SwiftUI

extension View {
    
    func collapsed(_ isCollapsed: Bool) -> some View {
        self.frame(height: isCollapsed ? 0 : nil)
            .opacity(isCollapsed ? 0 : 1)
            .disabled(isCollapsed)
            .clipped()
    }
}
