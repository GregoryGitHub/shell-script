#!/bin/bash
# usuarios.sh
#
# Mostra os logins e nomes de usuários do sistema
# Obs. Lê dados do arquivo /etc/passwd
#
# ------------- Resumo das versões -----------------------------
# Versão 1: Mostra usuários e nomes separados por TAB
# Versão 2: Adicionado suporte à opção -h
# Versão 3: Adicionado suporte à opção -V e opções inválidas
# Versão 4: Arrumado bug quando não tem opções, basename no
#           nome do programa, -V extraindo direto dos cabeçlhos,
#           adicionadas opções --help e --version
# Versão 5: Adiciona as opções -s e --sort para ordenar a 
#           saída.
#
#
# José Henrique <henriquegreg45@gmail.com>
# data de criação 13/12/2019

ordenar=0 # A saída deve ser ordenada de forma alfabética?

MSG_USO="

    Uso: $(basename $0) [-h|-V|-s]

        -h,--help        Mostra essa tela de ajuda e sai.
        -V,--version     Mostra a versão do programa e sai.
        -s,--sort        Ordena a saída alfabeticamente.

"
# Tratamento das opções de linha de comando.
case "$1" in
-h|--help)
    echo "$MSG_USO"
    exit 0
;;
-V|--version)
    # Mostra a versão
    printf $(basename "$0") 

    # Extrai a versão diretamente dos cabeçalhos do programa
    grep '^# Versão ' "$0" | tail -1 | cut -d : -f 1 | tr -d \#

    exit 0
;;
-s|--sort)
    # Altera o valor de ordenar
    ordenar=1
;;
*)
    if test -n "$1"
    then
    # Opção inválida
    echo "Opção inválida: $1"
    exit 1
    fi
;;
esac

# Processamento
# Extrai a listagem
lista=$(cut -d : -f1,5 /etc/passwd)

if test "$ordenar" = 1
then
    lista=$(echo "$lista" | sort)
fi
 echo "$lista" | tr : \\t
