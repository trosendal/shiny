# A couple of web applications built with the R package shiny


Shiny is an R package available from cran and is open source.

For more information about how shiny can be used to do analysis behind a website
look at http://shiny.rstudio.com/ to see an example and to get some guidance on
writing the code for the application look here http://shiny.rstudio.com/tutorial/. 
There are also example of application on the we here: http://shiny.rstudio.com/gallery/


In this project I created are two examples that are inline with the goals of
the risksurr tools development goals: 

1. A true prevalence estimator
2. A sample size calculator


## A true prevalence estimator
The true prevalence calculator uses the rpackage 'epiR' to
calculate true prevalence based on 4 methods from apparent
prevalence based on the user's inputs to the page. Notice
the dynamic link between the user inputs and output. Also 
the code that runs the functions is available in an Ace 
editor on the page that can also be hidden. The page runs
from just two files: server.R and ui.R

To run this example set your working directory in R to the shiny
directory if you are using R studio just open the .Rproj file. Then if
you don't have the dependancies: library(shiny) library(epiR) library(shinyAce)
you need to install them from cran.

Then run these two lines:

    library(shiny)
    runApp("trueprev/", port=4984, launch.browser = TRUE)

Your default browser will open with the page. When you change
the inputs in the app it runs the code in you present R session.
If you want to open it in another browser paste the following
into your address bar:

    localhost:4984

## A sample size calculator

This is a slightly fancier example. It uses some test in .html
files and a sweave file to generate a pdf report for the user. 
The essential functionality is still in the two files server.R
and ui.R

To run this example set your working directory in R to the shiny
directory if you are using R studio just open the .Rproj file. Then if
you don't have the dependancies: library(shiny) library(epiR)
library(knitr) library(shinyAce) you need to install them from cran. To
produce the pdf report you also need a latex installation.

Then run these two lines:

    library(shiny)
    runApp("sampsi/", port=4984, launch.browser = TRUE)

Your default browser will open with the page. When you change
the inputs in the app it runs the code in you present R session.
If you want to open it in another browser paste the following
into your address bar:

    localhost:4984


## To run these apps on a server so the world can see them

Download open source shiny server from here:

http://www.rstudio.com/shiny/server/install-opensource

* I have tried this and succefully deployed the samplesize
calculator example above. This was done on a machine with
linux Mint, using NGINX as a front end proxy that
redirects port 80 traffic to the shiny server. To deploy
new applications all I do is copy the folder, like the ones
in the current project to /var/shiny-server/www/ and restart the
server process and it is up and available. On the server you need 
to install the R packages that the app depends on as well as a 
latex installation to produce PDF reports.