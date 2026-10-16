clear

echo "====================================="
echo " Proyecto final - Sistemas Operativos"
echo "           Andres Viera"
echo "        Santiago Martinez"
echo "          Marcos Siuciak"
echo "        Thiago Utaravicius"
echo "====================================="

if [ -e Alumnos.dat ]
then
    echo "El archivo Alumnos.dat ya existe."
else
    touch Alumnos.dat
    echo "El archivo Alumnos.dat fue creado."
fi
 
if [ -e Grupos.dat ]
then
    echo "El archivo Grupos.dat ya existe."
else
    touch Grupos.dat
    echo "El archivo Grupos.dat fue creado."
fi

while true
do
    echo
    echo "==========================="
    echo "       Menu Principal"
    echo "==========================="
    echo "1) Grupos"
    echo "2) Alumnos"
    echo "3) Salir"
    echo "==========================="
    echo "Ingrese opcion:"
    read op

    case $op in

    1)
        sh Grupos.sh
        ;;

    2)
        sh Alumnos.sh
        ;;

    3)
        echo "Saliendo del programa..."
        clear 
        exit
        ;;
    *)
        echo "Opcion incorrecta"
        echo "Escribe Enter para Volver al Menu Principal..."
        read skip
        sh ProyectoFinal.sh
        ;;

    esac
  done
