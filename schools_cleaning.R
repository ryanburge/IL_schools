
schools <- read.csv("D:/schools.csv", stringsAsFactors = FALSE)
schools$days <- as.numeric(schools$Days)
schools$days[is.na(schools$days)] <- 365
summary(schools$days)
dim(schools)
sub <- subset(schools, days < 365)
df1 <- as.data.frame(table(sub$County))
df2 <- as.data.frame(table(schools$County))
merge <- merge(df1,df2,by=c("Var1"))
merge$percent <- merge$Freq.x/merge$Freq.y
merge = merge[-1,]
fips <- read.csv("D:/primary_results.csv", stringsAsFactors = FALSE)
fips <- subset(fips, candidate == "Donald Trump")
ferge <- merge(merge,fips,by=c("county"))
map <- select(ferge, county, Freq.x, Freq.Y, percent, fips)
map$region <- map$fips
map$value <- map$percent
choro = CountyChoropleth$new(map)
choro$title = "Schools in Trouble by County"
choro$set_num_colors(1)
choro$set_zoom("illinois")
choro$ggplot_polygon = geom_polygon(aes(fill = value), color = NA)
choro$ggplot_scale = scale_fill_gradientn(name = "Percent", colours = brewer.pal(8, "Reds"))
choro$render()
