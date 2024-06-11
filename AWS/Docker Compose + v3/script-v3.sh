#!/bin/bash
clear
echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Olá $USERNAME, sou a Lis! Sua assistente para instalação ! :D"
sleep 5
echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Verificando suas dependências ..."
sleep 3
echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Só um momento..."
sleep 2

# Função para verificar e instalar dependências
verificarDependencias() {
    # Verificar se o Docker está instalado
    if ! command -v docker &> /dev/null; then
        echo "$(tput setaf 4)[LIS]:$(tput setaf 7) O Docker não está instalado. Iniciando o processo de instalação..."
        curl -fsSL https://get.docker.com -o get-docker.sh
        sudo sh get-docker.sh
        echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Docker instalado com sucesso."
    else
        echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Docker já está instalado."
    fi
    sleep 5
    # Verificar se o Docker Compose está instalado
    if ! command -v docker-compose &> /dev/null; then
        echo "$(tput setaf 4)[LIS]:$(tput setaf 7) O Docker Compose não está instalado. Iniciando o processo de instalação..."
        sudo apt install docker-compose -y
        echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Docker Compose instalado com sucesso."
    else
        echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Docker Compose já está instalado."
    fi
    sleep 5
    # Verificar se o Java 17 está instalado
    if ! command -v java &> /dev/null || [[ $(java -version 2>&1 | grep -c "17\..*") -eq 0 ]]; then
        echo "$(tput setaf 4)[LIS]:$(tput setaf 7) O Java 17 não está instalado. Iniciando o processo de instalação..."
        sudo apt update
        sudo apt install openjdk-17-jdk -y
        echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Java 17 instalado com sucesso."
    else
        echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Java 17 já está instalado."
    fi
}

# Função principal
main() {
    verificarDependencias

    # Conteúdo do docker-compose.yml
    cat << EOF > docker-compose.yml
version: '3.3'

services:
  # ---------- SERVICE LISYNC ----------- 
  lisync-service:
    container_name: serviceLisync
    image: giuliacarmona/lisync-jar
    restart: always
    build:
      context: .
      args:
        JAR_URL: https://github.com/LiSync-Signage/JAR-Lisync/raw/main/jar/JAR_Lisync.jar
    ports:
      - 8080:8080
    depends_on:
      - lisync-mysql

  # ----------- MYSQL LISYNC ------------ 
  lisync-mysql:
    container_name: bancoLisync
    image: mysql:5.7
    restart: always
    environment:
      MYSQL_DATABASE: lisyncDB
      MYSQL_ROOT_PASSWORD: urubu100
    volumes:
      - ./init-scripts:/docker-entrypoint-initdb.d
      - mysql-data:/var/lib/mysql
    ports:
      - 3306:3306

volumes:
  mysql-data:

EOF

    # Baixar e iniciar os contêineres usando docker-compose
    echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Baixando e iniciando os contêineres..."
    docker-compose up -d

    if [ $? -eq 0 ]; then
        echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Contêineres iniciados com sucesso."
        echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Você pode acessar o serviço Lisync através do navegador da web, acessando http://localhost:8080"

        # Criar um atalho na área de trabalho para o JAR
        echo "$(tput setaf 4)[LIS]:$(tput setaf 7) "Criando atalho na área de trabalho para o JAR..."
        ln -s "$(pwd)/JAR_Lisync.jar" ~/Desktop/JAR_Lisync.jar""
        echo "$(tput setaf 4)[LIS]:$(tput setaf 7) "Atalho criado com sucesso."

    else
        echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Ocorreu um erro ao iniciar os contêineres. Finalizando ..."
    fi
}

# Chamada da função principal
main
chmod +x ~/Desktop/JAR_Lisync.jar
java -jar ~/Desktop/JAR_Lisync.jar