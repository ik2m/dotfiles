# コメントの方針

**コードを読めばわかることはコメントに書かない。**

コメントは「コードから読み取れないこと」だけを書く。具体的には、なぜその実装を選んだのか、
なぜ単純な書き方ではダメなのか、外部仕様やデータ由来の制約、ハマりどころなど。

迷ったら「このコメントを消して困る人がいるか」で判断する。困らないなら消す。

---

# パッケージマネージャー

新規で Node.js プロジェクトを作る場合は pnpm を使うこと。

既存のプロジェクトでは、lockfile (`package-lock.json` / `yarn.lock` / `pnpm-lock.yaml`) に合わせたものを使う。

---

# ツールチェーン

新規で JavaScript / TypeScript プロジェクトを立ち上げる場合:

- lint は oxlint、format は oxfmt を優先的に提案する (ESLint / Prettier より優先)
- 可能であれば Vite+ (vite plus) も優先的に提案する

既存のプロジェクトでは、導入済みのツールに合わせる。

---

# Chrome DevTools MCP

WSL では、chrome-devtools MCP を使う前に `start-chrome-debug` を実行して Windows 側の
Chrome をリモートデバッグ付きで起動しておく。起動していないと MCP が接続できない。

---

# マシン固有の指示

@~/.claude/CLAUDE.local.md
