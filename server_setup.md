Shiny server setup

- installed shiny server and placed example files in:

    	/var/shiny-server/www/01_hello

- configuration of shiny server was done in the default.config file located in:

		/opt/shiny-server/config/default.config

- It was altered to reflect the setup as follows:

		run_as shiny;
		
		server {
		  listen 3838;
		
		  location / {
		    site_dir /var/shiny-server/www;
		    log_dir /var/shiny-server/log;
		    directory_index on;
		  }
		}

- Following the description [here](https://github.com/Cambridge-R-User-Group/CambRweb/wiki/Shiny-Server-tutorial), I started the server the issue the following command:

		screen -d -m su - -c shiny-server

- This starts the server as the root in a virtual terminal. To finish the process connect to this virtual terminal:

		screen -aAx

- Then entered the sudo password then to get back to the 'other' terminal:

		Ctrl-A
		d
 
- Next I need to make an init script so it starts on startup and put it behind nginx and run it as a process instead of in the terminal according to a respong from R-studio [here](https://groups.google.com/forum/#!topic/shiny-discuss/9bVI5HO_wfM)