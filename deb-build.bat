docker build -t eqemu_build . || exit /b
docker create --name build_result eqemu_build || exit /b
docker cp build_result:/build/bin ./build || exit /b
docker rm build_result || exit /b

scp -r build/ root@simplynorrath.com:/home/eqemu/server_build/bin || exit /b
ssh root@simplynorrath.com bash -c "su eqemu -c 'cd /home/eqemu/server && ./server_stop.sh && ./server_start_with_login.sh'" || exit /b
wsl --shutdown