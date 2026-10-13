

while true
do
    clear

    echo "========================="
    echo "       MENU ALUMNOS"
    echo "========================="
    echo "1) Ingresar Alumno"
    echo "2) Dar de baja Alumno"
    echo "3) Modificar telefono"
    echo "4) Consultar Alumno"
    echo "5) Listar Alumnos"
    echo "6) Listar alumnos de un año"
    echo "7) Volver al menu principal"
    echo "========================="
    echo "Ingresar opcion:"
    read op

    case $op in
    1)
        echo "Ingresar CI:"
        read ci

        # Comprobar CI repetida
        existe=$(grep "^$ci," Alumnos.dat)

        if [ -n "$existe" ]
        then
            echo "Ya existe un alumno con esa CI."
        else

            echo "Ingresar apellido:"
            read ape

            echo "Ingresar nombre:"
            read nom

            echo "Fecha de nacimiento:"
            read nac

            echo "Ingresar telefono:"
            read tel

            echo "Ingresar año a cursar:"
            read ano

            
            # materias pendientes del alumno, analiza y ve si se puede inscribir
            
            echo
            echo "¿El alumno tiene asignaturas pendientes?"
            echo "1) Si"
            echo "2) No"
            read pendiente

            if [ "$pendiente" = "1" ]
            then
                echo "No se puede inscribir al alumno."
            else
                echo
                echo "Buscando grupos disponibles..."

                encontrado=0

                while IFS=',' read grupo or sal ad anogrupo
                do
                    if [ "$anogrupo" = "$ano" ]
                    then
                        cantidad=$(grep ",$grupo$" Alumnos.dat | wc -l)

                        if [ $cantidad -lt 15 ]
                        then
                            encontrado=1
                            grupoelegido=$grupo
                            break
                        fi
                    fi
                done < Grupos.dat

                # por si no hay grupos creados
                if [ $encontrado -eq 0 ]
                then
                    echo
                    echo "No existe un grupo disponible para el año $ano."
                    echo "Todos los grupos pueden estar llenos."
                    echo "Debe crear un nuevo grupo."
                else

                    echo
                    echo "Grupo asignado: $grupoelegido"

                    echo "$ci,$ape,$nom,$nac,$tel,$ano,$grupoelegido" >> Alumnos.dat

                    echo
                    echo "Alumno ingresado correctamente."
                    echo "Grupo asignado: $grupoelegido"
                fi
            fi
        fi

        read -p "Presione ENTER para continuar..."
        read skip
        sh Alumnos.sh
        ;;
    2)
        echo "Ingresar CI del alumno:"
        read ci

        existe=$(grep "^$ci," Alumnos.dat)

        if [ -z "$existe" ]
        then
            echo "No existe un alumno con esa CI."
        else
            grep -v "^$ci," Alumnos.dat > Alumnos.tmp
            mv Alumnos.tmp Alumnos.dat

            echo "Alumno eliminado correctamente."
        fi

        read -p "Presione ENTER para continuar..."
         read skip
         sh Alumnos.sh
        ;;
    3)
        echo "Ingresar CI del alumno:"
        read ci

        datos=$(grep "^$ci," Alumnos.dat)

        if [ -z "$datos" ]
        then
            echo "No existe un alumno con esa CI."
        else

            echo "Ingresar nuevo telefono:"
            read nuevo

            IFS=',' read ci2 ape nom nac tel ano grupo <<< "$datos"

            grep -v "^$ci," Alumnos.dat > Alumnos.tmp

            echo "$ci2,$ape,$nom,$nac,$nuevo,$ano,$grupo" >> Alumnos.tmp

            mv Alumnos.tmp Alumnos.dat

            echo "Telefono modificado correctamente."
        fi

        echo "Presione Enter para Volver al Menu de Alumnos..."
        read skip
        sh Alumnos.sh
        ;;
    4)
        echo "Ingresar CI:"
        read ci

        datos=$(grep "^$ci," Alumnos.dat)

        if [ -z "$datos" ]
        then
            echo "No existe un alumno con esa CI."
        else

            IFS=',' read ci2 ape nom nac tel ano grupo <<< "$datos"

            echo
            echo "-----------------------------"
            echo "       DATOS DEL ALUMNO"
            echo "-----------------------------"
            echo "CI: $ci2"
            echo "Apellido: $ape"
            echo "Nombre: $nom"
            echo "Fecha de nacimiento: $nac"
            echo "Telefono: $tel"
            echo "Año: $ano"
            echo "Grupo: $grupo"
        fi

        read -p "Presione ENTER para continuar..."
        read skip
        sh Alumnos.sh
        ;;
    5)
        echo "-----------------------------"
        echo "       LISTADO ALUMNOS"
        echo "-----------------------------"

        if [ ! -s Alumnos.dat ]
        then
            echo "No hay alumnos registrados."
        else

            while IFS=',' read ci ape nom nac tel ano grupo
            do
                echo "CI: $ci | $ape $nom | Año: $ano | Grupo: $grupo"
            done < Alumnos.dat

        fi

        read -p "Presione ENTER para continuar..."
        read skip
        sh Alumnos.sh
        ;;
    6)
        echo "Ingresar año:"
        read ano

        echo
        echo "--------------------------------"
        echo " ALUMNOS DEL AÑO $ano"
        echo "--------------------------------"

        encontrados=0

        while IFS=',' read ci ape nom nac tel anoalumno grupo
        do
            if [ "$anoalumno" = "$ano" ]
            then
                echo "CI: $ci | $ape $nom | Grupo: $grupo"
                encontrados=1
            fi
        done < Alumnos.dat

        if [ $encontrados -eq 0 ]
        then
            echo "No hay alumnos registrados en ese año."
        fi

        echo "Presione Enter Para Volver Al Menu de Alumnos..."
        read skip
        sh Alumnos.sh
        ;;

    7)
        sh ProyectoFinal.sh
        ;;


    *)
        echo "Opcion Incorrecta."
        echo "Presione Enter para Volver al Menu Alumnos..."
        read skip
        sh Alumnos.sh
        ;;

    esac
done
