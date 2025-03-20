# Install and load required libraries
install.packages(c("ggplot2", "plotly", "shiny"))
library(ggplot2)
library(plotly)
library(shiny)

# Creating data frames for each segment based on the provided data

# Market Size Data
market_size <- data.frame(
  Year = 2023:2034,
  Market_Size = c(1042.8, 1309.0, 1636.7, 2034.1, 2507.6, 3060.0, 3688.2, 4380.9, 5116.0, 5859.4, 6564.2, 7173.4),
  YoY_Growth = c(NA, 25.53, 25.03, 24.28, 23.28, 22.03, 20.53, 18.78, 16.78, 14.53, 12.03, 9.28)
)

# Regional Insights Data
regional_insights <- data.frame(
  Region = c("North America", "Europe", "Asia Pacific", "Middle East and Africa", "Latin America"),
  CAGR = c(13.7, 14.5, 15.1, 13.3, 14.0),
  Market_Size_2025 = c(2261.1, 1883.0, 1827.8, 749.6, 451.9)
)

# Deployment Modes Data
deployment_modes <- data.frame(
  Mode = c("Cloud", "On-premises"),
  CAGR = c(14.0, 15.1),
  Market_Size_2025 = c(5749.5, 1423.9)
)

# Components Data
components <- data.frame(
  Component = c("Software", "Services"),
  CAGR = c(14.1, 14.7),
  Market_Size_2025 = c(5605.4, 1568.0)
)


market_plot <- ggplot(market_size, aes(x = Year, y = Market_Size)) +
  geom_line(color = "blue", size = 1) +
  geom_point(color = "orange", size = 3) +
  ggtitle("Global VDR Market Size (2023-2034)") +
  ylab("Market Size (USD Million)") +
  xlab("Year") +
  theme_minimal()

# Convert to interactive plot using plotly
market_plot_interactive <- ggplotly(market_plot)
market_plot_interactive


region_plot <- ggplot(regional_insights, aes(x = Region, y = Market_Size_2025, fill = Region)) +
  geom_bar(stat = "identity") +
  ggtitle("Regional Market Size (2025)") +
  ylab("Market Size (USD Million)") +
  xlab("Region") +
  theme_minimal()

# Convert to interactive plot using plotly
region_plot_interactive <- ggplotly(region_plot)
region_plot_interactive

deployment_plot <- ggplot(deployment_modes, aes(x = Mode, y = Market_Size_2025, fill = Mode)) +
  geom_bar(stat = "identity") +
  ggtitle("VDR Market by Deployment Mode (2025)") +
  ylab("Market Size (USD Million)") +
  xlab("Deployment Mode") +
  theme_minimal()

# Convert to interactive plot using plotly
deployment_plot_interactive <- ggplotly(deployment_plot)
deployment_plot_interactive


component_plot <- ggplot(components, aes(x = Component, y = Market_Size_2025, fill = Component)) +
  geom_bar(stat = "identity") +
  ggtitle("VDR Market by Components (2025)") +
  ylab("Market Size (USD Million)") +
  xlab("Component") +
  theme_minimal()

# Convert to interactive plot using plotly
component_plot_interactive <- ggplotly(component_plot)
component_plot_interactive


ui <- fluidPage(
  titlePanel("Global VDR Market Analysis"),
  sidebarLayout(
    sidebarPanel(
      selectInput("view", "Choose a View:", 
                  choices = c("Market Size Over Time", "Regional Insights", 
                              "Deployment Modes", "Components")),
    ),
    mainPanel(
      plotlyOutput("plot")
    )
  )
)

server <- function(input, output) {
  output$plot <- renderPlotly({
    if (input$view == "Market Size Over Time") {
      market_plot_interactive
    } else if (input$view == "Regional Insights") {
      region_plot_interactive
    } else if (input$view == "Deployment Modes") {
      deployment_plot_interactive
    } else if (input$view == "Components") {
      component_plot_interactive
    }
  })
}

shinyApp(ui = ui, server = server)



