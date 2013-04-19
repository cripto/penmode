#!/bin/bash

# Autori:
#
# P	@Pinperepette	
# H	@HackerRedenti
# # @b4d_tR1p
# 0 @Th3Zer0
# S @Stabros
#########################################################################
#  This program is free software; you can redistribute it and/or modify #
#  it under the terms of the GNU General Public License as published by #
#  the Free Software Foundation; either version 2 of the License, or    #
#  (at your option) any later version.                                  #
#                                                                       #
#  This program is distributed in the hope that it will be useful,      #
#  but WITHOUT ANY WARRANTY; without even the implied warranty of       #
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        #
#  GNU General Public License for more details.                         #
#                                                                       #
#  You should have received a copy of the GNU General Public License    #
#  along with this program; if not, write to the Free Software          #
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,           #
#  MA 02110-1301, USA.                                                  #
############################# DISCALIMER ################################
#  Usage of this software for probing/attacking targets without prior   #
#  mutual consent, is illegal. It's the end user's responsability to    #
#  obey alla applicable local laws. Developers assume no liability and  #
#  are not responible for any missue or damage caused by thi program    #
#########################################################################
prog="PH#0S Penmode"
disclamer="DISCLAMER LEGALE: L'uso di questo software è da considerarsi per esclusivo scopo di test.
  L'utente che lo utilizza si dichiara consapevole che qualsiasi uso finalizzato a creare danni, disagi o malfunzionamenti
   è illegale se non espressamente autorizzati dall'amministratore del/dei sito/i su cui viene puntato. 
   Gli autori non sono responsabili dell'eventuale uso improprio del presente software 
   o dei danni/disagi/malfunzionamenti causati dal suo utilizzo."

echo "                                                                              
    iMMMMMMMMai   SMMM,     BMMB     WM8  XMM:   7WMMMMM0     7MMMMMMM,       
    iMMMWBBMMMM2  7MMM      8MM0     MM;  XMB   8MMMWBMMMX   MMMM0BBMMZ       
    iMM@    aMMM  7MMW      aMM8  7MMMMM@@MMMM:XMMM    ZMMB 7MMM     :        
    :MMM    XMMM  rMMW      2MM8  XMMMMMMMMMMM;WMMS     MMM ,MMM@S            
    iMMMSrXBMMM7  rMMMMMMMMMMMMZ    SMS   MM   @MMX     MMM. ;MMMMMMZ;        
    :MMMMMMMMWi   rMMMWMMM@@MMM8  WMMMMM@MMMMa @MMX     MMM;     7BMMMMW      
    :MMMr:ii      7MMB      SMMZ  MMMMMMMMMMM0 BMMa    .MMM,       ,MMM7      
    :MMM          rMM@      ZMM8   ;MM   BM7   rMMM:   @MMZ  XZ    ,MMM:      
    rMMM:         SMMM.     BMMB   8M@  .MM;    ZMMMMMMMMB   MMMMMMMMMM7      
    iMMM,         rMMW      aMMZ   8MZ  ;MM:      0MMMMB:   .8MMMMMWi         
     :;i;i;i;i;iii,                                      iii;iiii:            
BMMMMMMMMMMMMMMMMMM@:                           .ZMMMMMMMMMMMMMMMMMMWS        
MMMMMMXXSXXXXXSXSMMMMM@X                     2MMMMMMMMMMMMaXXXSXXBMMMMM8ai    
X                 78BMMMMMa7i          ,X@MMMMMM8Z.                 iMMMMMW7  
                      :0MMMMMMMMMMMMMMMMMMMMMW;                        ;WMMMMM
                         :iXMMMMMMMMMMMMa;:                               :8MM
                         
                         "
                              
                              
########################################################################
######################### EXTRA SUBROUTINES ############################
########################################################################

msg() {
	local mesg=$1; shift
	printf "${BOLD}[ ${GREEN}I${ALL_OFF}${BOLD} ]${ALL_OFF} ${mesg}\n" "$@" >&2
}

excla() {
	local mesg=$1; shift
	printf "${BOLD}[ ${BLUE}!${ALL_OFF}${BOLD} ]${ALL_OFF} ${mesg}\n" "$@" >&2
}

warning() {
	local mesg=$1; shift
	printf "${BOLD}[ ${YELLOW}W${ALL_OFF}${BOLD} ]${ALL_OFF} ${mesg}\n" "$@" >&2
}

