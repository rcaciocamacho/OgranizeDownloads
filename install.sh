#!/bin/bash

echo "Eliminando instalción existente..."
sudo rm -rf /home/$USER/.config/ogranizeDownload/*

sudo systemctl disable ogranize.service
sudo systemctl daemon-reload
sudo rm -rf /lib/systemd/system/ogranize.service

echo "Creando directorio de instalación..."
sudo mkdir /home/$USER/.config/ogranizeDownload

echo "Copiando ficheros..."
sudo cp -R ../OgranizeDownloads/* /home/$USER/.config/ogranizeDownload/

echo "Creando softlink de la aplicación..."
sudo ln -s /home/$USER/.config/ogranizeDownload/main.py /usr/local/bin/ogranize

echo "Instalando servicio en el sistema..."
sudo cp -R service_file/ogranize.service /lib/systemd/system/ogranize.service

echo "Damos permisos a los ficheros de log para escritura"
sudo chmod 777 /home/$USER/.config/ogranizeDownload/indexingFile.log

echo "Gestionando permisos y habilitando el servicio..."
sudo systemctl daemon-reload
sudo systemctl enable ogranize.service

echo "Iniciando servicio y finalizando la instalción..."
sudo systemctl start ogranize.service 

echo "Finalizado."
