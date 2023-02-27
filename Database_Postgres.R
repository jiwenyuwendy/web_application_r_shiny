library(tidyverse)
library(RPostgres)

#CREATE THE DATABASE----
con <- dbConnect(
  drv = dbDriver('Postgres'),
  user = 'proj22b_3',
  password = 'AVNS_2beAy3wAEqGtXl3URJk',
  host = 'db-postgresql-nyc1-44203-do-user-8018943-0.b.db.ondigitalocean.com', 
  port = 25060,
  dbname = 'fest3',
  sslmode = 'require'
)

#_create hos_info table----
stmt <- 'CREATE TABLE hos_info (
          hos_id int,
          hos_name varchar(100),
          hos_zipcode bpchar(100),
          hos_address varchar(500),
          lat numeric,
          lng numeric,
          hos_phone varchar(100),
          PRIMARY KEY(hos_id)
        );'
dbExecute(con, stmt)  

#_create venue table----

stmt <- 'CREATE TABLE venues (
          venue_id int,
          venue_name varchar(100),
          lat numeric,
          lng numeric,
          address varchar(100),
          PRIMARY KEY(venue_id)
        );'

#_create artist11 table----
stmt <- 'CREATE TABLE artist11 (
          art_id int(100),
          art_name varchar(100),
          genre varchar(100),
          vid varchar(100),
          PRIMARY KEY(art_id)
        );'
dbExecute(con, stmt)  


#_read source data----
df1 <- read.csv('/Users/wenyuji/Desktop/5310/Team_Project/Honolulu_Hospitals_Cleaned/honolulu_hos_Info.csv', stringsAsFactors = FALSE)
print(df1)

df2cc <- bind_cols('hos_id' = 1:nrow(df1), df1)
df2cc
dbWriteTable(
  conn = con,
  name = 'hos_info',
  value = df2cc,
  row.names = FALSE,
  append = TRUE
)


#_read venue data----

df3 <- read.csv('/Users/wenyuji/Desktop/5310/Team_Project/Honolulu_Hospitals_Cleaned/Aloha Stadium.csv', stringsAsFactors = FALSE)
print(df3)

df3cc <- bind_cols('venue_id' = 1:nrow(df3), df3)
df3cc
dbWriteTable(
  conn = con,
  name = 'venues',
  value = df3cc,
  row.names = FALSE,
  append = TRUE
)


#_read artist11 data----

df4 <- read.csv('/Users/wenyuji/Desktop/5310/Team_Project/Honolulu_Hospitals_Cleaned/artists11.csv', stringsAsFactors = FALSE)
print(df4)

df4cc <- bind_cols('art_id' = 1:nrow(df4), df4)
df4cc
dbWriteTable(
  conn = con,
  name = 'artist11',
  value = df4cc,
  row.names = FALSE,
  append = TRUE
)


#_create accom_island table----
stmt <- 'CREATE TABLE accom_island (
          island_id int,
          island varchar(100),
          PRIMARY KEY (island_id)
        );'
dbExecute(con, stmt)  

#_create accom table----
stmt <- 'CREATE TABLE accom (
          accom_id int,
          island_id int,
          accom_name varchar(100),
          address varchar(80),
          website Varchar(64),
          price int,
          star_rating float,
          lng numeric,
          lat numeric,
          PRIMARY KEY(accom_id),
          FOREIGN KEY(island_id) REFERENCES accom_island
        );'
dbExecute(con, stmt)  

#******************----
#EXTRACT----
#_read source data----
df <- read.csv('accom.csv')
df1 <- df %>% select('accom_id', 'accom_name', 'address', 'island', 'website', 'lng', 'lat', 'star_rating', 'price')

#******************----
#TRANSFORM----
#accom_island
#_gather the type of the accom----
df2 <- df1 %>% 
  select('island') %>% 
  unique()
#attach the type_id as the primary key
df2a <- bind_cols('island_id' = 1:nrow(df2), df2)

#write into the database
dbWriteTable(
  conn = con,
  name = 'accom_island',
  value = df2a,
  row.names = FALSE,
  append = TRUE
)

#accom
#Assign island_id
df3 <- df1 %>%
  inner_join(df2a)%>%
  select(accom_id, island_id, accom_name, address, website, lng, lat, star_rating, price)

df3$price <- as.numeric(df3$price)


#write into database
dbWriteTable(
  conn = con,
  name = 'accom',
  value = df3,
  row.names = FALSE,
  append = TRUE
)

#_create parking_info table----
stmt <- 'CREATE TABLE parking_info (
          parking_id int,
          park_name varchar(64),
          parking_ty varchar(64),
          parking_1 varchar(64),
          parking_area varchar(64),
          parking_spaces int,
          PRIMARY KEY(parking_id)
        );'
