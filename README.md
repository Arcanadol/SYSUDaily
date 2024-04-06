# 中山大学数学学院「每日一题」模板

## 简介

此文档类 `SYSUdaily.cls` 旨在建立一个简单易用的中山大学数学学院「每日一题」计划的排版渠道.

## 免责声明

此文档类仅仅为了处理中山大学数学学院「每日一题」计划而编写, 勿作他图, 任何将此模板用于非中山大学数学学院「每日一题」计划排版而导致的纠纷与本模板作者无关.

- [中山大学数学学院「每日一题」模板](#中山大学数学学院每日一题模板)
  - [简介](#简介)
  - [免责声明](#免责声明)
  - [介绍](#介绍)
  - [使用方法](#使用方法)
    - [`daily` 环境](#daily-环境)
      - [类型](#类型)
      - [日期](#日期)
      - [难度](#难度)
      - [标题](#标题)
    - [字体](#字体)
    - [数学字体](#数学字体)
    - [宏包依赖](#宏包依赖)
    - [更新历史](#更新历史)

## 介绍

最早的一版用于中山大学数学学院「每日一题」计划排版的 LaTeX 模板由 Innocent 编写, 在 2023 年 10 月投入最初的使用. 2024 年 3 月, Panadol 重构了整个模板的代码, 现在代码托管在 [GitHub](https://github.com/Arcanadol/SYSUdaily) 上, 由 Innocent 和 Panadol 共同维护.

## 使用方法

### `daily` 环境

本项目是中山大学数学学院每日一题的模板, 使用方法为:

```latex
\begin{daily}[参数]
  正文
\end{daily}
```

方括号 `[]` 中的参数的顺序不影响结果. 参数列表如下:

#### 类型

仅需输入类型命名即可确定 `SYSUdaily` 的类型. 所有类型定义及颜色如下:

![1712425709735](https://github.com/Arcanadol/SYSUdaily/assets/104732548/932b4a42-7687-4caa-a0c7-03f4275ec12d)

类型未设置时, 默认为 `proposition`.

#### 日期

日期为8, 6, 4位整数: `20101225`, `101225`, `1225` 分别代表三种不同的日期输入风格.
日期未设置时, 默认为当天日期 `\today`:

```latex
\begin{daily}
  \today{}.
\end{daily}
```

![1712425677560](https://github.com/Arcanadol/SYSUdaily/assets/104732548/0a01bcc2-4680-4136-b2f2-6ef34994076e)

#### 难度

难度为1–4的整数, 否则不会识别为难度.

```latex
\begin{daily}[解析函数的刻画, theorem, 20101010, 4]
  ......
\end{daily}
```

![1712425731009](https://github.com/Arcanadol/SYSUdaily/assets/104732548/85354b78-5e47-4ea1-9629-4711a094170c)

难度未设置时, 默认为 `0`.

#### 标题

除去满足上面条件的参数, 其余参数均视为标题, 若识别到多个标题, 则以第一个为准.
若想要输入域时间, 难度, 类型重复的标题, 可以在使用 `\mbox{}` 解决:

```latex
\begin{daily}[\mbox{theorem}]
  正文
\end{daily}
```

![1712425740427](https://github.com/Arcanadol/SYSUdaily/assets/104732548/01e452bf-8209-46c9-8a49-cd3f462506f5)

标题未设置时, 默认为 `\relax`.

### 字体

`SYSUdaily.cls` 默认使用 fandol 字库, 因此不支持 pdfLaTeX, 同时,
在检测到存在时, 会调用 Resource Han Rounded 作为中文等宽字体.

当使用 `unimath=true` 预设时, 会使用方正新书宋, 方正粗雅宋, 华文楷体, 苹方黑体作为中文字体, 且使用 Minion Pro 作为西文字体, 这些字体均是商业字体.

### 数学字体

`SYSUdaily.cls` 默认使用以下宏包作为字体调用库:

- amsfonts
- amssymb
- mathrsfs
- dsfont
- eucal

当使用 `unimath=true` 预设时, 会使用 Minion Math 作为主要数学字体, 这款字体也是商业字体.

### 宏包依赖

在任何情况下, 文档类都会显式调用以下宏包或文档类:

- ctexart. 中文排版的通用框架;
- xcolor. 提供色彩支持, 默认按 `svgnames` 载入;
- amsmath, amsthm. 数学框架;
- fontspec. 调整字体, 因此不支持 pdfLaTeX;
- geometry. 用于调整页面尺寸;
- eucal. 调整手写数学字体样式;
- fixdif, mathtools. amsmath 的扩展;
- kvoptions. 设置关键词之用;
- graphicx. 提供图形插入的接口;
- enumitem. 设置列表环境格式.

`unimath=true` 预设会调用相关的字体宏包, 具体调用细节已在[此](#字体)中列出.

### 更新历史

**v2.0** (2024/03/20–2024/04/04)

- 应用 LaTeX3 重构代码;
- 添加 `unimath` 文档类选项;
- 将原来的 `theorem` 等环境简化为 `daily` 环境;
- 使用 l3seq 处理 `daily` 环境的可选参数, 利用更合理的判断机制实现输入上的简化;
- 去除随机图标.
