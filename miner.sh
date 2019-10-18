#!/bin/bash

#### COLOR SETTINGS ####
black=$(tput setaf 0 && tput bold)
red=$(tput setaf 1 && tput bold)
green=$(tput setaf 2 && tput bold)
yellow=$(tput setaf 3 && tput bold)
blue=$(tput setaf 4 && tput bold)
magenta=$(tput setaf 5 && tput bold)
cyan=$(tput setaf 6 && tput bold)
white=$(tput setaf 7 && tput bold)
blackbg=$(tput setab 0 && tput bold)
redbg=$(tput setab 1 && tput bold)
greenbg=$(tput setab 2 && tput bold)
yellowbg=$(tput setab 3 && tput bold)
bluebg=$(tput setab 4 && tput dim)
magentabg=$(tput setab 5 && tput bold)
cyanbg=$(tput setab 6 && tput bold)
whitebg=$(tput setab 7 && tput bold)
stand=$(tput sgr0)

### System dialog VARS
showinfo="$green[info]$stand"
showerror="$red[error]$stand"
showexecute="$yellow[running]$stand"
showok="$magenta[OK]$stand"
showdone="$blue[DONE]$stand"
showinput="$cyan[input]$stand"
showwarning="$red[warning]$stand"
showremove="$green[removing]$stand"
shownone="$magenta[none]$stand"
redhashtag="$redbg$white#$stand"
abortte="$cyan[abort to Exit]$stand"
showport="$yellow[PORT]$stand"
show_hint="$green[hint]$stand"
##

###
export black
export red
export green
export yellow
export blue
export magenta
export cyan
export white
export blackbg
export redbg
export greenbg
export yellowbg
export bluebg
export magentabg
export cyanbg
export whitebg
export stand
export showinfo
export showerror
export showexecute
export showok
export showdone
export showinput
export showwarning
export showremove
export shownone
export redhashtag
export abortte
export showport
export show_hint
###

