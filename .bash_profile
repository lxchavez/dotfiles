export PATH=/usr/local/bin:/Users/achavez/Library/Python/2.7/bin:$HOME/.local/bin:$PATH

# vi fun
export VISUAL=vim
export EDITOR="$VISUAL"
set -o vi

alias ll="ls -lah"

#==========================================================
# ALIASES -- Keep in #SYNC with DE TUNNEL SCRIPT
# (Last copied here 20180522)
#==========================================================
alias dbconn-prod-dw01_dmf='USAGE: Configure DB TOOLS to connect to DW01 db via host=localhost,port=55432'
alias dbconn-prod-dw02_dmf='USAGE: Configure DB TOOLS to connect to DW02 db via host=localhost,port=56432'
alias dbconn-prod-dwdev_dmf='USAGE: Configure DB TOOLS to connect to DWDEV db via host=localhost,port=56439'
alias dmf_aliases_dbconn='echo ""; echo "*** LIST OF ALL DMF DBCONN ALISES: ***"; echo ""; echo "$(alias | grep -i dbconn | egrep -i "_dmf|dmf_") "
'
alias dmf_aliases_rdp='echo ""; echo "*** LIST OF ALL DMF RDP ALISES: ***"; echo ""; echo "$(alias | grep -i rdp | egrep -i "_dmf|dmf_") "'
alias dmf_aliases_ssh='echo ""; echo "*** LIST OF ALL DMF SSH ALISES: ***"; echo ""; echo "$(alias | grep -i ssh | egrep -i "_dmf|dmf_") "'
alias dmf_ps_psnl_ssh='echo ""; echo "*** LIST OF ALL PSNL SSH PROCESSES (REGARDLESS of DMF): ***"; echo ""; echo "$(ps | grep -i ssh) "'
alias helpme='echo -e '\''\n*** MAIN HELPME: SHOWING ALL DMF ALIASES ETC: ***\n'\''; alias | grep -i '\''dmf'\'' '
alias rdp-prod-rdp01_dmf='USAGE: Configure RDP to connect to RDP01 server via host=localhost,port=53389'
alias rdp-prod-report01_dmf='USAGE: Configure RDP to connect to REPORT01 server via host=localhost,port=52389'
alias ssh-prod-dw01_dmf='ssh alex_chavez@localhost -p 55022'
alias ssh-prod-dw02_dmf='ssh alex_chavez@localhost -p 56022'
alias ssh-prod-dwdev_dmf='ssh alex_chavez@localhost -p 57022'
alias ssh-prod-etl01_dmf='ssh alex_chavez@localhost -p 51022'
#==========================================================


# startup virtualenv-burrito
if [ -f $HOME/.venvburrito/startup.sh ]; then
    . $HOME/.venvburrito/startup.sh
fi
