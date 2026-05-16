@echo off
REM ───────────────────────────────────────────────
REM  지혜의 창 자동 커밋/푸시 스크립트
REM  변경사항이 있을 때만 커밋하고 푸시함
REM ───────────────────────────────────────────────

cd /d "%~dp0"

REM 변경사항 확인
git diff --quiet --exit-code
set CHANGED1=%errorlevel%
git diff --cached --quiet --exit-code
set CHANGED2=%errorlevel%

REM 추적 안 된 파일도 확인
for /f %%i in ('git ls-files --others --exclude-standard') do set UNTRACKED=1

if "%CHANGED1%"=="0" if "%CHANGED2%"=="0" if not defined UNTRACKED (
    echo [%date% %time%] 변경사항 없음 >> auto-sync.log
    exit /b 0
)

REM 커밋 메시지에 시간 넣기
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set DT=%%I
set TIMESTAMP=%DT:~0,4%-%DT:~4,2%-%DT:~6,2% %DT:~8,2%:%DT:~10,2%

git add -A >> auto-sync.log 2>&1
git commit -m "자동 동기화 %TIMESTAMP%" >> auto-sync.log 2>&1
git push >> auto-sync.log 2>&1

if %errorlevel%==0 (
    echo [%TIMESTAMP%] 동기화 성공 >> auto-sync.log
) else (
    echo [%TIMESTAMP%] 동기화 실패 (errorlevel=%errorlevel%) >> auto-sync.log
)
