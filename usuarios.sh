#!/bin/bash
# usuarios.sh
#
# Mostra os logins e nomes de usuários do sistema
# Obs. Lê dados do arquivo /etc/passwd
#
# José Henrique <henriquegreg45@gmail.com>
# data de criação 13/12/2019
#
# Versão: 0.1 Mostra usuários e nomes separados por TAB
# Versão: 0.2 Adicionado suporte à opção -h

MSG_USO="

    Uso: $0 [-h]
    -h      Mostra essa tela de ajuda e sai.

"
# Tratamento das opções de linha de comando.
if test "$1" = "-h"
then
    echo "$MSG_USO"
    exit 0
fi

# Processamento
cut -d : -f1,5 /etc/passwd | tr : \\t
