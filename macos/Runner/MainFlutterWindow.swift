import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController =
      FlutterViewController()

    self.contentViewController =
      flutterViewController

    self.setFrame(
      NSRect(
        x: 0,
        y: 0,
        width: 1800,
        height: 1100
      ),
      display: true,
    )

    self.minSize =
      NSSize(
        width: 1650,
        height: 980
      )

    self.titleVisibility = .hidden
    self.titlebarAppearsTransparent = true

    RegisterGeneratedPlugins(
      registry:
        flutterViewController
    )

    super.awakeFromNib()
  }
}