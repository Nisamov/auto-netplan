#!/bin/bash

# Ruta de ficheros del programa
program_files="/usr/local/sbin/auto-netplan"
# Idioma del programa
language=$(cat "$program_files/program-files/language.lg")
# Ultima version
response=$(curl -s https://api.github.com/repos/Nisamov/autonetplan/releases/latest)
# Lastest tag
latest_tag=$(echo "$response" | jq -r .tag_name)
# Extraccion
latest_version=$(echo "$latest_tag" | sed -n 's/v\?\([0-9]\+\.[0-9]\+\.[0-9]\+\).*/\1/p')
# Ruta de descarga ( Se ha seleccionado esta para tras la descarga, desinstalar el previo e instalar esa otra version, por lo tanto, no afectaria al programa recien descargado )
# Ejemplo de como deberia quedar: /home/autonetplan/autonetplan_0.9.0 ( solo en descargas de ultima version )
downloadrute_lookback="/home/$USER/autonetplan_$latest_version"

if [[ "$1" == "-v" || "$1" == "--version" ]]; then
    # Crear un menu de seleccion dodne el usuario pueda ver y seleccionar (no interactuable, pero si de ingresar texto)
    # Menu manual (no cuento con los conocimientos para hacer algo mas avanzado que esto, lo siento)
    echo "| Version Selection : "
    echo "9 | v.0.9.0"
    echo "8 | v.0.8.0"
    echo "7 | v.0.7.0"
    echo "6 | v.0.6.0"
    echo "5 | v.0.5.0"
    echo "4 | v.0.4.0"
    echo "3 | v.0.3.0"
    echo "2 | v.0.2.0"
    echo "1 | v.0.1.0"
    if [[ $language == "ESP" ]]; then
        read -p "[#] Ingrese la version a descargar (por caracter numerico): " dwnldversion
    else
        read -p "[#] Enter the version to download (numeric characters): " dwnldversion
    fi
    downloadrute_lookback_spfv="/home/$USER/autonetplan_$dwnldversion"
    mkdir "$downloadrute_lookback_spfv"
    
    
elif [[ "$1" == "-l" || "$1" == "--lastest" ]]; then
    # Crear ruta
    mkdir -r "$downloadrute_lookback"
    # Ultima version oficial
    git clone -b "$latest_version" --single-branch "https://github.com/Nisamov/autonetplan" "$downloadrute_lookback"
    if [[ $language == "ESP" ]]; then
        echo "[#] El software ha sido descargado en $downloadrute_lookback."
    else
        echo "[#] Software installed in $downloadrute_lookback."
    fi
fi