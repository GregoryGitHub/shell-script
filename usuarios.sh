#!/bin/bash
# usuarios.sh
#
# Mostra os logins e nomes de usuários do sistema
# Obs. Lê dados do arquivo /etc/passwd
#
# José Henrique <henriquegreg45@gmail.com>
# data de criação 13/12/2019
# Versão: 0.1

cut -d : -f1,5 /etc/passwd | tr : \\t
