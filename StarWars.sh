#!/usr/bin/env bash

THIS_DIR=$(cd $(dirname $0); pwd)
cd $THIS_DIR

install() {
	    cd tg
		sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
		sudo apt-get install g++-4.7 -y c++-4.7 -y
		sudo apt-get update
		sudo apt-get upgrade
		sudo apt-get install libreadline-dev -y libconfig-dev -y libssl-dev -y lua5.2 -y liblua5.2-dev -y lua-socket -y lua-sec -y lua-expat -y libevent-dev -y make unzip git redis-server autoconf g++ -y libjansson-dev -y libpython-dev -y expat libexpat1-dev -y
		sudo apt-get install screen -y
		sudo apt-get install tmux -y
		sudo apt-get install libstdc++6 -y
		sudo apt-get install lua-lgi -y
		sudo apt-get install libnotify-dev -y
		wget https://valtman.name/files/telegram-cli-1222
		mv telegram-cli-1222 tgcli
		chmod +x tgcli
		cd ..
		chmod +x bot
		chmod +x tg
		chmod +x autobd.sh
}

function print_logo() {
	green " "
	green "__        ___    ____  ____ _____ _____    _    __  __
\ \      / / \  |  _ \/ ___|_   _| ____|  / \  |  \/  |
 \ \ /\ / / _ \ | |_) \___ \ | | |  _|   / _ \ | |\/| |
  \ V  V / ___ \|  _ < ___) || | | |___ / ___ \| |  | |
   \_/\_/_/   \_\_| \_\____/ |_| |_____/_/   \_\_|  |_|"
	green " "
	green " "
	echo -e "\n\e[0m"
}

function logo_play() {
    declare -A txtlogo
    seconds="0.010"
    txtlogo[1]=" "
    txtlogo[2]="
__        ___   ____   ____ _____ _____    _    __  __
\ \      / / \  |  _ \/ ___|_   _| ____|  / \  |  \/  |
 \ \ /\ / / _ \ | |_) \___ \ | | |  _|   / _ \ | |\/| |
  \ V  V / ___ \|  _ < ___) || | | |___ / ___ \| |  | |
   \_/\_/_/   \_\_| \_\____/ |_| |_____/_/   \_\_|  |_|"
    txtlogo[3]=" "
    txtlogo[4]=" "
    printf "\e[31m\t"
    for i in ${!txtlogo[@]}; do
        for x in `seq 0 ${#txtlogo[$i]}`; do
            printf "${txtlogo[$i]:$x:1}"
            sleep $seconds
        done
        printf "\n\t"
    done
    printf "\n"
	echo -e "\e[0m"
}

function th3boss() {
	echo -e "\e[0m"
	  red "     >>>>                        We Are Not Attacker                             "
    green "     >>>>                            We Are Not Alliance                             "
	white "     >>>>                        We Are Programmer                               "
	white "     >>>>                        We Are The Best                                 "
	  red "     >>>>                        We Are Family                                   "
	  red "     >>>>                        Ch :- @WarsTeam                                "
	echo -e "\e[0m"
}

red() {
  printf '\e[1;31m%s\n\e[0;39;49m' "$@"
}
green() {
  printf '\e[1;32m%s\n\e[0;39;49m' "$@"
}
white() {
  printf '\e[1;37m%s\n\e[0;39;49m' "$@"
}
update() {
	git pull
}

if [ "$1" = "install" ]; then
	print_logo
	th3boss
	logo_play
	install
  else
if [ ! -f ./tg/tgcli ]; then
    echo "tg not found"
    echo "Run $0 install"
    exit 1
 fi
	print_logo
	StarWars
	logo_play
   #sudo service redis-server restart
   ./tg/tgcli -s ./bot/bot.lua -l 1 -E $@
   #./tg/tgcli -s ./bot/bot.lua $@
fi
