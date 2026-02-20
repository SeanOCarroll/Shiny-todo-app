library(shiny)

ui <- fluidPage(
  tags$head(
    tags$style(HTML("
      body {
        background-color: #eef2f7;
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI',
                     Roboto, Arial, sans-serif;
      }

      .card {
        background: white;
        padding: 28px;
        border-radius: 14px;
        max-width: 900px;
        margin: 48px auto;
        box-shadow: 0 10px 22px rgba(0,0,0,0.10);
      }

      .btn { margin-bottom: 10px; }
    ")),
    
    # Enter key adds task
    tags$script(HTML("
      $(document).on('keypress', '#new_item', function(e) {
        if (e.which === 13) {
          e.preventDefault();
          $('#add').click();
        }
      });
    "))
  ),
  
  div(class = "card",
      titlePanel("To-Do List"),
      
      sidebarLayout(
        sidebarPanel(
          textInput("new_item", "New task"),
          actionButton("add", "Add Task"),
          
          tags$hr(),
          
          actionButton("mark_all_done", "All Done"),
          actionButton("mark_selected_done", "Selected Done"),
          
          tags$hr(),
          
          actionButton("delete_selected", "Delete Selected"),
          actionButton("delete_all", "Delete ALL")
        ),
        
        mainPanel(
          checkboxGroupInput(
            "selected_tasks",
            "Select Tasks:",
            choices = NULL
          ),
          
          tags$hr(),
          h4("Task Status"),
          tableOutput("task_table")
        )
      )
  )
)

server <- function(input, output, session) {
  
  tasks <- reactiveVal(data.frame(
    id = integer(),
    task = character(),
    done = logical(),
    stringsAsFactors = FALSE
  ))
  
  next_id <- reactiveVal(0)
  
  # Add task
  observeEvent(input$add, {
    txt <- trimws(input$new_item)
    if (txt == "") return()
    
    id <- next_id() + 1
    next_id(id)
    
    df <- tasks()
    df <- rbind(df, data.frame(id = id, task = txt, done = FALSE))
    tasks(df)
    
    updateTextInput(session, "new_item", value = "")
  })
  
  # Update checkbox choices (selection only)
  observe({
    df <- tasks()
    
    updateCheckboxGroupInput(
      session,
      "selected_tasks",
      choices = setNames(as.character(df$id), df$task)
    )
  })
  
  # Toggle ALL tasks done/undone
  observeEvent(input$mark_all_done, {
    df <- tasks()
    
    if (all(df$done) && nrow(df) > 0) {
      df$done <- FALSE
    } else {
      df$done <- TRUE
    }
    
    tasks(df)
  })
  
  # Toggle SELECTED tasks done/undone
  observeEvent(input$mark_selected_done, {
    df <- tasks()
    
    selected_ids <- as.integer(input$selected_tasks)
    df$done[df$id %in% selected_ids] <-
      !df$done[df$id %in% selected_ids]
    
    tasks(df)
  })
  
  # Delete selected (multiple allowed)
  observeEvent(input$delete_selected, {
    df <- tasks()
    selected_ids <- as.integer(input$selected_tasks)
    
    df <- df[!(df$id %in% selected_ids), ]
    tasks(df)
    
    updateCheckboxGroupInput(session,
                             "selected_tasks",
                             selected = character(0))
  })
  
  # Delete ALL
  observeEvent(input$delete_all, {
    tasks(data.frame(
      id = integer(),
      task = character(),
      done = logical(),
      stringsAsFactors = FALSE
    ))
    
    updateCheckboxGroupInput(session,
                             "selected_tasks",
                             selected = character(0))
  })
  
  # Display table
  output$task_table <- renderTable({
    df <- tasks()
    
    if (nrow(df) == 0)
      return(data.frame(Message = "No tasks yet"))
    
    data.frame(
      Task = df$task,
      Done = ifelse(df$done, "✅", "")
    )
  }, rownames = FALSE)
}

shinyApp(ui, server)
