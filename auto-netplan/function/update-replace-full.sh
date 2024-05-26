#!/bin/bash

# Declaracion de variables
program_files="/usr/local/sbin/auto-netplan"
# Se usa el idioma ya usado en versiones previas
language=$(cat $program_files/program-files/language.lg)
#   Nueva version  (new version)
nwvsn="/usr/local/sbin/auto-netplan/temp"

# Contenido a reemplazar
#   version [done]
#   Todos los ficheros .sh
#   Fichero de configuracion [done]
#   Fichero .help [done]
#   Fichero .man [done]

# Comprobar existencia de fichero de version
if [[ -f "$nwvsn/program-files/version" ]]; then
    # Eliminar fichero local
    sudo rm "$program_files/program-files/version"
    # Copiar fichero descargado a ruta indicada
    sudo cp "$nwvsn/program-files/version" "/usr/local/sbin/auto-netplan/program-files/version"
    if [[ $language == "ESP" ]]; then
        echo "[#] Fichero de version actualizado correctamente."
    elif [[ $language == "ENG" ]]; then
        echo "[#] Version file correctly updated."
    else
        echo "[#] Version file correctly updated." 
    fi
fi

# Comprobar fichero de configuracion
if [[ -f "$nwvsn/auneconf/autonetplan.conf" ]]; then
    # Eliminar fichero de configuracion local
    sudo rm "/etc/autonetplan/autonetplan.conf"
    # Copiar fichero descargado a ruta indicada
    sudo cp "$nwvsn/auneconf/autonetplan.conf" "/etc/autonetplan/autonetplan.conf"
    if [[ $language == "ESP" ]]; then
        echo "[#] FIchero de configuracion actualizado corractamente."
    elif [[ $language == "ENG" ]]; then
        echo "[#] Configuration file correctly updated."
    else
        echo "[#] Configuration file correctly updated."
    fi
fi

# Comprobar fichero de manual
if [[ -f "$nwvsn/program-files/autonetplan.man" ]]; then
    # Eliminar fichero manual local
    sudo rm "$program_files/program-files/autonetplan.man"
    # Copiar fichero descargado a ruta indicada
    sudo cp "$nwvsn/program-files/autonetplan.man" "$program_files/program-files/autonetplan.man"
    if [[ $language == "ESP" ]]; then
        echo "[#] Fichero de manual actualizado correctamente."
    elif [[ $language == "ENG" ]]; then
        echo "[#] Manual correctly updated."
    else
        echo "[#] Manual correctly updated."
    fi
fi

# Comprobar fichero de mhelp
if [[ -f "$nwvsn/program-files/autonetplan.help" ]]; then
    # Eliminar fichero manual local
    sudo rm "$program_files/program-files/autonetplan.help"
    # Copiar fichero descargado a ruta indicada
    sudo cp "$nwvsn/program-files/autonetplan.help" "$program_files/program-files/autonetplan.help"
    if [[ $language == "ESP" ]]; then
        echo "[#] Fichero de ayuda actualizado correctamente."
    elif [[ $language == "ENG" ]]; then
        echo "[#] Help file correctly updated."
    else
        echo "[#] Help file correctly updated."
    fi
fi

# Finalizacion de actualizacion
if [[ $language == "ESP" ]]; then
    echo -e "[\e[32m#\e[0m] Actualizacion finalizada correctamente."
elif [[ $language == "ENG" ]]; then
    echo -e "[\e[32m#\e[0m] Update finished correctly."
else
    echo -e "[\e[32m#\e[0m] Update finished correctly."
fi