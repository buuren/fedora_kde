# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

function git_url() {
	if [ -d ".git" ]; then
		url=`git config --get remote.origin.url`
		echo "~ $url"
	fi
}

function git_branch() {
	if [ -d ".git" ]; then
		branch=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/\(.*\)/ \1/'`
		echo "$branch *"
	fi
}

function git_status() {
	gitstatus=`git status 2> /dev/null`
	output=""

	untracked=`git ls-files --other --exclude-standard | wc -l`
	unstaged=`git diff --name-only | wc -l`
	staged=`git diff --name-only --staged | wc -l`

	if [ $untracked != 0 ]; then
		output="Untracked: $untracked"
	fi

	if [ $unstaged != 0 ]; then
		output="$output Unstaged: $unstaged"
	fi

	if [ $staged != 0 ]; then 
		output="$output Staged: $staged"
	fi

	echo "$output"
}

PS="""
\[\033[38;5;012m\]\t 
\[\033[38;5;047m\]\u
\[\033[38;5;158m\]@
\[\033[38;5;078m\]\H 
\[\033[38;5;158m\][
\[\033[38;5;192m\]\w
\[\033[38;5;158m\]] 
\[\033[38;5;051m\]\$(git_url)
\[\033[38;5;159m\]\$(git_branch)\[$(tput sgr0)\] 
\[\033[48;5;196m\]\$(git_status)\[$(tput sgr0)\]
\n
\[\033[38;5;011m\]# \$?
\[\033[38;5;202m\]> \[$(tput sgr0)\]
"""

# User specific aliases and functions
export PS1=`echo "${PS}" | tr -d '\n'`

PATH=$PATH:$HOME/.local/bin:$HOME/bin:/opt/jdk1.8.0_121/bin/:/opt/git/bin

export ORACLE_HOME=/opt/oracle-12c/instantclient_12_1/
export CLASSPATH=$ORACLE_HOME
export LD_LIBRARY_PATH=$CLASSPATH
export NLS_LANG=american_america.BLT8MSWIN1257
export TNS_ADMIN=$ORACLE_HOME/network/admin
export PATH=$PATH:$HOME/.local/bin:$HOME/bin:/opt/jdk1.8.0_121/bin/:/opt/git/bin:$ORACLE_HOME:/opt/gradle-3.3/bin/
