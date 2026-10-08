# 测试

> 唯一来源：测试框架与策略。运行命令见 `commands.md`。

- 使用 **Swift Testing**（`import Testing`、`@Test`、`#expect`），禁止新增 XCTest。写法遵循 `swift-testing-pro` skill。
- 测试文件放 `MochiTests/`，文件名与被测类型对应（`FooTests.swift` 测 `Foo`）。
- ViewModel 与 Service 逻辑必须有单元测试；Service 依赖通过协议注入，测试中用替身。
- 纯视图排版不写单测；界面验证用 `run` skill 启动 app 并截图确认。
- 修 bug 先写复现测试（见 `core.md`）。
