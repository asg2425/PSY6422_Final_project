## install packages for data preparation ##

install.packages("readxl")
install.packages("writexl")
install.packages("reshape2")
install.packages("dplyr")

#load the package & set directory
library(readxl)
library(here)

#import data from excel
country_tc_loss_wide <- read_excel("IDN.xlsx", sheet = "Country tree cover loss")
View(country_tc_loss_wide)

subnational_tc_loss_wide <- read_excel("IDN.xlsx", sheet = "Subnational 1 tree cover loss")
View(subnational_tc_loss_wide)

country_carbon_data_wide <- read_excel("IDN.xlsx", sheet = "Country carbon data")
View(country_carbon_data_wide)

subnational_carbon_data_wide <- read_excel("IDN.xlsx", sheet = "Subnational 1 carbon data")
View(subnational_carbon_data_wide)

#to check the data
summary(country_tc_loss_wide)
str(country_tc_loss_wide)

#because this is a wide format data, I will convert it to long data format
install.packages("reshape2")
library(reshape2)

#this code did not work, it was very messy and was hard to edit anything here
long_ddata <- melt(country_tree_cover_loss, id.vars = c('country', 'threshold', 'area_ha', 'extent_2000_ha', 'extent_2010_ha', 'gain_2000-2020_ha') 
                   measure.vars=c('tc_loss_ha_2001','tc_loss_ha_2002', 'tc_loss_ha_2003', 'tc_loss_ha_2004', 'tc_loss_ha_2005', 'tc_loss_ha_2006',
                                  'tc_loss_ha_2007', 'tc_loss_ha_2008', 'tc_loss_ha_2009', 'tc_loss_ha_2010', 'tc_loss_ha_2011', 'tc_loss_ha_2012',
                                  'tc_loss_ha_2013', 'tc_loss_ha_2014', 'tc_loss_ha_2015', 'tc_loss_ha_2016', 'tc_loss_ha_2017', 'tc_loss_ha_2018', 
                                  'tc_loss_ha_2019', 'tc_loss_ha_2020', 'tc_loss_ha_2021', 'tc_loss_ha_2022', 'tc_loss_ha_2023' ), 
                   variable.name = "tree cover loss")

#Asked Google Gemimi what's wrong with my code, ended up getting corrected code from it
long_data <- melt(country_tree_cover_loss, 
                   id.vars = c('country', 'threshold', 'area_ha', 
                               'extent_2000_ha', 'extent_2010_ha', 
                               'gain_2000-2020_ha'),
                   measure.vars = c('tc_loss_ha_2001', 'tc_loss_ha_2002', 
                                    'tc_loss_ha_2003', 'tc_loss_ha_2004', 
                                    'tc_loss_ha_2005', 'tc_loss_ha_2006',
                                    'tc_loss_ha_2007', 'tc_loss_ha_2008', 
                                    'tc_loss_ha_2009', 'tc_loss_ha_2010', 
                                    'tc_loss_ha_2011', 'tc_loss_ha_2012',
                                    'tc_loss_ha_2013', 'tc_loss_ha_2014', 
                                    'tc_loss_ha_2015', 'tc_loss_ha_2016', 
                                    'tc_loss_ha_2017', 'tc_loss_ha_2018',
                                    'tc_loss_ha_2019', 'tc_loss_ha_2020', 
                                    'tc_loss_ha_2021', 'tc_loss_ha_2022', 
                                    'tc_loss_ha_2023'),
                   variable.name = "tree cover loss")

#tried correcting the code by making it more neat, then it worked!
country_tc_loss_long <- melt(country_tc_loss_wide, 
                             id.vars = c('country', 'threshold', 'area_ha', 
                                         'extent_2000_ha', 'extent_2010_ha', 
                                         'gain_2000-2020_ha'), 
                             measure.vars=c('tc_loss_ha_2001','tc_loss_ha_2002', 
                                            'tc_loss_ha_2003', 'tc_loss_ha_2004', 
                                            'tc_loss_ha_2005', 'tc_loss_ha_2006',
                                            'tc_loss_ha_2007', 'tc_loss_ha_2008', 
                                            'tc_loss_ha_2009', 'tc_loss_ha_2010', 
                                            'tc_loss_ha_2011', 'tc_loss_ha_2012',
                                            'tc_loss_ha_2013', 'tc_loss_ha_2014', 
                                            'tc_loss_ha_2015', 'tc_loss_ha_2016', 
                                            'tc_loss_ha_2017', 'tc_loss_ha_2018', 
                                            'tc_loss_ha_2019', 'tc_loss_ha_2020', 
                                            'tc_loss_ha_2021', 'tc_loss_ha_2022', 
                                            'tc_loss_ha_2023'),
                             variable.name = 'year_tc_loss',
                             value.name = 'tc_loss')