error() {
	local mesg=$1; shift
	printf "${BOLD}[ ${RED}E${ALL_OFF}${BOLD} ]${ALL_OFF} ${mesg}\n" "$@" >&2
}

# check if messages are to be printed using color
unset ALL_OFF BOLD BLUE GREEN RED YELLOW
ALL_OFF="\e[1;0m"
BOLD="\e[1;1m"
BLUE="${BOLD}\e[1;34m"
GREEN="${BOLD}\e[1;32m"
RED="${BOLD}\e[1;31m"
YELLOW="${BOLD}\e[1;33m"
readonly ALL_OFF BOLD BLUE GREEN RED YELLOW


########################################################################
############################# SUBROUTINES ##############################
########################################################################

help() {
	excla "$disclamer"
	echo -e "Uso: penmode [tool_name][help] \nTool:"
	msg "nmap - avvio programma nmap per scansione porte"
	msg "nikto - effettua la scansione professionale del sito"
	msg "whatweb - effettua la scansione del sito riconoscendo CMS, librerie java, blog platform e relativi servizi"
	msg "joomscan - Cerca le vulnerabilita' dei CMS Joomla"
	msg "wpscan - strumento per la ricerca di vulnerabilità di Wordpress"
	msg "skipfish - scanner per vulnerabilità nelle web applications"
	msg "exploit - htexploit bypass standard directory protection. Dobbiamo aggiungere altro?"
	msg "sqlmap - è uno strumento automatico che consente la scansione e la verifica di possibili criticità nei database SQL"
	msg "slowloris - strumento per attacco dos"
	msg "sql_ricerca - ricerca e attacca google dork con sqlmap "
	msg "socatoff - chiudi il canale socat"

}

