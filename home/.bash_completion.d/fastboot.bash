function _fastboot()
{
  local cur prev opts cmds c subcommand device_selected
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  opts="-w -s -p -c -i -b -n"
  cmds="update flashall flash erase getvar boot devices \
        reboot reboot-bootloader oem"
  subcommand=""
  partition_list="boot recovery system userdata"
  device_selected=""

  # Look for the subcommand.
  c=1
  while [ $c -lt $COMP_CWORD ]; do
    word="${COMP_WORDS[c]}"
    if [ "$word" = "-s" ]; then
      device_selected=true
    fi
    for cmd in $cmds; do
      if [ "$cmd" = "$word" ]; then
        subcommand="$word"
      fi
    done
    c=$((++c))
  done

  case "${subcommand}" in
    '')
      case "${prev}" in
        -s)
          # Use 'fastboot devices' to list serial numbers.
          COMPREPLY=( $(compgen -W "$(fastboot devices|cut -f1)" -- ${cur} ) )
          return 0
          ;;
      esac
      case "${cur}" in
        -*)
          COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
          return 0
          ;;
      esac
      if [ -z "$device_selected" ]; then
        local num_devices=$(( $(fastboot devices 2>/dev/null|wc -l) ))
        if [ "$num_devices" -gt "1" ]; then
          # With multiple devices, you must choose a device first.
          COMPREPLY=( $(compgen -W "-s" -- ${cur}) )
          return 0
        fi
      fi
      COMPREPLY=( $(compgen -W "${cmds}" -- ${cur}) )
      return 0
      ;;
    flash)
      # partition name
      COMPREPLY=( $(compgen -W "${partition_list}" -- ${cur}) )
      return 0
      ;;
    erase)
      # partition name
      COMPREPLY=( $(compgen -W "${partition_list}" -- ${cur}) )
      return 0
      ;;
  esac
}
complete -o default -F _fastboot fastboot
