
#"The coordinates of the fossiliferous localities used in this study were obtained from the original publications, whenever possible. When the exact coordinates for a locality had not been published or when the locality was too vague (e.g. Libya), we included approximate coordinates based on the description of the locality in the original publication."

# Maps of localities - Agiadi et al. MSC

# 21.02.2024
# Author: K. Agiadi

library(tidyverse)
library(ggmap)
library(ggthemes)
library(ggplot2)


# To get the Mediterranean map from Stadia Maps, it is necessary to have an API key, which you can get for free by registering at https://client.stadiamaps.com/
# Then, register the key by
# register_stadiamaps("PUT YOUR API KEY HERE", write=TRUE)
# To setup the bbox margins, go to OpenStreetMap, find the view you want and click export

bbox=c(left=-7.4,bottom=28.5,right=40,top=47.1)
Med_map<-get_stadiamap(bbox,maptype="stamen_toner_lite",zoom=5)  
ggmap(Med_map)

# Read locality data
coord<-read.csv("coord.csv")
class(coord)

# Whole dataset map
qmplot(lon,lat,data=coord,maptype="stamen_toner_lite",color=I("red"))
ggsave("dataset_map.pdf",width=9,height=5) 

# Color by stage
Tortonian<-filter(coord,Age=="Tortonian")
Messinian<-filter(coord,Age=="pre-evaporitic Messinian")
Zanclean<-filter(coord,Age=="Zanclean")
ggmap(Med_map)+geom_point(data=Tortonian,color="blue")+geom_point(data=Messinian,color="red")+geom_point(data=Zanclean,color="yellow")
ggsave("locs_by_stage_map.pdf",width=9,height=5)

# Color by region
wMed<-filter(coord,region=="Western Mediterranean")
eMed<-filter(coord,region=="Eastern Mediterranean")
PoA<-filter(coord,region=="Po Plain-Northern Adriatic")
ggmap(Med_map)+geom_point(data=wMed,color="green4")+geom_point(data=eMed,color="pink4")+geom_point(data=PoA,color="orange3")
ggsave("locs_by_region_map.pdf",width=9,height=5)
