pkgname <- "RobLoxBioC"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('RobLoxBioC')

assign(".oldSearch", search(), pos = 'CheckExEnv')
cleanEx()
nameEx("0RobLoxBioC-package")
### * 0RobLoxBioC-package

flush(stderr()); flush(stdout())

### Name: RobLoxBioC-package
### Title: Infinitesimally robust estimators for preprocessing omics data
### Aliases: RobLoxBioC-package RobLoxBioC
### Keywords: package

### ** Examples

library(RobLoxBioC)



cleanEx()
nameEx("KolmogorovMinDist")
### * KolmogorovMinDist

flush(stderr()); flush(stdout())

### Name: KolmogorovMinDist
### Title: Generic Function for Computing Minimum Kolmogorov Distance for
###   Biological Data
### Aliases: KolmogorovMinDist KolmogorovMinDist-methods
###   KolmogorovMinDist,matrix,Norm-method
###   KolmogorovMinDist,AffyBatch,AbscontDistribution-method
###   KolmogorovMinDist,BeadLevelList,AbscontDistribution-method
### Keywords: robust

### ** Examples

set.seed(123) # to have reproducible results for package checking

## matrix method for KolmogorovMinDist
ind <- rbinom(200, size=1, prob=0.05) 
X <- matrix(rnorm(200, mean=ind*3, sd=(1-ind) + ind*9), nrow = 2)
KolmogorovMinDist(X, D = Norm())

## using Affymetrix-Data
data(SpikeIn)
probes <- log2(pm(SpikeIn))
(res <- KolmogorovMinDist(probes, Norm()))
boxplot(res$dist)

## Not run: 
##D ## "Not run" just because of computation time
##D require(affydata)
##D data(Dilution)
##D res <- KolmogorovMinDist(Dilution[,1], Norm())
##D summary(res$dist)
##D boxplot(res$dist)
##D plot(res$n, res$dist, pch = 20, main = "Kolmogorov distance vs. sample size",
##D      xlab = "sample size", ylab = "Kolmogorov distance",
##D      ylim = c(0, max(res$dist)))
##D uni.n <- min(res$n):max(res$n)
##D lines(uni.n, 1/(2*uni.n), col = "orange", lwd = 2)
##D legend("topright", legend = "minimal possible distance", fill = "orange")
## End(Not run)

## using Illumina-Data
## Not run: 
##D ## "Not run" just because of computation time
##D data(BLData)
##D res <- KolmogorovMinDist(BLData, Norm(), arrays = 1)
##D res1 <- KolmogorovMinDist(BLData, log = TRUE, Norm(), arrays = 1)
##D summary(cbind(res$dist, res1$dist))
##D boxplot(list(res$dist, res1$dist), names = c("raw", "log-raw"))
##D sort(unique(res1$n))
##D plot(res1$n, res1$dist, pch = 20, main = "Kolmogorov distance vs. sample size",
##D      xlab = "sample size", ylab = "Kolmogorov distance",
##D      ylim = c(0, max(res1$dist)), xlim = c(min(res1$n), 56))
##D uni.n <- min(res1$n):56
##D lines(uni.n, 1/(2*uni.n), col = "orange", lwd = 2)
##D legend("topright", legend = "minimal possible distance", fill = "orange")
## End(Not run)



cleanEx()
nameEx("SimStudies")
### * SimStudies

flush(stderr()); flush(stdout())

### Name: SimStudies
### Title: Perform Monte-Carlo Study.
### Aliases: AffySimStudy IlluminaSimStudy
### Keywords: robust

### ** Examples

set.seed(123) # to have reproducible results for package checking

AffySimStudy(n = 11, M = 100, eps = 0.02, contD = Norm(mean = 0, sd = 3), 
             plot1 = TRUE, plot2 = TRUE, plot3 = TRUE)
IlluminaSimStudy(n = 30, M = 100, eps = 0.02, contD = Norm(mean = 0, sd = 3), 
                 plot1 = TRUE, plot2 = TRUE, plot3 = TRUE)



cleanEx()
nameEx("robloxbioc")
### * robloxbioc

flush(stderr()); flush(stdout())

### Name: robloxbioc
### Title: Generic Function for Preprocessing Biological Data
### Aliases: robloxbioc robloxbioc-methods robloxbioc,matrix-method
###   robloxbioc,AffyBatch-method robloxbioc,beadLevelData-method
### Keywords: robust

### ** Examples

set.seed(123) # to have reproducible results for package checking

## similar to rowRoblox of package RobLox
ind <- rbinom(200, size=1, prob=0.05)
X <- matrix(rnorm(200, mean=ind*3, sd=(1-ind) + ind*9), nrow = 2)
robloxbioc(X)
robloxbioc(X, steps = 5)
robloxbioc(X, eps = 0.05)
robloxbioc(X, eps = 0.05, steps = 5)

## the function is designed for large scale problems
X <- matrix(rnorm(50000*20, mean = 1), nrow = 50000)
system.time(robloxbioc(X))

## using Affymetrix-Data
## confer example to generateExprVal.method.mas
## A more worked out example can be found in the scripts folder
## of the package.
data(SpikeIn)
probes <- pm(SpikeIn) 
mas <- generateExprVal.method.mas(probes)
rl <- 2^robloxbioc(log2(t(probes)))
concentrations <- as.numeric(colnames(SpikeIn))
plot(concentrations, mas$exprs, log="xy", ylim=c(50,10000), type="b",
     ylab = "expression measures")
points(concentrations, rl[,1], pch = 20, col="orange", type="b")
legend("topleft", c("MAS", "roblox"), pch = c(1, 20))

## Not run: 
##D ## "Not run" just because of computation time
##D require(affydata)
##D data(Dilution)
##D eset <- robloxbioc(Dilution)
##D ## Affymetrix scale normalization
##D eset1 <- robloxbioc(Dilution, normalize = TRUE)
## End(Not run)

## using Illumina-Data
## Not run: 
##D ## "Not run" just because of computation time
##D require(beadarrayExampleData)
##D data(exampleBLData)
##D res <- robloxbioc(exampleBLData, eps.upper = 0.5)
##D res
## End(Not run)



### * <FOOTER>
###
cat("Time elapsed: ", proc.time() - get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
