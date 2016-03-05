#!/usr/bin/env bash

echo """Bienvenido a Clear_messages.sh, este script mantemdra
monitorizado su archivo messages enviando cualquier entrada 
que contenga la cadena de texto indicada a otro archivo de log
y eliminandola del mensages
Una vez indicada la cadena de caracteres a monitorizar el script
continuara con la monitorizacion"
read "Cadena de texto a monitorizar:" cadena
sleep 5
fichero="/var/log/othermessages.txt"
while true:do
#Comprobacion de tamaño de fichero para realizar rotado de logs
	if (stat -c %s $fichero) >= 10000;then
		if $fichero == "/var/log/othermessages.txt"
			 fichero="/var/log/othermessages1.txt"
			 cat /dev/null > $fichero
			 fi
		elif $fichero == "/var/log/othermessages1.txt";then
			 fichero="/var/log/othermessages2.txt"
			 cat /dev/null > $fichero
			 fi
		elif $fichero == "/var/log/othermessages2.txt";then
			 fichero="/var/log/othermessages3.txt"
			 cat /dev/null > $fichero
			 fi
		else
			 fichero="/var/log/othermessages.txt"
			 cat /dev/null > $fichero
			 fi
		fi
	
	#enviar log a archivo secundario
	cat /var/log/messages > /var/log/messages.tmp
	
	#Enviar las entradas correspondientes a otro log
	cat /var/log/messages.tmp | grep RIP > $fichero
	
	#Sobreescribir el archivo inicial 
	#sin las entradas enviadas a otro log
	
	cat /var/log/messages.tmp | grep -v RIP > $fichero
	tamano=$(stat -c %s $fichero)
	sleep 300
	done
############################################################
# SECCIÓN INFORMATIVA SOBRE EL CREADOR Y EL PROGRAMA       #
############################################################

#############################################################
#                          España                           #
#                                                           #
# NOMBRE:Alberto Lopez Ruano                                #
# VERSIÓN: 1.0                                              #
# TIPO DE PROGRAMA: script                                  #
# FUNCIÓN: Limpiar de messages de la cadena de texto        #
# indicada los logs del sistema                             # 
# NOMBRE CÓDIGO:clear_rip.sh                                #
# PAÍS ORIGEN:España                                        #
# CREADO POR:Alberto Lopez Ruano                            #
# EMAIL:albertogasco@gmail.com                              #
# FECHA DE LANZAMIENTO DE LA PRIMERA VERSIÓN (1.0):05/03/16 #
# FECHA DE LANZAMIENTO DE LA VERSIÓN ACTUAL (8.0+0):05/03/16#
# FECHA DE ULTIMA ACTUALIZACIÓN:05/03/16                    #
#############################################################
