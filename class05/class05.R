#' ---
#' title:"Class5 R graphics"
#' author: "Phoebe"
#' date: "fri Jan 25 13:30:02 2019"
#' output: github_document
#' ---



#' Class 05 Graphics and plots with R
#' This is some narative text that I can style **bold** and *italic* and 
#' links to [webpages](https://rmarkdown.rstudio.com/articles_report_from_r_script.html)


# class05 Graphics and Plots with R

#' Section 2A:  **Line plot**
weight <- read.table('bimm143_05_rstats/weight_chart.txt', header=TRUE)
plot(weight$Age, weight$Weight,pch=1:10,ylim=c(2,10),
     xlab="Age (months)", ylab="Weight (kg)",
     type='o',col=c('red','blue'),cex=1.5,
     lwd=2,main="Baby weight with age")


#2B barchart
fc <- read.table('bimm143_05_rstats/feature_counts.txt',header=TRUE,sep='\t')
par(mar=c(5,12,4,2))
barplot(fc$Count,names.arg=fc$Feature,
        horiz=TRUE,ylab='',
        las=1,
        xlim=c(0,80000),
        main="Number of features in the mouse GRCm38 genome")

#reset par
dev.off()
#section 3A Using color in plots


mf <-read.table('bimm143_05_rstats/male_female_counts.txt',header=TRUE,sep='\t') 
barplot(mf$Count,names.arg=mf$Sample,
        las=2,
        col=rainbow(nrow(mf)),
        ylab="Counts")
barplot(mf$Count,names.arg=mf$Sample,
        las=2,
        col=c("blue2","red2"),
        ylab="Counts")

#section 3B Coloring by value
genes <- read.table("bimm143_05_rstats/up_down_expression.txt",header=TRUE,sep="\t")
table(genes$State)
plot(genes$Condition1,genes$Condition2,
     xlab="Expression Condiiton1", ylab="Expression Condiiton2",
     col=genes$State)
palette()
levels(genes$State)
palette(c("blue","grey","red"))

#section 3C Dynamic use of color
meth <- read.table("bimm143_05_rstats/expression_methylation.txt",header=TRUE,sep='\t')
meth_noz <- meth$expression > 0 # select entries with expressions greater than 0

plot(meth$gene.meth[meth_noz],meth$expression[meth_noz],pch=20,
     col=densCols(meth$gene.meth[meth_noz],meth$expression[meth_noz])
     )

plot(meth$gene.meth[meth_noz],meth$expression[meth_noz],pch=20,
     col=densCols(meth$gene.meth[meth_noz],meth$expression[meth_noz],
     colramp =colorRampPalette(c("blue", "green","red")))
)

#section 4A mapping colors
# source the provided function so we can use it
source("bimm143_05_rstats/color_to_value_map.r")
mycols=map.colors(meth$expression, 
                  c(max(meth$expression), min(meth$expression)), 
                  colorRampPalette(c("blue","red"))(100))

plot(meth$promoter.meth, meth$gene.meth, 
     ylab="Gene Methylation", 
     xlab="Promoter Methylation", 
     col=mycols)
