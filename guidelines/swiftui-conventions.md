# SwiftUI 约定

> 唯一来源：本项目特有的 SwiftUI 约定。通用 SwiftUI 最佳实践以 `swiftui-pro` skill（`.claude/skills/swiftui-pro`）为准，此处不复写。

## 部署目标

- 最低 **macOS 15**。使用更高版本 API 必须包 `#available`，且不得修改 `project.yml` 里的部署目标。
- `swiftui-pro` 默认假设 iOS 27 / Swift 6.4+；与本项目目标冲突时，以 `project.yml` 为准。

## 依赖

- 禁止引入第三方框架，需要时先询问用户。
- 避免 UIKit/AppKit，除非 SwiftUI 无法实现并经用户同意。已批准例外：刘海悬浮岛的窗口层用 AppKit `NSPanel`，内容仍用 SwiftUI。

## 视觉

颜色、字体、间距、动画一律取自 `MochiTheme`，规则见 `design-system.md`；与 `swiftui-pro` 通用建议冲突时以 `design-system.md` 为准。

## 工作方式

- 写或改 SwiftUI 代码时遵循 `swiftui-pro`；完成后可让 agent 用它审查。
- 做功能时只改被要求的内容，无关的现代化建议单独提出，不擅自应用（与 `core.md` 一致）。
- 视图出错用明确的错误状态展示；加载中用明确的 loading 状态，不使用空白占位。
