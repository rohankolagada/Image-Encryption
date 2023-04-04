#! /bin/env bash
      
# this script enables user to interactives encrypt or decrypt a image using rofi as the gui driver utility
# although rofi is not a pure gui utility, it neatly fits our need so we used it for our convinience

#function retrieves user input and then feeds the calling variable with it
user_input() {
  killall rofi &>/dev/null; # killing all the rofi instances to avoid colliding
  #call to rofi ( a gui menu widget )
  rofi -dmenu\
		-i\
		-no-fixed-num-lines\
		-p "$1"\
		-theme ./confirm.rasi
}

# Message
# Provides the given message in a nice little box to the user
msg() {
	rofi -theme "./message.rasi" -e "$1"
}
#
# Driver function

main(){
	ans=$(user_input "Select 1.Encrypt 2.Decrypt ->" &)
  if [[ $ans == "1" || $ans == "1 Encrypt" || $ans == "encrypt" || $ans == "Encrypt" ]]; then
    source_path=$(user_input "Enter input file path->");
    destination_path=$(user_input "Enter output file name(with extension)->");
    message=$(user_input "Enter the message to encode ->");
    res=$(./encode.py "$source_path" "$PWD/$destination_path" "$message");
    pwait ./encode.py ;
    if [[ $res == "" ]]
    then 
      res="Failed to encode, Please provide valid path"
    fi
    msg "$res";
  elif [[ $ans == "2" || $ans == "2 Decrypt" || $ans == "decrypt" || $ans == "Decrypt" ]]; then
    source_path=$(user_input "Enter the source path ->");
    res=$(./decode.py $source_path);
    if [[ $res == "" ]]
    then 
      res="Failed to decode, Please provide valid path"
    fi
    msg "$res";
  else
    msg "Available options- encode/1/ or decode/2/"
	fi
}
main
