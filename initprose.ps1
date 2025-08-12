# initprose.ps1
# -----------------------------------------
# Asks prompts and creates a prose.sh post with frontmatter filled, ready to be edited. 
# -----------------------------------------
$today = Get-Date -Format "yyyy-MM-dd"
$title = Read-Host -Prompt "Enter the post title"
$description = Read-Host -Prompt "Enter the post description"
$image = "og.png" # Default image, can be changed later

$tagsInput = Read-Host -Prompt "Enter tags (comma separated)" 
$tagsArray = $tagsInput -replace '\s', '' | Where-Object { $_ } #strip spaces
$tagsLine = "tags: [" + ($tagsArray -join ', ') + "]"

$slug = Read-Host -Prompt "Enter slug (lowercase, hyphens, no extension)" # e.g. my-new-post
$filepath = "$slug.md"

$lines = @(
    "---" 
    "title: $title"
    "description: $description"
    "date: $today"
    $tagsLine
    "image: $image"
    "card: summary"
    "draft: true"
    "toc: false"
    "---"
    ""
    "Body content goes here..."
)

Set-Content -Path $filepath -Value $lines -Encoding utf8 # create the file with UTF-8 encoding

Write-Host "Post created: $filepath"
Write-Host "After editing, run: scp $slug.md prose.sh:/"
