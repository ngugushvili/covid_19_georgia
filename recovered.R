# recovery rate 
View(georgia)

recovered <-georgia %>% filter(type == "recovered")
View(recovered)

# filter out empty months 
recovered <-recovered %>% filter(month >= "3")
View(recovered)

rec10 <-georgia %>% filter(type == "recovered", month == "10")
View(rec10)

# rbind all months

recovered_full  <- rbind(recovered, rec10)
View(recovered_full)

# plot it out

recg <-ggplot(data = recovered_full, aes(x = date, y = cases))+ 
        geom_line(linetype = "solid", color = "steelblue", size = 2) + 
        labs(title = "Number of recovered patients in Georgia: March-October, 2020", x = "Date", y = "Recovered") +
        theme(legend.position = "center") + 
        cowplot::theme_cowplot()
        
recg

# animate

