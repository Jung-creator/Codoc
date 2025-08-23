import SwiftUI
import CoreText

@main
struct CodocApp: App {
    init() {
        // 커스텀 폰트 등록
        registerCustomFonts()
    }
    
    var body: some Scene {
        WindowGroup {
            MainViewMock()
        }
    }
    
    private func registerCustomFonts() {
        // Pretendard 폰트들 등록
        let fontNames = [
            "Pretendard-Regular",
            "Pretendard-Medium", 
            "Pretendard-Bold"
        ]
        
        for fontName in fontNames {
            if let fontURL = Bundle.main.url(forResource: fontName, withExtension: "otf") {
                CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, nil)
            }
        }
    }
}
