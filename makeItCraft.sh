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
# Installer Script v0.1.2
# By Matt Stauffer (mattstauffer.co)
#
###############################################################################

mkdir -p tmp

echo ''
coloredEcho "Do you accept Craft's license? [http://buildwithcraft.com/license]"
read -p "[yN]" -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

### Frustrated attempts to get this to work over Curl
# read -r -p "[y/N] " response
# case $response in
#     [yY][eE][sS]|[yY]) 
#         # pass
#         ;;
#     *)
#         exit 1
#         ;;
# esac
# read -p 'Do you want to Continue (yes/no?): ' answer
# if [[ $answer = "y" ]]; then
#     echo 'AWESOME'
# else
#     echo 'NOPE'
#     exit 1
# fi

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
echo 'Next steps:'
echo ' - Create a database with charset `utf8` and collation `utf8_unicode_ci`'
echo ' - Update craft/config/db.php with your database credentials'
echo ' - Run the installer at your-domain.com/admin'
echo " - Delete public/web.config if you're on Apache, or delete public/.htaccess if you're on IIS"
echo ''
echo 'Happy Crafting!'
