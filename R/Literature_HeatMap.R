# library(pheatmap)
# library(tidyverse)
# library(readxl)
# library(RColorBrewer)
# setwd("~/Desktop")
# getwd()
# ?read.table
# annotation_table= read.table("./input/Literature_HeatMap_Data_anno.txt")
# Taxa<-read_xlsx("./input/Literature_HeatMap_Data_Ivan.xlsx", sheet = 1, col_names = TRUE)
# Taxa<-read.table("./input/Literature_HeatMap_Data_reduced.txt")
# Taxa<-read.table("HumanIBDStudies.txt")
# read_
# ann_colors = list(
#   Gender = c(Less="#3399FF", More="#cc6666", Unknown="#f4fcfc"), 
#   Sample_Type = c(Biopsy="#efe9d0", Stool="#ccbb74", Stool_Biopsy="#bc5607"),
#   Sample_Size = c(LessThanFifty="#cff7d5",Between50_100="#a5f7b0", Between101_200="#78e887", MoreThan200="#47a354"),
#   Median_Age = c(BetweenTenTwenty="#e1e8f4",BetweenThirtyFourty="#c1d3f2", BetweenThirtyFifty="#94b6ef", BetweenFiftySeventy="#6d98e0", Unknown="#f4fcfc"),
#   RaceEthnicity = c(MostlyCaucasian="#aaf2ff", Indian="brown", Japanese="#e5f98b", Han= "#efb94c", Korean = "#cc6666", Unknown="#f4fcfc"),
#   Method = c(RT_PCR="#e9e3ef", R454="#c3a9e5",  MiSeq="#a276db", HiSeq="#7b45c1", Other="#f4fcfc"))
# 
# ann_colors = list(
#   Gender = c(Less="#3399FF", More="#cc6666", Unknown="#f4fcfc"), 
#   Sample_Type = c(Biopsy="#efe9d0", Stool="#ccbb74", Stool_Biopsy="#bc5607"),
#   Sample_Size = c(Human="#efe9d0",Dog="#ccbb74", Cat="#ce8852", Mice="#bc5607"),
#   Median_Age = c(Young="#97edd0", Adult="#378e71", Old="#215e4a", Unknown="#f4fcfc"),
#   RaceEthnicity = c(MostlyCaucasian="#aaf2ff", Indian="brown", Japanese="#e5f98b", Han= "#efb94c", Korean = "#cc6666", Unknown="#f4fcfc"),
#   Species=c(Human="#efe9d0",Dog="#ccbb74", Cat="#ce8852", Mice="#bc5607"),
#   Type=c(Natural="#aaf2ff", Chemical="#cc6666", Genetic="#e5f98b", Chemical_Genetic ="#efb94c", Other="#f4fcfc"),
#   Method = c(FISH="#d0eaef", R454="#aaf2ff", RT_PCR="#3399FF", MiSeq="#efb94c", HiSeq="#cc6666", Other="#f4fcfc"))
# 
# pheatmap(Taxa, 
#          fontsize_row = 8, fontsize_col = 5, cluster_cols = TRUE, cluster_rows = TRUE,
#          color = colorRampPalette(rev(rwbcols))(100),
#          cellwidth = 4, cellheight = 12,
#          annotation_col=annotation_table,annotation_colors = ann_colors, border_color = "grey60")
# 
# rwbcols <- c("#D33F6A","#E07B91","#E6AFB9","#f4fcfc","#B5BBE3", "#8595E1", "#4A6FE3")
# pheatmap(Taxa, 
#          fontsize_row = 8, fontsize_col = 5, cluster_cols = TRUE, cluster_rows = FALSE,
#          color = colorRampPalette(rev(rwbcols))(100),
#          cellwidth = 4, cellheight = 12,
#          annotation_col=annotation_table,annotation_colors = ann_colors, border_color = "grey60")
# 
# rwbcols <- c("#D33F6A","#E07B91","#E6AFB9","#ffffff","#B5BBE3", "#8595E1", "#4A6FE3")
# 
# pheatmap(Taxa, 
#          fontsize_row = 8, fontsize_col = 5, cluster_cols = TRUE, cluster_rows = TRUE,
#          color = colorRampPalette(rev(rwbcols))(100),
#          cellwidth = 4, cellheight = 12,
#          )