dbExecute(con, stmt)  


#_create parking_loca table----
parking_loca <- 'CREATE TABLE parking_loca (
          parking_id int,
          parking_name varchar(64),
          parking_location varchar(64),
          parking_landmark varchar(64),
          parking_address varchar(64),
          parking_entry varchar(64),
          parking_exit varchar(64),
          PRIMARY KEY(parking_id)
        );'
dbExecute(con, parking_loca) 

#_load parking_info data-----
df <- read.csv('/Users/chenzhao/Desktop/parking_facilities/Parking_info.csv', stringsAsFactors = FALSE)
print(df)

dbWriteTable(
  conn = con,
  name = 'parking_info',
  value = df,
  row.names = FALSE,
  append = TRUE
)

#_load parking_loca data-----

df1 <- read.csv('/Users/chenzhao/Desktop/parking_facilities/Parking_loca.csv', stringsAsFactors = FALSE)
print(df1)

dbWriteTable(
  conn = con,
  name = 'parking_loca',
  value = df1,
  row.names = FALSE,
  append = TRUE
)

#_create park_amanities table----
park_amanities <- 'CREATE TABLE park_amanities (
          park_id int,
          park_type int,
          park_name varchar(64),
          park_phone varchar(64),
          park_address varchar(64),
          park_zipcode int,
          PRIMARY KEY(park_id)
        );'
dbExecute(con, park_amanities) 

#_load park_amanities data-----

df2 <- read.csv('/Users/chenzhao/Desktop/parking_amanities/parking_amanities_new1.csv', stringsAsFactors = FALSE)
print(df2)

dbWriteTable(
  conn = con,
  name = 'park_amanities',
  value = df2,
  row.names = FALSE,
  append = TRUE
)

#_create rest_info table----
stmt <- 'CREATE TABLE rest_info (
          rest_id int,
          rest_name varchar(70),
          rest_phone varchar(70),
          rest_permit varchar(70),
          rest_lag numeric,
          rest_lng numeric,
          rest_street varchar(70),
          PRIMARY KEY(rest_id)
        );'
dbExecute(con, stmt)

dbRemoveTable(con, 'rest_info')

df <- read.csv('restaurant final.csv')
df


df_1 <- df %>%
  select(rest_id, rest_name, rest_phone, rest_permit, rest_lag, rest_lng, rest_street) %>%
  distinct()

colnames(df_1) <- c(new_col1_name,new_col2_name,new_col3_name)

dbWriteTable(
  conn = con, 
  name = 'rest_info',
  value = df_1, 
  row.names = FALSE, 
  append = TRUE
)

#_create stage table----
stmt <- 'CREATE TABLE stage (
          stage_id int,
          artist_name varchar(50),
          artist_id int, 
          song_id int, 
          stage_day int, 
          PRIMARY KEY(stage_id), 
          FOREIGN KEY(artist_id) REFERENCES artist, 
          FOREIGN KEY(song_id) REFERENCES song
        );'
dbExecute(con, stmt)  

#_create artist table----

stmt <- 'CREATE TABLE artist (
          artist_id int,
          artist_name varchar(50),
          artist_type varchar(50),
          PRIMARY KEY(artist_id)
        );'
dbExecute(con, stmt)  

#_create song table----
stmt <- 'CREATE TABLE song (
          song_id int,
          song_name varchar(100),
          PRIMARY KEY(song_id)
        );'
dbExecute(con, stmt)  



#******************----
#EXTRACT----
#_read source data----
df_stage <- read.csv("stage.csv")
df_artist <- read.csv("artist.csv")
df_song <- read.csv("song.csv")

df_stage
df_artist
df_song

nrow(df_artist)

#******************----
#LOAD----
#_load stage table----
df1 <- df_stage %>%
  select(stage_id, artist_name, artist_id, song_id, stage_day) %>%
  distinct()
#df2 attaches the stage_id primary key
dbWriteTable(
  conn = con, 
  name = 'stage',
  value = df1, 
  row.names = FALSE, 
  append = TRUE
)



#_load artist table----
df2 <- df_artist %>%
  select(artist_id, artist_name, artist_type) %>%
  distinct()
#df2 attaches the artist_id primary key
dbWriteTable(
  conn = con, 
  name = 'artist',
  value = df2, 
  row.names = FALSE, 
  append = TRUE
)


#_load song table----
df3 <- df_song %>%
  select(song_id, song_name) %>%
  distinct()
#df2 attaches the song_id primary key
dbWriteTable(
  conn = con, 
  name = 'song',
  value = df3, 
  row.names = FALSE, 
  append = TRUE
)

