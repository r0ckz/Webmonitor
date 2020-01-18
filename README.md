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

You should be able to tweak this script a bit for use with wget and compare other downloadable (text)files.

If you don't want to follow the automatic redirections of an url you can remove the `-L` parameter from the curl commands. But keep in mind that this often causes problems, especially when using `http://` links that redirect to `https://` links. You can also add the `-s` parameter to the curl commands, if you wish to only show sendEmail messages. I don't prefer this, since I like to see all the activity that's going on. This all comes down to personal preference.
