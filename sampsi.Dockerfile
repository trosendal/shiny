FROM rocker/r-base:latest

LABEL maintainer "Thomas Rosendal <thomas.rosendal@sva.se>"

# basic shiny functionality
RUN R -e "install.packages(c('shiny', 'rmarkdown'), repos='https://cloud.r-project.org/')"

# install dependencies of the the sampsi app
RUN R -e "install.packages(c('epiR', 'knitr', 'shinyAce'), repos='https://cloud.r-project.org/')"

# copy the app to the image
RUN mkdir /root/sampsi
COPY sampsi /root/sampsi

# copy in the Rprofile to define shiny ports
COPY Rprofile.site /usr/lib/R/etc/

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/root/sampsi')"]
