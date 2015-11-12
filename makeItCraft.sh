#!/bin/bash
function coloredEcho(){
    local exp=$1;
    local color=$2;
    if ! [[ $color =~ '^[0-9]$' ]] ; then
       case $(echo $color | tr '[:upper:]' '[:lower:]') in
        black) color=0 ;;
        red) color=1 ;;
        green) color=2 ;;
        yellow) color=3 ;;
        blue) color=4 ;;
        magenta) color=5 ;;
        cyan) color=6 ;;
        white|*) color=7 ;; # white or invalid color
       esac
    fi
    tput setaf $color;
    echo $exp;
    tput sgr0;
}

###############################################################################
#  ______   ______   ______   ______  ______  ______   __    __   ______
# /\  ___\ /\  == \ /\  __ \ /\  ___\/\__  _\/\  ___\ /\ "-./  \ /\  ___\
# \ \ \____\ \  __< \ \  __ \\ \  __\\/_/\ \/\ \ \____\ \ \-./\ \\ \___  \
#  \ \_____\\ \_\ \_\\ \_\ \_\\ \_\     \ \_\ \ \_____\\ \_\ \ \_\\/\_____\
#   \/_____/ \/_/ /_/ \/_/\/_/ \/_/      \/_/  \/_____/ \/_/  \/_/ \/_____/
#
# Installer Script v0.2.0
# By Matt Stauffer (mattstauffer.co)
#
###############################################################################

mkdir -p tmp

echo ''
coloredEcho "Do you accept Craft's license? [http://buildwithcraft.com/license]"
read -p "[y/N]" -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi
echo ''

echo ''
coloredEcho 'Downloading and installing the latest version of Craft...' green
echo ''

curl -L http://buildwithcraft.com/latest.zip?accept_license=yes -o tmp/Craft.zip
unzip tmp/Craft.zip
rm -rf tmp

permLevel=774
chmod $permLevel craft/app
chmod $permLevel craft/config
chmod $permLevel craft/storage
echo ''
echo "  chmod $permLevel craft/app"
echo "  chmod $permLevel craft/config"
echo "  chmod $permLevel craft/storage"

mv public/htaccess public/.htaccess
echo '  mv public/htaccess public/.htaccess'
echo ''
echo '------------------'
echo ''
coloredEcho 'NOTE:' red
coloredEcho 'Setting craft/app, craft/config, and craft/storage permissions to be 774; change to your desired permission set.' red
echo ''
coloredEcho 'See the docs for your options: http://buildwithcraft.com/docs/installing' red

echo ''
coloredEcho "Do you want to use PHPDotEnv and Composer (requires globally-installed Composer)?"
read -p "[y/N]" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    cat >composer.json <<EOL
{
    "require": {
        "vlucas/phpdotenv": "^2.0"
    }
}
    EOL
    echo '  (created composer.json)'
    cat >tmpIndexHeader <<EOL
require_once('../vendor/autoload.php');

try {
    $dotenv = new Dotenv\Dotenv(dirname(__DIR__));
    $dotenv->load();
    $dotenv->required(['DB_HOST', 'DB_NAME', 'DB_USER', 'DB_PASS']);
} catch (Exception $e) {
    exit('Could not find a .env file.');
}
    EOL
    cat public/index.php >> tmpIndexHeader
    mv tmpIndexHeader public/index.php
    echo '  (added composer and phpdotenv loader to public/index.php)'
    composer install
    echo '  composer install'
    cat >.env <<EOL
DB_HOST=localhost
DB_NAME=craft
DB_USER=root
DB_PASS=root
    EOL
    cp .env .env.example
    echo '  (created .env and .env.example)'
    touch .gitignore
    echo '.env' >> .gitignore
    echo '/vendor/' >> .gitignore
    echo '  (added .env and /vendor/ to .gitignore)'
    echo '@todo: update craft config files'
fi
echo ''

echo ''
echo 'Next steps:'
echo ' - Create a database with charset `utf8` and collation `utf8_unicode_ci`'
echo ' - Update craft/config/db.php with your database credentials'
echo ' - Run the installer at your-domain.com/admin'
echo " - Delete public/web.config if you're on Apache, or delete public/.htaccess if you're on IIS"
echo ''
echo 'Happy Crafting!'
