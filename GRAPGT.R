## inputs parameters
argv <- commandArgs(TRUE)

# -- The minimum support --
minSup <- as.double(argv[1])

# -- The minimum length of extracted gradual pattern
minLength <- as.integer(argv[2])

# -- Input file
input <- argv[3]

# -- Output file
output <- argv[4]

# -- Define output tempon file & input Convolution
outputInputTemp <- "FileForAprioriTID.txt"

# -- The Firts constant
k1 <- as.numeric(argv[5])

# -- The Second constant
k2 <- as.numeric(argv[6])

# -- The gradual threshold
type <- argv[7]

cat("\n")
cat("----- The minimum support is ", minSup, "------ \n")
cat("\n")
cat("----- The minimum length of extracted gradual pattern is ", minLength, "----\n")
cat("\n")
cat("----- The firts constant is", k1, "----\n")
cat("\n")
cat("----- The second constant is ", k2, "----\n")
cat("\n")
cat("----- The  gradual threshold is ", type, "----\n")
cat("\n")
cat("----- The separator of data is ", argv[8], "------ \n")

cat("\n")

## import library Java
library("rJava")

## Read input data file 
data <- read.csv(input, sep = argv[8])

## ------ The beginning of the standard deviation ------
## Transform dataframe to matrix 
data_mat <- as.matrix(data)

## ------ Time ------as
t1 <- Sys.time()
## ------ Debut standard deviation (sd) ------
ecarttype <- vector("numeric",ncol(data_mat))

if (type == 'sd'){
	## ECART TYPE
	for (i in 1 : ncol(data_mat))
	  ecarttype[i] <- (sd(data_mat[,i]) * k1) + k2
}else if (type == 'st'){
	## Compute deviation standard of ecart
	vec_st <- vector()
	vec_sort <- vector()
	for (i in 1:ncol(data_mat)) {
	  vec_sort <- sort(data_mat[,i])
	  for (j in 2:length(vec_sort)) {
		vec_st[j-1] <-as.numeric(vec_sort[j]) - as.numeric(vec_sort[j-1])
	  }
	  ecarttype[i] <- (sd(vec_st) * k1) + k2
	}
}else{
	## COEFFICIENT DE VARIATION
	for (i in 1 : ncol(data_mat))  
	  ecarttype[i] <- ((sd(data_mat[,i])/mean(data_mat[,i])) * k1) + k2
}

## ------ Fin  standard deviation ------

## ------ The beginning of the NumVersCat procedure -------
data_diff <- diff(data_mat)
## -- Util pour APRIORI
tab_vec <- array()

## Transform numerical data matrix to categorical data matrix containing  "+", "-" and "o" items
data_cat <- matrix(0, nrow = nrow(data_diff), ncol = ncol(data_diff))

for(i in 1:ncol(data_diff)){
  for(j in 1 : nrow(data_diff)){
    if ((data_diff[j,i] > ecarttype[i]) & (data_diff[j,i] > 0)){
      data_cat[j,i] <-paste0(paste0("X",i),"=+") # Xi=+
    }else if((abs(data_diff[j,i]) > ecarttype[i]) & (data_diff[j,i] < 0)){
      data_cat[j,i] <-paste0(paste0("X",i),"=-") #Xi=-
    }else{
      data_cat[j,i] <-paste0(paste0("X",i),"=o") #Xi=o
    }
  }
}
# ----------------------------------
for (i in 1:nrow(data_cat)) {
  for(j in 1:ncol(data_cat)){
    if (j == 1) {tab_vec[i] <- data_cat[i,j]}else{tab_vec[i] <- paste(tab_vec[i], data_cat[i,j])}
  }
}
# ----------------------------------

# -- Ecrire dans un fichier tempon pour traitement par AprioriTID
write(tab_vec, file = outputInputTemp, sep =" ")

### ----- Début Insertion du code java -----
# -- initialisation of the JVM
.jinit()

# -- Add .jar file to the class path
.jaddClassPath("GRAPGT-AprioriTID.jar")

# -- instatiation of the Class
obj <- .jnew("AlgoAprioriTID")

cat("----- BEFORE APRIORI ----\n")
# -- Call function directly with parameters
.jcall(obj, "V","runAlgorithmModifierNotTID", outputInputTemp, output, minSup, minLength)
cat("----- AFTER APRIORI ----\n")
t2 <- Sys.time()
t2 - t1
cat("\n")

