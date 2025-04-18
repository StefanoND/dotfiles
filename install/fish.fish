#!/usr/bin/env fish

nvm install latest && sync
npm i -g all-the-package-names && sync
npm i -g npm@latest && sync
npm i --package-lock-only && sync
npm audit fix && sync

# NPM
set -l PKGTS \
    'bash-language-server' \
    '@tailwindcss/language-server' \
    'typescript' \
    'typescript-language-server' \
    'eslint-lsp' \
    '@fsouza/prettierd' \
    'yarn' \
    '@vscode/vsce' \
    'fish-lsp'
set PKGTS $PKGTS


for pkg in $PKGTS
    echo && echo "INSTALLING: $pkg" && echo
    npm i -g $pkg && sync
end

npm audit fix && sync