#I use levels() function to change the column "year" into just numbers.
levels(country_tc_loss_long$year_tc_loss)
levels(country_tc_loss_long$year_tc_loss) <- c("2001", "2002", "2003", "2004", 
                                               "2005", "2006", "2007", "2008", 
                                               "2009", "2010", "2011", "2012", 
                                               "2013", "2014", "2015", "2016", 
                                               "2017", "2018", "2019", "2020", 
                                               "2021", "2022", "2023")
levels(country_tc_loss_long$year_tc_loss) #to check the new modified years

#now to transform other data!
subnational_tc_loss_long <- melt(subnational_tc_loss_wide, 
                             id.vars = c('country', 'subnational1', 'threshold',
                                          'area_ha','extent_2000_ha', 'extent_2010_ha', 
                                          'gain_2000-2020_ha'), 
                             measure.vars=c('tc_loss_ha_2001','tc_loss_ha_2002', 
                                            'tc_loss_ha_2003', 'tc_loss_ha_2004', 
                                            'tc_loss_ha_2005', 'tc_loss_ha_2006',
                                            'tc_loss_ha_2007', 'tc_loss_ha_2008', 
                                            'tc_loss_ha_2009', 'tc_loss_ha_2010', 
                                            'tc_loss_ha_2011', 'tc_loss_ha_2012',
                                            'tc_loss_ha_2013', 'tc_loss_ha_2014', 
                                            'tc_loss_ha_2015', 'tc_loss_ha_2016', 
                                            'tc_loss_ha_2017', 'tc_loss_ha_2018', 
                                            'tc_loss_ha_2019', 'tc_loss_ha_2020', 
                                            'tc_loss_ha_2021', 'tc_loss_ha_2022', 
                                            'tc_loss_ha_2023'),
                             variable.name = 'year_tc_loss',
                             value.name = 'tc_loss')

levels(subnational_tc_loss_long$year_tc_loss)
levels(subnational_tc_loss_long$year_tc_loss) <- c("2001", "2002", "2003", "2004", 
                                                   "2005", "2006", "2007", "2008", 
                                                   "2009", "2010", "2011", "2012", 
                                                   "2013", "2014", "2015", "2016", 
                                                   "2017", "2018", "2019", "2020", 
                                                   "2021", "2022", "2023")

levels(subnational_tc_loss_long$year_tc_loss) #to check the new modified years

#GFW use 30% canopy cover threshold as a default for analysis, so I will
#filter the data to include just the 30% threshold for subnational data
library(dplyr)
filtered_subnational_tc_loss <- subnational_tc_loss_long%>%filter(threshold == 30)
View(filtered_subnational_tc_loss)

---

## install packages for data visualisation (plot) ##
  
install.packages("ggplot2")
install.packages("RColorBrewer")
  
#plotting the country data first using ggplot
library(ggplot2)

#load RColorBrewer to allow color customisation
library(RColorBrewer)
display.brewer.all()
brewer.pal.info

country_tcloss_plot <- ggplot(data = country_tc_loss_long, mapping = 
                                aes(x = year_tc_loss, y = tc_loss, 
                                    color = threshold)) 
                              

country_tcloss_plot + geom_point() + labs(x = "Year", y = "Tree Cover Loss",
                                          title = "Tree Cover Loss in Indonesia (2001-2023)",
                                          subtitle = "Data points are based on canopy cover thresholds",
                                          caption = "Source: Global Forest Watch.")

scale_fill_brewer(palette = "Set2") 
# when adding this line of code, it did not work because this is designed for discrete color scales
# which are used for categorical variables

# Extract the desired colors from the YlGn palette
ylgn_colors <- brewer.pal(9, "YlGn")
low_color <- ylgn_colors[1]
high_color <- ylgn_colors[9]

