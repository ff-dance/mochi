# Git 工作流

> 唯一来源：分支与提交约定。

- 主分支：`main`。
- 提交格式：`type(scope): description`（如 `feat(player): add playback queue`）。
- `*.xcodeproj` 不入库；`project.yml` 入库。
- 提交前门禁通过 `.githooks/pre-commit` 运行，启用方式见 `commands.md`。
- 未经用户要求，agent 不主动提交或推送。
