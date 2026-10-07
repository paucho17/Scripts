#!/bin/bash
# Ejecutar como usuario normal (no con sudo): ./instalar.sh

# 1. Actualizar sistema e instalar programas base
sudo apt update && sudo apt upgrade -y
sudo apt install -y software-properties-common apt-transport-https wget curl git \
  python3 python3-pip python3-venv texlive-full texstudio kile inkscape pandoc gnuplot

# 2. Instalar VS Code y extensiones
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
sudo apt update && sudo apt install -y code
code --install-extension ms-python.python
code --install-extension ms-toolsai.jupyter
code --install-extension ms-python.vscode-pylance
code --install-extension James-Yu.latex-workshop

# 3. Crear entorno virtual e instalar librerías de Python
mkdir -p ~/.virtualenvs
python3 -m venv ~/.virtualenvs/ciencia
source ~/.virtualenvs/ciencia/bin/activate
pip install --upgrade pip
pip install numpy scipy pandas matplotlib sympy jupyterlab

# 4. Crear usuario Estudiante y asignar contraseña estudiante (omitiendo restricciones de PAM)
sudo useradd -m -s /bin/bash Estudiante
sudo usermod -p "$(openssl passwd -6 estudiante)" Estudiante
