@ECHO OFF

set CURRENT_DIR=%cd%

set FILENAME=%0

if "%ENV_NAME%" == "" (set ENVNAME=my_env) else (set ENVNAME=%ENV_NAME%)

if "%1" == "" (
	call :Usage
	goto end
)

if "%1" == "create_env" (
	call :CreateEnv
	goto end
)

if "%1" == "start_env" (
	call :StartEnv
	goto end
)

if "%1" == "stop_env" (
	call :StopEnv
	goto end
)

if "%1" == "remove_env" (
	call :RemoveEnv
	goto end
)

if "%1" == "run_env" (
	call :RunEnv
	goto end
)

:Usage
echo Usage: %FILENAME% [commands] [-]
echo Commands:
echo    run_env       Create and start the evnvironment container
echo    create_env    Create the environment container
echo    start_env     Start the environment container
echo    stop_env      Stop the the environment container already started
echo    remove_env    Remove the environment container
echo %ENVNAME%
EXIT /B 0

:CreateEnv
docker create -it --name %ENVNAME% --mount type=bind,source=%CURRENT_DIR%,target=/root/env lhel/myenv
EXIT /B 0

:StartEnv
docker start -i %ENVNAME%
EXIT /B 0

:StopEnv
docker stop %ENVNAME%
EXIT /B 0

:RemoveEnv
docker rm -f %ENVNAME%
EXIT /B 0

:RemoveEnv
docker rm -f %ENVNAME%
EXIT /B 0

:RunEnv
docker run -it --rm --name %ENVNAME% --mount type=bind,source=%CURRENT_DIR%,target=/root/env lhel/myenv
EXIT /B 0

:end