#input to the ggplot
country_tcloss_plot + geom_point() + labs(x = "Year", y = "Tree Cover Loss",
                                          title = "Tree Cover Loss in Indonesia (2001-2023)",
                                          subtitle = "Data points are based on Canopy Cover Thresholds",
                                          caption = "Source: Global Forest Watch.") + scale_fill_gradient(
                                            low = low_color, high = high_color)
#there's two threshold?? okay let's try again :')

country_tcloss_plot + geom_point() + labs(x = "Year", y = "Tree Cover Loss",
                                          title = "Tree Cover Loss in Indonesia (2001-2023)",
                                          subtitle = "Data points are based on Canopy Cover Thresholds",
                                          caption = "Source: Global Forest Watch.") + scale_color_gradientn(colors = brewer.pal(9, "YlGn"))

# i remove "fill=" in country_tcloss_plot and it worked
# i want to exclude th first two colors in the YlGn sequential color in RColorBrewer

selected_green <- ylgn_colors[4:9]
country_tcloss_plot + geom_point() + labs(x = "Year", y = "Tree Cover Loss",
                                          title = "Tree Cover Loss in Indonesia (2001-2023)",
                                          subtitle = "Data points are based on canopy cover thresholds",
                                          caption = "Source: Global Forest Watch.") + scale_color_gradientn(colors = selected_green)
# AND IT WORKS!!! such beautiful green color
# now on to removing the gray background color of the plot

country_tcloss_plot + geom_point() + labs(x = "Year", y = "Tree Cover Loss",
                                          title = "Tree Cover Loss in Indonesia (2001-2023)",
                                          subtitle = "Data points are based on canopy cover thresholds",
                                          caption = "Source: Global Forest Watch.") + 
  scale_color_gradientn(colors = selected_green) + theme_minimal() 

# got the theme_minimal() function from previous years code hehe, tried other but i like this the most
# now to change the threshold labels to be 0, 25, 50, 75

ggplot(data = country_tc_loss_long, mapping = aes(x = year_tc_loss, y = tc_loss, color = threshold)) + geom_point() + labs(x = "Year", y = "Tree Cover Loss",
                                          title = "Tree Cover Loss in Indonesia (2001-2023)",
                                          subtitle = "Data points are based on canopy cover thresholds",
                                          caption = "Source: Global Forest Watch.") + theme_minimal() + 
  scale_color_continuous(breaks = c(0, 25, 50, 75), labels = c("0%", "25%", "50%", "75%"), 
                         colors = selected_green)
#the code above did not worked, consulted with Google Gemini and it said that 
# Ensure compatibility: The number of colors in selected_green should match 
# the number of breaks specified in scale_color_continuous().
# let's try modifying the selected_green to include 4 colors only to fit 0, 25, 50, 75 labels
# or maybe add more breaks! let's try both

selected_green1 <- ylgn_colors[6:9]
selected_green2 <- c("#41AB5D", "#238443", "#1E642C", "#124638", "#002B36")

country_tcloss_plot + geom_point() + 
  labs(x = "Year", y = "Tree Cover Loss",title = "Tree Cover Loss in Indonesia (2001-2023)", 
       subtitle = "Data points are based on canopy cover thresholds",
       caption = "Source: Global Forest Watch.") + theme_minimal()
#struggling a lot... let's go back from the beginning

ggplot(data = country_tc_loss_long, 
       mapping = aes(x = year_tc_loss, y = tc_loss, color = threshold)) +
  geom_point() +
  labs(x = "Year", y = "Tree Cover Loss",
       title = "Tree Cover Loss in Indonesia (2001-2023)",
       subtitle = "Data points are based on canopy cover thresholds",
       caption = "Source: Global Forest Watch.") +
  theme_minimal() +
  scale_color_continuous(name = "Canopy cover threshold (%)", low = selected_green[1], high = selected_green[length(selected_green)], 
                         breaks = c(0, 25, 50, 75), 
                         labels = c("0%", "25%", "50%", "75%"))

#chatGPT solved the issue...even on how to rename the threshold label
#Need to customise font and tree cover loss values (add separator), but let's save this first success

ggsave(filename = "figures/country_tc_loss_figure.png")
ggsave(filename = "figures/country_tc_loss_figure.jpg")

# let's start again after a short break! let's add 1000 separator comma for the y-axis numbers
# don't forget to change the font, Roboto seems good 

