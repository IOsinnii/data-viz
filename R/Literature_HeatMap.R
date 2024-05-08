library(pheatmap)
library(tidyverse)
library(readxl)
library(RColorBrewer)
setwd("~/Desktop")
getwd()
?read.table
annotation_table= read.table("./input/Literature_HeatMap_Data_anno.txt")
Taxa<-read_xlsx("./input/Literature_HeatMap_Data_Ivan.xlsx", sheet = 1, col_names = TRUE)
Taxa<-read.table("./input/Literature_HeatMap_Data_reduced.txt")
Taxa<-read.table("HumanIBDStudies.txt")
read_
ann_colors = list(
  Gender = c(Less="#3399FF", More="#cc6666", Unknown="#f4fcfc"),
  Sample_Type = c(Biopsy="#efe9d0", Stool="#ccbb74", Stool_Biopsy="#bc5607"),
  Sample_Size = c(LessThanFifty="#cff7d5",Between50_100="#a5f7b0", Between101_200="#78e887", MoreThan200="#47a354"),
  Median_Age = c(BetweenTenTwenty="#e1e8f4",BetweenThirtyFourty="#c1d3f2", BetweenThirtyFifty="#94b6ef", BetweenFiftySeventy="#6d98e0", Unknown="#f4fcfc"),
  RaceEthnicity = c(MostlyCaucasian="#aaf2ff", Indian="brown", Japanese="#e5f98b", Han= "#efb94c", Korean = "#cc6666", Unknown="#f4fcfc"),
  Method = c(RT_PCR="#e9e3ef", R454="#c3a9e5",  MiSeq="#a276db", HiSeq="#7b45c1", Other="#f4fcfc"))

ann_colors = list(
  Gender = c(Less="#3399FF", More="#cc6666", Unknown="#f4fcfc"),
  Sample_Type = c(Biopsy="#efe9d0", Stool="#ccbb74", Stool_Biopsy="#bc5607"),
  Sample_Size = c(Human="#efe9d0",Dog="#ccbb74", Cat="#ce8852", Mice="#bc5607"),
  Median_Age = c(Young="#97edd0", Adult="#378e71", Old="#215e4a", Unknown="#f4fcfc"),
  RaceEthnicity = c(MostlyCaucasian="#aaf2ff", Indian="brown", Japanese="#e5f98b", Han= "#efb94c", Korean = "#cc6666", Unknown="#f4fcfc"),
  Species=c(Human="#efe9d0",Dog="#ccbb74", Cat="#ce8852", Mice="#bc5607"),
  Type=c(Natural="#aaf2ff", Chemical="#cc6666", Genetic="#e5f98b", Chemical_Genetic ="#efb94c", Other="#f4fcfc"),
  Method = c(FISH="#d0eaef", R454="#aaf2ff", RT_PCR="#3399FF", MiSeq="#efb94c", HiSeq="#cc6666", Other="#f4fcfc"))

pheatmap(Taxa,
         fontsize_row = 8, fontsize_col = 5, cluster_cols = TRUE, cluster_rows = TRUE,
         color = colorRampPalette(rev(rwbcols))(100),
         cellwidth = 4, cellheight = 12,
         annotation_col=annotation_table,annotation_colors = ann_colors, border_color = "grey60")

rwbcols <- c("#D33F6A","#E07B91","#E6AFB9","#f4fcfc","#B5BBE3", "#8595E1", "#4A6FE3")
pheatmap(Taxa,
         fontsize_row = 8, fontsize_col = 5, cluster_cols = TRUE, cluster_rows = FALSE,
         color = colorRampPalette(rev(rwbcols))(100),
         cellwidth = 4, cellheight = 12,
         annotation_col=annotation_table,annotation_colors = ann_colors, border_color = "grey60")

rwbcols <- c("#D33F6A","#E07B91","#E6AFB9","#ffffff","#B5BBE3", "#8595E1", "#4A6FE3")

pheatmap(Taxa,
         fontsize_row = 8, fontsize_col = 5, cluster_cols = TRUE, cluster_rows = TRUE,
         color = colorRampPalette(rev(rwbcols))(100),
         cellwidth = 4, cellheight = 12,
         )

install.packages("complexheatmap")


