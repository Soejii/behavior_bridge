# 1. Build Flutter web
Write-Host "Building Flutter web..."
flutter build web --release

# 2. Remove old docs folder if it exists
Write-Host "Cleaning old docs folder..."
if (Test-Path docs) {
    Remove-Item docs -Recurse -Force
}

# 3. Recreate docs folder
Write-Host "Creating docs folder..."
New-Item docs -ItemType Directory | Out-Null

# 4. Copy new web build into docs
Write-Host "Copying files..."
Copy-Item "build\web\*" "docs\" -Recurse -Force

# 5. SPA fallback (recommended for Netlify/GitHub Pages)
Write-Host "Setting up 404 fallback..."
Copy-Item "docs\index.html" "docs\404.html" -Force

Write-Host "Done! The 'docs' folder is ready for deployment."
# Uncomment the lines below if you want to automatically commit and push to GitHub Pages
# git add docs/
# git commit -m "chore: update web build in docs"
# git push
