		 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━	
				README


			Michaël Chirmeni Boujike
		 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


==========================================================================
			Files
==========================================================================
		1.	GRAPGT-AprioriTID.jar	
		2.	GRAPGT.R
		3.	test3.data


==========================================================================
			Files description
==========================================================================
		1.	"GRAPGT-AprioriTID.jar" : modified java library of the AprioriTID algorithm for generating extensions;	
		2.	"GRAPGT.R" : modified approach of the T-GPatterns algorithm taking into account the gradual threshold;
		3.	"test3.data" : dataset; 

==========================================================================
		Run (WINDOWS)
==========================================================================	
		1.	Install R (latest version 3.6.x);
		2.	Put the bin of R in the environment variable (ex : C:\Program Files\R\R-3.6.0\bin);
		3.	After installing R, you must install the Java library for R:
			-	install.packages("rJava")
			-	if the Java JDK is not installed :
				*	download and install  jdk (latest version) : https://www3.ntu.edu.sg/home/ehchua/programming/howto/JDK_Howto.html
				*	create environment variable JAVA_HOME and put path until JDK (ex: JAVA_HOME ="C:\Program Files\Java\jdk1.8.0_171")
		4.	Go to the command prompt and go to the directory containing the source code then type :
			- "PATH\Rscript" <<File_R>> <<minSupp>> <<minimum_size_of_gradual_pattern>> <<dataset>> <<output_file>> <<K1>> <<K2>> <<column_separator_in_the_dataset>>
			- where K1 and K2 are constants
		   Example :
				- 	Rscript GRAPGT.R 0.08 2 test3.data output.csv 1 0  sd " "
				
==========================================================================
		Run (LINUX)
==========================================================================	
		1.	Install R (latest version 3.6.x);
		2.	After installing R, you must install the Java library for R:
			-	install.packages("rJava")
			-	if the Java JDK is not installed :
				*	download and install  jdk (latest version) : https://www3.ntu.edu.sg/home/ehchua/programming/howto/JDK_Howto.html
				*	create environment variable AVA_HOME and put path until SDK
		3.	Go to the command prompt and go to the directory containing the source code then type :
			- "PATH\Rscript" <<File_R>> <<minSupp>> <<minimum_size_of_gradual_pattern>> <<dataset>> <<output_file>> <<K1>> <<K2>> <<column_separator_in_the_dataset>>
			- where K1 and K2 are constants
		   Exemple :
				- 	script GRAPGT.R 0.08 2 test3.data output.csv 1 0  sd " "