ggplot(data = country_tc_loss_long, 
       mapping = aes(x = year_tc_loss, y = tc_loss, color = threshold)) +
  geom_point() +
  labs(x = "Year", y = "Tree Cover Loss",
       title = "Tree Cover Loss in Indonesia (2001-2023)",
       subtitle = "Data points are based on canopy cover thresholds",
       caption = "Source: Global Forest Watch.") +
  theme_minimal() +
  scale_color_continuous(name = "Canopy cover threshold (%)", low = selected_green[1], high = selected_green[length(selected_green)], 
                         breaks = c(0, 25, 50, 75), 
                         labels = c("0%", "25%", "50%", "75%")) + 
  scale_y_continuous(labels = scales::comma) 

install.packages("showtext")
library(showtext)
font_add_google("Roboto", "Roboto")
showtext_auto()

ggplot(data = country_tc_loss_long, 
       mapping = aes(x = year_tc_loss, y = tc_loss, color = threshold)) +
  geom_point() +
  labs(x = "Year", y = "Tree Cover Loss",
       title = "Tree Cover Loss in Indonesia (2001-2023)",
       subtitle = "Data points are based on canopy cover thresholds",
       caption = "Source: Global Forest Watch.") +
  theme_minimal() +
  scale_color_continuous(name = "Canopy cover threshold (%)", low = selected_green[1], 
                         high = selected_green[length(selected_green)], 
                         breaks = c(0, 25, 50, 75), 
                         labels = c("0%", "25%", "50%", "75%")) + 
  scale_y_continuous(labels = scales::comma) + 
  (theme(plot.title = element_text(family = "Futura", size = 16, face = "bold"),
         plot.subtitle = element_text(family = "Futura", size = 12),
         axis.title = element_text(family = "Futura", size = 12),
         axis.text = element_text(family = "Futura", size = 10), 
         plot.caption = element_text(family = "Futura", size = 10),
         legend.title = element_text(family = "Futura", size = 10),
         legend.text = element_text(family = "Futura", size = 9))) 

ggsave(filename = "figures/country_tc_loss_figure1.png")
ggsave(filename = "figures/country_tc_loss_figure1.jpg")
 ---

# advice from Hazel: specify which point you want to connect if you want to connect
# the scatterplot with each point (as there are multiple points based on threshold)

---

subnational_tcloss_plot <- ggplot(data = filtered_subnational_tc_loss, mapping =
                                    aes(x = year_tc_loss, y = tc_loss, group = 
                                          subnational1, color = subnational1))
subnational_tcloss_plot + geom_line() + geom_point() +
  labs(x = "Year", y = "Tree Cover Loss",
       title = "Tree Cover Loss Indonesia by Province (2001-2023)",
       subtitle = "Data points are based on canopy cover threshold of 30%",
       caption = "Source: Global Forest Watch.", color = NULL) +
  theme_minimal() + scale_y_continuous(labels = scales::comma) +
  (theme(plot.title = element_text(family = "Futura", size = 16, face = "bold"),
         plot.subtitle = element_text(family = "Futura", size = 12),
         axis.title = element_text(family = "Futura", size = 12),
         axis.text = element_text(family = "Futura", size = 8), 
         plot.caption = element_text(family = "Futura", size = 10),
         legend.title = element_text(family = "Futura", size = 10),
         legend.text = element_text(family = "Futura", size = 8))) 

ggsave(filename = "figures/subnational_tc_loss_figure1.jpg")

#Plan A
#the filtered subnational data is too large and visually unclear, so I am going to 
#form groups based on the 7 islands - Sumatra, Java, Sulawesi, Kalimantan, 
#Nusa Tenggara, Maluku, and Papua

# From Google Gemini
# filtered_df <- df %>%filter(city %in% c("London", "Paris")) -> error not sure why
# filtered_df <- df %>%filter(str_detect(city, "London|Paris")) -> did not work as well:(
# filtered_df <- subset(df, city %in% c("London", "Paris")) -> THIS WORKS!!!

#Java 
java_tcloss <- subset(filtered_subnational_tc_loss, subnational1 %in% 
                        c("Banten","Jakarta Raya", "Jawa Barat", "Jawa Tengah",
                          "Jawa Timur", "Yogyakarta"))
