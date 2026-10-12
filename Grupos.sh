    clear
while true
do
    clear

    echo "==========================="
    echo "        MENU GRUPOS"
    echo "==========================="
    echo "1) Ingresar Grupo"
    echo "2) Dar de baja Grupo"
    echo "3) Listar Grupos"
    echo "4) Consultar Grupo"
    echo "5) Ver alumnos de un Grupo"
    echo "6) Volver al menu principal"
    echo "==========================="
    echo "Ingresar opcion:"
    read op

    case $op in
    1)
        echo "Ingresar nombre del grupo:"
        read grupo

        echo "Ingresar orientacion:"
        read or

        echo "Ingresar salon:"
        read sal

        echo "Ingresar nombre de adscripto:"
        read ad

        echo "Ingresar año del grupo:"
        read ano

        # Verifica si ya existe
        existe=$(grep "^$grupo," Grupos.dat)

        if [ -n "$existe" ]
        then
            echo "Ese grupo ya existe."
        else
            echo "$grupo,$or,$sal,$ad,$ano" >> Grupos.dat
            echo "Grupo ingresado correctamente."
        fi

        echo "Presione Enter Para Volver Al Menu De Grupos..."
        read skip
        sh Grupos.sh
        ;;
    2)
        echo "Ingresar nombre del grupo a eliminar:"
        read grupo

        # sigue verificando si existe, aca si no existe
        existe=$(grep "^$grupo," Grupos.dat)

        if [ -z "$existe" ]
        then
            echo "El grupo no existe."
        else
            # Verificar si tiene alumnos
            cantidad=$(grep ",$grupo$" Alumnos.dat | wc -l)

            if [ $cantidad -gt 0 ]
            then
                echo "No se puede eliminar el grupo."
                echo "El grupo tiene $cantidad alumno(s) asignado(s)."
            else
                grep -v "^$grupo," Grupos.dat > Grupos.tmp
                mv Grupos.tmp Grupos.dat
                echo "Grupo eliminado correctamente."
            fi
        fi

        echo "Presione Enter Para Volver Al Menu De Grupos..."
        read skip
        sh Grupos.sh
        ;;
    3)
        echo "=============================="
        echo "      LISTADO DE GRUPOS"
        echo "=============================="

        if [ ! -s Grupos.dat ]
        then
            echo "No hay grupos registrados."
        else
            while IFS=',' read grupo or sal ad ano
            do
                cantidad=$(grep ",$grupo$" Alumnos.dat | wc -l)

                echo
                echo "Grupo: $grupo"
                echo "Orientacion: $or"
                echo "Salon: $sal"
                echo "Adscripto: $ad"
                echo "Año: $ano"
                echo "Alumnos: $cantidad / 15"
                echo "-------------------------------"
            done < Grupos.dat
        fi

        echo "Presione Enter Para Volver Al Menu De Grupos..."
        read skip
        sh Grupos.sh
        ;;
    4)
        echo "Ingresar nombre del grupo:"
        read grupo

        datos=$(grep "^$grupo," Grupos.dat)

        if [ -z "$datos" ]
        then
            echo "El grupo no existe."
        else
            IFS=',' read nombre or sal ad ano <<< "$datos"

            cantidad=$(grep ",$grupo$" Alumnos.dat | wc -l)

            echo
            echo "=============================="
            echo "        DATOS DEL GRUPO"
            echo "=============================="
            echo "Grupo: $nombre"
            echo "Orientacion: $or"
            echo "Salon: $sal"
            echo "Adscripto: $ad"
            echo "Año: $ano"
            echo "Cantidad de alumnos: $cantidad / 15"
        fi

        echo "Presione Enter Para Volver Al Menu De Grupos..."
        read skip
        sh Grupos.sh
        ;;
    5)
        echo "Ingresar nombre del grupo:"
        read grupo

        existe=$(grep "^$grupo," Grupos.dat)

        if [ -z "$existe" ]
        then
            echo "El grupo no existe."
        else
            echo
            echo "================================"
            echo " ALUMNOS DEL GRUPO: $grupo"
            echo "================================"

            alumnos=$(grep ",$grupo$" Alumnos.dat)

            if [ -z "$alumnos" ]
            then
                echo "El grupo no tiene alumnos."
            else
                while IFS=',' read ci ape nom nac tel ano gr
                do
                    echo "CI: $ci - $ape $nom - Año: $ano"
                done <<< "$alumnos"
            fi
        fi

        echo "Presione Enter Para Volver Al Menu De Grupos..."
        read skip
        sh Grupos.sh
        ;;
    6)
        sh ProyectoFinal.sh
        ;;


    *)
        echo "Opcion incorrecta."
        echo "Presione Enter Para Volver Al Menu De Grupos..."
        read skip
        sh Grupos.sh
        ;;

    esac
done
```
