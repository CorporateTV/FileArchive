#!/bin/bash
PURPLE= '0;35'
NC= '\033[0m'
VERSAO= 11

# Limpando a Tela
clear
# Introduzindo a assistente
echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Olá $USERNAME, sou a Lis! Sua assistente para instalação ! :D"
echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Estou verificando aqui se você possui o Java instalado..."
sleep 2
echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Só um momento..."
sleep 2

java -version # Verificando a versão do Java

if [ $? -eq 0 ] #Se o Java estiver instalado
then #Se o Java estiver instalado
  clear
  echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Você já tem o java instalado!!! Vamos prosseguir com a instalação!"

else #Se o Java não estiver instalado
  echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Opa! Não identifiquei nenhuma versão do Java instalado, mas sem problemas, irei resolver isso agora!"
  echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Confirme para mim se realmente deseja instalar o Java (S/N)?" #Perguntando se deseja instalar o Java

  read instalarJava #Lendo a resposta do usuário

  if [ \"$instalarJava\" == \"S\" ] || [ \"$instalarJava\" == \"s\" ] #Se a resposta for sim
  then
    echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Ok! Você escolheu instalar o Java ;D"
    echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Adicionando o repositório!"

    sleep 2 #Aguardando 2 segundos
    sudo add-apt-repository ppa:webupd8team/java -y #Adicionando o repositório
    clear

    echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Atualizando! Quase lá ..."
    sleep 2
    sudo apt update -y #Atualizando
    clear

    if [ $VERSAO -eq 11 ] #Se a versão for 11
    then
      echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Preparando para instalar a versão 11 do Java. Confirme a instalação quando solicitado ;D"
      sudo apt install default-jre ; apt install openjdk-11-jre-headless; -y #Instalando a versão 11
      clear
      echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Java instalado com sucesso!"
    fi

  else
    echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Você optou por não instalar o Java por enquanto, até a próxima então!" #Se a resposta for não
  fi
fi  
docker -version

if [ $? -eq 0 ]
then 
  echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Você já possui o Docker instalado! Vamos prosseguir..."
else
  clear
  echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Opa! Não identifiquei nenhuma versão do Docker instalado, mas sem problemas, irei resolver isso agora!"
  echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Confirme para mim se realmente deseja instalar o Docker (S/N)?"

  read instalarContainer

  if [ "$instalarContainer" == "S" ] ||  [ "$instalarContainer" == "s" ]
  then
    echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Ok! Você escolheu instalar o Docker ;D"
    echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Instalando o Docker ..."

    sleep 2 #Aguardando 2 segundos
    sudo apt install docker.io -y
    clear

    echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Atualizando! Quase lá ..."
    sleep 2
    sudo apt update -y 

    echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Docker instalado com sucesso! :D"
  else
    echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Você optou por não instalar o Docker por enquanto, até a próxima então!" #Se a resposta for não
  fi
fi


echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Vamos instalar seu JAR agora? (S/N)?" #Perguntando se deseja instalar o JAR

read inst #Lendo a resposta do usuário

if [ \"$inst\" == \"S\" ] || [ \"$inst\" == \"s\" ] #Se a resposta for sim
then
  echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Ok! Você escolheu instalar o JAR ;D"
  echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Por favor, informe o caminho do arquivo JAR que deseja instalar:"
  read caminho #Lendo o caminho do arquivo JAR
  mkdir $caminho #Criando o diretório
  cd $caminho #Entrando no diretório
  clear

  echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Copiando o arquivo JAR para a pasta "$caminho" ..."
  git clone https://github.com/LiSync-Signage/JAR-Lisync.git #Clonando o repositório
  cd JAR-Lisync #Entrando no diretório"
  sleep 2
  clear

  echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Arquivo JAR copiado com sucesso!"

  echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Deseja executar o arquivo JAR agora? (S/N)?" #Perguntando se deseja executar o JAR
  read executar #Lendo a resposta do usuário

  if [ \"$executar\" == \"S\" ] || [ \"$executar\" == \"s\" ] #Se a resposta for sim
  then
    echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Ok! Você escolheu executar o JAR :D"
    echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Abrindo o arquivo JAR..."
    cd jar #Entrando no diretório
    chmod 777 JAR_Lisync.jar #Dando permissão de execução
	sleep 4
    java -jar JAR_Lisync.jar #Executando o JAR
  else
    echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Você optou por não executar o JAR por enquanto, até logo :D!" #Se a resposta for não
  fi

else
  echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Você optou por não instalar o JAR por enquanto, até logo :D"
fi #Fim do script
