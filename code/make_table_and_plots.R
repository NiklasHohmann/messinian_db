#### Load data ####
messinian_db <- read.csv(file = "data/messinianDB.csv")

## Merge species names
sp_names = paste(messinian_db$Genus.name, messinian_db$Species.name, sep = " ")
sp_names = replace(sp_names, messinian_db$Species.name == "sp.", NA)
messinian_db$full_sp_name = sp_names

#### Define constants ####
time_bins <- unique(messinian_db$Age)[c(3, 1, 2)] # sorted from old to young
regions <- unique(messinian_db$region.new)
group_names <- unique(messinian_db$group.name)
# sort group names to match order in table in manuscript
group_names <- group_names[c(9, 14, 7, 8, 2, 3, 6, 4, 11, 13, 1, 12, 5, 10)]
# summary numbers extracted
summary_nos <- c("occ_all", "occ_eMed", "occ_wMed", "occ_PoA", "species", "genera", "families", "loc_all", "loc_eMed", "loc_wMed", "loc_PoA")

#### Initialize storage ####
table <- matrix(
  data = NA,
  nrow = length(group_names) + 1,
  ncol = length(summary_nos),
  dimnames = list(
    "group" = c(group_names, "total"),
    "spec" = summary_nos
  )
)

#### Occurrences ####
for (group in group_names) {
  table[group, "occ_all"] <- length(messinian_db$ID[messinian_db$group.name == group])
  table[group, "occ_eMed"] <- length(messinian_db$ID[messinian_db$group.name == group & messinian_db$region.new == "Eastern Mediterranean"])
  table[group, "occ_wMed"] <- length(messinian_db$ID[messinian_db$group.name == group & messinian_db$region.new == "Western Mediterranean"])
  table[group, "occ_PoA"] <- length(messinian_db$ID[messinian_db$group.name == group & messinian_db$region.new == "Po Plain-Northern Adriatic"])
}
table["total", "occ_all"] <- sum(table[group_names, "occ_all"])
table["total", "occ_eMed"] <- sum(table[group_names, "occ_eMed"])
table["total", "occ_wMed"] <- sum(table[group_names, "occ_wMed"])
table["total", "occ_PoA"] <- sum(table[group_names, "occ_PoA"])

#### Localities ####
for (group in group_names) {
  table[group, "loc_all"] <- length(unique(messinian_db$Locality[messinian_db$group.name == group]))
  table[group, "loc_eMed"] <- length(unique(messinian_db$Locality[messinian_db$group.name == group & messinian_db$region.new == "Eastern Mediterranean"]))
  table[group, "loc_wMed"] <- length(unique(messinian_db$Locality[messinian_db$group.name == group & messinian_db$region.new == "Western Mediterranean"]))
  table[group, "loc_PoA"] <- length(unique(messinian_db$Locality[messinian_db$group.name == group & messinian_db$region.new == "Po Plain-Northern Adriatic"]))
}
table["total", "loc_all"] <- length(unique(messinian_db$Locality))
table["total", "loc_eMed"] <- length(unique(messinian_db$Locality[messinian_db$region.new == "Eastern Mediterranean"]))
table["total", "loc_wMed"] <- length(unique(messinian_db$Locality[messinian_db$region.new == "Western Mediterranean"]))
table["total", "loc_PoA"] <- length(unique(messinian_db$Locality[messinian_db$region.new == "Po Plain-Northern Adriatic"]))

#### Raw taxonomic richness ####
for (group in group_names) {
  table[group, "species"] <- length(unique(messinian_db$full_sp_name[messinian_db$group.name == group & !is.na(messinian_db$full_sp_name)] ))
  table[group, "genera"] <- length(unique(messinian_db$Genus.name[messinian_db$group.name == group & (messinian_db$Genus.name != "indet.")]))
  table[group, "families"] <- length(unique(messinian_db$Family[ (messinian_db$group.name == group) & (messinian_db$Family != "indet")]))
}
table["total", "species"] <- sum(table[group_names,"species"])
table["total", "genera"] <- sum(table[group_names,"genera"]) 
table["total", "families"] <- sum(table[group_names,"families"])

#### Show table ####
table

cat("Table successfully generated!\n")

#### make plots ####
library(ggplot2)
cat("Creating plots\n")
## plot occurrences
make_occ_plot = function(file_name){
  df = data.frame(group = rep(group_names, each = 3),
                  regions = rep(regions, length(group_names)),
                  nocc = rep(NA, length(regions) * length(group_names)))
  for (i in seq_len(nrow(df))){
    df[i, "nocc"] = length(unique(messinian_db$ID[messinian_db$group.name == df$group[i] & messinian_db$region.new == df$regions[i]]))
  }
  ggplot(df, aes(x = group, fill = regions, y = nocc)) +
    geom_bar(stat = "identity", position = "dodge") +
    theme_classic()
  ggsave(file_name)
}
make_occ_plot("figs/occ.pdf")

make_loc_plot = function(file_name){
  df = data.frame(group = rep(group_names, each = 3),
                  regions = rep(regions, length(group_names)),
                  nloc = rep(NA, length(regions) * length(group_names)))
  for (i in seq_len(nrow(df))){
    df[i, "nloc"] = length(unique(messinian_db$Locality[messinian_db$group.name == df$group[i] & messinian_db$region.new == df$regions[i]]))
  }
  
  ggplot(df, aes(x = group, y = nloc, fill = regions)) +
    geom_bar(position = position_dodge(), stat = "identity") +
    theme_classic()
  ggsave(file_name)
}
make_loc_plot("figs/locs.pdf")



cat("Plots are in figs/ \n")
