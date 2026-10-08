# Product

<!-- impeccable:product-schema 1 -->

## Platform

ios

> 实际平台是**原生 macOS app**（菜单栏 + 刘海悬浮岛，SwiftUI + AppKit `NSPanel`）。impeccable 只支持 web/ios/android/adaptive，这里取最接近 Apple 原生语言的 `ios`；触控目标、安全区等 iOS 专属建议不适用。

## Stack

SwiftUI（窗口层用 AppKit `NSPanel`），XcodeGen 管理工程，最低 macOS 15、Swift 6，Swift Testing。详见 `CLAUDE.md` 与 `guidelines/`。

## Users

作者本人（个人项目，不分发）：在 Mac 前工作、学习、睡前，需要伴随式听歌；听腻了自己的歌单，想要有人陪着、有人讲故事的听歌方式。

## Product Purpose

常驻菜单栏的 AI 音乐电台。女声主理人 Lyra 根据天气、时段和近期听歌偏好替用户选歌，每首歌前用一小段口播（背景故事与推荐理由）引入；口播时音乐压低为背景，结束后渐强。不展示歌单或队列，只显示当前曲目，历史阅后即焚。成功标准：主观上"比原来的歌单更不乏味"。

## Positioning

- 选曲由程序完成，LLM 只负责写口播脚本，结果稳定、便宜、可调试。
- 故事只能来自检索到的资料，没有可靠资料时降级为只讲推荐理由，不编造。
- 口播是附加品：任何一环失败都不能让音乐停下来，最差只放歌。
- 口播与音乐混音（ducking），人声突出而不是在歌曲之间插播。

## Operating Context

用户在 Mac 前长时间后台收听，界面应轻、不抢注意力；目标机型带刘海，悬浮岛从刘海处展开，无刘海屏幕降级为顶部居中胶囊。音源为 Apple Music（MusicKit）与 QQ 音乐（非官方接口，阶段 3）；大模型与 TTS 走云端，由用户自行配置，密钥只放钥匙串。

## Capabilities and Constraints

- 当前处于阶段 0（技术验证），未过"关口 0"前不写阶段 1 功能代码。
- 非官方 QQ 音乐接口仅限个人自用、不分发。
- Lyra 是原创人设，不克隆任何影视角色或真实演员的声音。
- 未决：Apple Music 压低音乐的具体做法、TTS 服务与音色、"阅后即焚"的具体规则。
- 完整需求与方案见 `docs/product-specs/radio/001-ai-radio.md`、`docs/design-specs/radio/001-ai-radio.md`，已确认决策见 `docs/decisions.md`。

## Brand Commitments

- 主理人名称 **Lyra（天琴）**，温柔女声，科幻管家式语气：克制、聪明、略带冷幽默。
- 视觉以 `guidelines/design-system.md` 为**唯一来源且已绑定**（纯黑岛、单一品牌强调色、动效跟着声音走）；本文件不复述视觉细节。

## Evidence on Hand

无真实用户、指标或第三方数据。没有品牌资产（Logo、菜单栏图标矢量图尚未设计）。后续工作不得编造用户反馈或基准数据。

## Product Principles

1. 无需选择：打开即听，惊喜大于控制。
2. 真实优先：宁可少讲，不可编造。
3. 声音优先：界面尽量轻，只在声音变化时动。
4. 口播有节制：短、准、可随时跳过，失败时静默降级。
5. 数据留在本机：密钥进钥匙串，历史阅后即焚。

## Accessibility & Inclusion

字幕、键盘操作、VoiceOver、增强对比度与减弱动态效果支持，具体规则见 `guidelines/design-system.md` §8。