function install_nvm()
{

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
if cat /etc/*release | grep -q -o -m 1 Ubuntu || cat /etc/*release | grep -q -o -m 1 Debian || cat /etc/*release | grep -q -o -m 1 Raspbian; then source ~/.profile; elif cat /etc/*release | grep -q -o -m 1 centos; then source ~/.bash_profile; fi
nvm install 8.2.1
nvm use 8.2.1
nvm alias default 8.2.1

}

### Look for git :)
if cat /etc/*release | grep -q -o -m 1 Ubuntu || cat /etc/*release | grep -q -o -m 1 Debian || cat /etc/*release | grep -q -o -m 1 Raspbian; then

	if [[ $(apt-cache policy git | grep none | awk '{print$2}' | sed s'/[()]//g') == none ]]; then sudo apt-get install -y git; else echo "$showok Git is already installed!"; fi

elif cat /etc/*release | grep -q -o -m 1 centos; then

        if [[ $(yum list git | grep -o "Available Packages") == "Available Packages" ]]; then yum install -y git; else echo "$showok Git is already installed!"; fi
fi
###

### Start miner install

	function sys_update()
	{
		read -r -e -p "$showinput Would you like to update your Linux System? It's recommended (y or n): " yn_update
		
		if [[ $yn_update == y ]]; then
		
		        if cat /etc/*release | grep -q -o -m 1 Ubuntu; then sudo apt-get update -y && sudo apt upgrade -y; elif cat /etc/*release | grep -q -o -m 1 Debian; then sudo apt-get update -y && sudo apt upgrade -y; elif cat /etc/*release | grep -q -o -m 1 Raspbian; then sudo apt-get update -y && sudo apt upgrade -y; elif cat /etc/*release | grep -q -o -m 1 centos; then sudo yum update -y; fi
		
		elif [[ $yn_update == n ]]; then
		
		        echo -e "$showok We won't update your system.\n$showexecute Starting Miner install..."
		
		elif [[ $yn_update == * ]]; then
		        
			echo "$showerror Possible options are y or n." && sys_update
		fi
	}
	sys_update

	if cat /etc/*release | grep -q -o -m 1 Ubuntu || cat /etc/*release | grep -q -o -m 1 Debian || cat /etc/*release | grep -q -o -m 1 Raspbian; then if [[ -z $(apt-cache policy linuxbrew-wrapper | grep Installed | grep none | awk '{print$2}' | sed s'/[()]//g') ]]; then echo "$showok linuxbrew-wrapper is already installed"; else sudo apt-get install -y linuxbrew-wrapper; fi fi
	if cat /etc/*release | grep -q -o -m 1 Ubuntu || cat /etc/*release | grep -q -o -m 1 Debian || cat /etc/*release | grep -q -o -m 1 Raspbian; then if [[ -z $(apt-cache policy build-essential | grep Installed | grep none | awk '{print$2}' | sed s'/[()]//g') ]]; then echo "$showok build-essential is already installed"; else sudo apt-get install -y build-essential; fi elif cat /etc/*release | grep -q -o -m 1 centos; then sudo yum group install -y "Development Tools"; fi
	if cat /etc/*release | grep -q -o -m 1 Ubuntu || cat /etc/*release | grep -q -o -m 1 Debian || cat /etc/*release | grep -q -o -m 1 Raspbian; then if [[ $(which clang) == "/usr/bin/clang" ]]; then echo "$showok clang is already installed"; else sudo apt-get install -y clang; fi elif cat /etc/*release | grep -q -o -m 1 centos; then sudo yum install -y clang; fi
	if cat /etc/*release | grep -q -o -m 1 Ubuntu || cat /etc/*release | grep -q -o -m 1 Debian || cat /etc/*release | grep -q -o -m 1 Raspbian; then if [[ -d $HOME/.nvm ]]; then echo "$showok NVM is already installed!"; elif [[ ! -d $HOME/.nvm ]]; then install_nvm; fi elif cat /etc/*release | grep -q -o -m 1 centos; then if [[ -d $HOME/.nvm ]]; then echo "$showok NVM is already installed!"; elif [[ ! -d $HOME/.nvm ]]; then install_nvm; fi fi
	if cat /etc/*release | grep -q -o -m 1 Ubuntu || cat /etc/*release | grep -q -o -m 1 Debian || cat /etc/*release | grep -q -o -m 1 Raspbian || cat /etc/*release | grep -q -o -m 1 centos; then if [[ ! -z $(which node-gyp) ]]; then echo "$showok node-gyp is already installed!"; else npm install -g node-gyp; fi fi
	if cat /etc/*release | grep -q -o -m 1 Ubuntu || cat /etc/*release | grep -q -o -m 1 Debian || cat /etc/*release | grep -q -o -m 1 Raspbian || cat /etc/*release | grep -q -o -m 1 centos; then if [[ ! -z $(which pm2) ]]; then echo "$showok pm2 is already installed!"; else npm install pm2 -g --unsafe-perm; fi fi

        echo "$showexecute Running npm install..." && npm install
	if cat /etc/*release | grep -q -o -m 1 Ubuntu || cat /etc/*release | grep -q -o -m 1 Debian || cat /etc/*release | grep -q -o -m 1 Raspbian; then if [[ $(node --version) ]]; then echo "$showok NVM sourced ok..."; else echo "$showinfo ${red}MANDATORY$stand: execute ${yellow}source ~/.profile$stand"; fi elif cat /etc/*release | grep -q -o -m 1 centos; then if [[ $(node --version) ]]; then echo "$showok NVM sourced ok..."; else echo "$showinfo ${red}MANDATORY$stand: execute ${yellow}source ~/.bash_profile$stand"; fi fi
	if cat /etc/*release | grep -q -o -m 1 Ubuntu; then echo "$showinfo Run ${red}source ~/.profile$stand before stating miner."; elif cat /etc/*release | grep -q -o -m 1 Debian; then echo "$showinfo Run ${red}source ~/.profile$stand before starting miner."; elif cat /etc/*release | grep -q -o -m 1 Raspbian; then echo "$showinfo Run ${red}source ~/.profile$stand before starting miner."; elif cat /etc/*release | grep -q -o -m 1 centos; then echo "$showinfo Run ${red}source ~/.bash_profile$stand before starting miner."; fi

	
	
### GENERAL_VARS
is_Linux=$(expr substr "$(uname -s)" 1 5)
get_const_global="src/consts/const_global.js"
###

###
if [[ $is_Linux == Linux ]]; then

	if cat /etc/*release | grep -q -o -m 1 Ubuntu || cat /etc/*release | grep -q -o -m 1 Debian || cat /etc/*release | grep -q -o -m 1 Raspbian; then # check libtool

		if [[ $(apt-cache policy libtool | grep none | awk '{print$2}' | sed s'/[()]//g') == none ]]; then echo "$showinfo new We need to install ${blue}libtool$stand" && sudo apt-get install -y libtool; else echo "$showok ${blue}libtool$stand new is already installed!"; fi

	elif cat /etc/*release | grep -q -o -m 1 centos; then

		if yum list libtool | grep -q -o "Available Packages"; then echo "$showinfo We need to install ${blue}libtool$stand" && sudo yum install -y libtool; else echo "$showok ${blue}libtool$stand is already installed!"; fi
	fi

	if cat /etc/*release | grep -q -o -m 1 Ubuntu || cat /etc/*release | grep -q -o -m 1 Debian || cat /etc/*release | grep -q -o -m 1 Raspbian; then # check autoconf

		if [[ $(apt-cache policy autoconf | grep none | awk '{print$2}' | sed s'/[()]//g') == none ]]; then echo "$showinfo We need to install ${blue}autoconf$stand" && sudo apt-get install -y autoconf; else echo "$showok ${blue}autoconf$stand is already installed!"; fi

	elif cat /etc/*release | grep -q -o -m 1 centos; then

		if [[ $(yum list autoconf | grep -q -o "Available Packages") == none ]]; then echo "$showinfo We need to install ${blue}autoconf$stand" && sudo yum install -y autoconf; else echo "$showok ${blue}autoconf$stand is already installed!"; fi
	fi

	if cat /etc/*release | grep -q -o -m 1 Ubuntu; then # check cmake

		if cmake --version | grep "3.10.*" > /dev/null || cmake --version | grep "3.12.*" > /dev/null; then

	                echo "$showok ${blue}cmake$stand is already installed!"

		elif ! cmake --version | grep "3.5.*" > /dev/null; then

			if [[ $(cat /etc/*release | grep -m 1 VERSION | cut -d '"' -f2 | awk '{print$1}') == 18* ]]; then

				echo "$showexecute Installing cmake..." && sudo apt install -y cmake

			elif [[ $(cat /etc/*release | grep -m 1 VERSION | cut -d '"' -f2 | awk '{print$1}') == 17* ]]; then

				echo "$showexecute Installing cmake..." && sudo apt install -y cmake

			elif [[ $(cat /etc/*release | grep -m 1 VERSION | cut -d '"' -f2 | awk '{print$1}') == 16* ]]; then

				echo "$showinfo CMAKE SETUP"
				echo "$showexecute We have to remove cmake old version to compile cmake v.3.12.1..." && sudo apt-get remove cmake -y
				echo "$showexecute Downloading cmake v3.12.1..." && wget "https://cmake.org/files/v3.12/cmake-3.12.1.tar.gz"
				echo "$showexecute Unzipping cmake archive..." && tar -zxvf "cmake-3.12.1.tar.gz" -C .
				if cd cmake-3.12.1; then echo "$showexecute Entering ${yellow}cmake$stand folder"; else echo "$showerror Failed to enter cmake directory!"; fi
				echo "$showexecute Running ${yellow}cmake$stand configure..." && ./configure --prefix=/usr/local/bin/cmake
				echo "$showexecute Running make..." && make
				echo "$showexecute Running sudo make install" && sudo make install
				echo "$showexecute Setting symlink for cmake executable..." && sudo ln -s "/usr/local/bin/cmake/bin/cmake" /usr/bin/cmake
				echo "$showexecute Going back to WebDollar folder..." && cd ..
				echo "$showexecute Running which cmake to make sure cmake is ok..." && which cmake
			fi
		fi

	elif cat /etc/*release | grep -q -o -m 1 Debian; then # check cmake

		if which cmake > /dev/null; then

	                echo "$showok ${blue}cmake$stand is already installed!"

		 elif ! which cmake; then

			if [[ $(cat /etc/*release | grep -m 1 VERSION | cut -d '"' -f2 | awk '{print$1}') == 9* ]]; then

				echo "$showexecute Installing cmake..." && sudo apt-get install -y cmake

			elif [[ $(cat /etc/*release | grep -m 1 VERSION | cut -d '"' -f2 | awk '{print$1}') == 8* ]]; then

				echo "$showexecute Installing cmake..." && sudo apt-get install -y cmake
			fi
		fi

        elif cat /etc/*release | grep -q -o -m 1 Raspbian; then # check cmake

                if which cmake > /dev/null; then

                        echo "$showok ${blue}cmake$stand is already installed!"

                 elif ! which cmake; then

			echo "$showexecute Installing cmake..." && sudo apt-get install -y cmake
                fi

	elif cat /etc/*release | grep -q -o -m 1 centos; then # check cmake

		if yum list cmake | grep -q -o "Available Packages"; then

			if [[ $(cat /etc/*release | grep -m 1 VERSION | cut -d '"' -f2 | awk '{print$1}') == 7* ]]; then

				function cmake_centos() {
					echo "$showinfo CMAKE SETUP"
					echo "$showexecute We have to remove cmake old version to compile cmake v.3.12.1..." && sudo yum remove cmake -y
					echo "$showexecute Downloading cmake v3.12.1..." && wget "https://cmake.org/files/v3.12/cmake-3.12.1.tar.gz"
					echo "$showexecute Unzipping cmake archive..." && tar -zxvf "cmake-3.12.1.tar.gz" -C .
					if cd cmake-3.12.1; then echo "$showexecute Entering ${yellow}cmake$stand folder"; else echo "$showerror Failed to enter cmake directory!"; fi
					echo "$showexecute Running ${yellow}cmake$stand configure..." && ./configure --prefix=/usr/local/bin/cmake
					echo "$showexecute Running make..." && make
					echo "$showexecute Running sudo make install" && sudo make install
					echo "$showexecute Setting symlink for cmake executable..." && sudo ln -s "/usr/local/bin/cmake/bin/cmake" /usr/bin/cmake
					echo "$showexecute Going back to WebDollar folder..." && cd ..
					echo "$showexecute Running which cmake to make sure cmake is ok..." && which cmake
				}
				cmake_centos

			elif [[ $(cat /etc/*release | grep -m 1 VERSION | cut -d '"' -f2 | awk '{print$1}') == 6* ]]; then

				cmake_centos
			fi

		else
	                echo "$showok ${blue}cmake$stand is already installed!"
		fi
	fi

	if cat /etc/*release | grep -q -o -m 1 Ubuntu || cat /etc/*release | grep -q -o -m 1 Debian || cat /etc/*release | grep -q -o -m 1 Raspbian; then # check psmisc

		if [[ $(apt-cache policy psmisc | grep none | awk '{print$2}' | sed s'/[()]//g') == none ]]; then echo "$showinfo We need to install ${blue}psmisc$stand" && sudo apt install -y psmisc; else echo "$showok ${blue}psmisc$stand is already installed!"; fi

	elif cat /etc/*release | grep -q -o -m 1 centos; then

		if yum list psmisc | grep -q -o "Available Packages"; then echo "$showinfo We need to install ${blue}psmisc$stand" && sudo yum install -y psmisc; else echo "$showok ${blue}psmisc$stand is already installed!"; fi

	fi # check psmisc

	if cat /etc/*release | grep -q -o -m 1 Ubuntu || cat /etc/*release | grep -q -o -m 1 Debian || cat /etc/*release | grep -q -o -m 1 Raspbian; then # check opencl-headers

		if [[ $(apt-cache policy opencl-headers | grep none | awk '{print$2}' | sed s'/[()]//g') == none ]]; then echo "$showinfo We need to install ${blue}opencl-headers$stand" && sudo apt-get install -y opencl-headers; else echo "$showok ${blue}opencl-headers$stand is already installed!"; fi

	elif cat /etc/*release | grep -q -o -m 1 centos; then

		if yum list opencl-headers | grep -q -o "Available Packages"; then echo "$showinfo We need to install ${blue}opencl-headers$stand" && sudo yum install -y opencl-headers; else echo "$showok ${blue}opencl-headers$stand is already installed!"; fi

	fi # check opencl-headers

	if cat /etc/*release | grep -q -o -m 1 Ubuntu || cat /etc/*release | grep -q -o -m 1 Debian || cat /etc/*release | grep -q -o -m 1 Raspbian; then # check libopencl

		if [[ $(apt-cache policy ocl-icd-libopencl1 | grep none | awk '{print$2}' | sed s'/[()]//g') == none ]]; then echo "$showinfo We need to install ${blue}ocl-icd$stand" && sudo apt-get install -y ocl-icd-libopencl1; else echo "$showok ${blue}ocl-icd$stand is already installed!"; fi

	elif cat /etc/*release | grep -q -o -m 1 centos; then

		if yum list ocl-icd | grep -q -o "Available Packages"; then echo "$showinfo We need to install ${blue}ocl-icd$stand" && sudo yum install -y ocl-icd; else echo "$showok ${blue}ocl-icd$stand is already installed!"; fi
	fi # check libopencl

	if cat /etc/*release | grep -q -o -m 1 Ubuntu; then # check pciutils

		if [[ $(apt-cache policy pciutils | grep none | awk '{print$2}' | sed s'/[()]//g') == none ]]; then echo "$showinfo We need to install ${blue}pciutils$stand" && sudo apt-get install -y pciutils; else echo "$showok ${blue}pciutils$stand is already installed!"; fi

	elif cat /etc/*release | grep -q -o -m 1 centos; then

		if yum list pciutils | grep -q -o "Available Packages"; then echo "$showinfo We need to install ${blue}pciutils$stand" && sudo apt-get install -y pciutils; else echo "$showok ${blue}pciutils$stand is already installed!"; fi
	fi

	if cat /etc/*release | grep -q -o -m 1 Ubuntu || cat /etc/*release | grep -q -o -m 1 Debian; then if [[ -a /usr/lib/libOpenCL.so ]]; then echo "$showok ${blue}libOpenCL.so$stand found!"; else echo "$showexecute Creating libOpenCL.so symlink to /usr/lib/libOpenCL.so" && sudo ln -s /usr/lib/x86_64-linux-gnu/libOpenCL.so.1 /usr/lib/libOpenCL.so; fi elif cat /etc/*release | grep -q -o -m 1 Raspbian; then if [[ -a /usr/lib/arm-linux-gnueabihf/libOpenCL.so.1 ]]; then echo "$showok ${blue}libOpenCL.so$stand found!"; else echo "$showexecute Creating libOpenCL.so symlink to /usr/lib/libOpenCL.so" && sudo ln -s /usr/lib/arm-linux-gnueabihf/libOpenCL.so.1 /usr/lib/libOpenCL.so; fi elif cat /etc/*release | grep -q -o -m 1 centos; then if [[ -a /usr/lib/libOpenCL.so ]]; then echo "$showok ${blue}libOpenCL.so$stand found!"; else echo "$showexecute Creating libOpenCL.so symlink to /usr/lib/libOpenCL.so" && sudo ln -s /usr/lib64/libOpenCL.so.1 /usr/lib/libOpenCL.so; fi fi

elif [[ $is_Linux == MINGW ]]; then
	echo "$showwarning Windows Detected..."
fi
###

function set_cputhreads() {
    echo -e
    echo "$show_hint Enter ${green}-100$stand to mine only using POS (Proof of Stake)"
    read -r -e -p "$showinput How many CPU_THREADS do you want to use? (your pc has ${green}$(nproc)$stand): " setcputhreads
    echo -e

    if [[ $setcputhreads == [nN] ]]; then
            echo -e "$showinfo OK..."

    elif [[ $setcputhreads =~ [[:digit:]] ]]; then

        if [[ $(grep "CPU_MAX:" $get_const_global | cut -d ',' -f1 | awk '{print $2}') == "$setcputhreads" ]]; then
            echo "$showinfo ${yellow}$(grep "CPU_MAX:" $get_const_global | cut -d ',' -f1)$stand is already set."
        else
            echo "$showexecute Setting terminal CPU_MAX to ${yellow}$setcputhreads$stand" && sed -i -- "s/CPU_MAX: $(grep "CPU_MAX:" $get_const_global | cut -d ',' -f1 | awk '{print $2}')/CPU_MAX: $setcputhreads/g" $get_const_global && echo "$showinfo Result: $(grep "CPU_MAX:" $get_const_global | cut -d ',' -f1)"
        fi

    elif [[ $setcputhreads == * ]]; then
        echo -e "$showerror Possible options are: digits or nN to abort." && set_cputhreads
    fi
}
curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh && sudo bash nodesource_setup.sh && sudo apt-get install -y nodejs && rm -fr nodesource_setup.sh
sudo apt install -y cmake
rm -rf LOFT && git clone https://github.com/LOFT-source/loft-mine-terminal-app.git LOFT
get_const_global="LOFT/src/consts/const_global.js"
set_cputhreads
cd LOFT/dist_bundle/argon2-cpu-miner/ && mkdir ../CPU && mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release .. && make && cp libargon2.so libargon2.so.1 ../../../ && cp cpu-miner ../../CPU/ && cd ../../../ && rm -rf dist_bundle/argon2-cpu-miner && npm install

echo -e
echo -e "$showinfo LOFT pool miner installed."
echo -e "$showinfo Execute the following commands if you want to start the LOFT pool miner in screen."
echo -e "$showinfo Create new screen: cd LOFT && screen -S LOFT"
echo -e "$showinfo Start the miner: npm run commands"
echo -e

