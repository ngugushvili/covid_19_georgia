#covid-19

library(dplyr)
library(coronavirus)
update_dataset()
glimpse(coronavirus)
library(ggplot2)
# subset georgia cases 
georgia <-coronavirus %>% filter(country == "Georgia")
View(georgia)
names(georgia)

# drop empty columns 
georgia <-georgia%>% select(date, type, cases)
View(georgia)

# group and summarize by type

georgia %>% group_by(type)%>% summarize(max_cases = max(cases))

# plot it out 

ggplot(data = georgia, aes(x = date, y = cases, group = type, color = type))+
        geom_line(size = 2)

# use different aesthetics

g <-ggplot(data = georgia, aes(x = date, y = cases, group = type, color = type))+
        geom_line((aes(group=date), linetype=1)) + 
labs(title = "Covid-19 in Georgia:Jan-Oct, 2020", xlab = "Cases", ylab = "Date")

g +  theme_bw()

# try to animate it 
install.packages("gganimate")
library(gganimate)
library(transformr)


# animating 
anim <-g +
transition_time(date)
        

anim
# filter confirmed cases only

confirmed <-georgia %>% filter(type == "confirmed")


#plot out with linear and logarithmic trend lines 
a <- ggplot(data = georgia, aes(x = date, y = cases)) +
        geom_line(color = "blue", size = 1) +
        geom_smooth(method = "lm", se = FALSE, color = "red", size = 2) + 
        ylab("Cumulative confirmed cases in Georgia")
a   
        

# filter out cases such that it does not contain zeros
filtered_conf <-confirmed %>% filter(cases > 0 )
View(filtered_conf)

# logarithmic trend line 

x <-a +
scale_y_log10()
x


# working on death 
death <-georgia %>% filter(type == "death")
View(death)

d <-ggplot(data = death, aes(x = date, y = cases)) +
        geom_line() +
        geom_smooth(method = "lm", se = FALSE, color = "blue") + 
        ylab("Cumulative death cases in Georgia")
d

dd <-ggplot(data = death, aes(x = date, y = cases)) +
        geom_line(color = "blue", size = 1) +
        ylab("Cumulative death cases in Georgia")

dd
