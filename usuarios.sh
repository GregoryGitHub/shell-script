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
# Versão 6: Adiciona as opçoes -r,--reverse,-u,--uppercase
#           Leitura de múltiplas opções
#
#
# José Henrique <henriquegreg45@gmail.com>
# data de criação 13/12/2019

ordenar=0 # A saída deve ser ordenada de forma alfabética?
maiuscula=0 # A saída de ser toda maiúscula?
inverte=0 # A saida ordenada deve ser invertida?

MSG_USO="

    Uso: $(basename $0) [OPÇÕES]

        -r,--reverse     Inverte a listagem.
        -s,--sort        Ordena a saída alfabeticamente.
        -u,--uppercase   Mostra a listagem em maiúsculas.
        -V,--version     Mostra a versão do programa e sai.
        -h,--help        Mostra essa tela de ajuda e sai.

"
# Tratamento das opções de linha de comando.
while test -n "$1"
do
    case "$1" in
    # Opções que trocam chaves 
    -s|--sort) ordenar=1 ;;
    -r|--reverse) inverte=1 ;;
    -u|--uppercase) maiuscula=1 ;;

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

    *)
  
    if test -n "$1"
    then
        # Opção inválida
        echo "Opção inválida: $1"
        exit 1
    fi
;;
esac
# Opção $1 já processada, chamando o próximo da fila
  shift
done


# Extrai a listagem
lista=$(cut -d : -f1,5 /etc/passwd)

test "$ordenar" = 1 && lista=$(echo "$lista" | sort)
test "$maiuscula" = 1 && lista=$(echo "$lista" | tr a-z A-Z)
test "$inverte" = 1 && lista=$(echo "$lista" | tac)

# Mostra o resultado para o usuário
echo "$lista" | tr : \\t
