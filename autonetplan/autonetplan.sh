#!/bin/bash
# Programa autonetplan
# Este programa permite configurar la red de tu equipo de manera automatica, evitando problemas de aplicacion, espacios o tabuladores
# Licencia Apache2.0

# Declaracion variable directorio de configuracion netplan
network_dir="/etc/netplan/00-installer-config.yaml"
work_dir="/usr/local/sbin"
program_files="/usr/local/sbin/auto-netplan/"
INSTALL_DIR="/usr/local/sbin"
MANUAL="/usr/share/man/man1/autonetplan"

function aune-help(){
    echo "Soporte AutoNetplan"
    echo ""
    echo "Principales valores '$.1':"
    echo "  -h | --help :: Mostrar ayuda de la ruta raiz, tras haber instalado el programa"
    echo "  -r | --remove :: Desinstalar programa"
    echo "  -l | --license :: Mostrar licencia del programa"
    echo "  -b | --backup :: Creacion de copia de seguridad de configuracion de red"
    echo "  -x | --execute :: Continuacion con el programa"
    echo ""
    echo "Valores segunda categoría '$.2'"
    echo "  -m | --manual :: Configuracion de red manual"
    echo "  -a | --automatic :: Configuracion de red automatica"
    echo ""
    echo "Valores tercera categoria '$.3'"
    echo "  -f | --fluid :: Configuracion DHCP (red fluida)"
    echo "  -s | --static :: Configuracion fija (red estatica)"
}

function aune-remove(){
    # Funcion desinstalar programa
    sudo rm -rf $program_files
    sudo rm -f $INSTALL_DIR/autonetplan
    sudo rm -f $MANUAL
}

function aune-backup(){
    # Funcion guardar copia de seguridad con numero progresivo para evitar reemplazar ficheros
    local backup_number=0
    local backup_file
    echo "[#] Copiando fichero $network_dir..."
    sudo cp "$network_dir" "$network_dir.bk"
    echo "[#] Copia completada."
}

function netplanapply(){
    # Preguntar si aplicar cambios de red
    read -p "Desea aplicar los cambios antes de continuar? (s/n): " netwapply
    if [[ $netwapply == "s" ]]; then
        sudo netplan apply
    elif [[ $netwapply == "n" ]]; then
        echo -e "[\e[31m#\e[0m] Se ha denegado la aplicacion de cambios."
    else
        # Mensaje rojo - referencia
        echo -e "[\e[31m#\e[0m] Se ha introducido un valor no registrado."
        # Mensaje verde - referencia
        echo -e "[\e[32m#\e[0m] Se han aplicado los cambios por seguridad."
        sudo netplan apply
    fi
}

function aune-networked(){
    # Configuracion de red por autonetplan
            echo "Configuración de red por configuracion automatica..."
            sudo cat <<EOF > "$network_dir"
# Editado con autonetplan
network:
  version: 2
  renderer: networkd
  ethernets:
    $iface:
      dhcp4: no
      addresses: [$ipconfigure/$masked]
      gateway4: $linkeddoor
EOF
}

if [[ $1 == "-h" || $1 == "--help" ]]; then
    # Mostrar ayuda de la ruta raiz, tras haber instalado el programa
    # Llamada de funcion ayuda
        aune-help
elif [[ $1 == "-r" || $1 == "--remove" ]]; then
    # Llamada de funcion aune-remove
        aune-remove
elif [[ $1 == "-b" || $1 == "--backup" ]]; then
    # Creacion de copia de seguridad de configuracion de red
    # Llamada a funcion aune-backup
        aune-backup
elif [[ $1 == "-l" || $1 == "--license" ]]; then
    # Lectura de fichero de licencia
        sudo less "$program_files/LICENSE.txt"

# Continuacion con el programa

elif [[ $1 == "-x" || $1 == "--execute" ]]; then
    # Continuacion de programa
    if [[ $2 == "-m" || $2 == "--manual" ]]; then
        sudo nano "$network_dir"
    elif [[ $2 == "-a" || $2 == "--automatic" ]]; then
        # Configuracion automatica
        # Continuacion de programa
        if [[ $3 == "-f" || $3 == "--fluid" ]]; then
            # Configuracion de red por DHCP
            echo "Configuración de red por DHCP..."
            sudo cat <<EOF > "$network_dir"
# Editado con autonetplan
network:
  version: 2
  renderer: networkd
  ethernets:
  # Se ha asignado una mascara generica, editela si ve necesario
    enp0s3:
      dhcp4: yes
EOF
        elif [[ $3 == "-s" || $3 == "--static" ]]; then
            # Configuracion de red por ip estatica
            # Continuacion de programa
            if [[ $4 == "-iface" || $4 == "--interface" ]]; then
                # Preguntar por interfaz de red a usar
                read -p "Ingrese la interfaz de red a usar: " iface
                if [[ $5 == "-ip" || $5 == "--ipconfigure" ]]; then
                    # Preguntar por ip a almacenar
                    read -p "Ingrese la direccion IP a usar: " ipconfigure
                    if [[ $6 == "-ntmk" || $6 == "--netmask" ]]; then
                        # Preugntar por mascara de red a agregar
                        read -p "Ingrese la mascara de red a agregar: " masked
                        if [[ $7 == "-lnkd" || $7 == "--linkeddoor" ]]; then
                            # Preguntar por puerta de enlace
                            read -p "Ingrese una puerta de enlace: " linkeddoor
                        else
                            # Mensaje por error de valores
                            echo -e "[\e[31m#\e[0m] No se ha ingresado una puerta de enlace: '-ntmk'."
                        fi
                        # Llamada del programa configuracion completa
                        aune-networked
                        # Tras la configuracion, preguntar si guardar cambios
                        # Llamada a la funcion de aplicacion de cambios en fichero netplan
                        netplanapply
                    else
                        # Mensaje por error de valores
                        echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-ntmk', valor ingresado: '$6'."
                        # Error por ingreso de valores erroneos
                        exit 1
                    fi
                else
                    # Mensaje por error de valores
                    echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-ip', valor ingresado: '$5'."
                    # Error por ingreso de valores erroneos
                    exit 1
                fi
            else
                # Mensaje por error de valores
                echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-iface', valor ingresado: '$4'."
                # Error por ingreso de valores erroneos
                exit 1
            fi
        else
            # Mensaje por error de valores
            echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-f' o '-s', valor ingresado: '$3'."
            # Error por ingreso de valores erroneos
            exit 1
        fi
    else
        # Mensaje por error de valores
        echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-m' o '-a', valor ingresado: '$2'."
        # Error por ingreso de valores erroneos
        exit 1
    fi
else
    # Mensaje por error de valores
    echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-h', '-r', '-b', '-l' o '-x', valor ingresado: '$1'."
    # Error por ingreso de valores erroneos
    exit 1
fi