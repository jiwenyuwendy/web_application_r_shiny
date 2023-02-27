ui <- fullPage(
  
  opts = list(
    controlArrows = FALSE,
    fadingEffect = TRUE,
    fitToSection = TRUE,
    loopBottom = FALSE,
    loopHorizontal = TRUE,
    navigation = FALSE,
    scrollBar = FALSE,
    scrollOverflow = TRUE,
    scrollOverflowReset = TRUE,
    slidesNavigation = TRUE,
    verticalCentered = TRUE
  ),
  
  # menu tabs----
  menu = c(
    'Home' = 'home',
    'The Lineup' = 'artists',
    'The Venue' = 'venue',
    'The Experience' = 'exper',
    'About Us' = 'about'
  ),
  
  # home section----
  fullSectionImage(
    menu = 'home',
    center = TRUE,
    img = 'background123.gif',
    fullSlide(
      div(
        style = 'padding:0 20% 0 20%;',
        wellPanel(
          style = 'background-color:rgba(20,20,20,0.5); 
                   padding:15px; border-width:0;',
          fullButtonDown(
            # img(
            #   src = 'logo.png',
            #   height = '120px',
            # )
          ),
          h2(
            style = 'color:white; font-size:36px;',
            'Hawaii Music Festival'
          ),
          hr(),
          div(
            style = 'padding:0 5% 0 5%;',
            fluidRow(
              column(
                width = 5,
                align = 'right',
                actionBttn(
                  inputId = 'sqlDts',
                  label = 'December 02-04, 2022',
                  style = 'stretch',
                  color = 'primary',
                  size = 'sm'
                )
              ),
              column(
                width = 2,
                h5(style = 'color:white;','|')
              ),
              column(
                width = 5,
                align = 'left',
                actionBttn(
                  inputId = 'sqlDts',
                  label = 'Honolulu, HI',
                  style = 'stretch',
                  color = 'danger',
                  size = 'sm'
                )
              )
            )
          )
        )
      ),
    )
  ),

  # artists section----
  fullSectionImage(
    menu = 'artists',
    center = TRUE,
    img = 'pg_artist.jpeg',
    fullSlide(
      uiOutput('uiArt1')
    ),
    fullSlide(
      uiOutput('uiArt2')
    )
  ),
  
  # venue section----
  fullSectionImage(
    menu = 'venue',
    center = TRUE,
    img = 'stad.jpeg',
    fullSlide(
      fullButtonRight(
        img(
          src = 'Aloha_Stadium2.png',
          width = '40%'
        )
      )
    ),
    fullSlide(
      uiOutput('uiVenue')
    )
  ),
  
  # exper section----
  fullSectionImage(
    menu = 'exper',
    center = TRUE,
    img = 'experience.jpg',
    fullSlide(
      wellPanel(
        style = 'background-color:rgba(0,0,0,0); border:0px; 
                 padding:0 15% 0 15%;',
        h1(style = 'color:white; line-height:1.5;',
          'Explore Hawaii'),
        hr(),
        fluidRow(
          column(
            width = 3,
            fullButtonRight(
              actionBttn(
                inputId = 'hotels',
                label = 'Hotels',
                style = 'gradient',
                color = 'primary',
                size = 'lg',
                block = TRUE
              )
            )
          ),
          column(
            width = 3,
            fullButtonRight(
              actionBttn(
                inputId = 'rests',
                label = 'Restaurants',
                style = 'gradient',
                color = 'success',
                size = 'lg',
                block = TRUE
              )
            )
          ),
          column(
            width = 3,
            fullButtonRight(
              actionBttn(
                inputId = 'park',
                label = 'Parks',
                style = 'gradient',
                color = 'danger',
                size = 'lg',
                block = TRUE
              )
            )
          ),
          column(
            width = 3,
            fullButtonRight(
              actionBttn(
                inputId = 'ame',
                label = 'Hospitals',
                style = 'gradient',
                color = 'warning',
                size = 'lg',
                block = TRUE
              )
            )
          )
        )
      )
    ),
    fullSlide(
      uiOutput('uiExper')
    )
  ),
  
  # about section----
  fullSectionImage(
    menu = 'about',
    center = TRUE,
    img = 'about_us.jpg',
    fullSlide(
      wellPanel(
        style = 'background-color:rgba(0,0,0,0); border:0px; 
                 padding-top:40vh; padding-bottom:40vh;',
        fullButtonRight(
          h1(
            style = 'color:white;',
            'Our Team'
          )
        )
      )
    ),
    fullSlide(
      uiOutput('uiTeam')
    )
  )
  
)


