Programa configuracion automatica > netplan

Clonar repositorio:
    instalar git:
        sudo apt install git
    clonar repositorio:
        git clone https://github.com/Nisamov/auto-netplan (ruta)
    ejecutar instalador:
        cd 7home/$USER/downloads
        cd auto-netplan
        sudo bash instalacion.sh

Llamar al programa:
    autonetplan.sh (introducir parametros)

Paramteros:
    $1:_
        -h      / --help            >> Mostrar ayuda del programa
        -r      / --remove          >> Desinstalar el programa
        -l      / --license         >> Mostrar licencia del programa
        -b      / --backup          >> Crear copia seguridad configuracion actual red
        -x      / --execute         >> Continuar con la ejecucion del programa
    $2:_
        -m      / --manual          >> Configuracion manual
        -a      / --automatic       >> Configuracion automatica
    $3:_
        -f      / --fluid           >> Configuracion DHCP (red fluida)
        -s      / --static          >> Configuracion fija (red estatica)
    $4:_
        -iface  / --interface       >> Indicar posteriormente la interfaz a usar
    $5:_
        -ip     / --ipconfigure     >> indicar posteriormente la ip fija (solo tras haber indicado previamente '-s')
    $6:_
        -ntmk   / --netmask         >> Establecer mascara de red posteriormente


        linkeddoor
    $7:_
        (Implementacion de mas interfaces de red usar, en futuras version irá una nueva version del programa con dicha implementacion)

[!] Ejemplo uso:
    Apertura de soporte:
        autonetplan.sh -h
    Desinstalar programa:
        autonetplan.sh -r
    Establecer ip manualmente:
        autonetplan.sh -x -m
    Estalecer ip automaticamente y conexion por dhcp
        autonetplan.sh -x -a -f
    Establecer ip automaticamente con ip fija
        autonetplan.sh -x -a -s -iface enp0s3 -ip 192.168.10.120 -ntmk 16 -gtw 192.168.10.1

Exit Codes:
    exit 0 > Codigo de salida por introduccion de valor erroneo
    exit 1 > Codigo de salida por salida exitosa del programa

// Ejemplo estructura programa
-x
└── -m
└── -a
     └── -f
     └── -s
          └── -iface
                 └── -ip
                      └── -ntmk
                            └── -pintf (plus interfaces) - dentro de un while que ira añadiendo interfaces