library(readxl)
data_bike_crash <- read_excel("~/Master's in Analytics/ALY 6040/bike_crash dataset.xlsx")
View(data_bike_crash)

#Data Exploration
# View the structure of the dataset
str(data_bike_crash)

# Summary statistics of numeric variables
summary(data_bike_crash)

# Check for missing values
missing_values <- colSums(is.na(data_bike_crash))

# Print columns with missing values
print(missing_values[missing_values > 0])
library(ggplot2)

# Plot histograms for relevant features
ggplot(data_bike_crash, aes(x = `Crash Severity`)) +
  geom_bar() +
  labs(title = "Distribution of Crash Severity")

ggplot(data_bike_crash, aes(x = `Crash Time`)) +
  geom_histogram(binwidth = 1) +
  labs(title = "Distribution of Crash Time")

ggplot(data_bike_crash, aes(x = `Surface Condition`)) +
  geom_bar() +
  labs(title = "Distribution of Road Conditions")

ggplot(data_bike_crash, aes(x = `Day of Week`)) +
  geom_bar() +
  labs(title = "Distribution of Day")

ggplot(data_bike_crash, aes(x = `Roadway Part`)) +
  geom_bar() +
  labs(title = "Distribution of Roadway Part")



library(dplyr)
library(magrittr)

# Feature engineering
data_bike_crash <- data_bike_crash %>%
  mutate(`Crash Timing` = case_when(
    `Crash Time` >= 1 & `Crash Time` <= 554 ~ "Midnight",
    `Crash Time` >= 603 & `Crash Time` <= 1159 ~ "Morning",
    `Crash Time` >= 1200 & `Crash Time` <= 1759 ~ "Afternoon",
    `Crash Time` >= 1800 & `Crash Time` <= 2358 ~ "Evening"
  ))

View(data_bike_crash)



# Bar plot showing Crash Severity by Person Helmet
ggplot(data_bike_crash, aes(x = `Crash Severity`, fill = `Person Helmet`)) +
  geom_bar(position = "dodge") +
  labs(title = "Crash Severity by Person Helmet",
       x = "Crash Severity",
       y = "Count",
       fill = "Person Helmet") +
  scale_fill_manual(values = c("Not Worn" = "red", "Unknown If Worn" = "blue", "Worn, Damaged" = "black", "Worn, Not Damaged" = "green", "Worn, Unk Damage" = "pink" )) +
  theme_minimal()


library(dplyr)

# Removing irrelevant variables
data_bike_crash <- data_bike_crash %>%
  select(-c("$1000 Damage to Any One Person's Property", 
            "Active School Zone Flag",
            "At Intersection Flag",
            "Average Daily Traffic Amount",
            "Construction Zone Flag",
            "Crash Time",
            "Crash Total Injury Count",
            "Crash Year",
            "Day of Week",
            "Intersection Related",
            "Traffic Control Type"))

# View the modified dataframe
View(data_bike_crash)


feature_select_data <- read_excel("~/Master's in Analytics/ALY 6040/bike_crash dataset.xlsx")
View(feature_select_data)

# Drop the specified variables
feature_select_data <- feature_select_data %>%
  select(-c("$1000 Damage to Any One Person's Property", 
            "Average Daily Traffic Amount", 
            "Crash Total Injury Count", 
            "Crash Year", 
            "Intersection Related", 
            "Traffic Control Type"))

# View the modified dataset
View(feature_select_data)


feature_select_data$`Active School Zone Flag`[feature_select_data$`Active School Zone Flag` == "No"] <- 0
feature_select_data$`Active School Zone Flag`[feature_select_data$`Active School Zone Flag` == "Yes"] <- 1

feature_select_data$`At Intersection Flag`[feature_select_data$`At Intersection Flag` == "FALSE"] <- 0
feature_select_data$`At Intersection Flag`[feature_select_data$`At Intersection Flag` == "TRUE"] <- 1

feature_select_data$`Construction Zone Flag`[feature_select_data$`Construction Zone Flag` == "No"] <- 0
feature_select_data$`Construction Zone Flag`[feature_select_data$`Construction Zone Flag` == "Yes"] <- 1

