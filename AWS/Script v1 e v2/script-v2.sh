#!/bin/bash
PURPLE= '0;35'
NC= '\033[0m'
VERSAO= 11

# Limpando a Tela
clear
# Introduzindo a assistente
 Olá $USERNAME, sou a Lis! Sua assistente para instalação ! :D"
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

if ! command -v docker &> /dev/null;
then 
  echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Você já possui o Docker instalado! Vamos prosseguir..."
else
  clear
  echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Opa! Não identifiquei nenhuma versão do Docker instalado, mas sem problemas, irei resolver isso agora!"
  echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Confirme para mim se realmente deseja instalar o Docker (S/N)?"

  read instalarDocker

  if [ "$instalarDocker" == "S" ] ||  [ "$instalarDocker" == "s" ]
  then
    echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Ok! Você escolheu instalar o Docker ;D"
    echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Instalando o Docker ..."

    sleep 2 #Aguardando 2 segundos
    sudo apt-get update
    sudo apt-get install -y docker.io
    clear

    echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Atualizando! Quase lá ..."
    sleep 2

    echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Docker instalado com sucesso! :D"
  else
    echo "$(tput setaf 4)[LIS]:$(tput setaf 7) Você optou por não instalar o Docker por enquanto, até a próxima então!" #Se a resposta for não
  fi
fi #Fim do script
