library(shiny)


shinyUI(fluidPage(
    titlePanel("Lizbeth Contreras"),
    sidebarLayout(
        sidebarPanel(
          radioButtons("opcion", label = h3("Tarea:"), choices = c("Tarea 1", "Tarea 2","Tarea 4"), selected = 'Tarea 1'),
  
          ##############
          ## Tarea 4  ##
          ##############
          
 conditionalPanel(
              'input.opcion === "Tarea 4"',
              
              selectInput("dep", "Variable Dependiente:", choices = c('crim'=1,'black'=2,'rm'=3,'medv'=4)), 
              checkboxGroupInput("checkGroup", label = "Variables Independientes", 
                                 choices = c('crim'=1,'black'=2,'rm'=3,'medv'=4),
                                 selected = 2:4),
            sliderInput('long4', label = 'Numero de cadenas', value = 1, min = 1, max = 10, step = 1),
              sliderInput('N4', label = 'Longitud de la cadena', min = 1000, max = 100000, value =1000, step = 1000),
            actionButton('Calcular', 'Calcular')),
            
            
#-------------------------------------------------------------------------------            
            conditionalPanel(
              'input.opcion === "Tarea 2"',
            
            numericInput('n', label = 'Dimension de la funcion', value = 2, min = 1, max = 5),
            textInput(
              inputId="expresionMC", 
              label="Funcion g(x)",
              value="function(x) 12*x[1]^2/(1+x[2]^2)"
            ),
            sliderInput('a', label = 'Limites de integracion', min = -6, max = 6, value = c(0,1), step = 0.5),
            selectInput("N", "Numero de simulaciones:", choices = c(10,100,1000,10000,100000), selected = 100), 
            sliderInput('alpha', label = 'Significancia del intervalo', min = 0.001, max = 0.1, value = 0.05, step = 0.001)),
            
  #------------------------------------------------------------------------------------------------------------          
            conditionalPanel(
                'input.opcion === "Tarea 1"',
                sliderInput('nsims', label = 'Numero de simulaciones', value = 1800, min = 10, max = 2000, step = 1),
                sliderInput('nbins', label = 'Numero de clases', value = 10, min = 2, max = 10, step = 1),

                  numericInput("lambda",
                               "Parametro:",
                               value = 2,step=.1),
                  downloadButton('downloadData', 'Download')
                  
              
            )
            
            
        ),
##############
## Tarea 1  ##
##############
        mainPanel(
          conditionalPanel(condition="input.opcion=='Tarea 1'",
            tabsetPanel(type = 'tabs',
                        tabPanel("Histograma",
                                 
                                 plotOutput("distPlot")),
                        tabPanel("Pruebas", plotOutput("plotVs")  , h1('Bondad de ajuste'), 
                                 p(textOutput("pvalChi"),textOutput("pvalK"))),
                        
                       
                        tabPanel("Descriptivos",h4('Descriptivos de la muestra obtenida.') ,verbatimTextOutput("summary"),
                                 h4('Valores teoricos: '),  h5(textOutput('media')),h5(textOutput('q1')),h5(textOutput('mediana')) ,h5(textOutput('q3'))),
                        
                        tabPanel("Observaciones", 
                                 h4('Para descargar un archivo csv con todas las simulaciones, oprimir el boton Download.'),tableOutput("table"))
        ))
        ,
 #---------------------------------------------------------------------------------------------------
 
        conditionalPanel(condition="input.opcion=='Tarea 4'",
                         tabsetPanel(type = 'tabs',
                                     tabPanel('Grafico de Dispersion',
                                     
                                    h5('Modelo'),
                                    withMathJax('$$Y=X\\beta+\\epsilon \\mbox{, en donde }\\epsilon\\sim N(0,\\sigma^2I)$$'),
h5('Se utilizaran las distribuciones a priori:'),     
withMathJax('$$\\beta_j\\sim N(0,100)$$'),
withMathJax('$$\\sigma\\sim exp\\left(\\frac{1}{10}\\right)$$'),
h5('Grafica de dispersion de la base de datos Boston.'),
plotOutput('Boston'),

withMathJax(uiOutput('tableMH')),
withMathJax(uiOutput('tableMH2'))

),

                           tabPanel('Histogramas',h4('A continuacion se presentan los histogramas obtenidos para cada parametro.'),plotOutput('ploH')
                                    
                           ),
                           
                           
                           tabPanel('Densidad',h4('Aqui se presentan la distribucion a priori y la posterior obtenida.'),plotOutput('ploPP')
                                    
                           ),
                           tabPanel('Datos', h4('A continuacion se presentan las simulacion de las cadenas para cada parametro.'),dataTableOutput("tablechain"))))
        
        ,
        
 conditionalPanel(condition="input.opcion=='Tarea 2'",
                   tabsetPanel(
                     #         tabPanel('Hist', plotOutput('random_hist')),
                     tabPanel('Estimacion',
                             h5('En dimension 2, function(x) 12*x[1]^2/(1+x[2]^2) representarC-a: '),
                              withMathJax("$$\\int_{0}^{1}\\int_{0}^{1}\\frac{12x^2}{1+y^2}dxdy=\\pi$$"),
                              
                              withMathJax(uiOutput('estim_MC')),
                              withMathJax(uiOutput('estim_trap')),
                              
                              plotOutput('plot', width = '8in', height = '3in'),
                              checkboxInput('ribbon', 'Mostrar intervalos de confianza', value = TRUE),
                              checkboxInput('trap', 'Comparar con metodo del trapecio', value = FALSE)
                              

                     ),
                     tabPanel('Datos', dataTableOutput('data'))
                   )
                   
                   
                   
                   )


        
        
)
)))


