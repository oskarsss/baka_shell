confirm() {
    # call with a prompt string or use a default
    read -r -p "${1:-Are you sure? [y/N]} " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            true
            ;;
	[nN][oO]|[nN]|'')
            false
            ;;
        *)
	echo "input yes or no"
	confirm
	;;

    esac
}