check_socat() {
	# Controllo e apertura socat
	# check and open socat connections
	notify-send -t 8000 -i /usr/share/icons/gnome/48x48/status/debmode.png "Avvio Socat"
	check=$(ps caux | grep socat)
	if [ -n "$check" ]; then
		socatpid=`pgrep socat` 
		echo "Socat è avviato. -> $socatpid"
		notify-send -t 8000 -i /usr/share/icons/gnome/48x48/status/debmode.png "Socat è avviato"
	else
		# Impostare un Target
		# select target
		url=`zenity --entry --title="$prog - Inserire il target" --text="Inserire il target"`
		ip=`tor-resolve $url`
		socat TCP4-LISTEN:8080,fork SOCKS4a:127.0.0.1:$ip:80,socksport=9050 &
		socatpid=$!
		echo "Socat è ora avviato. -> $socatpid"
		notify-send -t 8000 -i /usr/share/icons/gnome/48x48/status/debmode.png "Socat è ora avviato. -> $socatpid"
	fi
}
check_socat_http() {
	     # Controllo e apertura socat
	     # check and open socat http connections 
	     notify-send -t 8000 -i /usr/share/icons/gnome/48x48/status/debmode.png "Avvio Socat"
	     check=$(ps caux | grep socat)
	 if [ -n "$check" ]; then
		 socatpid=`pgrep socat` 
		 echo "Socat è avviato. -> $socatpid"
		 notify-send -t 8000 -i /usr/share/icons/gnome/48x48/status/debmode.png "Socat è avviato"
	 else
	     check_socat_http2	
	 fi
}
check_socat_http2() {
	     # Impostare un Target
	     # select Target
	     url=`zenity --entry --title="$prog - Inserire il target" --text="Inserire il target"`
	 if [ $url != "http://*" ];then
		 URL=${url#http://}
		 ip=`tor-resolve $URL`
		 socat TCP4-LISTEN:8080,fork SOCKS4a:127.0.0.1:$ip:80,socksport=9050 &
		 socatpid=$!
		 echo "Socat è ora avviato. -> $socatpid"
		 notify-send -t 8000 -i /usr/share/icons/gnome/48x48/status/debmode.png "Socat è ora avviato. -> $socatpid"
		 a=$URL
	 else
		 ip=`tor-resolve $url`
		 socat TCP4-LISTEN:8080,fork SOCKS4a:127.0.0.1:$ip:80,socksport=9050 &
		 socatpid=$!
		 echo "Socat è ora avviato. -> $socatpid"
		 notify-send -t 8000 -i /usr/share/icons/gnome/48x48/status/debmode.png "Socat è ora avviato. -> $socatpid"
		 a=$url
     fi
}
kill_socat() {
	check=$(ps caux | grep socat)
	if [ -n "$check" ]; then
		# Richiesta chiusura socat
		# Ask if you need to close socat
		zenity --question --text="Chiudere socat?"
		if [[ "$?" = '0' ]]; then
			killall socat
			notify-send -t 8000 -i /usr/share/icons/gnome/48x48/status/debmode.png "Socat Chiuso"
		else
		notify-send -t 8000 -i /usr/share/icons/gnome/48x48/status/dmerror1.png "Socat è Aperto"	
		
		fi
	fi
	
}

ping_silenzioso() {
           notify-send -t 8000 -i /usr/share/icons/gnome/48x48/status/debmode.png "Eseguo il Ping silenzioso"
           ping=`zenity --entry --title="$prog - Inserire il target" --text="Inserire il target"`
      if [ $ping != "http://*" ];then
           PING=${ping#http://}
           ip=`tor-resolve $PING`
      else    
		   ip=`tor-resolve $ping`
	  fi   
		        
}

check_software() {
	uscita=0
	if [ $(dpkg -s zenity | grep -c "install ok") -ne "1" ]; then
		error "Impossibile trovare il programma: zenity."
	notify-send -t 8000 -i /usr/share/icons/gnome/48x48/status/dmerror1.png "Impossibile trovare il programma: zenity."	
		uscita=1
	fi
	
	if [ $(dpkg -s socat | grep -c "install ok") -ne "1" ]; then
		error "Impossibile trovare il programma: socat."
	notify-send -t 8000 -i /usr/share/icons/gnome/48x48/status/dmerror1.png "Impossibile trovare il programma: socat."	
		uscita=1
	fi
	
	if [ $(dpkg -s tor | grep -c "install ok") -ne "1" ]; then
		error "Impossibile trovare il programma: tor."
	notify-send -t 8000 -i /usr/share/icons/gnome/48x48/status/dmerror1.png "Impossibile trovare il programma: tor."	
		uscita=1
	fi

	
	if [ "$uscita" = '1' ]; then
		exit 1
	fi
}	


########################################################################
###############  Lasciate ogni speranza o voi che entrate  #############
########################################################################



check_software
notify-send -t 10000 -i /usr/share/icons/gnome/48x48/status/debmode.png "PenMode by PH#0S" 

if [ $# = '1' ]; then
	for i in $@; do
	  case $i in
#########################################################################	  
	       "nmap")
			ping_silenzioso
	        echo "avvio scansione"
			echo "$ip"
			echo "$ping"
			sudo proxychains nmap -sV -O -P0 -p 21,22,25,53,80,135,139,443,445 $ip | tee ./$ping-$(date +%m-%d-%Y_%H-%M).txt
	        break
	       ;;
#########################################################################       
	       "sqlmap")
	        notify-send -t 8000 -i /usr/share/icons/gnome/48x48/status/debmode.png "Avvio sqlmap" 
	        sudo proxychains sqlmap --wizard | tee ./$url-$(date +%m-%d-%Y_%H-%M)sqlmap.txt
	        notify-send -t 8000 -i /usr/share/icons/gnome/48x48/status/debmode.png "Finito, il report lo trovi in Home"	
	        break
	       ;;
#########################################################################	       
	       "sql_ricerca")
	        notify-send -t 8000 -i /usr/share/icons/gnome/48x48/status/debmode.png "Ricerca google dork con sqlmap" 
	        dork=`zenity --entry --title="$prog - Inserire il target" --text="Inserire la dork"`
	        sudo proxychains sqlmap -g $dork --random-agent --threads=5		
	        break
	       ;;
#########################################################################        
	       "whatweb")
		   check_socat_http
	       echo "avvio whatweb"
	       notify-send -t 8000 -i /usr/share/icons/gnome/48x48/status/debmode.png "Avvio whatweb"
	       sh -c whatweb
	       whatweb -v 127.0.0.1:8080 
	       notify-send -t 8000 -i /usr/share/icons/gnome/48x48/status/debmode.png "Lavoro finito" "Il Report lo trovi in Home"	
	       break
	       ;;
#########################################################################	       
	       "joomscan")
	       check_socat_http
		   echo "avvio joomscan"
		   notify-send -t 8000 -i /usr/share/icons/gnome/48x48/status/debmode.png "Avvio joomscan"
	       sh -c joomscan 
	       joomscan -u $a -x 127.0.0.1:8080
           break
		   ;;