feature_select_data$`Crash Severity`[feature_select_data$`Crash Severity` == "Non-Incapacitating Injury"] <- 0
feature_select_data$`Crash Severity`[feature_select_data$`Crash Severity` == "Incapacitating Injury"] <- 1
feature_select_data$`Crash Severity`[feature_select_data$`Crash Severity` == "Killed"] <- 2
feature_select_data$`Crash Severity`[feature_select_data$`Crash Severity` == "Not Injured"] <- 3
feature_select_data$`Crash Severity`[feature_select_data$`Crash Severity` == "Possible Injury"] <- 4


feature_select_data$`Day of Week`[feature_select_data$`Day of Week` == "Sunday"] <- 0
feature_select_data$`Day of Week`[feature_select_data$`Day of Week` == "Monday"] <- 1
feature_select_data$`Day of Week`[feature_select_data$`Day of Week` == "Tuesday"] <- 0
feature_select_data$`Day of Week`[feature_select_data$`Day of Week` == "Wednesday"] <- 1
feature_select_data$`Day of Week`[feature_select_data$`Day of Week` == "Thursday"] <- 0
feature_select_data$`Day of Week`[feature_select_data$`Day of Week` == "Friday"] <- 1
feature_select_data$`Day of Week`[feature_select_data$`Day of Week` == "Saturday"] <- 0

feature_select_data$`Roadway Part`[feature_select_data$`Roadway Part` == "Main/Proper Lane"] <- 0
feature_select_data$`Roadway Part`[feature_select_data$`Roadway Part` == "Entrance/On Ramp"] <- 1
feature_select_data$`Roadway Part`[feature_select_data$`Roadway Part` == "Other (Explain In Narrative)"] <- 2
feature_select_data$`Roadway Part`[feature_select_data$`Roadway Part` == "Service/Frontage Road"] <- 3

feature_select_data$`Surface Condition`[feature_select_data$`Surface Condition` == "Dry"] <- 0
feature_select_data$`Surface Condition`[feature_select_data$`Surface Condition` == "Wet"] <- 1
feature_select_data$`Surface Condition`[feature_select_data$`Surface Condition` == "Standing Water"] <- 2
feature_select_data$`Surface Condition`[feature_select_data$`Surface Condition` == "Ice"] <- 3
feature_select_data$`Surface Condition`[feature_select_data$`Surface Condition` == "Sand, Mud, Dirt"] <- 4
feature_select_data$`Surface Condition`[feature_select_data$`Surface Condition` == "Unknown"] <- 5
feature_select_data$`Surface Condition`[feature_select_data$`Surface Condition` == "Other (Explain In Narrative)"] <- 6


feature_select_data$`Person Helmet`[feature_select_data$`Person Helmet` == "Not Worn"] <- 0
feature_select_data$`Person Helmet`[feature_select_data$`Person Helmet` == "Unknown If Worn"] <- 1
feature_select_data$`Person Helmet`[feature_select_data$`Person Helmet` == "Worn, Damaged"] <- 2
feature_select_data$`Person Helmet`[feature_select_data$`Person Helmet` == "Worn, Not Damaged"] <- 3
feature_select_data$`Person Helmet`[feature_select_data$`Person Helmet` == "Worn, Unk Damage"] <- 4
feature_select_data$`Person Helmet` <- ifelse(is.na(feature_select_data$`Person Helmet`), 4, feature_select_data$`Person Helmet`)


# Convert the variable to numeric
feature_select_data$`Active School Zone Flag` <- as.numeric(feature_select_data$`Active School Zone Flag`)
feature_select_data$`At Intersection Flag` <- as.numeric(feature_select_data$`At Intersection Flag`)
feature_select_data$`Construction Zone Flag` <- as.numeric(feature_select_data$`Construction Zone Flag`)
feature_select_data$`Crash Severity` <- as.numeric(feature_select_data$`Crash Severity`)
feature_select_data$`Day of Week` <- as.numeric(feature_select_data$`Day of Week`)
feature_select_data$`Roadway Part` <- as.numeric(feature_select_data$`Roadway Part`)
feature_select_data$`Surface Condition` <- as.numeric(feature_select_data$`Surface Condition`)
feature_select_data$`Person Helmet` <- as.numeric(feature_select_data$`Person Helmet`)