java_tcloss_plot <- ggplot(data = java_tcloss, mapping =
                             aes(x = year_tc_loss, y = tc_loss, group = 
                                   subnational1, color = subnational1)) + 
  geom_line() + geom_point() +
  labs(x = "Year", y = "Tree Cover Loss",
       title = "Tree Cover Loss in Java, Indonesia (2001-2023)",
       subtitle = "Data points are based on canopy cover threshold of 30%",
       caption = "Source: Global Forest Watch.", color = NULL) +
  theme_minimal() + scale_y_continuous(labels = scales::comma) +
  (theme(plot.title = element_text(family = "Futura", size = 16, face = "bold"),
         plot.subtitle = element_text(family = "Futura", size = 12),
         axis.title = element_text(family = "Futura", size = 12),
         axis.text = element_text(family = "Futura", size = 10), 
         plot.caption = element_text(family = "Futura", size = 10),
         legend.title = element_text(family = "Futura", size = 10),
         legend.text = element_text(family = "Futura", size = 9))) 

java_tcloss_plot

ggsave(filename = "figures/java_tc_loss_figure1.jpg")

# animate it to plot year by year (done!)

install.packages("gganimate")
install.packages("gifski")
library(gganimate)
library(gifski)

animate_java <- java_tcloss_plot + geom_point() + 
  transition_manual(year_tc_loss, cumulative=TRUE)

anim <- animate(animate_java, nframes = 50, fps = 10)
anim

dir.create("gif")
anim_save("gif/java_tcloss.gif", animation = anim)

# do animation for other regions

#Kalimantan
kalimantan_tcloss <- subset(filtered_subnational_tc_loss, subnational1 %in%
                              c("Kalimantan Barat", "Kalimantan Selatan", 
                                "Kalimantan Tengah", "Kalimantan Timur"))
kalimantan_tcloss_plot <- ggplot(data = kalimantan_tcloss, mapping =
                             aes(x = year_tc_loss, y = tc_loss, group = 
                                   subnational1, color = subnational1)) 
kalimantan_tcloss_plot + geom_line() + geom_point()

ggsave(filename = "figures/kalimantan_tc_loss_figure.jpg")

#Sumatra
sumatra_tcloss <- subset(filtered_subnational_tc_loss, subnational1 %in%
                           c("Sumatera Barat", "Sumatera Utara", "Sumatera Selatan",
                             "Bangka Belitung", "Lampung", "Riau", "Kepulauan Riau",
                             "Aceh", "Bengkulu", "Jambi"))
sumatra_tcloss_plot <- ggplot(data = sumatra_tcloss, mapping =
                                   aes(x = year_tc_loss, y = tc_loss, group = 
                                         subnational1, color = subnational1)) 
sumatra_tcloss_plot + geom_line() + geom_point()

ggsave(filename = "figures/sumatra_tc_loss_figure.jpg")

#Sulawesi
sulawesi_tcloss <- subset(filtered_subnational_tc_loss, subnational1 %in% 
                            c("Gorontalo", "Sulawesi Barat", "Sulawesi Selatan",
                              "Sulawesi Tengah", "Sulawesi Tenggara", "Sulawesi Utara"))
sulawesi_tcloss_plot <- ggplot(data = sulawesi_tcloss, mapping =
                                aes(x = year_tc_loss, y = tc_loss, group = 
                                      subnational1, color = subnational1)) 
sulawesi_tcloss_plot + geom_line() + geom_point()

ggsave(filename = "figures/sulawesi_tc_loss_figure.jpg")

#Nusa Tenggara
nusatenggara_tcloss <- subset(filtered_subnational_tc_loss, subnational1 %in%
                                c("Bali", "Nusa Tenggara Barat", "Nusa Tenggara Timur"))
nusatenggara_tcloss_plot <- ggplot(data = nusatenggara_tcloss, mapping =
                                 aes(x = year_tc_loss, y = tc_loss, group = 
                                       subnational1, color = subnational1)) 
nusatenggara_tcloss_plot + geom_line() + geom_point()

ggsave(filename = "figures/nusatenggara_tc_loss_figure.jpg")

#Maluku
maluku_tcloss <- subset(filtered_subnational_tc_loss, subnational1 %in% 
                          c("Maluku", "Maluku Utara"))
maluku_tcloss_plot <- ggplot(data = maluku_tcloss, mapping =
                                     aes(x = year_tc_loss, y = tc_loss, group = 
                                           subnational1, color = subnational1)) 
maluku_tcloss_plot + geom_line() + geom_point()

ggsave(filename = "figures/maluku_tc_loss_figure.jpg")

