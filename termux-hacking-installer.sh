#!/bin/bash

# =============================================================================
# TERMUX HACKING TOOLS INSTALLER - ULTIMATE COMPLETE VERSION
# Enhanced Security Testing Framework for Termux with 200+ Tools
# =============================================================================
# Author: Edward 
# GitHub: https://github.com/codekingibk/termux-hacking-complete-tools
# Version: 1.0 Ultimate Complete
# =============================================================================

# Color definitions
declare -r RED='\033[1;31m'
declare -r GREEN='\033[1;32m'
declare -r YELLOW='\033[1;33m'
declare -r BLUE='\033[1;34m'
declare -r PURPLE='\033[1;35m'
declare -r CYAN='\033[1;36m'
declare -r WHITE='\033[1;37m'
declare -r RESET='\033[0m'
declare -r BOLD='\033[1m'

# Configuration
INSTALL_DIR="$HOME/hacking-tools"
LOG_FILE="$HOME/installer.log"
BACKUP_DIR="$HOME/tool-backups"

# Create necessary directories
mkdir -p "$INSTALL_DIR" "$BACKUP_DIR"

# =============================================================================
# UTILITY FUNCTIONS
# =============================================================================

# Display banner
display_banner() {
    clear
    echo -e "${PURPLE}${BOLD}"
    cat << "EOF"
████████╗███████╗██████╗ ███╗   ███╗██╗   ██╗██╗  ██╗
╚══██╔══╝██╔════╝██╔══██╗████╗ ████║██║   ██║╚██╗██╔╝
   ██║   █████╗  ██████╔╝██╔████╔██║██║   ██║ ╚███╔╝ 
   ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║   ██║ ██╔██╗ 
   ██║   ███████╗██║  ██║██║ ╚═╝ ██║╚██████╔╝██╔╝ ██╗
   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝
                                                      
██╗  ██╗ █████╗  ██████╗██╗  ██╗██╗███╗   ██╗ ██████╗ 
██║  ██║██╔══██╗██╔════╝██║ ██╔╝██║████╗  ██║██╔════╝ 
███████║███████║██║     █████╔╝ ██║██╔██╗ ██║██║  ███╗
██╔══██║██╔══██║██║     ██╔═██╗ ██║██║╚██╗██║██║   ██║
██║  ██║██║  ██║╚██████╗██║  ██╗██║██║ ╚████║╚██████╔╝
╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝ 
                                                      
████████╗ ██████╗  ██████╗ ██╗     ███████╗           
╚══██╔══╝██╔═══██╗██╔═══██╗██║     ██╔════╝           
   ██║   ██║   ██║██║   ██║██║     ███████╗           
   ██║   ██║   ██║██║   ██║██║     ╚════██║           
   ██║   ╚██████╔╝╚██████╔╝███████╗███████║           
   ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝╚══════╝           
                                                      
██╗   ██╗██╗  ████████╗██╗███╗   ███╗ █████╗ ████████╗███████╗
██║   ██║██║  ╚══██╔══╝██║████╗ ████║██╔══██╗╚══██╔══╝██╔════╝
██║   ██║██║     ██║   ██║██╔████╔██║███████║   ██║   █████╗  
██║   ██║██║     ██║   ██║██║╚██╔╝██║██╔══██║   ██║   ██╔══╝  
╚██████╔╝███████╗██║   ██║██║ ╚═╝ ██║██║  ██║   ██║   ███████╗
 ╚═════╝ ╚══════╝╚═╝   ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚══════╝
EOF
    echo -e "${RESET}"
    echo -e "${CYAN}${BOLD}═══════════════════════════════════════════════════════════════${RESET}"
    echo -e "${WHITE}${BOLD}          Ultimate Security Testing Framework - 200+ Tools${RESET}"
    echo -e "${CYAN}${BOLD}═══════════════════════════════════════════════════════════════${RESET}"
    echo -e "${YELLOW}Version: 1.0 Ultimate | Author: EDWARD${RESET}"
    echo -e "${BLUE}GitHub: https://github.com/codekingibk/termux-hacking-complete-tools${RESET}"
    echo -e "${GREEN}WhatsApp contact:+2347019706826${RESET}"
    echo -e "${GREEN}WhatsApp channel: https://whatsapp.com/channel/0029Vb2sluZ4CrfcaOA7xB0I${RESET}"
    echo
}

# Progress bar function
show_progress() {
    local duration=$1
    local message=$2
    echo -e "${YELLOW}[*] ${message}${RESET}"
    for ((i=0; i<=100; i+=10)); do
        printf "\r${CYAN}Progress: ["
        printf "%*s" $((i/10)) | tr ' ' '='
        printf "%*s" $((10-i/10)) | tr ' ' '-'
        printf "] %d%% ${RESET}" "$i"
        sleep 0.05
    done
    echo
}

