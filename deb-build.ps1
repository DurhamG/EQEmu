docker build -t eqemu_debian . ; if (-not $?) { exit $LastExitCode  }
docker rm build_result
docker run --workdir /source/ --name build_result eqemu_debian /bin/bash ./deb-build.sh ; if (-not $?) { exit $LastExitCode  }
Start-Process powershell -Verb RunAs "cd $(Get-Location); docker cp build_result:/source/deb-build ./" ; if (-not $?) { exit $LastExitCode  }
docker rm build_result ; if (-not $?) { exit $LastExitCode  }

scp -r deb-build/bin/ root@simplynorrath.com:/home/eqemu/server_build/temp ; if (-not $?) { exit $LastExitCode  }
ssh root@simplynorrath.com "chown -R eqemu:eqemu /home/eqemu/server_build/temp && chmod -R a+x /home/eqemu/server_build/temp/ && mv -f /home/eqemu/server_build/temp/bin/* /home/eqemu/server_build/bin/ && su eqemu -c 'cd /home/eqemu/server && ./stop.sh && ./start_with_login.sh'"