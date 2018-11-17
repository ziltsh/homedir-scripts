#
# Makefile for github respository homedir-scripts
# $Id$
#

MAKEFLAGS = 
#MAKEFLAGS = -s

INSTALL = /usr/bin/install
I_OPT   = -p

PKG     = playground
DESTDIR = debian
# from the environment, hopefully the users homedir
HOMEDIR = ${DESTDIR}${HOME}
AVAILABLE_DIR =	${DESTDIR}/${HOME}/.bashrc-avail.d
ENABLED_DIR = ${DESTDIR}/${HOME}/.bashrc-enabled.d

default:
	make -s usage
.PHONY: default

i: install
install: install_dir install_file link_file
	make -s install_instructions printtree
install_dir:
	-${INSTALL} ${I_OPT} -m 0750 -d ${DESTDIR}
	-${INSTALL} ${I_OPT} -d ${HOMEDIR}
	${INSTALL} ${I_OPT} -m 0750 -d ${AVAILABLE_DIR}
	${INSTALL} ${I_OPT} -m 0750 -d ${ENABLED_DIR}
install_file:
	${INSTALL} bashrc.common ${HOMEDIR}/.bashrc.common
	${INSTALL} avail.d/bak ${AVAILABLE_DIR}/bak
	${INSTALL} avail.d/cvs ${AVAILABLE_DIR}/cvs
	${INSTALL} avail.d/ssh-agent ${AVAILABLE_DIR}/ssh-agent
	${INSTALL} avail.d/zz-tmux-list-sessions ${AVAILABLE_DIR}/zz-tmux-list-sessions
link_file:
	-ln -sv ../.bashrc-avail.d/bak ${ENABLED_DIR}/bak
	-ln -sv ../.bashrc-avail.d/ssh-agent ${ENABLED_DIR}/ssh-agent
	-ln -sv ../.bashrc-avail.d/zz-tmux-list-sessions ${ENABLED_DIR}/zz-tmux-list-sessions
.PHONY: i install install_dir install_file

u: uninstall
uninstall: unlink_file uninstall_file uninstall_dir
	make -s printtree
uninstall_dir:
	-rmdir ${AVAILABLE_DIR}
	-rmdir ${ENABLED_DIR}
uninstall_file:
	rm -fv ${HOMEDIR}/.bashrc.common
	rm -fv ${AVAILABLE_DIR}/bak
	rm -fv ${AVAILABLE_DIR}/cvs
	rm -fv ${AVAILABLE_DIR}/ssh-agent
	rm -fv ${AVAILABLE_DIR}/zz-tmux-list-sessions
.PHONY: u uninstall uninstall_dir uninstall_file
unlink_file:
	-rm -fv ${ENABLED_DIR}/bak
	-rm -fv ${ENABLED_DIR}/cvs
	-rm -fv ${ENABLED_DIR}/ssh-agent
	-rm -fv ${ENABLED_DIR}/zz-tmux-list-sessions
.PHONY: unlink_file


#homedir:
#	printf "# homedir: %s\n" "${HOMEDIR}"
#.PHONY: homedir

install_instructions:
	printf "+ hook-up to the ~/.bashrc script with:\n"
	printf "\n   [ -r ~/.bashrc.common] && . ~/.bashrc.common\n\n"
.PHONY: install_instructions

printtree:
	#printf "\n"
	find ./${DESTDIR} -ls
.PHONY: printtree

usage:
	printf "\n"
	printf "  Usage: make [-s] {install|uninstall}\n"
	printf "                   {printtree}\n"
	printf "                   {default|usage}\n"
	printf "\n"
.PHONY: usage


#.