# install.packages("complexheatmap")

library(ggplot2)
library(dplyr)
library(tidyr)
library(RColorBrewer)
# library(complexheatmap)  # For clustering, if needed

# Assuming rwbcols is defined
rwbcols <- brewer.pal(3, "RdBu")

# 1. Convert Taxa to long format
Taxa_long <- Taxa %>%
  rownames_to_column("RowNames") %>%
  pivot_longer(cols = -RowNames, names_to = "ColumnName", values_to = "Value")

# 2. (Optional) Perform clustering - if you decide to handle clustering separately
# This is an example using hclust for column clustering and not row clustering
# Skip this part if clustering is not needed or apply as needed
Taxa_dist <- dist(t(Taxa))  # Transpose for column clustering
Taxa_hclust <- hclust(Taxa_dist)
Taxa_long$ColumnName <- factor(Taxa_long$ColumnName, levels = colnames(Taxa)[Taxa_hclust$order])

# 3. Create the plot
p <- ggplot(Taxa_long, aes(x = ColumnName, y = RowNames, fill = Value)) +
  geom_tile() +
  scale_fill_gradientn(colors = colorRampPalette(rev(rwbcols))(100)) +
  theme_minimal() +
  theme(axis.text.x = element_text(size = 5, angle = 45, hjust = 1),
        axis.text.y = element_text(size = 8),
        axis.title = element_blank()) +
  labs(fill = "Value") +
  coord_fixed(ratio = 12 / 7)  # Adjust ratio based on cellheight and cellwidth

# Print the plot
print(p)



library(ggplot2)
library(dplyr)
library(tidyr)
library(RColorBrewer)
# library(ComplexHeatmap)  # for clustering if needed
library(gridExtra)  # for arranging plots including annotations

# Define your color palettes and the rwbcols
rwbcols <- brewer.pal(3, "RdBu")

# Prepare Taxa data
Taxa_long <- Taxa %>%
  rownames_to_column("RowNames") %>%
  pivot_longer(cols = -RowNames, names_to = "ColumnName", values_to = "Value")

# Assuming annotation_table is defined correctly in your environment
# Prepare annotation data
ann_colors <- list(
  Gender = c(Less="#3399FF", More="#cc6666", Unknown="#f4fcfc"), 
  Sample_Type = c(Biopsy="#efe9d0", Stool="#ccbb74", Stool_Biopsy="#bc5607"),
  Sample_Size = c(LessThanFifty="#cff7d5", Between50_100="#a5f7b0", Between101_200="#78e887", MoreThan200="#47a354"),
  Median_Age = c(BetweenTenTwenty="#e1e8f4", BetweenThirtyFourty="#c1d3f2", BetweenThirtyFifty="#94b6ef", BetweenFiftySeventy="#6d98e0", Unknown="#f4fcfc"),
  RaceEthnicity = c(MostlyCaucasian="#aaf2ff", Indian="brown", Japanese="#e5f98b", Han= "#efb94c", Korean = "#cc6666", Unknown="#f4fcfc"),
  Method = c(RT_PCR="#e9e3ef", R454="#c3a9e5",  MiSeq="#a276db", HiSeq="#7b45c1", Other="#f4fcfc")
)

# Plotting main heatmap
p1 <- ggplot(Taxa_long, aes(x = ColumnName, y = RowNames, fill = Value)) +
  geom_tile(color = "grey60") +
  scale_fill_gradientn(colors = colorRampPalette(rev(rwbcols))(100)) +
  theme_minimal() +
  theme(axis.text.x = element_text(size = 5, angle = 45, hjust = 1),
        axis.text.y = element_text(size = 8),
        axis.title = element_blank()) +
  coord_fixed(ratio = 12 / 7)  # Adjust ratio based on cellheight and cellwidth

# Add annotations as separate plots
p2 <- ggplot(annotation_table, aes(x = Factor1, y = Factor2, fill = Factor3)) +
  geom_tile() +
  scale_fill_manual(values = ann_colors[[1]]) +
  theme_void()

# Arrange plots including annotations (simple vertical arrangement example)
grid.arrange(p1, p2, ncol = 1)

# Print the plot
print(p1)