View(feature_select_data)
str(feature_select_data)


# Compute the correlation matrix
correlation_matrix <- cor(feature_select_data)

# Convert the correlation matrix to a dataframe for plotting
correlation_df <- as.data.frame(as.table(correlation_matrix))

# Load the required packages
library(ggplot2)

# Create a heatmap using ggplot2
heatmap <- ggplot(data = correlation_df, aes(x = Var1, y = Var2, fill = Freq, label = round(Freq, 2))) +
  geom_tile() +
  geom_text(color = "black") +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", 
                       midpoint = 0, limit = c(-1,1), space = "Lab", 
                       name="Correlation") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

# Print the heatmap
print(heatmap)
# Ensure results are repeatable
set.seed(7)

# Load the required libraries
library(caret)
library(mlbench)  # Assuming mlbench is needed for your dataset

# Prepare training scheme
control <- trainControl(method = "repeatedcv", number = 10, repeats = 3)

# Train the model with linear regression
model <- train(`Crash Severity` ~ ., data = feature_select_data, method = "lm", preProcess = "scale", trControl = control)

# Estimate variable importance
importance <- varImp(model, scale = FALSE)

# Summarize importance
print(importance)

# Plot importance
plot(importance)

# Sample importance values based on ranking
importance_ranking <- data.frame(
  Overall = c(3, 2, 1.5, 1.5, 0.8, 0.5, 0.5, 0.2),
  row.names = c("Roadway Part", "Surface Condition", "Person Helmet", 
                "Speed Limit", "Active School Zone Flag", "At Intersection Flag", 
                "Day of Week", "Crash Time")
)

# Assume feature values are already numeric in feature_select_data
# Calculate risk score for each observation based on the new importance values
feature_select_data$Risk_Score_Ranking <- rowSums(feature_select_data[, c("Roadway Part", "Surface Condition", "Person Helmet", 
                                                                          "Speed Limit", "Active School Zone Flag", 
                                                                          "At Intersection Flag", "Day of Week", "Crash Time")] * importance_ranking$Overall)

# View the resulting data with risk scores based on the new importance values
print(feature_select_data)



#Dummy Testing

library(readxl)
trial_dataset <- read_excel("~/Master's in Analytics/ALY 6040/bike_crash dataset.xlsx")

View(trial_dataset)

# View the variable names in the dataset
names(trial_dataset)
# Remove specified variables from the dataset
trial_dataset <- select(trial_dataset, -c("$1000 Damage to Any One Person's Property", 
                                          "Active School Zone Flag",
                                          "At Intersection Flag",
                                          "Average Daily Traffic Amount",
                                          "Construction Zone Flag",
                                          "Crash Total Injury Count",
                                          "Crash Year",
                                          "Intersection Related",
                                          "Speed Limit",
                                          "Traffic Control Type", "Person Helmet"))

# View the modified dataset
View(trial_dataset)



library(dplyr)

# Mutate to create the Timing variable based on Crash Time
trial_dataset <- trial_dataset %>%
  mutate(Timing = case_when(
    `Crash Time` >= 1 & `Crash Time` <= 554 ~ "Midnight",
    `Crash Time` >= 603 & `Crash Time` <= 1159 ~ "Morning",
    `Crash Time` >= 1200 & `Crash Time` <= 1759 ~ "Afternoon",
    `Crash Time` >= 1800 & `Crash Time` <= 2358 ~ "Evening"
  )) %>%
  # Drop the Crash Time variable
  select(-`Crash Time`)

# View the modified dataset
View(trial_dataset)

library(caret)
library(dplyr)

# Identify categorical variables
categorical_vars <- c("Crash Severity", "Roadway Part", "Surface Condition", "Day of Week", "Timing")

# Convert categorical variables to factor
trial_dataset[categorical_vars] <- lapply(trial_dataset[categorical_vars], factor)

# Create dummy variables
dummy_data <- dummyVars(~ ., data = trial_dataset[categorical_vars])
dummy_dataset <- predict(dummy_data, newdata = trial_dataset[categorical_vars])

