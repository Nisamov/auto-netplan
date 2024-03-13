#!/bin/bash

# Programa por github.com/Nisamov
# Licencia Apache2.0

#Programa instalacion servicio autonetplan

# Ruta del directorio donde se encuentra el script de instalación
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Ruta instalacion super usuario
INSTALL_DIR="/usr/local/sbin"

# Ruta ficheros programa super usuario
PROGRAM_FILES="/usr/local/sbin/auto-netplan/"

while [[ ! -d $PROGRAM_FILES ]]; do
   # Creacion directorio $PROGRAM_FILES
    sudo mkdir -p $PROGRAM_FILES
    # Si el directorio existe
    if [[ -d $PROGRAM_FILES ]]; then
         # Mensaje instalacion correcta
        echo "[#] Se ha creado la ruta $PROGRAM_FILES exitosamente"
   # Si el directorio no existe
    else
        echo -e "[\e[31m#\e[0m] No se ha clonado $PROGRAM_FILES correctamente, intentando de nuevo..."
        # Espera 1 segundo antes de intentar de nuevo
        sleep 1
    fi
done

# Copiar el script principal al directorio de instalación renombrando el programa como autonetplan
while [[ ! -f "$INSTALL_DIR/autonetplan" ]]; do
    # Copiar el archivo
    sudo cp "$SCRIPT_DIR/autonetplan/autonetplan.sh" "$INSTALL_DIR/autonetplan"
    # Verificar si la copia se realizó correctamente
    if [[ -f "$INSTALL_DIR/autonetplan" ]]; then
        # Mensaje de copia exitosa
        echo "[#] El script principal se ha copiado exitosamente a $INSTALL_DIR/autonetplan"
        # Dar permisos de ejecución al script principal
        sudo chmod +x "$INSTALL_DIR/autonetplan"
        # Mensaje tras otorgar correctamente los permisos
        echo "[#] Permisos necesarios otorgados correctamente"
    else
        # Mensaje si la copia no se realizó correctamente
        echo -e "[\e[31m#\e[0m] No se ha copiado el script principal correctamente, intentando de nuevo..."
        # Espera 1 segundo antes de intentar de nuevo
        sleep 1
    fi
done


# Copiar ficheros ejemplares en la ruta $PROGRAM_FILES
while [[ ! -d "$PROGRAM_FILES" ]]; do
    # Clonacion de contenido /program-files/ dentro de ruta $PROGRAM_FILES de forma recursiva
    sudo cp -r "$SCRIPT_DIR/program-files/" "$PROGRAM_FILES"
    # Verificar si la copia se realizó correctamente
    if [[ -d "$PROGRAM_FILES" ]]; then
        # Mensaje de copia exitosa
        echo "[#] Se ha copiado exitosamente $SCRIPT_DIR/program-files/ en $PROGRAM_FILES"
    else
        # Mensaje si la copia no se realizó correctamente
        echo -e "[\e[31m#\e[0m] No se ha copiado el contenido de $SCRIPT_DIR/program-files/ correctamente, intentando de nuevo..."
        # Espera 1 segundo antes de intentar de nuevo
        sleep 1
    fi
done

# Clonar el fichero de licencia dentro del resto de los ficheros
while [[ ! -f "$PROGRAM_FILES/LICENSE.txt" ]]; do
    # Clonar el archivo de licencia
    sudo cp "$SCRIPT_DIR/LICENSE.txt" "$PROGRAM_FILES"
    # Verificar si la clonación se realizó correctamente
    if [[ -f "$PROGRAM_FILES/LICENSE.txt" ]]; then
        # Mensaje de clonación exitosa de la licencia
        echo "[#] Licencia instalada correctamente 'autonetplan -l' para leerla."
    else
        # Mensaje si la clonación no se realizó correctamente
        echo -e "[\e[31m#\e[0m] No se ha clonado la licencia correctamente, intentando de nuevo..."
        # Espera 1 segundo antes de intentar de nuevo
        sleep 1
    fi
done

#!/bin/bash

# Función para pausar con mensaje opcional
function pause() {
    read -p "${1:-Presione cualquier tecla para continuar...}" -n1 -s
    echo ""
}

# Espacio diferencial de texto
echo

# Mostrar la licencia
sudo less LICENSE.txt

# Mensaje informativo
echo -e "[#] El repositorio clonado será eliminado para liberar espacio."

# Confirmación de eliminación del repositorio clonado
pause "Presione cualquier tecla para continuar con la eliminación del repositorio clonado..."

# Eliminar el repositorio clonado de forma recursiva
sudo rm -rf "$SCRIPT_DIR"

# Mensaje de eliminación del repositorio clonado
echo "[#] Se ha eliminado de forma recursiva el repositorio clonado."

# Mensaje de instalación exitosa
echo -e "[\e[32m#\e[0m] Programa instalado correctamente."
echo "[#] Las rutas del programa son: '$INSTALL_DIR/autonetplan' y '$PROGRAM_FILES'"
echo "[#] Para obtener ayuda sobre el programa autonetplan, ejecute el comando: 'autonetplan -h'"
