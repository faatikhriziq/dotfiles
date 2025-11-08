-- utils/cord_lang.lua
local M = {}

local function basename(path)
  if not path or path == "" then
    return ""
  end
  return path:gsub("\\", "/"):gsub(".*/", "")
end

local function get_ext(fname)
  local ext = fname:match("^.+%.([^.]+)$")
  return ext and ext:lower() or nil
end

-- =====================================================
-- EKSTENSI → {Nama Bahasa, Ikon}
-- =====================================================
local lang_map = {
  -- Sistem & native
  c = { "C", "💧" },
  h = { "C Header", "📘" },
  cc = { "C++", "💠" },
  cpp = { "C++", "💠" },
  cxx = { "C++", "💠" },
  hh = { "C++ Header", "📘" },
  hpp = { "C++ Header", "📘" },
  objc = { "Objective-C", "🍏" },
  m = { "Objective-C / MATLAB", "🧪" },
  mm = { "Objective-C++", "🍏" },
  swift = { "Swift", "🦅" },
  rs = { "Rust", "🦀" },
  go = { "Go", "⚙️" },
  asm = { "Assembly", "🧱" },
  s = { "Assembly", "🧱" },
  nasm = { "NASM Assembly", "🧱" },
  cu = { "CUDA", "🎮" },
  cl = { "OpenCL C", "🧬" },

  -- JVM & .NET
  java = { "Java", "☕" },
  kt = { "Kotlin", "🧬" },
  groovy = { "Groovy", "🎶" },
  scala = { "Scala", "🟥" },
  cs = { "C#", "🎯" },
  fs = { "F#", "🌀" },
  vb = { "Visual Basic", "🪟" },

  -- Web stack
  js = { "JavaScript", "🟨" },
  jsx = { "React (JSX)", "⚛️" },
  ts = { "TypeScript", "🟦" },
  tsx = { "TypeScript (React)", "⚛️" },
  html = { "HTML", "🌐" },
  css = { "CSS", "🎨" },
  scss = { "SCSS", "💅" },
  less = { "Less", "🎨" },
  vue = { "Vue", "🟢" },
  svelte = { "Svelte", "🔥" },
  astro = { "Astro", "🪐" },
  solid = { "SolidJS", "💎" },

  -- Python family
  py = { "Python", "🐍" },
  pyw = { "Python (Windows GUI)", "🐍" },
  ipynb = { "Jupyter Notebook", "📓" },

  -- Ruby / PHP
  rb = { "Ruby", "💎" },
  erb = { "ERB Template", "🧩" },
  php = { "PHP", "🐘" },

  -- Data & markup
  md = { "Markdown", "📝" },
  mdx = { "MDX", "📝" },
  rst = { "reStructuredText", "📘" },
  tex = { "LaTeX", "📘" },
  bib = { "BibTeX", "📚" },
  xml = { "XML", "🧾" },
  json = { "JSON", "🧾" },
  yaml = { "YAML", "📜" },
  toml = { "TOML", "⚙️" },
  ini = { "INI", "⚙️" },
  csv = { "CSV", "📈" },
  tsv = { "TSV", "📊" },

  -- Shell & scripting
  sh = { "Shell", "🐚" },
  bash = { "Bash", "🐚" },
  zsh = { "Zsh", "🐚" },
  ps1 = { "PowerShell", "💻" },
  bat = { "Batch", "🪟" },
  cmd = { "CMD Script", "🪟" },

  -- Template engines
  ejs = { "EJS", "🧩" },
  pug = { "Pug", "🐶" },
  mustache = { "Mustache", "🎭" },
  hbs = { "Handlebars", "🪶" },
  twig = { "Twig", "🌿" },
  jinja = { "Jinja", "🔥" },

  -- DB / Schema
  sql = { "SQL", "🧮" },
  sqlite = { "SQLite", "🪶" },
  prisma = { "Prisma", "🔷" },
  gql = { "GraphQL", "🕸️" },
  proto = { "Protocol Buffers", "🔗" },

  -- Infra / DevOps
  hcl = { "HCL", "🏗️" },
  tf = { "Terraform", "🏗️" },
  tfvars = { "Terraform Vars", "📦" },
  nix = { "Nix", "❄️" },
  bzl = { "Bazel", "🧱" },
  cmake = { "CMake", "⚙️" },

  -- FP / Academic
  hs = { "Haskell", "λ" },
  ml = { "OCaml", "🐫" },
  elm = { "Elm", "🌿" },
  lisp = { "Lisp", "🌈" },
  rkt = { "Racket", "🎈" },
  ex = { "Elixir", "💧" },

  -- Miscellaneous
  lua = { "Lua", "🌙" },
  dart = { "Dart", "🎯" },
  zig = { "Zig", "⚡" },
  nim = { "Nim", "🐝" },
  cr = { "Crystal", "🔮" },
  d = { "D", "💎" },
  vhdl = { "VHDL", "🔌" },
  sv = { "SystemVerilog", "🔌" },
  wgsl = { "WGSL", "🎨" },
  hlsl = { "HLSL", "🎮" },
  glsl = { "GLSL", "🎮" },
  shader = { "Shader", "🎮" },
  txt = { "Text", "📄" },
  log = { "Log", "🧾" },
}

-- =====================================================
-- NAMA FILE KHUSUS → {Nama, Ikon}
-- =====================================================
local special_map = {
  ["Dockerfile"] = { "Dockerfile", "🐳" },
  ["docker-compose.yml"] = { "Docker Compose", "🐳" },
  [".dockerignore"] = { "Docker Ignore", "🚫" },
  ["Makefile"] = { "Makefile", "🧱" },
  ["CMakeLists.txt"] = { "CMake", "⚙️" },
  ["package.json"] = { "Node Manifest", "📦" },
  ["Cargo.toml"] = { "Cargo Manifest", "📦" },
  ["go.mod"] = { "Go Module", "⚙️" },
  ["Gemfile"] = { "Ruby Gemfile", "💎" },
  ["composer.json"] = { "Composer Manifest", "🎻" },
  ["requirements.txt"] = { "Python Requirements", "🐍" },
  [".env"] = { "Environment Config", "⚙️" },
  ["README.md"] = { "Markdown", "📘" },
  ["LICENSE"] = { "License", "📜" },
  [".gitignore"] = { "Git Ignore", "🚫" },
  [".editorconfig"] = { "EditorConfig", "🧭" },
}

-- =====================================================
-- FUNGSI
-- =====================================================
function M.get_language(filename)
  local name = basename(filename)
  if name ~= "" and special_map[name] then
    return special_map[name]
  end

  local ext = get_ext(name)
  if ext and lang_map[ext] then
    return lang_map[ext]
  end

  local ft = (vim and vim.bo and vim.bo.filetype) and tostring(vim.bo.filetype) or ""
  if ft ~= "" then
    local pretty = ft:gsub("_", " "):gsub("^%l", string.upper)
    return { pretty .. " (filetype)", "🧩" }
  end

  return { "Unknown", "❓" }
end

return M