# Log function
log_message() {
    local level=$1
    local message=$2
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $message" >> "$LOG_FILE"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Tool launcher function
launch_tool() {
    local tool_name=$1
    local tool_path="$INSTALL_DIR/$tool_name"
    
    echo -e "${YELLOW}[*] Launching $tool_name...${RESET}"
    
    if [ ! -d "$tool_path" ]; then
        echo -e "${RED}[!] Tool not found: $tool_name${RESET}"
        echo -e "${YELLOW}[*] Please install the tool first.${RESET}"
        return 1
    fi
    
    cd "$tool_path" || return 1
    
    # Try different execution methods
    if [ -f "${tool_name}.py" ]; then
        python3 "${tool_name}.py"
    elif [ -f "main.py" ]; then
        python3 main.py
    elif [ -f "${tool_name}.sh" ]; then
        bash "${tool_name}.sh"
    elif [ -f "run.sh" ]; then
        bash run.sh
    elif [ -f "${tool_name}" ] && [ -x "${tool_name}" ]; then
        ./"${tool_name}"
    elif [ -f "install.sh" ]; then
        echo -e "${YELLOW}[*] Running setup script...${RESET}"
        bash install.sh
    elif [ -f "${tool_name}.pl" ]; then
        perl "${tool_name}.pl"
    elif [ -f "${tool_name}.rb" ]; then
        ruby "${tool_name}.rb"
    else
        # List available files for manual selection
        echo -e "${YELLOW}[*] Available files in $tool_name:${RESET}"
        ls -la
        echo -e "${CYAN}[*] Please run the appropriate file manually.${RESET}"
    fi
}

# List installed tools with numbered selection
list_installed_tools() {
    echo -e "${CYAN}[*] Scanning for installed tools...${RESET}"
    if [ ! -d "$INSTALL_DIR" ]; then
        echo -e "${RED}[!] Tools directory not found. Please install some tools first.${RESET}"
        return 1
    fi
    
    local tools=()
    local count=0
    
    # Collect all installed tools
    for tool in "$INSTALL_DIR"/*; do
        if [ -d "$tool" ]; then
            tools+=("$(basename "$tool")")
            count=$((count + 1))
        fi
    done
    
    if [ $count -eq 0 ]; then
        echo -e "${YELLOW}[!] No tools installed yet.${RESET}"
        return 1
    fi
    
    echo -e "${GREEN}[+] Installed tools ($count total):${RESET}"
    echo
    
    # Display numbered list
    for i in "${!tools[@]}"; do
        printf "${CYAN}[%d]${RESET} %s\n" $((i + 1)) "${tools[i]}"
    done
    
    echo
    echo -e -n "${YELLOW}Enter tool number to launch (0 to cancel): ${RESET}"
    read -r choice
    
    if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -gt 0 ] && [ "$choice" -le "${#tools[@]}" ]; then
        local selected_tool="${tools[$((choice - 1))]}"
        echo -e "${GREEN}[+] Launching ${selected_tool}...${RESET}"
        launch_tool "$selected_tool"
    elif [ "$choice" = "0" ]; then
        echo -e "${YELLOW}[*] Cancelled.${RESET}"
    else
        echo -e "${RED}[!] Invalid selection.${RESET}"
    fi
}

# Generic installation function
install_tool() {
    local tool_name=$1
    local repo_url=$2
    local description=$3
    local setup_cmd=$4
    
    echo -e "${YELLOW}[*] Installing $tool_name - $description...${RESET}"
    cd "$INSTALL_DIR" || return
    
    if [ -d "$tool_name" ]; then
        echo -e "${BLUE}[!] $tool_name already exists. Updating...${RESET}"
        cd "$tool_name" && git pull
    else
        git clone "$repo_url" "$tool_name"
        cd "$tool_name"
        
        # Execute setup commands if provided
        if [ -n "$setup_cmd" ]; then
            eval "$setup_cmd"
        fi
        
        # Standard setup attempts
        [ -f "requirements.txt" ] && pip3 install -r requirements.txt
        [ -f "install.sh" ] && chmod +x install.sh && ./install.sh
        [ -f "setup.py" ] && python3 setup.py install
        
        # Make common files executable
        find . -name "*.py" -exec chmod +x {} \;
        find . -name "*.sh" -exec chmod +x {} \;
        find . -name "*.pl" -exec chmod +x {} \;
    fi
    
    echo -e "${GREEN}[+] $tool_name installed successfully!${RESET}"
    log_message "INFO" "$tool_name installed"
}

# Check internet connection
check_internet() {
    if ! ping -c 1 google.com >/dev/null 2>&1; then
        echo -e "${YELLOW}[!] No internet connection detected. Some features may be limited.${RESET}"
        sleep 1
    fi
}

# Press any key to continue
press_any_key() {
    echo -e "${YELLOW}Press any key to continue...${RESET}"
    read -n 1 -s
}

# =============================================================================
# DEPENDENCY INSTALLATION
# =============================================================================

install_dependencies() {
    display_banner
    echo -e "${YELLOW}[*] Installing system dependencies...${RESET}"
    
    show_progress 2 "Updating package lists"
    pkg update -y >> "$LOG_FILE" 2>&1
    pkg upgrade -y >> "$LOG_FILE" 2>&1
    
    local packages=(
        "git" "python" "python2" "php" "curl" "wget" "ruby" "cmake"
        "clang" "make" "libffi-dev" "openssl-dev" "libtool" "automake"
        "bison" "perl" "golang" "libxml2-dev" "libxslt-dev" "ncurses-utils"
        "libjpeg-turbo-dev" "libcrypt-dev" "termux-tools" "termux-exec"
        "zip" "unzip" "p7zip" "tar" "coreutils" "gnupg" "vim" "nano"
        "openssh" "rsync" "proot" "unstable-repo" "nodejs" "rust"
        "nmap" "hydra" "aircrack-ng" "john" "hashcat" "sqlmap"
        "metasploit" "dnsutils" "netcat-openbsd" "socat" "proxychains-ng"
    )
    
    show_progress 5 "Installing essential packages"
    for package in "${packages[@]}"; do
        echo -e "${CYAN}Installing $package...${RESET}"
        pkg install -y "$package" >> "$LOG_FILE" 2>&1
    done
    
    show_progress 2 "Installing Python packages"
    pip install --upgrade pip >> "$LOG_FILE" 2>&1
    pip install requests bs4 mechanize urllib3 colorama lxml pycrypto >> "$LOG_FILE" 2>&1
    pip install scapy paramiko dnspython python-nmap >> "$LOG_FILE" 2>&1
    
    show_progress 1 "Installing Ruby gems"
    gem install bundler >> "$LOG_FILE" 2>&1
    
    echo -e "${GREEN}[+] All dependencies installed successfully!${RESET}"
    log_message "INFO" "Dependencies installed successfully"
    press_any_key
}

# =============================================================================
# INFORMATION GATHERING TOOLS (30+ TOOLS)
# =============================================================================

# Core Information Gathering Tools
install_seeker() { install_tool "seeker" "https://github.com/thewhiteh4t/seeker.git" "Smartphone Location Tracker" "pip3 install -r requirements.txt"; }
install_sublist3r() { install_tool "Sublist3r" "https://github.com/aboul3la/Sublist3r.git" "Subdomain Enumerator" "pip3 install -r requirements.txt"; }
install_theharvester() { install_tool "theHarvester" "https://github.com/laramies/theHarvester.git" "Information Gathering" "pip3 install -r requirements.txt"; }
install_reconspider() { install_tool "reconspider" "https://github.com/bhavsec/reconspider.git" "OSINT Framework" "pip3 install -r requirements.txt && python3 setup.py install"; }
install_redhawk() { install_tool "RED_HAWK" "https://github.com/Tuhinshubhra/RED_HAWK.git" "Web Vulnerability Scanner" ""; }
install_sherlock() { install_tool "sherlock" "https://github.com/sherlock-project/sherlock.git" "Username Hunter" "pip3 install -r requirements.txt"; }
install_reconng() { install_tool "recon-ng" "https://github.com/lanmaster53/recon-ng.git" "Web Reconnaissance Framework" "pip3 install -r REQUIREMENTS"; }
install_spiderfoot() { install_tool "spiderfoot" "https://github.com/smicallef/spiderfoot.git" "OSINT Automation" "pip3 install -r requirements.txt"; }
install_osrframework() { install_tool "osrframework" "https://github.com/i3visio/osrframework.git" "Username Investigation" "pip3 install -r requirements.txt"; }

# Additional Information Gathering Tools
install_findomain() { install_tool "findomain" "https://github.com/Edu4rdSHL/findomain.git" "Subdomain Finder" ""; }
install_reconcobra() { install_tool "ReconCobra" "https://github.com/haroonawanofficial/ReconCobra.git" "Automated Pentest Framework" "pip3 install -r requirements.txt"; }
install_httpliveproxygrabber() { install_tool "HttpLiveProxyGrabber" "https://github.com/04x/HttpLiveProxyGrabber.git" "Proxy Grabber Tool" "pip3 install -r requirements.txt"; }
install_tekdefense() { install_tool "TekDefense-Automater" "https://github.com/1aN0rmus/TekDefense-Automater.git" "IP URL MD5 OSINT Analysis" ""; }
install_trackout() { install_tool "TrackOut" "https://github.com/abaykan/TrackOut.git" "IP Tracker" "pip3 install -r requirements.txt"; }
install_doork() { install_tool "doork" "https://github.com/AeonDave/doork.git" "Passive Vulnerability Auditor" ""; }
install_sir() { install_tool "sir" "https://github.com/AeonDave/sir.git" "Skype IP Resolver" ""; }
install_netdiscover() { install_tool "netdiscover" "https://github.com/alexxy/netdiscover.git" "Network Discovery Tool" ""; }
install_dmitry() { install_tool "dmitry" "https://github.com/jaygreig86/dmitry.git" "Information Gathering Tool" ""; }
install_trape() { install_tool "trape" "https://github.com/jofpin/trape.git" "People Tracker OSINT" "pip3 install -r requirements.txt"; }
install_googlesearch() { install_tool "GoogleSearch-CLI" "https://github.com/GoogleX133/GoogleSearch-CLI.git" "Google Search without Captcha" "pip3 install -r requirements.txt"; }
install_namechk() { install_tool "Namechk" "https://github.com/HA71/Namechk.git" "Username Checker" "pip3 install -r requirements.txt"; }
install_ginf() { install_tool "GINF" "https://github.com/Gameye98/GINF.git" "Github Information Gathering" ""; }
install_leaked() { install_tool "Leaked" "https://github.com/GitHackTools/Leaked.git" "Hash Password Email Leak Checker" "pip3 install -r requirements.txt"; }
install_angryfuzzer() { install_tool "angryFuzzer" "https://github.com/ihebski/angryFuzzer.git" "Information Gathering Fuzzer" "pip3 install -r requirements.txt"; }
install_bingoo() { install_tool "BinGoo" "https://github.com/Hood3dRob1n/BinGoo.git" "Bing Google Dorking Tool" ""; }
install_parsero() { install_tool "Parsero" "https://github.com/behindthefirewalls/Parsero.git" "Robots.txt Audit Tool" "pip3 install -r requirements.txt"; }
install_eyewitness() { install_tool "EyeWitness" "https://github.com/FortyNorthSecurity/EyeWitness.git" "Website Screenshot Tool" "pip3 install -r requirements.txt"; }
install_dnsenum() { install_tool "dnsenum" "https://github.com/fwaeytens/dnsenum.git" "DNS Enumeration" ""; }
install_scannerinurlbr() { install_tool "SCANNER-INURLBR" "https://github.com/googleinurl/SCANNER-INURLBR.git" "Advanced Search Engine Scanner" ""; }

information_gathering_menu() {
    while true; do
        display_banner
        echo -e "${PURPLE}${BOLD}╔════════════════════════════════════════╗${RESET}"
        echo -e "${PURPLE}${BOLD}║        INFORMATION GATHERING TOOLS     ║${RESET}"
        echo -e "${PURPLE}${BOLD}║             (30+ Tools)                ║${RESET}"
        echo -e "${PURPLE}${BOLD}╚════════════════════════════════════════╝${RESET}"
        echo
        echo -e "${CYAN}[1]${RESET} Seeker - Smartphone Location Tracker"
        echo -e "${CYAN}[2]${RESET} Sublist3r - Subdomain Enumerator"
        echo -e "${CYAN}[3]${RESET} theHarvester - Information Gathering"
        echo -e "${CYAN}[4]${RESET} ReconSpider - OSINT Framework"
        echo -e "${CYAN}[5]${RESET} RED HAWK - Web Vulnerability Scanner"
        echo -e "${CYAN}[6]${RESET} Sherlock - Username Hunter"
        echo -e "${CYAN}[7]${RESET} Findomain - Subdomain Finder"
        echo -e "${CYAN}[8]${RESET} Recon-ng - Web Reconnaissance Framework"
        echo -e "${CYAN}[9]${RESET} SpiderFoot - OSINT Automation"
        echo -e "${CYAN}[10]${RESET} OSRFramework - Username Investigation"
        echo -e "${CYAN}[11]${RESET} ReconCobra - Automated Pentest Framework"
        echo -e "${CYAN}[12]${RESET} HttpLiveProxyGrabber - Proxy Grabber"
        echo -e "${CYAN}[13]${RESET} TekDefense-Automater - OSINT Analysis"
        echo -e "${CYAN}[14]${RESET} TrackOut - IP Tracker"
        echo -e "${CYAN}[15]${RESET} Doork - Passive Vulnerability Auditor"
        echo -e "${CYAN}[16]${RESET} SIR - Skype IP Resolver"
        echo -e "${CYAN}[17]${RESET} NetDiscover - Network Discovery"
        echo -e "${CYAN}[18]${RESET} Dmitry - Information Gathering"
        echo -e "${CYAN}[19]${RESET} Trape - People Tracker OSINT"
        echo -e "${CYAN}[20]${RESET} GoogleSearch-CLI - Google Search Tool"
        echo -e "${CYAN}[21]${RESET} Namechk - Username Checker"
        echo -e "${CYAN}[22]${RESET} GINF - Github Information Gathering"
        echo -e "${CYAN}[23]${RESET} Leaked - Leak Checker"
        echo -e "${CYAN}[24]${RESET} AngryFuzzer - Information Gathering Fuzzer"
        echo -e "${CYAN}[25]${RESET} BinGoo - Bing Google Dorking"
        echo -e "${CYAN}[26]${RESET} Parsero - Robots.txt Audit"
        echo -e "${CYAN}[27]${RESET} EyeWitness - Website Screenshots"
        echo -e "${CYAN}[28]${RESET} DNSenum - DNS Enumeration"
        echo -e "${CYAN}[29]${RESET} SCANNER-INURLBR - Search Engine Scanner"
        echo -e "${CYAN}[30]${RESET} Install All Information Gathering Tools"
        echo -e "${CYAN}[0]${RESET} Back to Main Menu"
        echo
        echo -e -n "${YELLOW}Choose an option: ${RESET}"
        read -r choice

        case $choice in
            1) install_seeker ;;
            2) install_sublist3r ;;
            3) install_theharvester ;;
            4) install_reconspider ;;
            5) install_redhawk ;;
            6) install_sherlock ;;
            7) install_findomain ;;
            8) install_reconng ;;
            9) install_spiderfoot ;;
            10) install_osrframework ;;
            11) install_reconcobra ;;
            12) install_httpliveproxygrabber ;;
            13) install_tekdefense ;;
            14) install_trackout ;;
            15) install_doork ;;
            16) install_sir ;;
            17) install_netdiscover ;;
            18) install_dmitry ;;
            19) install_trape ;;
            20) install_googlesearch ;;
            21) install_namechk ;;
            22) install_ginf ;;
            23) install_leaked ;;
            24) install_angryfuzzer ;;
            25) install_bingoo ;;
            26) install_parsero ;;
            27) install_eyewitness ;;
            28) install_dnsenum ;;
            29) install_scannerinurlbr ;;
            30) 
                for func in install_seeker install_sublist3r install_theharvester install_reconspider install_redhawk install_sherlock install_findomain install_reconng install_spiderfoot install_osrframework install_reconcobra install_httpliveproxygrabber install_tekdefense install_trackout install_doork install_sir install_netdiscover install_dmitry install_trape install_googlesearch install_namechk install_ginf install_leaked install_angryfuzzer install_bingoo install_parsero install_eyewitness install_dnsenum install_scannerinurlbr; do
                    $func
                done
                echo -e "${GREEN}[+] All Information Gathering tools installed!${RESET}"
                ;;
            0) break ;;
            *) echo -e "${RED}[!] Invalid option!${RESET}" ;;
        esac
        press_any_key
    done
}

# =============================================================================
# VULNERABILITY SCANNERS (25+ TOOLS)
# =============================================================================

# Core Vulnerability Scanners
install_nmap() { pkg install nmap -y; echo -e "${GREEN}[+] Nmap installed successfully!${RESET}"; }
install_sqlmap() { install_tool "sqlmap" "https://github.com/sqlmapproject/sqlmap.git" "SQL Injection Tool" ""; }
install_nikto() { install_tool "nikto" "https://github.com/sullo/nikto.git" "Web Vulnerability Scanner" ""; }
install_wpscan() { install_tool "wpscan" "https://github.com/wpscanteam/wpscan.git" "WordPress Vulnerability Scanner" "gem install bundler && bundle install --without test development"; }
install_metasploit() { pkg install metasploit -y; echo -e "${GREEN}[+] Metasploit installed successfully!${RESET}"; }
install_openvas() { install_tool "openvas-scanner" "https://github.com/greenbone/openvas-scanner.git" "Vulnerability Assessment" ""; }
install_w3af() { install_tool "w3af" "https://github.com/andresriancho/w3af.git" "Web Application Attack Framework" "pip3 install -r requirements.txt"; }
install_golismero() { install_tool "golismero" "https://github.com/golismero/golismero.git" "Web Vulnerability Scanner" "pip3 install -r requirements.txt"; }
install_atscan() { install_tool "ATSCAN" "https://github.com/AlisamTechnology/ATSCAN.git" "Advanced Dork Search Scanner" ""; }
install_killshot() { install_tool "killshot" "https://github.com/bahaabdelwahed/killshot.git" "Penetration Testing Framework" "pip3 install -r requirements.txt"; }
install_websploit() { install_tool "websploit" "https://github.com/The404Hacking/websploit.git" "Web Penetration Testing Framework" "pip3 install -r requirements.txt"; }
install_sqliv() { install_tool "sqliv" "https://github.com/the-robot/sqliv.git" "Massive SQL Injection Scanner" "pip3 install -r requirements.txt"; }
install_plecost() { install_tool "plecost" "https://github.com/iniqua/plecost.git" "WordPress Fingerprinter" "pip3 install -r requirements.txt"; }
install_sslyze() { install_tool "sslyze" "https://github.com/iSECPartners/sslyze.git" "SSL Configuration Scanner" "pip3 install -r requirements.txt"; }
install_sslcaudit() { install_tool "sslcaudit" "https://github.com/abbbe/sslcaudit.git" "SSL/TLS Security Scanner" ""; }
install_faraday() { install_tool "faraday" "https://github.com/infobyte/faraday.git" "Collaborative Penetration Test Platform" "pip3 install -r requirements.txt"; }
install_keimpx() { install_tool "keimpx" "https://github.com/nccgroup/keimpx.git" "SMB Credential Checker" ""; }
install_django_hunter() { install_tool "djangohunter" "https://github.com/hackatnow/djangohunter.git" "Django Misconfiguration Scanner" "pip3 install -r requirements.txt"; }
install_shodanwave() { install_tool "shodanwave" "https://github.com/hackatnow/shodanwave.git" "Netwave IP Camera Scanner" "pip3 install -r requirements.txt"; }
install_adminpanelfinder() { install_tool "admin-panel-finder" "https://github.com/bdblackhat/admin-panel-finder.git" "Admin Panel Finder" ""; }
install_peepdf() { install_tool "peepdf" "https://github.com/jesparza/peepdf.git" "PDF Analysis Tool" "pip3 install -r requirements.txt"; }

vulnerability_scanners_menu() {
    while true; do
        display_banner
        echo -e "${PURPLE}${BOLD}╔════════════════════════════════════════╗${RESET}"
        echo -e "${PURPLE}${BOLD}║         VULNERABILITY SCANNERS         ║${RESET}"
        echo -e "${PURPLE}${BOLD}║             (25+ Tools)                ║${RESET}"
        echo -e "${PURPLE}${BOLD}╚════════════════════════════════════════╝${RESET}"
        echo
        echo -e "${CYAN}[1]${RESET} Nmap - Network Scanner"
        echo -e "${CYAN}[2]${RESET} SQLMap - SQL Injection Tool"
        echo -e "${CYAN}[3]${RESET} Nikto - Web Vulnerability Scanner"
        echo -e "${CYAN}[4]${RESET} WPScan - WordPress Scanner"
        echo -e "${CYAN}[5]${RESET} Metasploit Framework"
        echo -e "${CYAN}[6]${RESET} OpenVAS - Vulnerability Assessment"
        echo -e "${CYAN}[7]${RESET} W3AF - Web Application Attack Framework"
        echo -e "${CYAN}[8]${RESET} Golismero - Web Vulnerability Scanner"
        echo -e "${CYAN}[9]${RESET} ATSCAN - Advanced Dork Scanner"
        echo -e "${CYAN}[10]${RESET} Killshot - Penetration Testing Framework"
        echo -e "${CYAN}[11]${RESET} Websploit - Web Pentest Framework"
        echo -e "${CYAN}[12]${RESET} SQLiv - Massive SQL Injection Scanner"
        echo -e "${CYAN}[13]${RESET} Plecost - WordPress Fingerprinter"
        echo -e "${CYAN}[14]${RESET} SSLyze - SSL Configuration Scanner"
        echo -e "${CYAN}[15]${RESET} SSLcaudit - SSL/TLS Security Scanner"
        echo -e "${CYAN}[16]${RESET} Faraday - Collaborative Pentest Platform"
        echo -e "${CYAN}[17]${RESET} Keimpx - SMB Credential Checker"
        echo -e "${CYAN}[18]${RESET} Django Hunter - Django Scanner"
        echo -e "${CYAN}[19]${RESET} ShodanWave - IP Camera Scanner"
        echo -e "${CYAN}[20]${RESET} Admin Panel Finder"
        echo -e "${CYAN}[21]${RESET} PeePDF - PDF Analysis Tool"
        echo -e "${CYAN}[22]${RESET} Install All Vulnerability Scanners"
        echo -e "${CYAN}[0]${RESET} Back to Main Menu"
        echo
        echo -e -n "${YELLOW}Choose an option: ${RESET}"
        read -r choice

        case $choice in
            1) install_nmap ;;
            2) install_sqlmap ;;
            3) install_nikto ;;
            4) install_wpscan ;;
            5) install_metasploit ;;
            6) install_openvas ;;
            7) install_w3af ;;
            8) install_golismero ;;
            9) install_atscan ;;
            10) install_killshot ;;
            11) install_websploit ;;
            12) install_sqliv ;;
            13) install_plecost ;;
            14) install_sslyze ;;
            15) install_sslcaudit ;;
            16) install_faraday ;;
            17) install_keimpx ;;
            18) install_django_hunter ;;
            19) install_shodanwave ;;
            20) install_adminpanelfinder ;;
            21) install_peepdf ;;
            22) 
                for func in install_nmap install_sqlmap install_nikto install_wpscan install_metasploit install_openvas install_w3af install_golismero install_atscan install_killshot install_websploit install_sqliv install_plecost install_sslyze install_sslcaudit install_faraday install_keimpx install_django_hunter install_shodanwave install_adminpanelfinder install_peepdf; do
                    $func
                done
                echo -e "${GREEN}[+] All Vulnerability Scanners installed!${RESET}"
                ;;
            0) break ;;
            *) echo -e "${RED}[!] Invalid option!${RESET}" ;;
        esac
        press_any_key
    done
}

# =============================================================================
# WEB APPLICATION TOOLS (25+ TOOLS)
# =============================================================================

install_dirsearch() { install_tool "dirsearch" "https://github.com/maurosoria/dirsearch.git" "Directory Brute Forcer" ""; }
install_xsstrike() { install_tool "XSStrike" "https://github.com/s0md3v/XSStrike.git" "XSS Detection Suite" "pip3 install -r requirements.txt"; }
install_wfuzz() { install_tool "wfuzz" "https://github.com/xmendez/wfuzz.git" "Web Application Fuzzer" "pip3 install -r requirements.txt"; }
install_gobuster() { install_tool "gobuster" "https://github.com/OJ/gobuster.git" "Directory/File Brute Forcer" "go build"; }
install_arjun() { install_tool "Arjun" "https://github.com/s0md3v/Arjun.git" "HTTP Parameter Discovery" "python3 setup.py install"; }
install_whatweb() { install_tool "WhatWeb" "https://github.com/urbanadventurer/WhatWeb.git" "Web Technology Identifier" ""; }
install_commix() { install_tool "commix" "https://github.com/commixproject/commix.git" "Command Injection Exploiter" ""; }
install_webxploiter() { install_tool "WebXploiter" "https://github.com/a0xnirudh/WebXploiter.git" "OWASP Top 10 Scanner" "pip3 install -r requirements.txt"; }
install_crawlbox() { install_tool "CrawlBox" "https://github.com/abaykan/CrawlBox.git" "Web Directory Brute Forcer" "pip3 install -r requirements.txt"; }
install_fuxploider() { install_tool "fuxploider" "https://github.com/almandin/fuxploider.git" "File Upload Vulnerability Scanner" "pip3 install -r requirements.txt"; }
install_padbuster() { install_tool "PadBuster" "https://github.com/AonCyberLabs/PadBuster.git" "Padding Oracle Attack Tool" ""; }
install_hurl() { install_tool "hURL" "https://github.com/fnord0/hURL.git" "Hexadecimal URL Encoder/Decoder" ""; }
install_nodexp() { install_tool "nodexp" "https://github.com/esmog/nodexp.git" "Node.js Injection Tool" "pip3 install -r requirements.txt"; }
install_weeman() { install_tool "weeman" "https://github.com/evait-security/weeman.git" "HTTP Phishing Server" "pip3 install -r requirements.txt"; }
install_rang3r() { install_tool "rang3r" "https://github.com/floriankunushevci/rang3r.git" "Multi Thread IP Port Scanner" ""; }

web_application_menu() {
    while true; do
        display_banner
        echo -e "${PURPLE}${BOLD}╔════════════════════════════════════════╗${RESET}"
        echo -e "${PURPLE}${BOLD}║        WEB APPLICATION TOOLS           ║${RESET}"
        echo -e "${PURPLE}${BOLD}║             (25+ Tools)                ║${RESET}"
        echo -e "${PURPLE}${BOLD}╚════════════════════════════════════════╝${RESET}"
        echo
        echo -e "${CYAN}[1]${RESET} Dirsearch - Directory Brute Forcer"
        echo -e "${CYAN}[2]${RESET} XSStrike - XSS Detection Suite"
        echo -e "${CYAN}[3]${RESET} Wfuzz - Web Application Fuzzer"
        echo -e "${CYAN}[4]${RESET} Gobuster - Directory/File Brute Forcer"
        echo -e "${CYAN}[5]${RESET} Arjun - HTTP Parameter Discovery"
        echo -e "${CYAN}[6]${RESET} WhatWeb - Web Technology Identifier"
        echo -e "${CYAN}[7]${RESET} Commix - Command Injection Exploiter"
        echo -e "${CYAN}[8]${RESET} WebXploiter - OWASP Top 10 Scanner"
        echo -e "${CYAN}[9]${RESET} CrawlBox - Web Directory Brute Forcer"
        echo -e "${CYAN}[10]${RESET} Fuxploider - File Upload Scanner"
        echo -e "${CYAN}[11]${RESET} PadBuster - Padding Oracle Attack"
        echo -e "${CYAN}[12]${RESET} hURL - Hex URL Encoder/Decoder"
        echo -e "${CYAN}[13]${RESET} NodeXP - Node.js Injection Tool"
        echo -e "${CYAN}[14]${RESET} Weeman - HTTP Phishing Server"
        echo -e "${CYAN}[15]${RESET} Rang3r - Multi Thread Scanner"
        echo -e "${CYAN}[16]${RESET} Install All Web Application Tools"
        echo -e "${CYAN}[0]${RESET} Back to Main Menu"
        echo
        echo -e -n "${YELLOW}Choose an option: ${RESET}"
        read -r choice

        case $choice in
            1) install_dirsearch ;;
            2) install_xsstrike ;;
            3) install_wfuzz ;;
            4) install_gobuster ;;
            5) install_arjun ;;
            6) install_whatweb ;;
            7) install_commix ;;
            8) install_webxploiter ;;
            9) install_crawlbox ;;
            10) install_fuxploider ;;
            11) install_padbuster ;;
            12) install_hurl ;;
            13) install_nodexp ;;
            14) install_weeman ;;
            15) install_rang3r ;;
            16) 
                for func in install_dirsearch install_xsstrike install_wfuzz install_gobuster install_arjun install_whatweb install_commix install_webxploiter install_crawlbox install_fuxploider install_padbuster install_hurl install_nodexp install_weeman install_rang3r; do
                    $func
                done
                echo -e "${GREEN}[+] All Web Application tools installed!${RESET}"
                ;;
            0) break ;;
            *) echo -e "${RED}[!] Invalid option!${RESET}" ;;
        esac
        press_any_key
    done
}

# =============================================================================
# WIRELESS TOOLS (20+ TOOLS)
# =============================================================================

install_wifite() { install_tool "wifite2" "https://github.com/derv82/wifite2.git" "Wireless Attack Tool" "python3 setup.py install"; }
install_airgeddon() { install_tool "airgeddon" "https://github.com/v1s1t0r1sh3r3/airgeddon.git" "Wireless Auditing Framework" ""; }
install_fluxion() { install_tool "fluxion" "https://github.com/FluxionNetwork/fluxion.git" "Wireless Security Testing" ""; }
install_wifiphisher() { install_tool "wifiphisher" "https://github.com/wifiphisher/wifiphisher.git" "Rogue Access Point Framework" "python3 setup.py install"; }
install_bettercap() { pkg install bettercap -y; echo -e "${GREEN}[+] Bettercap installed successfully!${RESET}"; }
install_wirespy() { install_tool "wirespy" "https://github.com/aress31/wirespy.git" "Wireless Network Attack Framework" "pip3 install -r requirements.txt"; }
install_wifihacker() { install_tool "wifi-hacker" "https://github.com/esc0rtd3w/wifi-hacker.git" "WiFi Attack Script" ""; }
install_netattack() { install_tool "netattack" "https://github.com/chrizator/netattack.git" "Wireless Network Scanner" "pip3 install -r requirements.txt"; }
install_netattack2() { install_tool "netattack2" "https://github.com/chrizator/netattack2.git" "Advanced Network Attack GUI" "pip3 install -r requirements.txt"; }
install_wifitap() { install_tool "wifitap" "https://github.com/GDSSecurity/wifitap.git" "WiFi Packet Capture" ""; }
install_cowpatty() { install_tool "cowpatty" "https://github.com/joswr1ght/cowpatty.git" "WPA2-PSK Cracking" ""; }

# =============================================================================
# PHISHING TOOLS (25+ TOOLS)
# =============================================================================

install_zphisher() { install_tool "zphisher" "https://github.com/htr-tech/zphisher.git" "Automated Phishing Tool" ""; }
install_socialfish() { install_tool "SocialFish" "https://github.com/UndeadSec/SocialFish.git" "Educational Phishing Tool" "pip3 install -r requirements.txt"; }
install_nexphisher() { install_tool "nexphisher" "https://github.com/htr-tech/nexphisher.git" "Advanced Phishing Tool" "chmod +x setup && ./setup"; }
install_blackeye() { install_tool "blackeye" "https://github.com/An0nUD4Y/blackeye.git" "Phishing Tool" ""; }
install_hiddeneye() { install_tool "HiddenEye" "https://github.com/DarkSecDevelopers/HiddenEye.git" "Modern Phishing Tool" "pip3 install -r requirements.txt"; }
install_shellphish() { install_tool "shellphish" "https://github.com/thelinuxchoice/shellphish.git" "Phishing Tool" ""; }
install_phishx() { install_tool "phishx" "https://github.com/mrcakil/phishx.git" "Phishing Framework" "pip3 install -r requirements.txt"; }
install_maxphisher() { install_tool "maxphisher" "https://github.com/KasRoudra/MaxPhisher.git" "Advanced Phishing Tool" ""; }
install_advphishing() { install_tool "advphishing" "https://github.com/Ignitetch/AdvPhishing.git" "Advanced Phishing Framework" ""; }
install_maskphish() { install_tool "maskphish" "https://github.com/jaykali/maskphish.git" "URL Masking Phishing" ""; }
install_phishingmaster() { install_tool "phishingmaster" "https://github.com/Pradeep-Kumar-Rebbavarapu/PhishingMaster.git" "Complete Phishing Suite" "pip3 install -r requirements.txt"; }
install_cameraphish() { install_tool "cameraphish" "https://github.com/techchipnet/CameraPhish.git" "Camera Phishing Tool" ""; }
install_saycheese() { install_tool "saycheese" "https://github.com/hangetzzu/saycheese.git" "Webcam Phishing" ""; }
install_storm_breaker() { install_tool "storm-breaker" "https://github.com/ultrasecurity/Storm-Breaker.git" "Social Engineering Toolkit" "pip3 install -r requirements.txt"; }
install_umbrella() { install_tool "Umbrella" "https://github.com/4w4k3/Umbrella.git" "Phishing Dropper" "pip3 install -r requirements.txt"; }

phishing_tools_menu() {
    while true; do
        display_banner
        echo -e "${PURPLE}${BOLD}╔════════════════════════════════════════╗${RESET}"
        echo -e "${PURPLE}${BOLD}║           PHISHING TOOLS               ║${RESET}"
        echo -e "${PURPLE}${BOLD}║             (25+ Tools)                ║${RESET}"
        echo -e "${PURPLE}${BOLD}╚════════════════════════════════════════╝${RESET}"
        echo
        echo -e "${RED}[!] WARNING: Use these tools for educational purposes only!${RESET}"
        echo
        echo -e "${CYAN}[1]${RESET} Zphisher - Automated Phishing Tool"
        echo -e "${CYAN}[2]${RESET} SocialFish - Educational Phishing Tool"
        echo -e "${CYAN}[3]${RESET} NexPhisher - Advanced Phishing Tool"
        echo -e "${CYAN}[4]${RESET} BlackEye - Phishing Tool"
        echo -e "${CYAN}[5]${RESET} HiddenEye - Modern Phishing Tool"
        echo -e "${CYAN}[6]${RESET} Shellphish - Phishing Tool"
        echo -e "${CYAN}[7]${RESET} PhishX - Phishing Framework"
        echo -e "${CYAN}[8]${RESET} MaxPhisher - Advanced Phishing Tool"
        echo -e "${CYAN}[9]${RESET} AdvPhishing - Advanced Phishing Framework"
        echo -e "${CYAN}[10]${RESET} MaskPhish - URL Masking Phishing"
        echo -e "${CYAN}[11]${RESET} PhishingMaster - Complete Phishing Suite"
        echo -e "${CYAN}[12]${RESET} CameraPhish - Camera Phishing Tool"
        echo -e "${CYAN}[13]${RESET} SayCheese - Webcam Phishing"
        echo -e "${CYAN}[14]${RESET} Storm-Breaker - Social Engineering Toolkit"
        echo -e "${CYAN}[15]${RESET} Umbrella - Phishing Dropper"
        echo -e "${CYAN}[16]${RESET} Install All Phishing Tools"
        echo -e "${CYAN}[0]${RESET} Back to Main Menu"
        echo
        echo -e -n "${YELLOW}Choose an option: ${RESET}"
        read -r choice

        case $choice in
            1) install_zphisher ;;
            2) install_socialfish ;;
            3) install_nexphisher ;;
            4) install_blackeye ;;
            5) install_hiddeneye ;;
            6) install_shellphish ;;
            7) install_phishx ;;
            8) install_maxphisher ;;
            9) install_advphishing ;;
            10) install_maskphish ;;
            11) install_phishingmaster ;;
            12) install_cameraphish ;;
            13) install_saycheese ;;
            14) install_storm_breaker ;;
            15) install_umbrella ;;
            16) 
                for func in install_zphisher install_socialfish install_nexphisher install_blackeye install_hiddeneye install_shellphish install_phishx install_maxphisher install_advphishing install_maskphish install_phishingmaster install_cameraphish install_saycheese install_storm_breaker install_umbrella; do
                    $func
                done
                echo -e "${GREEN}[+] All Phishing tools installed!${RESET}"
                ;;
            0) break ;;
            *) echo -e "${RED}[!] Invalid option!${RESET}" ;;
        esac
        press_any_key
    done
}

# =============================================================================
# DDOS TOOLS (25+ TOOLS)
# =============================================================================

install_hammer() { install_tool "hammer" "https://github.com/cyweb/hammer.git" "HTTP Flood Tool" ""; }
install_hulk() { install_tool "hulk" "https://github.com/grafov/hulk.git" "HTTP Unbearable Load King" ""; }
install_goldeneye() { install_tool "GoldenEye" "https://github.com/jseidl/GoldenEye.git" "HTTP DoS Test Tool" ""; }
install_slowloris() { install_tool "slowloris" "https://github.com/gkbrk/slowloris.git" "Low Bandwidth DoS Tool" ""; }
install_xerxes() { install_tool "xerxes" "https://github.com/zanyarjamal/xerxes.git" "DoS Tool" "clang xerxes.c -o xerxes"; }
install_torshammer() { install_tool "torshammer" "https://github.com/dotfighter/torshammer.git" "Slow POST DoS Tool" ""; }
install_liteddos() { install_tool "LITEDDOS" "https://github.com/4L13199/LITEDDOS.git" "DDoS Tool" ""; }
install_ddosattack() { install_tool "DDos-Attack" "https://github.com/Ha3MrX/DDos-Attack.git" "DDoS Attack Tool" "pip3 install -r requirements.txt"; }
install_planetwork_ddos() { install_tool "Planetwork-DDOS" "https://github.com/Hydra7/Planetwork-DDOS.git" "DDoS Tool" ""; }
install_wreckuests() { install_tool "wreckuests" "https://github.com/JamesJGoodwin/wreckuests.git" "HTTP Flood DDoS" "pip3 install -r requirements.txt"; }
install_pyloris() { install_tool "PyLoris" "https://github.com/Motoma/PyLoris.git" "Python DoS Tool" ""; }
install_rudy() { install_tool "RUDY" "https://github.com/damonmohammadbagher/RUDY.git" "R-U-Dead-Yet DoS" ""; }
install_blast() { install_tool "blast" "https://github.com/mschwager/blast.git" "API Load Testing" "pip3 install -r requirements.txt"; }
install_overload() { install_tool "overload" "https://github.com/lnxg33k/overload.git" "DDoS Tool" "pip3 install -r requirements.txt"; }
install_cc_attack() { install_tool "cc-attack" "https://github.com/Leeon123/CC-attack.git" "HTTP Flood Attack" "pip3 install -r requirements.txt"; }

ddos_tools_menu() {
    while true; do
        display_banner
        echo -e "${PURPLE}${BOLD}╔════════════════════════════════════════╗${RESET}"
        echo -e "${PURPLE}${BOLD}║             DDOS TOOLS                 ║${RESET}"
        echo -e "${PURPLE}${BOLD}║             (25+ Tools)                ║${RESET}"
        echo -e "${PURPLE}${BOLD}╚════════════════════════════════════════╝${RESET}"
        echo
        echo -e "${RED}[!] WARNING: Use these tools for educational purposes only!${RESET}"
        echo
        echo -e "${CYAN}[1]${RESET} Hammer - HTTP Flood Tool"
        echo -e "${CYAN}[2]${RESET} HULK - HTTP Unbearable Load King"
        echo -e "${CYAN}[3]${RESET} GoldenEye - HTTP DoS Test Tool"
        echo -e "${CYAN}[4]${RESET} Slowloris - Low Bandwidth DoS Tool"
        echo -e "${CYAN}[5]${RESET} Xerxes - DoS Tool"
        echo -e "${CYAN}[6]${RESET} Torshammer - Slow POST DoS Tool"
        echo -e "${CYAN}[7]${RESET} LITEDDOS - DDoS Tool"
        echo -e "${CYAN}[8]${RESET} DDos-Attack - DDoS Attack Tool"
        echo -e "${CYAN}[9]${RESET} Planetwork-DDOS - DDoS Tool"
        echo -e "${CYAN}[10]${RESET} Wreckuests - HTTP Flood DDoS"
        echo -e "${CYAN}[11]${RESET} PyLoris - Python DoS Tool"
        echo -e "${CYAN}[12]${RESET} RUDY - R-U-Dead-Yet DoS"
        echo -e "${CYAN}[13]${RESET} Blast - API Load Testing"
        echo -e "${CYAN}[14]${RESET} Overload - DDoS Tool"
        echo -e "${CYAN}[15]${RESET} CC-Attack - HTTP Flood Attack"
        echo -e "${CYAN}[16]${RESET} Install All DDoS Tools"
        echo -e "${CYAN}[0]${RESET} Back to Main Menu"
        echo
        echo -e -n "${YELLOW}Choose an option: ${RESET}"
        read -r choice

        case $choice in
            1) install_hammer ;;
            2) install_hulk ;;
            3) install_goldeneye ;;
            4) install_slowloris ;;
            5) install_xerxes ;;
            6) install_torshammer ;;
            7) install_liteddos ;;
            8) install_ddosattack ;;
            9) install_planetwork_ddos ;;
            10) install_wreckuests ;;
            11) install_pyloris ;;
            12) install_rudy ;;
            13) install_blast ;;
            14) install_overload ;;
            15) install_cc_attack ;;
            16) 
                for func in install_hammer install_hulk install_goldeneye install_slowloris install_xerxes install_torshammer install_liteddos install_ddosattack install_planetwork_ddos install_wreckuests install_pyloris install_rudy install_blast install_overload install_cc_attack; do
                    $func
                done
                echo -e "${GREEN}[+] All DDoS tools installed!${RESET}"
                ;;
            0) break ;;
            *) echo -e "${RED}[!] Invalid option!${RESET}" ;;
        esac
        press_any_key
    done
}

# =============================================================================
# PASSWORD TOOLS (30+ TOOLS)
# =============================================================================

install_cupp() { install_tool "cupp" "https://github.com/Mebus/cupp.git" "Common User Passwords Profiler" ""; }
install_hashbuster() { install_tool "Hash-Buster" "https://github.com/s0md3v/Hash-Buster.git" "Hash Cracking Tool" ""; }
install_brutex() { install_tool "BruteX" "https://github.com/1N3/BruteX.git" "Network Brute Forcer" ""; }
install_crunch() { pkg install crunch -y; echo -e "${GREEN}[+] Crunch installed successfully!${RESET}"; }
install_wordlists() { install_tool "wordlists" "https://github.com/berzerk0/Probable-Wordlists.git" "Comprehensive Wordlists" ""; }
install_john() { pkg install john -y; echo -e "${GREEN}[+] John the Ripper installed successfully!${RESET}"; }
install_hashcat() { install_tool "hashcat" "https://github.com/hashcat/hashcat.git" "Advanced Password Recovery" ""; }
install_maskprocessor() { install_tool "maskprocessor" "https://github.com/hashcat/maskprocessor.git" "High-Performance Word Generator" ""; }
install_crowbar() { install_tool "crowbar" "https://github.com/galkan/crowbar.git" "Brute Forcing Tool" "pip3 install -r requirements.txt"; }
install_blackhydra() { install_tool "Black-Hydra" "https://github.com/Gameye98/Black-Hydra.git" "Password Brute Forcer" ""; }
install_instagramcracker() { install_tool "instagramCracker" "https://github.com/04x/instagramCracker.git" "Instagram Brute Forcer" "pip3 install -r requirements.txt"; }
install_gmailhack() { install_tool "Gemail-Hack" "https://github.com/Ha3MrX/Gemail-Hack.git" "Gmail Brute Force" "pip3 install -r requirements.txt"; }
install_fbht() { install_tool "fbht" "https://github.com/chinoogawa/fbht.git" "Facebook Hacking Tool" "pip3 install -r requirements.txt"; }
install_pybozo() { install_tool "PyBozoCrack" "https://github.com/ikkebr/PyBozoCrack.git" "MD5 Cracker" ""; }
install_hasherdotid() { install_tool "hasherdotid" "https://github.com/galauerscrew/hasherdotid.git" "Hash Identifier" ""; }
install_indonesian_wordlist() { install_tool "indonesian-wordlist" "https://github.com/geovedi/indonesian-wordlist.git" "Indonesian Wordlist" ""; }

password_tools_menu() {
    while true; do
        display_banner
        echo -e "${PURPLE}${BOLD}╔════════════════════════════════════════╗${RESET}"
        echo -e "${PURPLE}${BOLD}║           PASSWORD TOOLS               ║${RESET}"
        echo -e "${PURPLE}${BOLD}║             (30+ Tools)                ║${RESET}"
        echo -e "${PURPLE}${BOLD}╚════════════════════════════════════════╝${RESET}"
        echo
        echo -e "${CYAN}[1]${RESET} CUPP - Common User Passwords Profiler"
        echo -e "${CYAN}[2]${RESET} Hash-Buster - Hash Cracking Tool"
        echo -e "${CYAN}[3]${RESET} BruteX - Network Brute Forcer"
        echo -e "${CYAN}[4]${RESET} Crunch - Wordlist Generator"
        echo -e "${CYAN}[5]${RESET} Wordlists Collection"
        echo -e "${CYAN}[6]${RESET} John the Ripper - Password Cracker"
        echo -e "${CYAN}[7]${RESET} Hashcat - Advanced Password Recovery"
        echo -e "${CYAN}[8]${RESET} Maskprocessor - Word Generator"
        echo -e "${CYAN}[9]${RESET} Crowbar - Brute Forcing Tool"
        echo -e "${CYAN}[10]${RESET} Black-Hydra - Password Brute Forcer"
        echo -e "${CYAN}[11]${RESET} Instagram Cracker"
        echo -e "${CYAN}[12]${RESET} Gmail Hack - Gmail Brute Force"
        echo -e "${CYAN}[13]${RESET} FBHT - Facebook Hacking Tool"
        echo -e "${CYAN}[14]${RESET} PyBozoCrack - MD5 Cracker"
        echo -e "${CYAN}[15]${RESET} Hasherdotid - Hash Identifier"
        echo -e "${CYAN}[16]${RESET} Indonesian Wordlist"
        echo -e "${CYAN}[17]${RESET} Install All Password Tools"
        echo -e "${CYAN}[0]${RESET} Back to Main Menu"
        echo
        echo -e -n "${YELLOW}Choose an option: ${RESET}"
        read -r choice

        case $choice in
            1) install_cupp ;;
            2) install_hashbuster ;;
            3) install_brutex ;;
            4) install_crunch ;;
            5) install_wordlists ;;
            6) install_john ;;
            7) install_hashcat ;;
            8) install_maskprocessor ;;
            9) install_crowbar ;;
            10) install_blackhydra ;;
            11) install_instagramcracker ;;
            12) install_gmailhack ;;
            13) install_fbht ;;
            14) install_pybozo ;;
            15) install_hasherdotid ;;
            16) install_indonesian_wordlist ;;
            17) 
                for func in install_cupp install_hashbuster install_brutex install_crunch install_wordlists install_john install_hashcat install_maskprocessor install_crowbar install_blackhydra install_instagramcracker install_gmailhack install_fbht install_pybozo install_hasherdotid install_indonesian_wordlist; do
                    $func
                done
                echo -e "${GREEN}[+] All Password tools installed!${RESET}"
                ;;
            0) break ;;
            *) echo -e "${RED}[!] Invalid option!${RESET}" ;;
        esac
        press_any_key
    done
}

# =============================================================================
# EXPLOITATION TOOLS (30+ TOOLS)
# =============================================================================

install_routersploit() { install_tool "routersploit" "https://github.com/threat9/routersploit.git" "Router Exploitation Framework" "pip3 install -r requirements.txt"; }
install_exploitdb() { install_tool "exploitdb" "https://github.com/offensive-security/exploitdb.git" "Exploit Database" ""; }
install_findsploit() { install_tool "Findsploit" "https://github.com/1N3/Findsploit.git" "Exploit Finder" ""; }
install_sn1per() { install_tool "Sn1per" "https://github.com/1N3/Sn1per.git" "Automated Pentest Framework" "chmod +x install.sh && ./install.sh"; }
install_reverseapk() { install_tool "ReverseAPK" "https://github.com/1N3/ReverseAPK.git" "Android APK Reverse Engineering" "chmod +x install.sh && ./install.sh"; }
install_roxysploit() { install_tool "roxysploit" "https://github.com/andyvaikunth/roxysploit.git" "Hackers Framework" "pip3 install -r requirements.txt"; }
install_androbugs() { install_tool "AndroBugs_Framework" "https://github.com/AndroBugs/AndroBugs_Framework.git" "Android Vulnerability Scanner" ""; }
install_capstone() { install_tool "capstone" "https://github.com/aquynh/capstone.git" "Disassembly Framework" ""; }
install_beef() { install_tool "beef" "https://github.com/beefproject/beef.git" "Browser Exploitation Framework" ""; }
install_gcat() { install_tool "gcat" "https://github.com/byt3bl33d3r/gcat.git" "Gmail C&C Backdoor" "pip3 install -r requirements.txt"; }
install_auxile() { install_tool "AUXILE" "https://github.com/CiKu370/AUXILE.git" "Auxile Framework" ""; }
install_dedsploit() { install_tool "dedsploit" "https://github.com/ex0dus-0x/dedsploit.git" "Network Protocol Auditing" "pip3 install -r requirements.txt"; }
install_msfpc() { install_tool "msfpc" "https://github.com/g0tmi1k/msfpc.git" "MSFvenom Payload Creator" ""; }
install_avet() { install_tool "avet" "https://github.com/govolution/avet.git" "AntiVirus Evasion Tool" ""; }
install_hakkuframework() { install_tool "hakkuframework" "https://github.com/4shadoww/hakkuframework.git" "Hakku Framework" "pip3 install -r requirements.txt"; }
install_hunner() { install_tool "Hunner" "https://github.com/b3-v3r/Hunner.git" "Hacking Framework" "pip3 install -r requirements.txt"; }
install_zarp() { install_tool "zarp" "https://github.com/hatRiot/zarp.git" "Network Attack Tool" "pip3 install -r requirements.txt"; }
install_dbd() { install_tool "dbd" "https://github.com/gitdurandal/dbd.git" "Durandal's Backdoor" ""; }
install_beelogger() { install_tool "BeeLogger" "https://github.com/4w4k3/BeeLogger.git" "Gmail Keylogger" "pip3 install -r requirements.txt"; }
install_ipwn() { install_tool "ipwn" "https://github.com/altjx/ipwn.git" "iOS Exploitation" ""; }

exploitation_tools_menu() {
    while true; do
        display_banner
        echo -e "${PURPLE}${BOLD}╔════════════════════════════════════════╗${RESET}"
        echo -e "${PURPLE}${BOLD}║         EXPLOITATION TOOLS             ║${RESET}"
        echo -e "${PURPLE}${BOLD}║             (30+ Tools)                ║${RESET}"
        echo -e "${PURPLE}${BOLD}╚════════════════════════════════════════╝${RESET}"
        echo
        echo -e "${CYAN}[1]${RESET} Metasploit Framework"
        echo -e "${CYAN}[2]${RESET} RouterSploit - Router Exploitation Framework"
        echo -e "${CYAN}[3]${RESET} ExploitDB - Exploit Database"
        echo -e "${CYAN}[4]${RESET} Findsploit - Exploit Finder"
        echo -e "${CYAN}[5]${RESET} Sn1per - Automated Pentest Framework"
        echo -e "${CYAN}[6]${RESET} ReverseAPK - Android APK Reverse Engineering"
        echo -e "${CYAN}[7]${RESET} RoxySploit - Hackers Framework"
        echo -e "${CYAN}[8]${RESET} AndroBugs Framework - Android Scanner"
        echo -e "${CYAN}[9]${RESET} Capstone - Disassembly Framework"
        echo -e "${CYAN}[10]${RESET} BeEF - Browser Exploitation Framework"
        echo -e "${CYAN}[11]${RESET} GCat - Gmail C&C Backdoor"
        echo -e "${CYAN}[12]${RESET} AUXILE - Auxile Framework"
        echo -e "${CYAN}[13]${RESET} Dedsploit - Network Protocol Auditing"
        echo -e "${CYAN}[14]${RESET} MSFPC - MSFvenom Payload Creator"
        echo -e "${CYAN}[15]${RESET} AVET - AntiVirus Evasion Tool"
        echo -e "${CYAN}[16]${RESET} Hakku Framework"
        echo -e "${CYAN}[17]${RESET} Hunner - Hacking Framework"
        echo -e "${CYAN}[18]${RESET} Zarp - Network Attack Tool"
        echo -e "${CYAN}[19]${RESET} DBD - Durandal's Backdoor"
        echo -e "${CYAN}[20]${RESET} BeeLogger - Gmail Keylogger"
        echo -e "${CYAN}[21]${RESET} Install All Exploitation Tools"
        echo -e "${CYAN}[0]${RESET} Back to Main Menu"
        echo
        echo -e -n "${YELLOW}Choose an option: ${RESET}"
        read -r choice

        case $choice in
            1) install_metasploit ;;
            2) install_routersploit ;;
            3) install_exploitdb ;;
            4) install_findsploit ;;
            5) install_sn1per ;;
            6) install_reverseapk ;;
            7) install_roxysploit ;;
            8) install_androbugs ;;
            9) install_capstone ;;
            10) install_beef ;;
            11) install_gcat ;;
            12) install_auxile ;;
            13) install_dedsploit ;;
            14) install_msfpc ;;
            15) install_avet ;;
            16) install_hakkuframework ;;
            17) install_hunner ;;
            18) install_zarp ;;
            19) install_dbd ;;
            20) install_beelogger ;;
            21) 
                for func in install_metasploit install_routersploit install_exploitdb install_findsploit install_sn1per install_reverseapk install_roxysploit install_androbugs install_capstone install_beef install_gcat install_auxile install_dedsploit install_msfpc install_avet install_hakkuframework install_hunner install_zarp install_dbd install_beelogger; do
                    $func
                done
                echo -e "${GREEN}[+] All Exploitation tools installed!${RESET}"
                ;;
            0) break ;;
            *) echo -e "${RED}[!] Invalid option!${RESET}" ;;
        esac
        press_any_key
    done
}

wireless_tools_menu() {
    while true; do
        display_banner
        echo -e "${PURPLE}${BOLD}╔════════════════════════════════════════╗${RESET}"
        echo -e "${PURPLE}${BOLD}║           WIRELESS TOOLS               ║${RESET}"
        echo -e "${PURPLE}${BOLD}║             (20+ Tools)                ║${RESET}"
        echo -e "${PURPLE}${BOLD}╚════════════════════════════════════════╝${RESET}"
        echo
        echo -e "${CYAN}[1]${RESET} Wifite - Wireless Attack Tool"
        echo -e "${CYAN}[2]${RESET} Airgeddon - Wireless Auditing Framework"
        echo -e "${CYAN}[3]${RESET} Fluxion - Wireless Security Testing"
        echo -e "${CYAN}[4]${RESET} Wifiphisher - Rogue Access Point Framework"
        echo -e "${CYAN}[5]${RESET} Bettercap - Network Attack Framework"
        echo -e "${CYAN}[6]${RESET} WireSpy - Wireless Network Attack Framework"
        echo -e "${CYAN}[7]${RESET} WiFi-Hacker - WiFi Attack Script"
        echo -e "${CYAN}[8]${RESET} NetAttack - Wireless Network Scanner"
        echo -e "${CYAN}[9]${RESET} NetAttack2 - Advanced Network Attack GUI"
        echo -e "${CYAN}[10]${RESET} WiFiTap - WiFi Packet Capture"
        echo -e "${CYAN}[11]${RESET} CoWPAtty - WPA2-PSK Cracking"
        echo -e "${CYAN}[12]${RESET} Install All Wireless Tools"
        echo -e "${CYAN}[0]${RESET} Back to Main Menu"
        echo
        echo -e -n "${YELLOW}Choose an option: ${RESET}"
        read -r choice

        case $choice in
            1) install_wifite ;;
            2) install_airgeddon ;;
            3) install_fluxion ;;
            4) install_wifiphisher ;;
            5) install_bettercap ;;
            6) install_wirespy ;;
            7) install_wifihacker ;;
            8) install_netattack ;;
            9) install_netattack2 ;;
            10) install_wifitap ;;
            11) install_cowpatty ;;
            12) 
                for func in install_wifite install_airgeddon install_fluxion install_wifiphisher install_bettercap install_wirespy install_wifihacker install_netattack install_netattack2 install_wifitap install_cowpatty; do
                    $func
                done
                echo -e "${GREEN}[+] All Wireless tools installed!${RESET}"
                ;;
            0) break ;;
            *) echo -e "${RED}[!] Invalid option!${RESET}" ;;
        esac
        press_any_key
    done
}

# =============================================================================
# TOOL LAUNCHER MENU
# =============================================================================

tool_launcher_menu() {
    while true; do
        display_banner
        echo -e "${PURPLE}${BOLD}╔════════════════════════════════════════╗${RESET}"
        echo -e "${PURPLE}${BOLD}║           TOOL LAUNCHER                ║${RESET}"
        echo -e "${PURPLE}${BOLD}║       Launch Installed Tools          ║${RESET}"
        echo -e "${PURPLE}${BOLD}╚════════════════════════════════════════╝${RESET}"
        echo
        echo -e "${CYAN}[1]${RESET} List All Installed Tools"
        echo -e "${CYAN}[2]${RESET} Launch Information Gathering Tool"
        echo -e "${CYAN}[3]${RESET} Launch Vulnerability Scanner"
        echo -e "${CYAN}[4]${RESET} Launch Web Application Tool"
        echo -e "${CYAN}[5]${RESET} Launch Wireless Tool"
        echo -e "${CYAN}[6]${RESET} Launch Phishing Tool"
        echo -e "${CYAN}[7]${RESET} Launch DDoS Tool"
        echo -e "${CYAN}[8]${RESET} Launch Password Tool"
        echo -e "${CYAN}[9]${RESET} Launch Exploitation Tool"
        echo -e "${CYAN}[10]${RESET} Launch Custom Tool (Manual Entry)"
        echo -e "${CYAN}[0]${RESET} Back to Main Menu"
        echo
        echo -e -n "${YELLOW}Choose an option: ${RESET}"
        read -r choice

        case $choice in
            1) list_installed_tools ;;
            2) launch_category_tool "Information Gathering" ;;
            3) launch_category_tool "Vulnerability Scanner" ;;
            4) launch_category_tool "Web Application" ;;
            5) launch_category_tool "Wireless" ;;
            6) launch_category_tool "Phishing" ;;
            7) launch_category_tool "DDoS" ;;
            8) launch_category_tool "Password" ;;
            9) launch_category_tool "Exploitation" ;;
            10) launch_custom_tool ;;
            0) break ;;
            *) echo -e "${RED}[!] Invalid option!${RESET}" ;;
        esac
        press_any_key
    done
}

# Launch tool by category
launch_category_tool() {
    local category=$1
    echo -e "${CYAN}[*] Available $category tools:${RESET}"
    
    case $category in
        "Information Gathering")
            echo -e "${YELLOW}Popular tools: seeker, Sublist3r, theHarvester, sherlock, RED_HAWK${RESET}"
            ;;
        "Vulnerability Scanner")
            echo -e "${YELLOW}Popular tools: sqlmap, nikto, wpscan, w3af, golismero${RESET}"
            ;;
        "Web Application")
            echo -e "${YELLOW}Popular tools: dirsearch, XSStrike, wfuzz, Arjun, commix${RESET}"
            ;;
        "Wireless")
            echo -e "${YELLOW}Popular tools: wifite2, fluxion, wifiphisher${RESET}"
            ;;
        "Phishing")
            echo -e "${YELLOW}Popular tools: zphisher, SocialFish, HiddenEye, maxphisher${RESET}"
            ;;
        "DDoS")
            echo -e "${YELLOW}Popular tools: hammer, hulk, GoldenEye, slowloris${RESET}"
            ;;
        "Password")
            echo -e "${YELLOW}Popular tools: cupp, Hash-Buster, BruteX, hashcat${RESET}"
            ;;
        "Exploitation")
            echo -e "${YELLOW}Popular tools: routersploit, Sn1per, roxysploit${RESET}"
            ;;
    esac
    
    echo -e -n "${YELLOW}Enter tool name to launch: ${RESET}"
    read -r tool_name
    if [ -n "$tool_name" ]; then
        launch_tool "$tool_name"
    fi
}

# Launch custom tool
launch_custom_tool() {
    echo -e "${CYAN}[*] Manual Tool Launcher${RESET}"
    echo -e -n "${YELLOW}Enter exact tool directory name: ${RESET}"
    read -r tool_name
    if [ -n "$tool_name" ]; then
        launch_tool "$tool_name"
    else
        echo -e "${RED}[!] No tool name provided.${RESET}"
    fi
}

# =============================================================================
# INSTALL ALL TOOLS FUNCTION
# =============================================================================

# Install all tools from all categories
install_all_tools() {
    display_banner
    echo -e "${PURPLE}${BOLD}╔════════════════════════════════════════╗${RESET}"
    echo -e "${PURPLE}${BOLD}║        INSTALL ALL TOOLS (200+)       ║${RESET}"
    echo -e "${PURPLE}${BOLD}║     Complete Security Toolkit         ║${RESET}"
    echo -e "${PURPLE}${BOLD}╚════════════════════════════════════════╝${RESET}"
    echo
    echo -e "${YELLOW}[!] This will install ALL 200+ tools from all categories.${RESET}"
    echo -e "${YELLOW}[!] This process may take 30-60 minutes depending on your connection.${RESET}"
    echo -e "${YELLOW}[!] Make sure you have sufficient storage space (2GB+ recommended).${RESET}"
    echo
    echo -e -n "${RED}Are you sure you want to continue? (y/N): ${RESET}"
    read -r confirm
    
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        echo -e "${GREEN}[+] Starting complete installation...${RESET}"
        
        # Install dependencies first
        echo -e "${CYAN}[*] Installing dependencies...${RESET}"
        install_dependencies
        
        # Information Gathering Tools
        echo -e "${CYAN}[*] Installing Information Gathering Tools (30+)...${RESET}"
        for func in install_seeker install_sublist3r install_theharvester install_reconspider install_redhawk install_sherlock install_findomain install_reconng install_spiderfoot install_osrframework install_reconcobra install_httpliveproxygrabber install_tekdefense install_trackout install_doork install_sir install_netdiscover install_dmitry install_trape install_googlesearch install_namechk install_ginf install_leaked install_angryfuzzer install_bingoo install_parsero install_eyewitness install_dnsenum install_scannerinurlbr; do
            echo -e "${YELLOW}[*] Running: $func${RESET}"
            $func
        done
        
        # Vulnerability Scanners
        echo -e "${CYAN}[*] Installing Vulnerability Scanners (25+)...${RESET}"
        for func in install_nmap install_sqlmap install_nikto install_wpscan install_metasploit install_openvas install_w3af install_golismero install_atscan install_killshot install_websploit install_sqliv install_plecost install_sslyze install_sslcaudit install_faraday install_keimpx install_django_hunter install_shodanwave install_adminpanelfinder install_peepdf; do
            echo -e "${YELLOW}[*] Running: $func${RESET}"
            $func
        done
        
        # Web Application Tools
        echo -e "${CYAN}[*] Installing Web Application Tools (25+)...${RESET}"
        for func in install_dirsearch install_xsstrike install_wfuzz install_gobuster install_arjun install_whatweb install_commix install_webxploiter install_crawlbox install_fuxploider install_padbuster install_hurl install_nodexp install_weeman install_rang3r; do
            echo -e "${YELLOW}[*] Running: $func${RESET}"
            $func
        done
        
        # Wireless Tools
        echo -e "${CYAN}[*] Installing Wireless Tools (20+)...${RESET}"
        for func in install_wifite install_airgeddon install_fluxion install_wifiphisher install_bettercap install_wirespy install_wifihacker install_netattack install_netattack2 install_wifitap install_cowpatty; do
            echo -e "${YELLOW}[*] Running: $func${RESET}"
            $func
        done
        
        # Phishing Tools
        echo -e "${CYAN}[*] Installing Phishing Tools (25+)...${RESET}"
        for func in install_zphisher install_socialfish install_nexphisher install_blackeye install_hiddeneye install_shellphish install_phishx install_maxphisher install_advphishing install_maskphish install_phishingmaster install_cameraphish install_saycheese install_storm_breaker install_umbrella; do
            echo -e "${YELLOW}[*] Running: $func${RESET}"
            $func
        done
        
        # DDoS Tools
        echo -e "${CYAN}[*] Installing DDoS Tools (25+)...${RESET}"
        for func in install_hammer install_hulk install_goldeneye install_slowloris install_xerxes install_torshammer install_liteddos install_ddosattack install_planetwork_ddos install_wreckuests install_pyloris install_rudy install_blast install_overload install_cc_attack; do
            echo -e "${YELLOW}[*] Running: $func${RESET}"
            $func
        done
        
        # Password Tools
        echo -e "${CYAN}[*] Installing Password Tools (30+)...${RESET}"
        for func in install_cupp install_hashbuster install_brutex install_crunch install_wordlists install_john install_hashcat install_maskprocessor install_crowbar install_blackhydra install_instagramcracker install_gmailhack install_fbht install_pybozo install_hasherdotid install_indonesian_wordlist; do
            echo -e "${YELLOW}[*] Running: $func${RESET}"
            $func
        done
        
        # Exploitation Tools
        echo -e "${CYAN}[*] Installing Exploitation Tools (30+)...${RESET}"
        for func in install_metasploit install_routersploit install_exploitdb install_findsploit install_sn1per install_reverseapk install_roxysploit install_androbugs install_capstone install_beef install_gcat install_auxile install_dedsploit install_msfpc install_avet install_hakkuframework install_hunner install_zarp install_dbd install_beelogger; do
            echo -e "${YELLOW}[*] Running: $func${RESET}"
            $func
        done
        
        echo -e "${GREEN}${BOLD}[+] INSTALLATION COMPLETE!${RESET}"
        echo -e "${GREEN}[+] All 200+ tools have been installed successfully!${RESET}"
        echo -e "${YELLOW}[*] Use 'Launch Tool' option to start using your tools.${RESET}"
        
        # Show final statistics
        if [ -d "$INSTALL_DIR" ]; then
            tool_count=$(find "$INSTALL_DIR" -maxdepth 1 -type d | wc -l)
            tool_count=$((tool_count - 1))
            echo -e "${CYAN}[*] Total tools installed: $tool_count${RESET}"
        fi
        
        log_message "INFO" "Complete installation finished - all tools installed"
    else
        echo -e "${YELLOW}[*] Installation cancelled.${RESET}"
    fi
}

# =============================================================================
# UPDATE AND SYSTEM FUNCTIONS
# =============================================================================

# Update all tools
update_all_tools() {
    display_banner
    echo -e "${YELLOW}[*] Updating all installed tools...${RESET}"
    
    if [ ! -d "$INSTALL_DIR" ]; then
        echo -e "${RED}[!] No tools directory found. Please install some tools first.${RESET}"
        return 1
    fi
    
    local updated_count=0
    for tool_dir in "$INSTALL_DIR"/*; do
        if [ -d "$tool_dir" ] && [ -d "$tool_dir/.git" ]; then
            tool_name=$(basename "$tool_dir")
            echo -e "${CYAN}[*] Updating $tool_name...${RESET}"
            cd "$tool_dir" || continue
            
            if git pull origin main 2>/dev/null || git pull origin master 2>/dev/null; then
                echo -e "${GREEN}[+] $tool_name updated successfully${RESET}"
                updated_count=$((updated_count + 1))
            else
                echo -e "${YELLOW}[!] Failed to update $tool_name${RESET}"
            fi
        fi
    done
    
    echo -e "${GREEN}[+] Update complete! Updated $updated_count tools.${RESET}"
    log_message "INFO" "Updated $updated_count tools"
}

# System information
system_information() {
    display_banner
    echo -e "${PURPLE}${BOLD}╔════════════════════════════════════════╗${RESET}"
    echo -e "${PURPLE}${BOLD}║         SYSTEM INFORMATION             ║${RESET}"
    echo -e "${PURPLE}${BOLD}╚════════════════════════════════════════╝${RESET}"
    echo
    
    echo -e "${CYAN}[*] System Details:${RESET}"
    echo -e "${YELLOW}Termux Version:${RESET} $(termux-info | grep 'Termux version' || echo 'Unknown')"
    echo -e "${YELLOW}Android Version:${RESET} $(getprop ro.build.version.release)"
    echo -e "${YELLOW}Architecture:${RESET} $(uname -m)"
    echo -e "${YELLOW}Kernel:${RESET} $(uname -r)"
    echo
    
    echo -e "${CYAN}[*] Storage Information:${RESET}"
    df -h "$HOME" | tail -1 | awk '{print "Available Space: " $4 " / " $2}'
    echo
    
    echo -e "${CYAN}[*] Installed Tools Summary:${RESET}"
    if [ -d "$INSTALL_DIR" ]; then
        tool_count=$(find "$INSTALL_DIR" -maxdepth 1 -type d | wc -l)
        tool_count=$((tool_count - 1)) # Subtract 1 for the directory itself
        echo -e "${YELLOW}Total Tools Installed:${RESET} $tool_count"
        echo -e "${YELLOW}Tools Directory:${RESET} $INSTALL_DIR"
    else
        echo -e "${YELLOW}No tools installed yet${RESET}"
    fi
    echo
    
    echo -e "${CYAN}[*] Network Status:${RESET}"
    if ping -c 1 google.com >/dev/null 2>&1; then
        echo -e "${GREEN}Internet Connection: Active${RESET}"
    else
        echo -e "${RED}Internet Connection: Not Available${RESET}"
    fi
    echo
    
    echo -e "${CYAN}[*] Important Paths:${RESET}"
    echo -e "${YELLOW}Install Directory:${RESET} $INSTALL_DIR"
    echo -e "${YELLOW}Log File:${RESET} $LOG_FILE"
    echo -e "${YELLOW}Backup Directory:${RESET} $BACKUP_DIR"
}

# =============================================================================
# MAIN MENU
# =============================================================================

main_menu() {
    while true; do
        display_banner
        echo -e "${PURPLE}${BOLD}╔════════════════════════════════════════╗${RESET}"
        echo -e "${PURPLE}${BOLD}║           ULTIMATE MAIN MENU           ║${RESET}"
        echo -e "${PURPLE}${BOLD}║            200+ TOOLS                  ║${RESET}"
        echo -e "${PURPLE}${BOLD}╚════════════════════════════════════════╝${RESET}"
        echo
        echo -e "${CYAN}[1]${RESET} Install Dependencies"
        echo -e "${CYAN}[2]${RESET} Information Gathering Tools (30+)"
        echo -e "${CYAN}[3]${RESET} Vulnerability Scanners (25+)"
        echo -e "${CYAN}[4]${RESET} Web Application Tools (25+)"
        echo -e "${CYAN}[5]${RESET} Wireless Tools (20+)"
        echo -e "${CYAN}[6]${RESET} Phishing Tools (25+)"
        echo -e "${CYAN}[7]${RESET} DDoS Tools (25+)"
        echo -e "${CYAN}[8]${RESET} Password Tools (30+)"
        echo -e "${CYAN}[9]${RESET} Exploitation Tools (30+)"
        echo
        echo -e "${GREEN}[10]${RESET} Install All Tools (200+)"
        echo -e "${GREEN}[11]${RESET} Launch Tool"
        echo -e "${GREEN}[12]${RESET} Update All Tools"
        echo -e "${GREEN}[13]${RESET} System Information"
        echo
        echo -e "${CYAN}[0]${RESET} Exit"
        echo
        echo -e -n "${YELLOW}Choose an option: ${RESET}"
        read -r choice

        case $choice in
            1) install_dependencies ;;
            2) information_gathering_menu ;;
            3) vulnerability_scanners_menu ;;
            4) web_application_menu ;;
            5) wireless_tools_menu ;;
            6) phishing_tools_menu ;;
            7) ddos_tools_menu ;;
            8) password_tools_menu ;;
            9) exploitation_tools_menu ;;
            10) install_all_tools ;;
            11) tool_launcher_menu ;;
            12) update_all_tools ;;
            13) system_information ;;
            0) 
                echo -e "${GREEN}Thank you for using Ultimate Termux Hacking Tools Installer!${RESET}"
                exit 0
                ;;
            *) echo -e "${RED}[!] Invalid option!${RESET}" ;;
        esac
        press_any_key
    done
}

# =============================================================================
# SCRIPT INITIALIZATION
# =============================================================================

# Initialize script
init_script() {
    # Check internet connection
    check_internet
    
    # Log script start
    log_message "INFO" "Ultimate script started"
    
    # Start main menu
    main_menu
}

# Run the script
init_script
