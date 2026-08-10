param(
    [string]$ProjectPath = 'call-my-ai-worker',
    [string]$Target,
    [int]$Port = 22,
    [string]$RemoteBase = '/data/single-website',
    [string]$ProjectName = '',
    [switch]$SkipBuild
)

$ErrorActionPreference = 'Stop'

if (-not $Target) {
    Write-Host '错误: 缺少 -Target 参数，例如 -Target root@1.2.3.4' -ForegroundColor Red
    exit 1
}

$projectDir = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot $ProjectPath))

if (-not (Test-Path -LiteralPath $projectDir)) {
    Write-Host "错误: 项目目录不存在: $projectDir" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path -LiteralPath (Join-Path $projectDir 'package.json'))) {
    Write-Host "错误: 项目目录中没有 package.json: $projectDir" -ForegroundColor Red
    exit 1
}

if (-not $ProjectName) {
    $ProjectName = Split-Path -Leaf $projectDir
}

$distDir = Join-Path $projectDir 'dist'
$remoteDir = "$RemoteBase/$ProjectName"

Write-Host "==> 项目: $ProjectName" -ForegroundColor Cyan
Write-Host "==> 目标: $Target`:$remoteDir" -ForegroundColor Cyan

if (-not $SkipBuild) {
    Write-Host '==> 执行 npm run build ...' -ForegroundColor Yellow
    Push-Location $projectDir
    try {
        npm run build
        if ($LASTEXITCODE -ne 0) {
            Write-Host '错误: 构建失败' -ForegroundColor Red
            exit 1
        }
    }
    finally {
        Pop-Location
    }
}

if (-not (Test-Path -LiteralPath $distDir)) {
    Write-Host "错误: dist 目录不存在，请先构建: $distDir" -ForegroundColor Red
    exit 1
}

Write-Host '==> 创建并清空远程目录 ...' -ForegroundColor Yellow
ssh -p $Port $Target "mkdir -p '$remoteDir' && rm -rf '$remoteDir'/*"
if ($LASTEXITCODE -ne 0) {
    Write-Host '错误: 远程目录处理失败' -ForegroundColor Red
    exit 1
}

Write-Host '==> 推送 dist 到远程 ...' -ForegroundColor Yellow
scp -P $Port -r "$distDir/*" "$Target`:$remoteDir/"
if ($LASTEXITCODE -ne 0) {
    Write-Host '错误: 推送失败' -ForegroundColor Red
    exit 1
}

Write-Host "==> 部署完成: $Target`:$remoteDir" -ForegroundColor Green
