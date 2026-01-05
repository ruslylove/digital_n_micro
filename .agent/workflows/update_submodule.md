---
description: Update the git submodule to the latest remote version and sync public folder
---
1. Update the submodule
// turbo
2. git submodule update --remote --merge

3. Sync public folder
// turbo
4. rsync -av common/public/ public/
