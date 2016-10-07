setwd("/tmp/")
unzip("bikeshareusersurvey.zip")
library(rio)
d = import("Excel/Sheet_1.xls")
names_second_level = d[1,]
names(d)
sel_na_names = is.na(names(d))
names(d)[sel_na_names] = names_second_level[sel_na_names]
d = d[-1,]

# put scheme into single column
scheme_variables = 10:28
d$scheme = do.call(pmax, c(d[scheme_variables], list(na.rm=TRUE)))
d = d[-scheme_variables]

# subset schemes
schemes_of_interest = c("Nextbike Glasgow", "CityBike Liverpool", "ReadyBike Reading ")
d = d[d$scheme %in% schemes_of_interest,] # only rows in those schemes

# find age variable
names(d)[grep(pattern = "age", x = names(d))]
names(d)[grep(pattern = "eth", x = names(d))]
library(dplyr)
people = select(d,
                age_band = `Which of the following age brackets do you fall into?`,
                sex = `Are you..?`,
                ethnicity = `Please specify your ethnicity`,
                postcode = `What is your home postcode?`
                )

people = filter(people, sex == "Male" | "Female")

library(ggplot2)


ggplot(data = people) +
  geom_bar(aes(x = age_band, fill = sex), position = "dodge")

barplot(x = people$age_band)

cycling = select

names_top_level[is.na(names_top_level)] =
