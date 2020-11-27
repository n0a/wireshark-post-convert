# Usefull-shell-scripts

## wsconv.sh
This script is designed to search from the exported wireshark POST objects and convert it to a format convenient for viewing.
Work tested on Linux and BSD systems and exclude specefic platform tools (tail -r on BSD, tac on Linux etc)

### How to use
Export wireshark objects and run shell script from export dir. 

![Export objects](https://i.imgur.com/gXULdCc.png)

#### Download
```sh
cd objects_export
wget https://raw.githubusercontent.com/n0a/usefull-shell-scripts/main/wsconv.sh && chmod +x wsconv.sh
./wsconv.sh
```
Check *found_files* dir for POST wireshark objects. Enjoy!

![Running result](https://i.imgur.com/DZd8PFR.png)
