REM Check if AWS CLI is installed
where aws > nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo AWS CLI not found. Please install the AWS CLI
    exit /b 1
)

docker build --progress=plain --no-cache -t local/glue_5 .