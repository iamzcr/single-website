# Call My AI Worker — 官网

「一次提问，多个 AI 同时回答」浏览器扩展 **Call My AI Worker** 的静态官网（落地页）。

> **扩展源码仓库**：<https://github.com/iamzcr/call-my-ai-worker>

## 项目简介

本仓库是面向 Call My AI Worker 浏览器扩展的产品官网。该扩展基于 Manifest V3 开发，在同页内以 iframe 平铺各个 AI 网页，支持勾选多个站点、输入一个问题后一键分发，各站点同时生成回答，省去来回切换。

## 链接

- **扩展源码仓库**：[iamzcr/call-my-ai-worker](https://github.com/iamzcr/call-my-ai-worker)
- **项目用途**：本仓库仅包含官网（静态落地页）部分；扩展本体（`manifest.json`、`app/`、`options/`、`content/`、`background/` 等）位于上述 GitHub 仓库。

## 功能特性

- **一次提问，多站并行**：勾选多个站点，输入一个问题一键分发，各站点同时回答。
- **国内 / 海外分组**：内置多个国内 / 海外主流站点，侧边栏分组展示，默认勾选常用国内站点。
- **上下文保持**：追问自动延续各站点对话；改选站点时仍选中的站点上下文不丢。
- **单站点刷新重问**：每个站点可单独刷新并重新提交当前问题，不影响其他站点。
- **一键停止回答**：点击停止即可让各站点停止生成并中断跟踪，不关闭扩展窗口。
- **站点可配置**：选项页可增删站点、调整选择器，支持选择器测试与配置导入导出。

## 页面结构

| 区块 | 组件 | 说明 |
| --- | --- | --- |
| 顶部导航 | `NavBar.vue` | 固定导航，滚动渐变背景，锚点高亮 |
| 首屏 | `HeroSection.vue` | 产品主标题 + 演示图轮播（支持点击放大灯箱） |
| 核心特性 | `FeaturesSection.vue` | 六大特性卡片 |
| 使用教程 | `HowItWorks.vue` | 三步上手流程 |
| 安装引导 | `CtaSection.vue` | 下载安装 CTA |
| 页脚 | `FooterSection.vue` | 版权信息与链接 |

## 技术栈

- [Vue 3](https://vuejs.org/)（Composition API + `<script setup>`）
- [Vite](https://vitejs.dev/)
- [Vue Router 4](https://router.vuejs.org/)（hash 模式，便于任意子路径部署）
- [Naive UI](https://www.naiveui.com/)

## 快速开始

```bash
# 安装依赖
npm install

# 启动开发服务
npm run dev

# 生产构建
npm run build

# 本地预览构建产物
npm run preview
```

## 目录结构

```
call-my-ai-worker/
├── index.html              # 入口 HTML
├── vite.config.js          # Vite 配置（base: './'）
├── public/
│   ├── icon128.png         # 站点图标
│   └── demo/               # 演示截图（轮播用）
└── src/
    ├── main.js             # 应用入口（含滚动显现指令）
    ├── App.vue             # 根组件
    ├── assets/logo.png     # Logo 资源
    ├── router/index.js     # 路由配置
    ├── styles/base.css     # 全局样式与 CSS 变量
    ├── views/HomeView.vue  # 首页视图
    └── components/         # 页面区块组件
```

## 部署说明

- 构建产物输出到 `dist/` 目录。
- `vite.config.js` 设置了 `base: './'`，产物可直接部署到任意静态服务器或子路径（如 GitHub Pages、Nginx 等），无需额外配置。
- 路由使用 hash 模式，刷新/直接访问任意路径均不会 404。