#########################################################################		   
		   "exploit")
		   echo "avvio htexploit"
		   notify-send -t 8000 -i /usr/share/icons/gnome/48x48/status/debmode.png "Avvio htexploit"
		   sh -c htexploit
		   url2=`zenity --entry --title="$prog - Inserire il target" --text="Inserire il target"`
		   exec sudo proxychains htexploit -u $url2 -o -w --verbose 3	
	       break
		   ;;
#########################################################################		   
		   "skipfish")  
           url2=`zenity --entry --title="$prog - Inserire il target" --text="Inserire il target"`
	  	   if [ $url2 != "http://*" ];then
	       url3=${url2#http://}
           notify-send -t 8000 -i /usr/share/icons/gnome/48x48/status/debmode.png "Avvio skipfish"
           echo "$url3"
           exec sudo proxychains skipfish -o /home/$url3 http://$url3
	       else
	       notify-send -t 8000 -i /usr/share/icons/gnome/48x48/status/debmode.png "Avvio skipfish"
	       echo "$url2"
	       exec sudo proxychains skipfish -o /home/$url2 http://$url2
		   fi
		   break
		   ;;
#########################################################################		   
		   "wpscan")
	       killall socat
		   echo "socat non attivo"
	       echo "avvio wpscan"
	       notify-send -t 8000 -i /usr/share/icons/gnome/48x48/status/debmode.png "Avvio wpscan"
	       url2=`zenity --entry --title="$prog - Inserire il target" --text="Inserire il target"`
	       sh -c wpscan 
	       exec sudo proxychains wpscan --url $url2	
	       break
	       ;;
#########################################################################	       
	       "slowloris")
		   check_socat_http
		   notify-send -t 8000 -i /usr/share/icons/gnome/48x48/status/debmode.png "Avvio slowloris"
		   args=`zenity --forms --title="$prog - Slowloris" \
		   --text="Goodbye Server. DIE BITCH!" \
		   --separator="|" \
		   --add-entry="Timeout Request" \
		   --add-entry="Request Number"`
           timeout=`echo $args | awk -F"|" '{print $1}'`
		   number=`echo $args | awk -F"|" '{print $2}'`
		   cd /opt/backbox/penmode/
		   exec perl ./slowloris.pl -dns 127.0.0.1 -port 8080 -timeout $timeout -num $number 
		   break
	       ;;
#########################################################################	       
	       "matrix")
	       notify-send -t 8000 -i /usr/share/icons/gnome/48x48/status/debmode.png "Avvio matrix"
	       /opt/backbox/penmode/matrixish.sh
	       break
	       ;;
#########################################################################	       
	       "socatoff")
	       notify-send -t 8000 -i /usr/share/icons/gnome/48x48/status/debmode.png "Chiudo tutti i socat"
	       killall socat
	       break
	       ;;
#########################################################################	       
	       "help")
	       help
	       break
	       ;;
#########################################################################	       
	       "nikto")
		    echo "stai per avviare nikto"
	        echo "una scansione può impiegare diverso tempo..."
	        echo "una volta lanciato potrai interagire con lui"
	        echo " "
	        echo "----------------------------------------------------"
	        echo "TI AVVERTO: tutte le azioni che compirai le troverai nel report in home "
	        echo "puoi sempre cancellarle dopo... ma per un report pulito"
	        echo "ti consiglio di usare solo SPAZIO"
	        echo "----------------------------------------------------"
	        echo "SPAZIO - Status Report di scansione corrente"
	        echo "v Attivare la modalità verbose on / off"
	        echo "d - Attivare la modalità di debug on / off"
	        echo "e - Accendere Error Reporting on / off"
	        echo "r - Turn redirect display on / off"
	        echo "c - Attiva display cookie on / off"
	        echo "o - Attiva OK display on/off"
	        echo "a - Attiva auth display on/off"
	        echo "q - esci"
	        echo "N - Prossimo ospite"
	        echo "P - Pausa"
	        echo "----------------------------------------------------"
	        check_socat_http
			echo "avvio scansione... Urcabalurca !!!"
			notify-send -t 8000 -i /usr/share/icons/gnome/48x48/status/debmode.png "Avvio Nikto"
			nikto -h 127.0.0.1:8080 | tee ./$ping-$(date +%m-%d-%Y_%H)nikto.txt	
			notify-send -t 8000 -i /usr/share/icons/gnome/48x48/status/debmode.png "Finito, il report lo trovi in Home"	
			break
	       ;;
#########################################################################	       
	       *)     
	       break;;
		 
		 
	  esac
	done
else
	help
	exit 1
fi


kill_socat

exit
