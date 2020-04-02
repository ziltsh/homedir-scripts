#
# Makefile for github respository homedir-scripts
# $Id$
#

MAKEFLAGS = 
#MAKEFLAGS = -s
TODAY   = `date '+%Y%m%d'`

INSTALL = /usr/bin/install
I_OPT   = -p -v --suffix=.bak${TODAY} -b

PKG     = playground
DESTDIR = debian
# from the environment, hopefully the users homedir
HOMEDIR = ${DESTDIR}${HOME}
BIN_DIR = ${DESTDIR}/${HOME}/bin
AVAILABLE_DIR =	${DESTDIR}/${HOME}/.bashrc-avail.d
ENABLED_DIR = ${DESTDIR}/${HOME}/.bashrc-enabled.d

default:
	printf "today is %s\n" "${TODAY}"
	make -s usage
.PHONY: default

i: install
install: install_dir install_file link_file
	make -s user install_instructions printtree
install_dir:
	#-${INSTALL} ${I_OPT} -m 0750 -d ${DESTDIR}
	#-${INSTALL} ${I_OPT} -d ${HOMEDIR}
	-${INSTALL} ${I_OPT} -d ${BIN_DIR}
	${INSTALL} ${I_OPT} -m 0750 -d ${AVAILABLE_DIR}
	${INSTALL} ${I_OPT} -m 0750 -d ${ENABLED_DIR}
install_file:
	${INSTALL} ${I_OPT} bashrc.common ${HOMEDIR}/.bashrc.common
	${INSTALL} ${I_OPT} muttrc ${HOMEDIR}/.muttrc
	${INSTALL} ${I_OPT} vimrc ${HOMEDIR}/.vimrc
	${INSTALL} ${I_OPT} git-puller ${BIN_DIR}/
	${INSTALL} ${I_OPT} avail.d/* ${AVAILABLE_DIR}/
link_file:
	-ln -sv ../.bashrc-avail.d/bak ${ENABLED_DIR}/bak
	-ln -sv ../.bashrc-avail.d/bash-history ${ENABLED_DIR}/bash-history
	-ln -sv ../.bashrc-avail.d/dimmer ${ENABLED_DIR}/dimmer
	-ln -sv ../.bashrc-avail.d/git-aliases ${ENABLED_DIR}/git-aliases
#	-ln -sv ../.bashrc-avail.d/ssh-agent ${ENABLED_DIR}/ssh-agent
	-ln -sv ../.bashrc-avail.d/user-cron-backup ${ENABLED_DIR}/user-cron-backup
	-ln -sv ../.bashrc-avail.d/zz-tmux-list-sessions ${ENABLED_DIR}/zz-tmux-list-sessions
.PHONY: i install install_dir install_file

u: uninstall
uninstall: unlink_file uninstall_file uninstall_dir
	make -s printtree
uninstall_dir:
	-rmdir ${BIN_DIR}
	-rmdir ${AVAILABLE_DIR}
	-rmdir ${ENABLED_DIR}
uninstall_file:
	rm -fv ${HOMEDIR}/.bashrc.common
	rm -fv ${HOMEDIR}/.muttrc
	rm -fv ${HOMEDIR}/.vimrc
	rm -fv ${AVAILABLE_DIR}/bak
	rm -fv ${AVAILABLE_DIR}/bash-history
	rm -fv ${AVAILABLE_DIR}/cvs
	rm -fv ${AVAILABLE_DIR}/dimmer
	rm -fv ${AVAILABLE_DIR}/git
	rm -fv ${AVAILABLE_DIR}/git-aliases
	rm -fv ${AVAILABLE_DIR}/ssh-agent
	rm -fv ${AVAILABLE_DIR}/user-cron-backup
	rm -fv ${AVAILABLE_DIR}/zz-tmux-list-sessions
	rm -fv ${BIN_DIR}/git-puller
.PHONY: u uninstall uninstall_dir uninstall_file
unlink_file:
	-rm -fv ${ENABLED_DIR}/bak
	-rm -fv ${ENABLED_DIR}/bash-history
	-rm -fv ${ENABLED_DIR}/cvs
	-rm -fv ${ENABLED_DIR}/dimmer
	-rm -fv ${ENABLED_DIR}/git-aliases
	-rm -fv ${ENABLED_DIR}/ssh-agent
	-rm -fv ${ENABLED_DIR}/user-cron-backup
	-rm -fv ${ENABLED_DIR}/zz-tmux-list-sessions
.PHONY: unlink_file


#homedir:
#	printf "# homedir: %s\n" "${HOMEDIR}"
#.PHONY: homedir

user:
	printf "+ user: %s\n" "${USER}"
.PHONY: user

install_instructions:
	printf "+ hook-up to the ~/.bashrc script with:\n"
	printf "\n[ -r ~/.bashrc.common ] && . ~/.bashrc.common  # homedir-scripts\n\n"
.PHONY: install_instructions

printtree:
	#printf "\n"
	[ -z "${DESTDIR}" ] \
		|| find ./${DESTDIR} -ls
.PHONY: printtree

usage:
	printf "\n"
	printf "  Usage: make [-s] {install|uninstall}\n"
	printf "                   {printtree}\n"
	printf "                   {default|usage}\n"
	printf "\n"
	printf "  user: %s\n" "${USER}"
	printf "  i.e:  make -s install DESTDIR=testdir\n"
	printf "  would install in <destdir>/<user homedir> -> testdir${HOME}\n"
	printf "\n"
	make -s user install_instructions
.PHONY: usage


#.
