#!/bin/bash
#
# Author Cesar Herdenez <caherdenez@gmail.com>
#
# Vars
ROOT_DIR=$(cd "$(dirname "$0")"; pwd) # absolute path
ORACLE_CLIENTS=${ROOT_DIR}/oracle-clients
DIR=/srv/wms_iq
ENV="$DIR"/env
BUILD_DIR=/tmp
PYTHON_VERSION=Python-3.6.2
SOURCE_TARBALL="https://python.org/ftp/python/3.6.2/$PYTHON_VERSION.tgz"



puts-step() {
	echo -e "\e[1m\e[36m===> $@\e[0m"
}

puts-error() {
	echo -e "\e[1m\e[31m=!=> $@\e[0m"
}

puts-warn() {
	echo -e "\e[1m\e[33m=!=> $@\e[0m"
}

print() {
	echo -e "\e[1m\e[35m--> $@\e[0m"
}


echo -e "\e[1m\e[32m Install  Warrants Managment System  \e[0m"

py36install(){
	if [ -f "$BUILD_DIR/runtime" ]; then
	  print "python36 in the system"
	  return 0
	fi

	print "Building Python..."
	if [ ! -f "$BUILD_DIR/$PYTHON_VERSION.tgz" ]; then
	  print "download python36"
	  wget $SOURCE_TARBALL | tar xf  >/dev/null 2> /tmp/erros_install.log
	fi

	if [ -f "$BUILD_DIR/$PYTHON_VERSION.tgz" ]; then
	   print "unarchive python36"
	   tar xf Python-3.6.2.tgz  >/dev/null 2> /tmp/erros_install.log
	   print "move python36 to src"
	   mv Python-3.6.2 src  >/dev/null 2> /tmp/erros_install.log
	fi

	if [ -d "$BUILD_DIR/src" ]; then
	  print " cd into src $PYTHON_VERSION"
	  cd src
	  print "configure $PYTHON_VERSION"
	  ./configure  >/dev/null 2> /tmp/erros_install.log
	  make  >/dev/null 2> /tmp/erros_install.log
	  sudo make install  >/dev/null 2> /tmp/erros_install.log
	fi

	sudo rm -rf src
	touch $BUILD_DIR/runtime
}

oracle_driver(){
	if [ -f "/etc/ld.so.conf.d/oracle.conf" ]; then
		return 0
	fi
	print "install oracle drivers"
	sudo alien -i "$ORACLE_CLIENTS"/oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm
	sudo alien -i "$ORACLE_CLIENTS"/oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm
	sudo alien -i "$ORACLE_CLIENTS"/oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.x86_64.rpm

	echo "/usr/lib/oracle/12.1/client/lib" > oracle.conf
	sudo cp oracle.conf /etc/ld.so.conf.d/oracle.conf
	sudo ldconfig
	export LD_LIBRARY_PATH=/usr/lib/oracle/12.2/client64/lib
}


conf_nginx(){
	touch /etc/nginx/sites-available/wms_iq
	cat << EOF > /etc/nginx/sites-available/wms_iq
	server {
	listen 80;
	server_name $1 ;

	access_log /srv/logs/nginx-access.log;
	error_log /srv/logs/nginx-error.log;

	location = /favicon.ico {
		access_log off; log_not_found off;
		}

	location /static/ {
		alias /srv/warrant_system/static/;
		}

	location / {
		include proxy_params;
		proxy_pass http://unix:/srv/run/gunicorn.sock;
		}
	}
EOF

sudo ln -sf /etc/nginx/sites-available/wms_iq /etc/nginx/sites-enabled/wms_iq
sudo nginx -t

}

puts-step "update system"
sudo apt-get update -y >/dev/null 2> /tmp/erros_install.log

puts-step "install dependences"
sudo apt-get install -y alien libaio1 python3-dev \
                         build-essential libssl-dev \
                         libffi-dev nginx supervisor >/dev/null 2> /tmp/erros_install.log

puts-step "check if exist py36 in the system"
py36install

puts-step "install oracle drivers"
oracle_driver
cd "$DIR"
puts-step "create python env "
python3.6 -m venv "$ENV"
puts-step "install requirements "
"$ENV"/bin/pip install -r "$DIR"/requirements/development.txt >/dev/null 2> /tmp/erros_install.log
"$ENV"/bin/pip install gunicorn >/dev/null 2> /tmp/erros_install.log

puts-step "Python initial collectstatic"
"$ENV"/bin/python "$DIR"/manage.py collectstatic --settings=config.settings.production >/dev/null 2> /tmp/erros_install.log

puts-step "create nginx supervisor config file"
mkdir -p /srv/{logs,run}

puts-step "edit config file"
conf_nginx "wms.tecsiq.com" # cambiar por el domain
sudo service nginx restart

puts-step "coping files"


cp scripts/wms.conf /etc/supervisor/conf.d/wms.conf
cd "$DIR"
chmod +x /srv/wms_iq/scripts/gunicorn_wms
sudo supervisorctl reread
sudo supervisorctl update
