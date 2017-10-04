GREEN="\e[32m"
NC="\033[0m"

echo -e "\n${GREEN}Installing JAVA${NC}\n"
# http://tipsonubuntu.com/2016/07/31/install-oracle-java-8-9-ubuntu-16-04-linux-mint-18/

add-apt-repository -y ppa:webupd8team/java
apt-get update
apt install -y oracle-java8-installer

echo -e "\n${GREEN}Installing EKL stack${NC}\n"
# https://www.howtoforge.com/tutorial/elasticsearch-and-kibana-installation-and-basic-usage-on-ubuntu-1604/

rm -rf temp
mkdir temp
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.6.1.deb -P ./temp
wget https://artifacts.elastic.co/downloads/kibana/kibana-5.6.1-amd64.deb -P ./temp
wget https://artifacts.elastic.co/downloads/logstash/logstash-5.6.1.deb -P ./temp
dpkg -i ./temp/*.deb

systemctl daemon-reload
systemctl enable elasticsearch
systemctl start elasticsearch

echo -e "\n${GREEN}Installing MongoDB${NC}\n"
# https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
apt-get update
apt-get install -y mongodb-org

systemctl daemon-reload
systemctl enable mongod
systemctl start mongod

echo -e "\n${GREEN}Installing python-pip and python-virtualenv${NC}\n"
apt-get install -y python-pip
apt-get install -y python-virtualenv

echo -e "\n${GREEN}Installing NodeJS${NC}\n"
# https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions

curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
apt-get install -y nodejs
npm install -g yarn
npm install -g pm2
npm install -g nodemon

echo -e "\n${GREEN}Start API${NC}\n"

rm -rf /srv
mkdir /srv
cd /srv
git clone https://github.com/saikrishnadeep/imdbnator-api.git .
yarn install
pm2 startup
PORT=80 REMOTE=http://www.imdbnator.com pm2 start -f api.js


echo -e "\n${GREEN}All done!${NC}\n"
