# for fullPage:
# install.packages("remotes")
# remotes::install_github("RinteRface/fullPage")
library(fullPage)
library(leaflet)
library(RPostgres)
library(scales)
library(shiny)
library(shinyalert)
library(shinyWidgets)
library(tidyverse)

# connect to the our database----

con <- dbConnect(
  drv = dbDriver('Postgres'),
  user = 'proj22b_3',
  password = 'AVNS_2beAy3wAEqGtXl3URJk',
  host = 'db-postgresql-nyc1-44203-do-user-8018943-0.b.db.ondigitalocean.com',
  port = 25060,
  dbname = 'fest3',
  sslmode = 'require'
)

arts11 <- dbGetQuery(con, 'SELECT * FROM artist11;')
vens <- dbGetQuery(con, 'SELECT * FROM venues')
hots <- dbGetQuery(con, 'SELECT * FROM accom')
ress <- dbGetQuery(con, 'SELECT * FROM rest_info;')
park <- dbGetQuery(con, 'SELECT * FROM park_amanities;')
atts <- dbGetQuery(con, 'SELECT * FROM hos_info')


# when exiting app, disconnect from the paris database
onStop(
  function()
  {
    dbDisconnect(con)
  }
)