# Combine dummy variables with original dataset
trial_dataset <- cbind(trial_dataset, dummy_dataset)

# Ensure results are repeatable
set.seed(7)

# Load the required libraries
library(caret)

# Prepare training scheme
control <- trainControl(method = "repeatedcv", number = 10, repeats = 3)

# Train the model with random forest (or any other method you prefer)
model_trial <- train(`Crash Severity` ~ ., data = trial_dataset, method = "rf", trControl = control)

# Estimate variable importance
importance_trial <- varImp(model_trial, scale = FALSE)

# Summarize importance
print(importance_trial)

# Plot importance
plot(importance_trial)

# Assign variable importance results to the global environment
importance_trial <- varImp(model_trial, scale = FALSE)
install.packages("shiny")


library(shiny)
library(shinythemes)

# Define UI
ui <- fluidPage(
  theme = shinytheme("cerulean"), # Apply a cerulean theme for a cleaner look
  titlePanel("Bike Crash Risk Score Calculator"),
  sidebarLayout(
    sidebarPanel(
      width = 3, # Adjust the sidebar width for better readability
      tags$head(
        tags$style(HTML(".sidebar { background-color: #f0f8ff; }")), 
        tags$style(HTML(".btn-primary { background-color: #6495ED; border-color: #6495ED; }")),
        tags$style(HTML(".btn-primary:hover { background-color: #4169E1; border-color: #4169E1; }")), 
        tags$style(HTML(".btn-primary:active { background-color: #4169E1; border-color: #4169E1; }")) 
      ),
      sliderInput("time_of_day", "Time of Day:", min = 0, max = 23, value = 12),
      selectInput("day_of_week", "Day of Week:", choices = c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")),
      selectInput("road_conditions", "Road Conditions:", choices = c("Dry", "Wet", "Standing Water", "Ice", "Sand, Mud, Dirt")),
      selectInput("location", "Location:", choices = c("Main/Proper Lane", "Entrance/On Ramp", "Service/Frontage Road")),
      actionButton("calculate_button", "Calculate Risk Score", class = "btn-primary") # Apply primary button style
    ),
    mainPanel(
      width = 9, 
      style = "background-color: #f0f8ff;",
      textOutput("risk_score_output")
    )
  )
)

# Define server logic
server <- function(input, output, session) {
  # Define risk scoring algorithm
  calculate_risk_score <- reactive({
    # Define weights for each feature
    weights <- c(Time_of_Day = 1, Day_of_Week = 2, Road_Conditions = 4, Location = 3)
    
    # Assign weights to each input
    time_weight <- input$time_of_day * weights["Time_of_Day"]
    day_weight <- switch(input$day_of_week,
                         "Saturday" = weights["Day_of_Week"],
                         "Sunday" = weights["Day_of_Week"] * 0.9,
                         "Monday" = weights["Day_of_Week"] * 0.8,
                         "Wednesday" = weights["Day_of_Week"] * 0.7,
                         "Tuesday" = weights["Day_of_Week"] * 0.6,
                         "Thursday" = weights["Day_of_Week"] * 0.5,
                         "Friday" = weights["Day_of_Week"] * 0.4,
                         0
    )
    road_condition_weight <- switch(input$road_conditions,
                                    "Dry" = weights["Road_Conditions"],
                                    "Wet" = weights["Road_Conditions"] * 0.9,
                                    "Standing Water" = weights["Road_Conditions"] * 0.8,
                                    "Sand, Mud, Dirt" = weights["Road_Conditions"] * 0.7,
                                    "Ice" = weights["Road_Conditions"] * 0.6,
                                    0
    )
    location_weight <- switch(input$location,
                              "Service/Frontage Road" = weights["Location"],
                              "Main/Proper Lane" = weights["Location"] * 0.9,
                              "Entrance/On Ramp" = weights["Location"] * 0.8,
                              0
    )
    
    # Calculate risk score
    risk_score <- time_weight + day_weight + road_condition_weight + location_weight
    
    return(risk_score)
  })
  
  # Display risk score
  output$risk_score_output <- renderText({
    paste("Risk Score:", calculate_risk_score())
  })
}

# Run the application
shinyApp(ui = ui, server = server)
