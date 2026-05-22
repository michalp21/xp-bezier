import ScreenSaver
import WebKit

// The @objc name must match NSPrincipalClass in Info.plist.
@objc(BezierScreenSaverView)
public class BezierScreenSaverView: ScreenSaverView {

    private var webView: WKWebView?

    public override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        let config = WKWebViewConfiguration()
        // Allow the bundled HTML to load sibling resources (p5.min.js) via file:// URL.
        config.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")

        let wv = WKWebView(frame: bounds, configuration: config)
        wv.autoresizingMask = [.width, .height]
        wv.wantsLayer = true
        wv.layer?.backgroundColor = CGColor(gray: 0, alpha: 1)
        addSubview(wv)
        webView = wv

        let bundle = Bundle(for: type(of: self))
        guard
            let htmlURL    = bundle.url(forResource: "screensaver", withExtension: "html"),
            let resourceDir = bundle.resourceURL
        else { return }

        wv.loadFileURL(htmlURL, allowingReadAccessTo: resourceDir)
    }

    // Let p5.js drive its own animation loop via requestAnimationFrame.
    public override func animateOneFrame() {}

    public override func startAnimation() {
        super.startAnimation()
        webView?.evaluateJavaScript("if (typeof loop === 'function') loop()", completionHandler: nil)
    }

    public override func stopAnimation() {
        super.stopAnimation()
        webView?.evaluateJavaScript("if (typeof noLoop === 'function') noLoop()", completionHandler: nil)
    }

    public override var hasConfigureSheet: Bool { false }
    public override var configureSheet: NSWindow? { nil }
}
