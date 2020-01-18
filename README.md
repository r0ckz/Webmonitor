# Webmonitor
A little easy-to-use script I use to monitor changes on a web page. You can use this to check entire pages or just a single line in the source (using grep). If you look for certain words, you will be notified once they appear/disappear from the web page or when something in that line changes.

Be sure to have sendmail installed:<br>
`sudo apt-get install sendmail` on Debian/Ubuntu-based systems<br>
`sudo yum install sendmail` on RHEL/CentOS-based systems

Then save the .sh file (to the current folder) by getting the raw file:<br>
`sudo wget -q https://raw.githubusercontent.com/r0ckz/Webmonitor/master/webmonitor.sh`

Edit the settings:<br>
`sudo nano webmonitor.sh`

Give the right permissions:<br>
`sudo chmod +x webmonitor.sh`

Run the file:<br>
`./webmonitor.sh`

Or alternatively, if you want to run this in the background and have the ability to log off:<br>
`nohup ./webmonitor.sh &`
