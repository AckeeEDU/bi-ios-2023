import SwiftUI

struct Theme {
    var commentAuthor = Color.cyan
    var commentText = Color.teal
}

struct ThemeEnvKey: EnvironmentKey {
    static var defaultValue: Theme {
        .init()
    }
}

struct ThemeEnvKey2: EnvironmentKey {
    static var defaultValue: Theme {
        .init()
    }
}


extension EnvironmentValues {
    var theme: Theme {
        get { self[ThemeEnvKey.self] }
        set { self[ThemeEnvKey.self] = newValue }
    }
    
    var theme2: Theme {
        get { self[ThemeEnvKey2.self] }
        set { self[ThemeEnvKey2.self] = newValue }
    }
}
