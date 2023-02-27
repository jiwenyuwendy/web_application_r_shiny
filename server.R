server <- function(input, output, session) {
  
  # reactive values----
  a <- reactiveValues(
    rt = NULL, # artist number (1-15)
    fd = NULL, # festival day (1-3)
    mn = NULL, # member number (1-5)
    ex = NULL, # experience option (1-4)
    ii = 0,  # experience list group
    ij = 1, # experience list item (1-3)
    eh = NULL, # hotel selected items
    er = NULL, # restaurant selected items
    ep = NULL, # park selected items
    ea = NULL, # amenities selected items
    ee = FALSE, # experience conversion
  )
  
  # ui art1----
  output$uiArt1 <- renderUI(
    {
      div(
        style = 'padding:0 10% 0 10%;',
        lapply(
          0:2, 
          function(i) {
            wellPanel(
              style = 'background-color:rgba(250,250,250,0.5);',
              fluidRow(
                column(
                  width = 2,
                  style = 'padding-top:5vh;',
                  actionBttn(
                    inputId = paste0('day', i+1),
                    label = (c('Friday', 'Saturday', 'Sunday')[i+1]),
                    style = 'minimal',
                    color = 'primary',
                    size = 'md'
                  )
                ),
                lapply(
                  1:5, 
                  function(j) {
                    column(
                      width = 2,
                      fullButtonRight(
                        tags$button(
                          id = paste0('btnArt', 5*i+j),
                          class = 'btn action-button',
                          style = 'background-color:rgba(0,0,0,0);',
                          img(
                            src = paste0('artists/', arts11$art_id[5*i+j], '.png'),
                            width = '80%'
                          )
                        )
                      ),
                      h5(
                        style = 'margin-bottom:0;',
                        arts11$art_name[5*i+j]
                      )
                    )
                  }
                )
              )
            )
          }
        ),
        uiOutput('festTix')
      )
    }
  )
  
  # _events day button----
  observeEvent(input$day1, {a$fd <- 1})
  observeEvent(input$day2, {a$fd <- 2})
  observeEvent(input$day3, {a$fd <- 3})
  
  # _events artist button----
  observeEvent(input$btnArt1, {a$rt <- 1})
  observeEvent(input$btnArt2, {a$rt <- 2})
  observeEvent(input$btnArt3, {a$rt <- 3})
  observeEvent(input$btnArt4, {a$rt <- 4})
  observeEvent(input$btnArt5, {a$rt <- 5})
  observeEvent(input$btnArt6, {a$rt <- 6})
  observeEvent(input$btnArt7, {a$rt <- 7})
  observeEvent(input$btnArt8, {a$rt <- 8})
  observeEvent(input$btnArt9, {a$rt <- 9})
  observeEvent(input$btnArt10, {a$rt <- 10})
  observeEvent(input$btnArt11, {a$rt <- 11})
  observeEvent(input$btnArt12, {a$rt <- 12})
  observeEvent(input$btnArt13, {a$rt <- 13})
  observeEvent(input$btnArt14, {a$rt <- 14})
  observeEvent(input$btnArt15, {a$rt <- 15})
  
  # _ui fest tix----
  output$festTix <- renderUI(
    if (!is.null(a$fd)) {
      div(
        actionBttn(
          inputId = 'tix1',
          label = paste(
            'Buy',
            c('Friday', 'Saturday', 'Sunday')[a$fd],
            'Pass'
          ),
          style = 'unite',
          color = 'primary',
          size = 'md'
        ),
        actionBttn(
          inputId = 'tix3',
          label = 'Buy Full 3-Day Pass',
          style = 'unite',
          color = 'success',
          size = 'md'
        )
      )
    }
  )
  
  # _events buy tix----
  observeEvent(input$tix1, {tixConf(1)})
  observeEvent(input$tix3, {tixConf(3)})
  
  # _function ticket confirm----
  tixConf <- function(d) {
    i <- if_else(d == 1, a$fd, 4)
    shinyalert(
      title = 'Thank you!',
      text = paste0(
        '<h3>You have purchased a pass for ',
        c('Friday night', 'Saturday night', 'Sunday night', 
          'all three nights')[i],
        '</h3>'
      ),
      showConfirmButton = TRUE,
      html = TRUE,
      type = 'success',
      closeOnClickOutside = TRUE
    )
  }
  
  # ui art2----
  output$uiArt2 <- renderUI(
    if (!is.null(a$rt)) {
      div(
        style = 'padding:0 10% 0 10%;',
        tags$iframe(
          height = '425px',
          width = '100%',
          style = 'border:5px solid white; border-radius:10px; margin-bottom:10px;',
          src = paste0(
            'https://www.youtube.com/embed/',
            arts11$vid[a$rt]
          ),
          allow = 'fullscreen; autoplay;'
        ),
        fullButtonLeft(
          actionBttn(
            inputId = 'backArt1',
            label = 'Back',
            style = 'simple',
            color = 'warning',
            size = 'md',
            icon = icon('arrow-left')
          )
        )
      )
    }
  )
  
  # ui venue----
  output$uiVenue <- renderUI(
    {
      div(
        style = 'padding:0 10% 0 10%;',
        wellPanel(
          style = 'background-color:rgba(100,100,100,0.7);',
          fluidRow(
            column(
              width = 6,
              align = 'left',
              h4(
                style = 'color:orange; line-height:1.25;',
                'The ',
                tags$span(
                  style = 'color:pink; line-height:1.25;', 
                  'Aloha Stadium ',
                  tags$span(
                    style = 'color:orange; line-height:1.25;',
                    paste0(
                      'Located in Central Oahu, for the past 47 years, ',
                      ' Aloha Stadium has been Hawaii’s largest outdoor arena and home to the',
                      ' University of Hawaii Rainbow Warriors football team.',
                      'As the historic facility evolves into the New Aloha Stadium Entertainment District,',
                      'or NASED, the stadium continues to host exciting events',
                      'that attract local residents and global visitors, including holiday light shows, car exhibits,',
                      'fairs and the ever-popular Aloha Stadium Swap Meet and Marketplace.',
                      'There is no greater place than the Aloha Stadium!')
                  )
                )
              ),
              h4(
                style = 'color:orange; line-height:1.25;',
                paste0(
                  'As a friendly reminder animals are not allowed at the stadium.',
                  ' Face coverings are recommended in large gatherings and social 
                  distancing is encouraged.',
                  ' Swap Meet is located outdoors in the stadium 
                  parking lot: Caution Warning: ',
                  'Surfaces May be Uneven. Watch your Step when walking around.')
              ),
              h4(
                style = 'color:orange; line-height:1.25;',
                paste0(
                  'We invite you to join us for the single greatest music ',
                  'festival while exploring all the beauty and flavors of Hawaii!')
              )
            ),
            column(
              width = 6,
              leafletOutput('stadiumMap', height = '60vh')
            )
          )
        ),
        fullButtonLeft(
          actionBttn(
            inputId = 'backVen1',
            label = 'Back',
            style = 'simple',
            color = 'warning',
            size = 'md',
            icon = icon('arrow-left')
          )
        )
      )
    }
  )
  
  # _Aloha Stadium map----
  output$stadiumMap <- renderLeaflet(
    {
      leaflet() %>%
        addProviderTiles(
          provider = providers$Stamen.TonerLite
        ) %>%
        addMarkers(
          lat = 21.37285, 
          lng = -157.92998,
          popup = 'Aloha Stadium'
        )
    }
  )

  
  # ui exper----
  output$uiExper <- renderUI(
    if (!is.null(a$ex)) {
      div(
        style = 'padding:0 10% 0 10%;',
        wellPanel(
          style = 'background-color:rgba(100,100,100,0.7);
                   padding-top:3px;',
          h2(
            style = paste0(
              'color:',
              switch(
                a$ex,
                'lightblue;',
                'lightgreen;',
                'lightpink;',
                'lightblue;'
              )
            ),
            switch(
              a$ex,
              'Honolulu Hotels',
              'Honolulu Restaurants',
              'Honolulu Park',
              'Honolulu Hospitals'
            )
          ),
          fluidRow(
            column(
              width = 8,
              switch(
                a$ex,
                leafletOutput('expMap', height = '50vh'),
                leafletOutput('expMap', height = '50vh'),
                uiOutput('parkImg'),
                leafletOutput('expMap', height = '50vh')
              )
              
            ),
            column(
              width = 4,
              uiOutput('expList'),
              actionBttn(
                inputId = 'showL',
                label = NULL,
                style = 'simple',
                color = 'primary',
                size = 'sm',
                icon = icon('arrow-left')
              ),
              actionBttn(
                inputId = 'showR',
                label = NULL,
                style = 'simple',
                color = 'primary',
                size = 'sm',
                icon = icon('arrow-right')
              )
            )
          ),
          uiOutput('experMsg')
        ),
        fullButtonLeft(
          actionBttn(
            inputId = 'backExp1',
            label = 'Back',
            style = 'simple',
            color = 'warning',
            size = 'md',
            icon = icon('arrow-left')
          )
        )
      )
    }  
  )
  
  # _ui exper msg----
  output$experMsg <- renderUI(
    if (a$ee) {
      h4(
        style = 'color:white;',
        switch(
          a$ex,
          paste0('You have booked a room at ', a$eh$accom_name[3*a$ii+a$ij]),
          paste0('You have reserved a table at ', a$er$rest_name[3*a$ii+a$ij]),
          paste0('You have purchased tickets for ', a$ep$park_name[3*a$ii+a$ij]),
          paste0('Please call this number: ', a$ea$hos_phone[3*a$ii+a$ij])
        )
      )
    }
  )
  
  # _event show more button----
  observeEvent(
    input$showL, 
    {
      a$ee <- FALSE
      a$ii <- ifelse(
        a$ii > 0,
        a$ii - 1,
        switch(
          a$ex,
          9,
          9,
          9,
          2
        )
      )
    }
  )
  
  observeEvent(
    input$showR, 
    {
      a$ee <- FALSE
      a$ii <- ifelse(
        a$ii < switch(
          a$ex,
          9,
          9,
          9,
          2
        ),
        a$ii + 1,
        0
      )
    }
  )
  
  # _events exper button----
  observeEvent(input$hotels,  {a$ex <- 1; a$ii <- 0; a$ee <- FALSE})
  observeEvent(input$rests,  {a$ex <- 2; a$ii <- 0; a$ee <- FALSE})
  observeEvent(input$park, {a$ex <- 3; a$ii <- 0; a$ee <- FALSE})
  observeEvent(input$ame, {a$ex <- 4; a$ii <- 0; a$ee <- FALSE})

  # _ui park image----
  output$parkImg <- renderUI(
    {
      img(
        src = paste0('parks/park', sample(1:5,1), '.jpeg'),
        width = '100%'
      )
    }
  )
  
  # _exp map----
  output$expMap <- renderLeaflet(
    {
      z = switch(
        a$ex, 
        dbGetQuery(con, 'SELECT * FROM accom ORDER BY random() LIMIT 30;'), 
        dbGetQuery(con, 'SELECT * FROM rest_info ORDER BY random() LIMIT 30;'),
        dbGetQuery(con, 'SELECT * FROM park_amanities ORDER BY random() LIMIT 30;'),
        dbGetQuery(con, 'SELECT * FROM hos_info;')
        
      )
      switch(
        a$ex, 
        a$eh <- z,
        a$er <- z,
        a$ep <- z,
        a$ea <- z
      )
      # z <- z %>% 
      #   sample_n(10)
      leaflet(
        z
      ) %>%
        addProviderTiles(
          provider = providers$Stamen.TonerLite
        ) %>%
        addAwesomeMarkers(
          lng = ~lng,
          lat = ~lat,
          popup = ~switch(a$ex, accom_name, rest_name, park_name,hos_name),
          icon = awesomeIcons(
            markerColor = switch(a$ex, 'blue', 'green','red', 'orange'),
            text = 1:switch(a$ex,30,30,30,9)
          )
        ) 
    }
  )
  
  # _exp list----
  output$expList <- renderUI(
    {
      lapply(
        1:3,
        function(i) {
          wellPanel(
            align = 'left',
            h5(
              paste0(
                3*a$ii + i, ') ', 
                switch(a$ex,
                       a$eh$accom_name[3*a$ii + i],
                       a$er$rest_name[3*a$ii + i],
                       a$ep$park_name[3*a$ii + i],
                       a$ea$hos_name[3*a$ii + i]
                       )
              )
            ),
            actionBttn(
              inputId = paste0('btnExp', i),
              label = switch(a$ex,
                             'Book a Room',
                             'Reserve a Table',
                             'Buy Tickets',
                             'Make a Call'),
              style = 'simple',
              color = switch(a$ex,
                             'primary',
                             'success',
                             'danger',
                             'warning'),
              size = 'sm'
            )
          )
        }
      )
    }
    
  )
  
  # _event btnExp----
  observeEvent(input$btnExp1, {a$ij <- 1; a$ee <- TRUE})
  observeEvent(input$btnExp2, {a$ij <- 2; a$ee <- TRUE})
  observeEvent(input$btnExp3, {a$ij <- 3; a$ee <- TRUE})
  
  # ui team----
  output$uiTeam <- renderUI(
    {
      div(
        style = 'padding:0 35% 0 35%;',
        lapply(
          1:5,
          function(i) {
            wellPanel(
              style = 'background-color:rgba(255,255,255,0.9); padding:3px;',
              fluidRow(
                column(
                  width = 4,
                  align = 'right',
                  img(
                    src = paste0(i, '.jpg'),
                    height = '60vh'
                  )
                ),
                column(
                  width = 8,
                  align = 'left',
                  style = 'padding-top:5px;',
                  actionBttn(
                    inputId = paste0('member', i),
                    label = c('Member1', 'Member2', 'Member3', 'Member4', 'Member5')[i],
                    style = 'stretch',
                    color = c('primary', 'success', 'warning', 'danger', 'royal')[i],
                    size = 'lg',
                    block = FALSE
                  )
                )
              )
            )
          }
        )
      )
    }
  )
  
  # _events member button----
  observeEvent(input$member1, {a$mn <- 1; memDet()})
  observeEvent(input$member2, {a$mn <- 2; memDet()})
  observeEvent(input$member3, {a$mn <- 3; memDet()})
  observeEvent(input$member4, {a$mn <- 4; memDet()})
  observeEvent(input$member5, {a$mn <- 5; memDet()})

  
  # _function member details----
  memDet <- function() {
    shinyalert(
      title = c('Wenyu Ji')[a$mn],
      text = paste0(
        '<h1>', c('CEO')[a$mn], '</h1>',
        '<hr>',
        '<img src = "', a$mn, '.jpg" ',
        'width ="200px"></img>'
      ),
      showConfirmButton = TRUE,
      html = TRUE,
      closeOnClickOutside = TRUE
    )
  }
}
