# aug-sept-oct, all cases


octg <-ggplot(data = autumn, aes(x = date, y = cases, group = type, color = type))+
        geom_line(size = 3.5) + 
        geom_point(color = "black", size = 0.9, alpha=0.5) + 
        labs(title = "Covid-19 in Georgia: Aug-Oct, 2020", x = "Date", y = "Cases")+
        theme(legend.position = "center") + 
        cowplot::theme_cowplot()


octg

# create a gif called all_cases.gif

# animation 

library(ggplot2)

anim02 <-octg + transition_states(month, transition_length = 2, state_length = 1)
anim02
#save
anim_save("all_cases.gif", anim01, width = 580, height = 400)


### OR, change plot design , though not better then previous one 

octg2 <-ggplot(data = autumn, aes(x = date, y = cases, group = type, color = type, )) +
        geom_line(linetype = "longdash", size = 1.8) +
        geom_point(size = 0.9) + 
        labs(title = "Covid-19 in Georgia: Aug-Oct, 2020", x = "Date", y = "Cases")+
        cowplot::theme_cowplot()
        
octg2
