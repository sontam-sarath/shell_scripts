
#!/bin/bash

:<<'FILE_INFO'
Title: 	Global log file
----------------------------------------------
Author: Sarath Sontam
Date: 	2024-12-10
----------------------------------------------
FILE_INFO

log_message(){

	if [[ ! -f log_file ]]
	then
		sudo touch log_file
		sudo chmod 777 log_file
	fi
	local message="$1"
	echo "$(date +'%Y-%m-%d %H:%M:%S') - $message" >> log_file
}

#log_message "log message"
