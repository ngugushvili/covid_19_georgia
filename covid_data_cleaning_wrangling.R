### data wrangling 


# load packages and data 
library(dplyr)
library(coronavirus)
library(ggplot2)
library(gganimate)
update_dataset()
glimpse(coronavirus)
georgia <-coronavirus %>% filter(country == "Georgia")
View(georgia)

# drop empty columns 
georgia <-georgia%>% select(date, type, cases)
View(georgia)

# create an integer from date; 

georgia$integerdate <-as.integer(format(georgia$date, "%Y%m%d"))
str(georgia)

# separate them into year, day, month 
georgia$year <- t(sapply(georgia$integerdate, function(x) substring(georgia$integerdate, 1,4)))
View(georgia)


georgia$month <-substring(georgia$integerdate, 5,6)
View(georgia)

georgia$day <-substring(georgia$integerdate, 7, 8)
View(georgia)
str(georgia)

# Now transform year, month, and day cols back into numeric  type 

# month
georgia$month <-as.numeric(georgia$month)
str(georgia)

# day 
georgia$day <-as.numeric(georgia$day)
str(georgia)


# now we are ready to plot and animate!!

ge <-ggplot(data = georgia, aes(x = date, y = cases, group = type, color = type))+
        geom_line(size = 1.3) + 
        labs(title = "Covid-19 in Georgia:Jan-Oct, 2020", xlab = "Cases", ylab = "Date")+
        theme_bw()+
        theme(legend.position = "top")
ge

#add animation
library(gifski)
library(gganimate)
library(ggplot2)
ge + transition_reveal(month)

ge + 
        geom_point() +
        transition_reveal(month)


# filter out since september only  and animate that 
library(dplyr)
sept <-georgia %>% filter(month > "7")# change this. 
View(sept)

oct <-georgia %>% filter(month == "10")
View(oct)

# rbind sept and oct 
autumn <-rbind(sept, oct)
View(autumn)

# create and animate graph for aug, sept, oct 

sepg <-ggplot(data = sept, aes(x = date, y = cases, group = type, color = type))+
        geom_line(size = 1.3) + 
        labs(title = "Covid-19 in Georgia:Aug-Oct, 2020", x = "Cases", y = "Date")+
        theme_bw()+
        theme(legend.position = "top")+
        xlim = c(0, 1500) + 
        ylim = c("2020-08-01", "2020-09-30")

sepg

sepg + transition_reveal(month)

sepg + 
        geom_point() +
        transition_reveal(month)


anim1 <-sepg + transition_states(month, transition_length = 2, state_length = 1)


anim1

#bouncing Y 
anim2 <-sepg + transition_states(month, transition_length = 2, state_length = 1) + 
ease_aes(y = "bounce-out")

anim2


# autumn data which includes october too

octg <-ggplot(data = autumn, aes(x = date, y = cases, group = type, color = type))+
        geom_line(size = 1.6) + 
        geom_point(color = "black", size = 0.7, alpha=0.5) + 
        labs(title = "Covid-19 in Georgia: Aug-Oct, 2020", x = "Date", y = "Cases")+
        theme(legend.position = "center") + 
        cowplot::theme_cowplot()
                

octg

# animation 

anim01 <-octg + transition_states(month, transition_length = 2, state_length = 1)
anim01
#save
anim_save("test2.gif", anim01, width = 800, height = 400)


library(gifski)
anim_save("oct.gif")



# death cases in september and august

deathautumn <-georgia %>% filter(type == "death", month >= "9")
deathautumn1 <-georgia %>% filter(type == "death", month == "10")
View(deathautumn1)
deathautumn <-rbind(deathautumn, deathautumn1)
View(deathautumn)

deathg <-ggplot(deathautumn, aes(x = date, y = cases))+ 
        geom_line(color = "blue", size = 1.5)+ 
        geom_point(color = "yellow", size = 1.1)+ 
        labs(title = "Death cases in September and October", x = "Date", y = "Cases")+
        theme_bw()+
        theme(legend.position = "right")+ 
        ylim(0, 15) + 
        xlim(as.Date("2020-09-01"), as.Date("2020-10-22")) +
        cowplot::theme_cowplot()
        

deathg

# animate
deathanim <- deathg + transition_states(month, transition_length = 2, state_length = 1)
deathanim
#save
anim_save("deathcases.gif", deathanim)

