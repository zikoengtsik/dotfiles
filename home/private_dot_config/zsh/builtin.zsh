#!/usr/bin/env zsh

# ================================================================ #
# Zsh Options
# ref: https://zsh.sourceforge.io/Doc/Release/Options.html
# ================================================================ #

# Changing Directories.
setopt auto_cd                  # Change To Directory Without Having To Type 'cd'.

# Completion.
setopt always_to_end            # Move Cursor To The End Of A Completed Word.
setopt auto_list                # Automatically List Choices On Ambiguous Completion.
setopt auto_menu                # Show Completion Menu On A Single Tab.
setopt auto_param_slash         # Add A Trailing Slash To Completed Symlinks.
setopt complete_aliases         # Allow Complete Aliases.
setopt complete_in_word         # Allow Completion Within A Word.
setopt glob_complete            # Perform Completion Globbing.
setopt list_packed              # The completion menu takes less space.
setopt list_rows_first          # Show rows first when completing.
unsetopt menu_complete          # Don't automatically Insert The First Matched Directory.

# Expansion and Globbing.
setopt brace_ccl                # Allow Brace Character Class List Expansion.
unsetopt case_glob              # Perform Case-Insensitive Globbing.
setopt extended_glob            # Enable Extended Globbing Operators.
setopt glob_dots                # Include Dot Files In Globbing.

# History.
HISTFILE="${ZSH_STATE_DIR}/history"         # Set The History File.
HISTSIZE=65536                              # Save 65536 Lines Of History Within The Shell.
SAVEHIST=65536                              # Save 65536 Lines Of History Within The History File.
setopt appendhistory notify                 # Append History To The History File When Exiting.
setopt bang_hist                            # Treat The '!' Character Specially During Expansion.
setopt inc_append_history                   # Write To The History File Immediately, Not When The Shell Exits.
setopt share_history                        # Share History Between All Sessions.
setopt hist_expire_dups_first               # Expire A Duplicate Event First When Trimming History.
setopt hist_ignore_dups                     # Do Not Record An Event That Was Just Recorded Again.
setopt hist_ignore_all_dups                 # Delete An Old Recorded Event If A New Event Is A Duplicate.
setopt hist_find_no_dups                    # Don't Display A Previously Found Event.
setopt hist_ignore_space                    # Don't Record An Event Starting With A Space.
setopt hist_save_no_dups                    # Don't Write A Duplicate Event To The History File.
setopt hist_verify                          # Don't Execute Immediately Upon History Expansion.
setopt extended_history                     # Show Timestamp In History.
setopt hist_reduce_blanks                   # Remove Superfluous Blanks Before Recording Entry.

# Input/Output.
setopt correct                  # Turn On Corrections.
unsetopt flow_control           # Disable Flow Control.
setopt interactive_comments     # Allow Comments In Interactive Shells.
setopt path_dirs                # Perform Path Search Even On Command Names With Slashes.
setopt rc_quotes                # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.

# Job Control.
setopt auto_resume              # Attempt To Resume Existing Job Before Creating A New Process.
unsetopt bg_nice                # Don't Run All Background Jobs At A Lower Priority.
unsetopt check_jobs             # Don't Report On Jobs When Shell Exit.
unsetopt hup                    # Don't Kill Jobs On Shell Exit.
setopt long_list_jobs           # List Jobs In The Long Format By Default.
setopt notify                   # Report Status Of Background Jobs Immediately.

# Prompting.
setopt prompt_subst             # Enable Substitution In Prompt Strings.

# Zle.
unsetopt beep                   # Don't Beep On Errors.
setopt combining_chars          # Combine Zero-Length Punctuation Characters ( Accents ) With The Base Character.

# ================================================================ #
# Zsh Completion System
# ref: https://zsh.sourceforge.io/Doc/Release/Completion-System.html
# ================================================================ #

# Use menu completion
zstyle ':completion:*' menu select

# Group results by category
zstyle ':completion:*' group-name ''

# Enable approximate completions
zstyle ':completion:*' completer _complete _correct _expand _match _list _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3)) numeric)'

# Keep directories and files separated
zstyle ':completion:*' list-dirs-first true

# Use dircolors $LS_COLORS for completion when possible
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Automatically update PATH entries
zstyle ':completion:*' rehash true

# Directories
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:cd:*' ignore-patterns parent pwd
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# Commands
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins commands functions

# Case-insensitive (all), partial-word, and then substring completion.
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Enable completion caching, use rehash to clear
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ${ZSH_CACHE_DIR}

# Don't complete hosts from /etc/hosts
zstyle -e ':completion:*' hosts 'reply=()'

# Nicer format for completion messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}- %d (errors: %e) -%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %d --%f'
zstyle ':completion:*:*:*:*:messages' format '%F{purple}-- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format '%F{red}- no matches found -%f'

# Don't complete uninteresting stuff unless we really want to.
zstyle ':completion:*' single-ignored show
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*:*:*:users' ignored-patterns \
		adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
		clamav cyrus daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
		gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
		ldap lp mail mailman mailnull man messagebus mldonkey mysql nagios \
		named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
		operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
		rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
		usbmux uucp vcsa wwwrun xfs cron mongodb nullmail portage redis \
		shoutcast tcpdump '_*'
