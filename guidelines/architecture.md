# 架构与分层

> 唯一来源：源码分层、数据边界、并发约定。SwiftUI 写法细节见 `swiftui-conventions.md`。

## 分层

```text
Views → ViewModels(@Observable) → Services → Models
```

- **Views**：只负责展示和用户交互，不直接访问网络、磁盘或系统服务。
- **ViewModels**：`@Observable` + `@MainActor`，持有视图状态，调用 Service。
- **Services**：封装外部依赖（网络、持久化、系统 API），以协议暴露，便于测试时替换。
- **Models**：领域模型，值类型优先，满足 `Sendable`。
- 依赖方向只能自上而下，下层不得引用上层。

## 数据边界

外部数据（API、文件、系统返回值）的原始结构只出现在 Service 边界；通过 mapper 转成领域模型后再向上传递，View 和 ViewModel 不直接使用外部结构。

## 并发

- Swift 6 严格并发；用 async/await，不用回调和 `DispatchQueue`。
- ViewModel 标 `@MainActor`；跨隔离域传递的类型必须 `Sendable`。

## 目录与文件

- 一个文件只放一个类型（struct/class/enum）。
- `Mochi/` 下按功能分目录（如 `Features/<Name>/`），共用代码放 `Shared/`；功能出现后再建，不预先建空目录。
- 新增或删除源文件后运行 `xcodegen generate`（见 `commands.md`）。
