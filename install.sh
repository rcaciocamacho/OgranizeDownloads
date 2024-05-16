#!/bin/bash

# Definir variables de configuración básicas
CONFIG_DIR="/home/$USER/.config/ogranizeDownload"
SERVICE_FILE_PATH="/lib/systemd/system/ogranize.service"
MAIN_PY="/home/$USER/.config/ogranizeDownload/main.py"
LOG_FILE="/home/$USER/.config/ogranizeDownload/indexingFile.log"

echo "Eliminando instalación existente..."
sudo rm -rf $CONFIG_DIR/*

# Deshabilitar y remover el servicio si existe
if systemctl is-enabled --quiet ogranize.service; then
    sudo systemctl disable ogranize.service
    sudo systemctl daemon-reload
    sudo rm -rf $SERVICE_FILE_PATH
fi

echo "Creando directorio de instalación..."
sudo mkdir -p $CONFIG_DIR

echo "Copiando ficheros..."
sudo cp -R ../OgranizeDownloads/* $CONFIG_DIR/

echo "Creando softlink de la aplicación..."
sudo ln -sf $MAIN_PY /usr/local/bin/ogranize

echo "Instalando servicio en el sistema..."
sudo cp -R service_file/ogranize.service $SERVICE_FILE_PATH

echo "Instalando dependencias de Python..."
pip install pillow --user

echo "Configurando fichero de log..."
sudo touch $LOG_FILE
sudo chmod 666 $LOG_FILE  # Uso 666 en lugar de 777 por razones de seguridad

echo "Gestionando permisos y habilitando el servicio..."
sudo systemctl daemon-reload
sudo systemctl enable ogranize.service

echo "Iniciando servicio y finalizando la instalación..."
sudo systemctl start ogranize.service 

echo "Finalizado."
