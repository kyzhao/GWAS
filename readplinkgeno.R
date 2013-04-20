## suppose you have plinkfileprefix.ped plinkfileprefix.map for genotypes.

tmpgenoprefix <- "plinkfileprefix" ## as example

plinkcmmd <- paste ("plink --noweb", tmpgenoprefix,  "--recodeA --out ", tmpgenoprefix )

## first run the following 3 lines on command line: 
# plink --noweb --file  plinkfileprefix  --recodeA --out plinkfileprefix
#cut -d" " -f1-6 plinkfileprefix.raw > plinkfileprefix.fam
#cut -d" " -f7- plinkfileprefix.raw > plinkfileprefix.raw0

## then run this R script to scan in the genotype and save as RData. 

tmpgenofile <- paste(tmpgenoprefix,".raw0",sep="")
tmpmapfile <- paste(tmpgenoprefix,".map",sep="")

tmpfamfile <- paste(tmpgenoprefix,".fam",sep="")
map <- as.matrix(read.csv(tmpmapfile, header=F,sep="\t"))
fam <- read.table(tmpfamfile, header=T,sep=" ")
dim(fam)
ninds <- dim(fam)[1]
colnames(map) <- c("Chr","SNPID","cM","Pos")
nsnps <- dim(map)[1]

geno <- matrix(scan( tmpgenofile, n = ninds*nsnps,skip=1), ninds, nsnps, byrow = TRUE)
save(geno,map,fam, file= paste(tmpgenoprefix,".RData",sep=""), compress=FALSE)

## later on, to use the genotype, simply load the .RData.
#load( paste(tmpgenoprefix,".RData",sep=""))