#Papua
papua_tcloss <- subset(filtered_subnational_tc_loss, subnational1 %in%
                         c("Papua", "Papua Barat"))
papua_tcloss_plot <- ggplot(data = papua_tcloss, mapping =
                               aes(x = year_tc_loss, y = tc_loss, group = 
                                     subnational1, color = subnational1)) 
papua_tcloss_plot + geom_line() + geom_point()

ggsave(filename = "figures/papua_tc_loss_figure.jpg")


# Ambitious plan
# Make it interactive when you hover the line

install.packages("plotly")
library(plotly)

subnational_tcloss_plot <- ggplot(data = filtered_subnational_tc_loss, mapping =
         aes(x = year_tc_loss, y = tc_loss, group = 
               subnational1, color = subnational1, text = paste0("Year: ", year_tc_loss, 
              "<br>Tree Cover Loss: ", tc_loss, 
              "<br>Region: ", subnational1)))  
 

p <- subnational_tcloss_plot + geom_line() + geom_point() +
  labs(x = "Year", y = "Tree Cover Loss",
       title = "Tree Cover Loss Indonesia by Province (2001-2023)",
       subtitle = "Data points are based on canopy cover threshold of 30%",
       caption = "Source: Global Forest Watch.", color = NULL) +
  theme_minimal() + scale_y_continuous(labels = scales::comma) +
  (theme(plot.title = element_text(family = "Futura", size = 16, face = "bold"),
         plot.subtitle = element_text(family = "Futura", size = 12),
         axis.title = element_text(family = "Futura", size = 12),
         axis.text = element_text(family = "Futura", size = 8), 
         plot.caption = element_text(family = "Futura", size = 10),
         legend.title = element_text(family = "Futura", size = 10),
         legend.text = element_text(family = "Futura", size = 8)))

interactive_plot <- ggplotly(p, tooltip = "text")  # Add tooltips
interactive_plot

#to save
library(htmlwidgets)
saveWidget(interactive_plot, "subnational_tcloss_plot.html")

# yeay a BIG SUCCESS!!! try another ambitious plan -> create map of the the 
# number of tree cover loss in 2023. I 'll use the code from the previous year
# project as guidance

covidhappiness_map <- plot_geo(df_map, locationmode = 'country names', frame = ~Year) %>% 
  add_trace(
    locations = ~Country, 
    z = ~Happiness, 
    color = ~Happiness, 
    colors = "PuRd",
    text = ~paste("Country:", Country, 
                  "<br>Happiness score:", Happiness),
    hoverinfo = "text"
  ) %>% 
  layout(font = f, 
         title = list(text='Happiness across the world from 2017 to 2022<br><sup>The impact of COVID-19 pandemic on world happiness<br><sup>Source: World Happiness Reports 2018 - 2023', 
                      x = 0.5, y = 0.9, xanchor = 'center', yanchor = 'top', font=f1),
         margin = list(l = 50, r = 50, b = 100, t = 100, pad = 4)
  ) %>%   
  colorbar(title = "Happiness Score", limits = c(1,8)) 

treeloss_map <- plot_geo(filtered_subnational_tc_loss, 
                         locationmode = 'subnational1', 
                         frame = 'year_tc_loss') %>% add_trace(locations = ~subnational1,
                                                               locationmode = "country names",
                                                               z = ~tc_loss, 
                                                               colors = "brown") %>% layout(title = "Tree cover loss in Indonesia",
                                                                                            geo = list (showframe = FALSE,
                                                                                            projection = list(type = "natural earth")))
treeloss_map

# unsuccessfull, let's try again later

treeloss_map <- plot_geo(filtered_subnational_tc_loss) %>%
  add_trace(
    locations = ~subnational1,         # Column specifying subnational regions
    locationmode = 'country names',    # Type of location matching
    frame = ~year_tc_loss,             # Animation frames by year
    z = ~tc_loss,                      # Values to color the map
    colors = 'brown'                   # Color scale
  ) %>%
  layout(
    title = "Tree Cover Loss in Indonesia",
    geo = list(
      showframe = FALSE,               # Remove map frame
      projection = list(type = "natural earth"))) # Set map projection
sf
rnaturalearth
indonesia_map <- ne_states(country = "Indonesia", returnclass = "sf")
geom_sf

ggplot(data = indonesia_map) + geom_sf(aes(fill = tree_loss)) + scale