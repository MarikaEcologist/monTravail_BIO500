##################################################################################################
############################## INJECTION DONNEES DANS SQLITE #####################################
##################################################################################################

if (!require("RSQLite")) install.packages("RSQLite"); library("RSQLite")
if (!require("knitr")) install.packages("knitr"); library("knitr")
if (!require("igraph")) install.packages("igraph"); library("igraph")
if (!require("reshape2")) install.packages("reshape2"); library("reshape2")

setwd('/cloud/project/travail_BIO500')

#Connection au SQLite si ce n'est pas déjà fait
con<-dbConnect(SQLite(),dbname="bd_reseau")

##################################### Injections des données concernant les etudiants
bd_noms<-read.csv(file='data_etudiant.csv')
dbWriteTable(con,append=TRUE, name='noms', value=bd_noms,row.name=FALSE)

##################################### Injection des données concernant les cours
bd_cours<-read.csv(file='Data_cours.csv')
dbWriteTable(con,append=TRUE,name='cours',value=bd_cours,row.name=FALSE)

#################################### Injection des données concernant les collaborations
bd_collaborations<-read.csv(file='Data_collabo.csv')
dbWriteTable(con,append=TRUE,name='collaborations',value=bd_collaborations,row.name=FALSE)



####################################################################################################
################# 1 LES REQUETES ###################################################################
############################ 1.1 NOMBRE DE COLLABORATIONS PAR PAIRE D'ETUDIANT  ####################
####################################################################################################

sql_requete <- "
SELECT etudiant1, etudiant2, count(*) AS nb_collaborations
FROM collaborations
GROUP BY etudiant1, etudiant2;"
resume_collabo <- dbGetQuery(con, sql_requete)
head(resume_collabo)
# resume_collabo respresente les populations, chaque cours est une population.


##########################################################################################################
################################ 1.2 CREATION DES POPULATIONS ############################################
##########################################################################################################

sql_requete <- "
SELECT etudiant1, etudiant2
FROM collaborations WHERE cours LIKE '%BCM113%'
GROUP BY etudiant1, etudiant2 ;"
Pop_BCM113 <- dbGetQuery(con, sql_requete)
head(Pop_BCM113)

sql_requete <- "
SELECT etudiant1, etudiant2
FROM collaborations WHERE cours LIKE '%BIO109%'
GROUP BY etudiant1, etudiant2 ;"
Pop_BIO109 <- dbGetQuery(con, sql_requete)
head(Pop_BIO109)

sql_requete <- "
SELECT etudiant1, etudiant2
FROM collaborations WHERE cours LIKE '%BIO500%'
GROUP BY etudiant1, etudiant2 ;"
Pop_BIO500 <- dbGetQuery(con, sql_requete)
head(Pop_BIO500)

sql_requete <- "
SELECT etudiant1, etudiant2
FROM collaborations WHERE cours LIKE '%BOT400%'
GROUP BY etudiant1, etudiant2 ;"
Pop_BOT400 <- dbGetQuery(con, sql_requete)
head(Pop_BOT400)

sql_requete <- "
SELECT etudiant1, etudiant2
FROM collaborations WHERE cours LIKE '%ECL308%'
GROUP BY etudiant1, etudiant2 ;"
Pop_ECL308 <- dbGetQuery(con, sql_requete)
head(Pop_ECL308)

sql_requete <- "
SELECT etudiant1, etudiant2
FROM collaborations WHERE cours LIKE '%ECL403%'
GROUP BY etudiant1, etudiant2 ;"
Pop_ECL403 <- dbGetQuery(con, sql_requete)
head(Pop_ECL403)

sql_requete <- "
SELECT etudiant1, etudiant2
FROM collaborations WHERE cours LIKE '%ECL404%'
GROUP BY etudiant1, etudiant2 ;"
Pop_ECL404 <- dbGetQuery(con, sql_requete)
head(Pop_ECL404)

sql_requete <- "
SELECT etudiant1, etudiant2
FROM collaborations WHERE cours LIKE '%ECL406%'
GROUP BY etudiant1, etudiant2 ;"
Pop_ECL406 <- dbGetQuery(con, sql_requete)
head(Pop_ECL406)

sql_requete <- "
SELECT etudiant1, etudiant2
FROM collaborations WHERE cours LIKE '%ECL515%'
GROUP BY etudiant1, etudiant2 ;"
Pop_ECL515 <- dbGetQuery(con, sql_requete)
head(Pop_ECL515)

sql_requete <- "
SELECT etudiant1, etudiant2
FROM collaborations WHERE cours LIKE '%ECL516%'
GROUP BY etudiant1, etudiant2 ;"
Pop_ECL516 <- dbGetQuery(con, sql_requete)
head(Pop_ECL516)

sql_requete <- "
SELECT etudiant1, etudiant2
FROM collaborations WHERE cours LIKE '%ECL527%'
GROUP BY etudiant1, etudiant2 ;"
Pop_ECL527 <- dbGetQuery(con, sql_requete)
head(Pop_ECL527)

sql_requete <- "
SELECT etudiant1, etudiant2
FROM collaborations WHERE cours LIKE '%ECL535%'
GROUP BY etudiant1, etudiant2 ;"
Pop_ECL535 <- dbGetQuery(con, sql_requete)
head(Pop_ECL535)

sql_requete <- "
SELECT etudiant1, etudiant2
FROM collaborations WHERE cours LIKE '%ECL611%'
GROUP BY etudiant1, etudiant2 ;"
Pop_ECL611 <- dbGetQuery(con, sql_requete)
head(Pop_ECL611)

sql_requete <- "
SELECT etudiant1, etudiant2
FROM collaborations WHERE cours LIKE '%ENT102%'
GROUP BY etudiant1, etudiant2 ;"
Pop_ENT102 <- dbGetQuery(con, sql_requete)
head(Pop_ENT102)

sql_requete <- "
SELECT etudiant1, etudiant2
FROM collaborations WHERE cours LIKE '%INS154%'
GROUP BY etudiant1, etudiant2 ;"
Pop_INS154 <- dbGetQuery(con, sql_requete)
head(Pop_INS154)

sql_requete <- "
SELECT etudiant1, etudiant2
FROM collaborations WHERE cours LIKE '%MCB101%'
GROUP BY etudiant1, etudiant2 ;"
Pop_MCB101 <- dbGetQuery(con, sql_requete)
head(Pop_MCB101)

sql_requete <- "
SELECT etudiant1, etudiant2
FROM collaborations WHERE cours LIKE '%TSB303%'
GROUP BY etudiant1, etudiant2 ;"
Pop_TSB303 <- dbGetQuery(con, sql_requete)    
head(Pop_TSB303)

sql_requete <- "
SELECT etudiant1, etudiant2
FROM collaborations WHERE cours LIKE '%ZOO105%'
GROUP BY etudiant1, etudiant2 ;"
Pop_ZOO105 <- dbGetQuery(con, sql_requete)    
head(Pop_ZOO105)

sql_requete <- "
SELECT etudiant1, etudiant2
FROM collaborations WHERE cours LIKE '%ZOO306%'
GROUP BY etudiant1, etudiant2 ;"
Pop_ZOO306 <- dbGetQuery(con, sql_requete)    
head(Pop_ZOO306)

sql_requete <- "
SELECT etudiant1, etudiant2
FROM collaborations WHERE cours LIKE '%ECL616%'
GROUP BY etudiant1, etudiant2 ;"
Pop_ECL616 <- dbGetQuery(con, sql_requete)    
head(Pop_ECL616)

sql_requete <- "
SELECT etudiant1, etudiant2
FROM collaborations WHERE cours LIKE '%ECL603%'
GROUP BY etudiant1, etudiant2 ;"
Pop_ECL603 <- dbGetQuery(con, sql_requete)    
head(Pop_ECL603)

sql_requete <- "
SELECT etudiant1, etudiant2
FROM collaborations WHERE cours LIKE '%GMQ106%'
GROUP BY etudiant1, etudiant2 ;"
Pop_GMQ106 <- dbGetQuery(con, sql_requete)    
head(Pop_GMQ106)

sql_requete <- "
SELECT etudiant1, etudiant2
FROM collaborations WHERE cours LIKE '%ECL534%'
GROUP BY etudiant1, etudiant2 ;"
Pop_ECL534 <- dbGetQuery(con, sql_requete)    
head(Pop_ECL534)

sql_requete <- "
SELECT etudiant1, etudiant2
FROM collaborations WHERE cours LIKE '%GBI104%'
GROUP BY etudiant1, etudiant2 ;"
Pop_GBI104 <- dbGetQuery(con, sql_requete)    
head(Pop_GBI104)

sql_requete <- "
SELECT etudiant1, etudiant2
FROM collaborations WHERE cours LIKE '%INS154%'
GROUP BY etudiant1, etudiant2 ;"
Pop_INS154 <- dbGetQuery(con, sql_requete)    
head(Pop_INS154)

sql_requete <- "
SELECT etudiant1, etudiant2
FROM collaborations WHERE cours LIKE '%ZOO307%'
GROUP BY etudiant1, etudiant2 ;"
Pop_ZOO307 <- dbGetQuery(con, sql_requete)    
head(Pop_ZOO307)

sql_requete <- "
SELECT etudiant1, etudiant2
FROM collaborations WHERE cours LIKE '%BCM104%'
GROUP BY etudiant1, etudiant2 ;"
Pop_BCM104 <- dbGetQuery(con, sql_requete)    
head(Pop_BCM104)

sql_requete <- "
SELECT etudiant1, etudiant2
FROM collaborations WHERE cours LIKE '%ECL522%'
GROUP BY etudiant1, etudiant2 ;"
Pop_ECL522 <- dbGetQuery(con, sql_requete)    
head(Pop_ECL522)

sql_requete <- "
SELECT etudiant1, etudiant2
FROM collaborations WHERE cours LIKE '%ECL510%'
GROUP BY etudiant1, etudiant2 ;"
Pop_ECL510 <- dbGetQuery(con, sql_requete)    
head(Pop_ECL510)

sql_requete <- "
SELECT etudiant1, etudiant2
FROM collaborations WHERE cours LIKE '%CHM319%'
GROUP BY etudiant1, etudiant2 ;"
Pop_CHM319 <- dbGetQuery(con, sql_requete)    
head(Pop_CHM319)
            
sql_requete <- "
SELECT etudiant1, etudiant2
FROM collaborations WHERE cours LIKE '%ECL301%'
GROUP BY etudiant1, etudiant2 ;"
Pop_ECL301 <- dbGetQuery(con, sql_requete)    
head(Pop_ECL301)

######################################################################################################
########################### 1.3 NOMBRE ETUDIANTS PAR COURS POUR CHAQUE COURS  ########################
######################################################################################################

sql_requete <- "
SELECT cours, count(DISTINCT etudiant1) AS nb_etudiants 
FROM collaborations
GROUP BY cours;"
resume_cours <- dbGetQuery(con, sql_requete)
head(resume_cours)


############################################################################################################
########################## 2. VISUALISATION DES RéSEAUX ####################################################
############## 2.1 CREATION MATRICE RESEAU COLLABORATION ###################################################
############################################################################################################

#install.packages('tidyr')
library(tidyr)
#install.packages('reshape2')
library(reshape2)
#install.packages("igraph")
library(igraph)

#Équilibre la matrice carrée
resume_collabo2 <- subset(resume_collabo, etudiant2%in%etudiant1)
resume_collabo3 <- subset(resume_collabo2, etudiant1%in%etudiant2)
L <- acast(resume_collabo3, etudiant1~etudiant2, value.var='nb_collaborations')

#Verification que la matrice est bien carrée
#ncol(L)
#nrow(L)

#####################################################################################################
############################################## 2.2 VISUALISATION IGRAPH #############################
#####################################################################################################


Colab <- graph.adjacency(L)
Colab <- simplify(Colab, remove.multiple = FALSE, remove.loops = TRUE)
plot(Colab, layout=layout_nicely, vertex.label = NA, edge.arrow.mode = 0, 
            vertex.frame.color = NA, vertex.size = 7, edge.width = 0.2)


plot(Colab, vertex.size = 10*degree(Colab)/max(degree(Colab))+3,
     vertex.color= as.character(factor(betweenness(Colab), 
     labels = rev(heat.colors(length(unique(betweenness(Colab))))))),
     vertex.label= NA, vertex.label.cex = 7, 
     vertex.shape="circle", edge.arrow.size= 0, 
     edge.width= 1, edge.color="grey",
     layout=layout_nicely, main='Réseau de collaborations des étudiants 
     provenant du cours BIO500 - Méthodes en écologie computationnelle')



##################################################################################################################
############################### 2.3 CREATION MATRICE DES POPULATIONS #############################################
####################### 2.3.1 POPULATION BCM113 ##################################################################
##################################################################################################################

class(bd_collaborations$cours)
bd_collaborations$cours <- as.character(bd_collaborations$cours)            

etudiantstotaux <- unique(c(as.character(Pop_BCM113$etudiant1),as.character(Pop_BCM113$etudiant2)))
matrix_collabo <- matrix(data =rep(NA, times=1764), nrow=length(etudiantstotaux),ncol=length(etudiantstotaux))
colnames(matrix_collabo) <- etudiantstotaux
rownames(matrix_collabo) <- etudiantstotaux

for (i in 1:ncol(matrix_collabo)){
        nom1 <- colnames(matrix_collabo)[i]
        collaborateurs <- subset(Pop_BCM113, etudiant1== nom1)$etudiant2
        for (j in 1:nrow(matrix_collabo)){
                print(j)
                if (rownames(matrix_collabo)[j]%in%collaborateurs){
                        matrix_collabo[j,i] <- 1
                        print('TRUE')
                }else{
                        matrix_collabo[j,i] <- 0 
                        print('FALSE')
                }
        }
}

#################### VISUALISATION
BCM113 <- graph.adjacency(matrix_collabo)
plot(BCM113, layout=layout_nicely, vertex.label.color = 'black',
            edge.arrow.mode = 0, vertex.frame.color = NA, 
            vertex.size = 7, edge.width = 0.2,
            main='Réseau de collaborations entre les étudiants
        de la sous-population du cours BCM113
     (Biochimie générale - Travaux pratiques)')

################################################################################################################
####################### 2.3.2 POPULATION BIO109 ###############################################################
################################################################################################################

etudiantstotaux <- unique(c(as.character(Pop_BIO109$etudiant1),as.character(Pop_BIO109$etudiant2)))
matrix_collabo <- matrix(data =rep(NA, times=1764), nrow=length(etudiantstotaux),ncol=length(etudiantstotaux))
colnames(matrix_collabo) <- etudiantstotaux
rownames(matrix_collabo) <- etudiantstotaux

for (i in 1:ncol(matrix_collabo)){
  nom1 <- colnames(matrix_collabo)[i]
  collaborateurs <- subset(Pop_BIO109, etudiant1== nom1)$etudiant2
  for (j in 1:nrow(matrix_collabo)){
    print(j)
    if (rownames(matrix_collabo)[j]%in%collaborateurs){
      matrix_collabo[j,i] <- 1
      print('TRUE')
    }else{
      matrix_collabo[j,i] <- 0 
      print('FALSE')
    }
  }
}

#################### VISUALISATION
BIO109 <- graph.adjacency(matrix_collabo)
plot(BIO109, layout=layout_nicely, vertex.label.color = 'black', 
     edge.arrow.mode = 0, vertex.frame.color = NA, 
     vertex.size = 7, edge.width = 0.2,
     main='BIO109')


################################################################################################################
####################### 2.3.3 POPULATION BIO500 ###############################################################
################################################################################################################

etudiantstotaux <- unique(c(as.character(Pop_BIO500$etudiant1),as.character(Pop_BIO500$etudiant2)))
matrix_collabo <- matrix(data =rep(NA, times=1764), nrow=length(etudiantstotaux),ncol=length(etudiantstotaux))
colnames(matrix_collabo) <- etudiantstotaux
rownames(matrix_collabo) <- etudiantstotaux

for (i in 1:ncol(matrix_collabo)){
  nom1 <- colnames(matrix_collabo)[i]
  collaborateurs <- subset(Pop_BIO500, etudiant1== nom1)$etudiant2
  for (j in 1:nrow(matrix_collabo)){
    print(j)
    if (rownames(matrix_collabo)[j]%in%collaborateurs){
      matrix_collabo[j,i] <- 1
      print('TRUE')
    }else{
      matrix_collabo[j,i] <- 0 
      print('FALSE')
    }
  }
}

#################### VISUALISATION
BIO500 <- graph.adjacency(matrix_collabo)
plot(BIO500, layout=layout_nicely, vertex.label.color = 'black', 
     edge.arrow.mode = 0, vertex.frame.color = NA, 
     vertex.size = 7, edge.width = 0.2,
     main='Réseau de collaborations entre les étudiants
     de la sous-population du cours BIO500
     (Méthodes en écologie computationnelle)')

################################################################################################################
####################### 2.3.4 POPULATION BOT400 ###############################################################
################################################################################################################

etudiantstotaux <- unique(c(as.character(Pop_BOT400$etudiant1),as.character(Pop_BOT400$etudiant2)))
matrix_collabo <- matrix(data =rep(NA, times=1764), nrow=length(etudiantstotaux),ncol=length(etudiantstotaux))
colnames(matrix_collabo) <- etudiantstotaux
rownames(matrix_collabo) <- etudiantstotaux


for (i in 1:ncol(matrix_collabo)){
  nom1 <- colnames(matrix_collabo)[i]
  collaborateurs <- subset(Pop_BOT400, etudiant1== nom1)$etudiant2
  for (j in 1:nrow(matrix_collabo)){
    print(j)
    if (rownames(matrix_collabo)[j]%in%collaborateurs){
      matrix_collabo[j,i] <- 1
      print('TRUE')
    }else{
      matrix_collabo[j,i] <- 0 
      print('FALSE')
    }
  }
}

#################### VISUALISATION
BOT400 <- graph.adjacency(matrix_collabo)
plot(BOT400, layout=layout_nicely, vertex.label.color = 'black', 
     edge.arrow.mode = 0, vertex.frame.color = NA, 
     vertex.size = 7, edge.width = 0.2,
     main='BOT400')

################################################################################################################
####################### 2.3.5 POPULATION ECL308 ###############################################################
################################################################################################################

etudiantstotaux <- unique(c(as.character(Pop_ECL308$etudiant1),as.character(Pop_ECL308$etudiant2)))
matrix_collabo <- matrix(data =rep(NA, times=1764), nrow=length(etudiantstotaux),ncol=length(etudiantstotaux))
colnames(matrix_collabo) <- etudiantstotaux
rownames(matrix_collabo) <- etudiantstotaux

for (i in 1:ncol(matrix_collabo)){
  nom1 <- colnames(matrix_collabo)[i]
  collaborateurs <- subset(Pop_ECL308, etudiant1== nom1)$etudiant2
  for (j in 1:nrow(matrix_collabo)){
    print(j)
    if (rownames(matrix_collabo)[j]%in%collaborateurs){
      matrix_collabo[j,i] <- 1
      print('TRUE')
    }else{
      matrix_collabo[j,i] <- 0 
      print('FALSE')
    }
  }
}

#################### VISUALISATION
ECL308 <- graph.adjacency(matrix_collabo)
plot(ECL308, layout=layout_nicely, vertex.label.color = 'black', 
     edge.arrow.mode = 0, vertex.frame.color = NA, 
     vertex.size = 7, edge.width = 0.2,
     main='ECL308')


################################################################################################################
####################### 2.3.6 POPULATION ECL403 ###############################################################
################################################################################################################

etudiantstotaux <- unique(c(as.character(Pop_ECL403$etudiant1),as.character(Pop_ECL403$etudiant2)))
matrix_collabo <- matrix(data =rep(NA, times=1764), nrow=length(etudiantstotaux),ncol=length(etudiantstotaux))
colnames(matrix_collabo) <- etudiantstotaux
rownames(matrix_collabo) <- etudiantstotaux

for (i in 1:ncol(matrix_collabo)){
  nom1 <- colnames(matrix_collabo)[i]
  collaborateurs <- subset(Pop_ECL403, etudiant1== nom1)$etudiant2
  for (j in 1:nrow(matrix_collabo)){
    print(j)
    if (rownames(matrix_collabo)[j]%in%collaborateurs){
      matrix_collabo[j,i] <- 1
      print('TRUE')
    }else{
      matrix_collabo[j,i] <- 0 
      print('FALSE')
    }
  }
}

#################### VISUALISATION
ECL403 <- graph.adjacency(matrix_collabo)
plot(ECL403, layout=layout_nicely, vertex.label.color = 'black', 
     edge.arrow.mode = 0, vertex.frame.color = NA, 
     vertex.size = 7, edge.width = 0.2,
     main='ECL403')


################################################################################################################
####################### 2.3.7 POPULATION ECL404 ###############################################################
################################################################################################################

etudiantstotaux <- unique(c(as.character(Pop_ECL404$etudiant1),as.character(Pop_ECL404$etudiant2)))
matrix_collabo <- matrix(data =rep(NA, times=1764), nrow=length(etudiantstotaux),ncol=length(etudiantstotaux))
colnames(matrix_collabo) <- etudiantstotaux
rownames(matrix_collabo) <- etudiantstotaux

for (i in 1:ncol(matrix_collabo)){
  nom1 <- colnames(matrix_collabo)[i]
  collaborateurs <- subset(Pop_ECL404, etudiant1== nom1)$etudiant2
  for (j in 1:nrow(matrix_collabo)){
    print(j)
    if (rownames(matrix_collabo)[j]%in%collaborateurs){
      matrix_collabo[j,i] <- 1
      print('TRUE')
    }else{
      matrix_collabo[j,i] <- 0 
      print('FALSE')
    }
  }
}

#################### VISUALISATION
ECL404 <- graph.adjacency(matrix_collabo)
plot(ECL404, layout=layout_nicely, vertex.label.color = 'black', 
     edge.arrow.mode = 0, vertex.frame.color = NA, 
     vertex.size = 7, edge.width = 0.2,
     main='ECL404')


################################################################################################################
####################### 2.3.8 POPULATION ECL406 ###############################################################
################################################################################################################

etudiantstotaux <- unique(c(as.character(Pop_ECL406$etudiant1),as.character(Pop_ECL406$etudiant2)))
matrix_collabo <- matrix(data =rep(NA, times=1764), nrow=length(etudiantstotaux),ncol=length(etudiantstotaux))
colnames(matrix_collabo) <- etudiantstotaux
rownames(matrix_collabo) <- etudiantstotaux

for (i in 1:ncol(matrix_collabo)){
  nom1 <- colnames(matrix_collabo)[i]
  collaborateurs <- subset(Pop_ECL406, etudiant1== nom1)$etudiant2
  for (j in 1:nrow(matrix_collabo)){
    print(j)
    if (rownames(matrix_collabo)[j]%in%collaborateurs){
      matrix_collabo[j,i] <- 1
      print('TRUE')
    }else{
      matrix_collabo[j,i] <- 0 
      print('FALSE')
    }
  }
}

#################### VISUALISATION
ECL406 <- graph.adjacency(matrix_collabo)
plot(ECL406, layout=layout_nicely, vertex.label.color = 'black', 
     edge.arrow.mode = 0, vertex.frame.color = NA, 
     vertex.size = 7, edge.width = 0.2,
     main='Réseau de collaborations entre les étudiants
     de la sous-population du cours ECL406
     (Tendances évolutives des plantes terrestres)')


################################################################################################################
####################### 2.3.9 POPULATION ECL515 ###############################################################
################################################################################################################

etudiantstotaux <- unique(c(as.character(Pop_ECL515$etudiant1),as.character(Pop_ECL515$etudiant2)))
matrix_collabo <- matrix(data =rep(NA, times=1764), nrow=length(etudiantstotaux),ncol=length(etudiantstotaux))
colnames(matrix_collabo) <- etudiantstotaux
rownames(matrix_collabo) <- etudiantstotaux

for (i in 1:ncol(matrix_collabo)){
  nom1 <- colnames(matrix_collabo)[i]
  collaborateurs <- subset(Pop_ECL515, etudiant1== nom1)$etudiant2
  for (j in 1:nrow(matrix_collabo)){
    print(j)
    if (rownames(matrix_collabo)[j]%in%collaborateurs){
      matrix_collabo[j,i] <- 1
      print('TRUE')
    }else{
      matrix_collabo[j,i] <- 0 
      print('FALSE')
    }
  }
}

#################### VISUALISATION
ECL515 <- graph.adjacency(matrix_collabo)
plot(ECL515, layout=layout_nicely, vertex.label.color = 'black', 
     edge.arrow.mode = 0, vertex.frame.color = NA, 
     vertex.size = 7, edge.width = 0.2,
     main='ECL515')

################################################################################################################
####################### 2.3.10 POPULATION ECL516 ###############################################################
################################################################################################################

etudiantstotaux <- unique(c(as.character(Pop_ECL516$etudiant1),as.character(Pop_ECL516$etudiant2)))
matrix_collabo <- matrix(data =rep(NA, times=1764), nrow=length(etudiantstotaux),ncol=length(etudiantstotaux))
colnames(matrix_collabo) <- etudiantstotaux
rownames(matrix_collabo) <- etudiantstotaux

for (i in 1:ncol(matrix_collabo)){
  nom1 <- colnames(matrix_collabo)[i]
  collaborateurs <- subset(Pop_ECL516, etudiant1== nom1)$etudiant2
  for (j in 1:nrow(matrix_collabo)){
    print(j)
    if (rownames(matrix_collabo)[j]%in%collaborateurs){
      matrix_collabo[j,i] <- 1
      print('TRUE')
    }else{
      matrix_collabo[j,i] <- 0 
      print('FALSE')
    }
  }
}

#################### VISUALISATION
ECL516 <- graph.adjacency(matrix_collabo)
plot(ECL516, layout=layout_nicely, vertex.label.color = 'black', 
     edge.arrow.mode = 0, vertex.frame.color = NA, 
     vertex.size = 7, edge.width = 0.2,
     main='ECL516')

################################################################################################################
####################### 2.3.11 POPULATION ECL527 ###############################################################
################################################################################################################

etudiantstotaux <- unique(c(as.character(Pop_ECL527$etudiant1),as.character(Pop_ECL527$etudiant2)))
matrix_collabo <- matrix(data =rep(NA, times=1764), nrow=length(etudiantstotaux),ncol=length(etudiantstotaux))
colnames(matrix_collabo) <- etudiantstotaux
rownames(matrix_collabo) <- etudiantstotaux

for (i in 1:ncol(matrix_collabo)){
  nom1 <- colnames(matrix_collabo)[i]
  collaborateurs <- subset(Pop_ECL527, etudiant1== nom1)$etudiant2
  for (j in 1:nrow(matrix_collabo)){
    print(j)
    if (rownames(matrix_collabo)[j]%in%collaborateurs){
      matrix_collabo[j,i] <- 1
      print('TRUE')
    }else{
      matrix_collabo[j,i] <- 0 
      print('FALSE')
    }
  }
}

#################### VISUALISATION
ECL527 <- graph.adjacency(matrix_collabo)
plot(ECL527, layout=layout_nicely, vertex.label.color = 'black', 
     edge.arrow.mode = 0, vertex.frame.color = NA, 
     vertex.size = 7, edge.width = 0.2,
     main='ECL527')

            
################################################################################################################
####################### 2.3.12 POPULATION ECL535 ###############################################################
################################################################################################################

etudiantstotaux <- unique(c(as.character(Pop_ECL535$etudiant1),as.character(Pop_ECL535$etudiant2)))
matrix_collabo <- matrix(data =rep(NA, times=1764), nrow=length(etudiantstotaux),ncol=length(etudiantstotaux))
colnames(matrix_collabo) <- etudiantstotaux
rownames(matrix_collabo) <- etudiantstotaux

for (i in 1:ncol(matrix_collabo)){
  nom1 <- colnames(matrix_collabo)[i]
  collaborateurs <- subset(Pop_ECL535, etudiant1== nom1)$etudiant2
  for (j in 1:nrow(matrix_collabo)){
    print(j)
    if (rownames(matrix_collabo)[j]%in%collaborateurs){
      matrix_collabo[j,i] <- 1
      print('TRUE')
    }else{
      matrix_collabo[j,i] <- 0 
      print('FALSE')
    }
  }
}

#################### VISUALISATION
ECL535 <- graph.adjacency(matrix_collabo)
plot(ECL535, layout=layout_nicely, vertex.label.color = 'black', 
     edge.arrow.mode = 0, vertex.frame.color = NA, 
     vertex.size = 7, edge.width = 0.2,
     main='ECL535')
     

################################################################################################################
####################### 2.3.13 POPULATION ECL611 ###############################################################
################################################################################################################

etudiantstotaux <- unique(c(as.character(Pop_ECL611$etudiant1),as.character(Pop_ECL611$etudiant2)))
matrix_collabo <- matrix(data =rep(NA, times=1764), nrow=length(etudiantstotaux),ncol=length(etudiantstotaux))
colnames(matrix_collabo) <- etudiantstotaux
rownames(matrix_collabo) <- etudiantstotaux

for (i in 1:ncol(matrix_collabo)){
  nom1 <- colnames(matrix_collabo)[i]
  collaborateurs <- subset(Pop_ECL611, etudiant1== nom1)$etudiant2
  for (j in 1:nrow(matrix_collabo)){
    print(j)
    if (rownames(matrix_collabo)[j]%in%collaborateurs){
      matrix_collabo[j,i] <- 1
      print('TRUE')
    }else{
      matrix_collabo[j,i] <- 0 
      print('FALSE')
    }
  }
}

#################### VISUALISATION
ECL611 <- graph.adjacency(matrix_collabo)
plot(ECL611, layout=layout_nicely, vertex.label.color = 'black', 
     edge.arrow.mode = 0, vertex.frame.color = NA, 
     vertex.size = 7, edge.width = 0.2,
     main='ECL611')

            
################################################################################################################
####################### 2.3.14 POPULATION ENT102 ###############################################################
################################################################################################################

etudiantstotaux <- unique(c(as.character(Pop_ENT102$etudiant1),as.character(Pop_ENT102$etudiant2)))
matrix_collabo <- matrix(data =rep(NA, times=1764), nrow=length(etudiantstotaux),ncol=length(etudiantstotaux))
colnames(matrix_collabo) <- etudiantstotaux
rownames(matrix_collabo) <- etudiantstotaux

for (i in 1:ncol(matrix_collabo)){
  nom1 <- colnames(matrix_collabo)[i]
  collaborateurs <- subset(Pop_ENT102, etudiant1== nom1)$etudiant2
  for (j in 1:nrow(matrix_collabo)){
    print(j)
    if (rownames(matrix_collabo)[j]%in%collaborateurs){
      matrix_collabo[j,i] <- 1
      print('TRUE')
    }else{
      matrix_collabo[j,i] <- 0 
      print('FALSE')
    }
  }
}

#################### VISUALISATION
ENT102 <- graph.adjacency(matrix_collabo)
plot(ENT102, layout=layout_nicely, vertex.label.color = 'black', 
     edge.arrow.mode = 0, vertex.frame.color = NA, 
     vertex.size = 7, edge.width = 0.2,
     main='ENT102')

            
################################################################################################################
####################### 2.3.15 POPULATION INS154 ###############################################################
################################################################################################################

etudiantstotaux <- unique(c(as.character(Pop_INS154$etudiant1),as.character(Pop_INS154$etudiant2)))
matrix_collabo <- matrix(data =rep(NA, times=1764), nrow=length(etudiantstotaux),ncol=length(etudiantstotaux))
colnames(matrix_collabo) <- etudiantstotaux
rownames(matrix_collabo) <- etudiantstotaux

for (i in 1:ncol(matrix_collabo)){
  nom1 <- colnames(matrix_collabo)[i]
  collaborateurs <- subset(Pop_INS154, etudiant1== nom1)$etudiant2
  for (j in 1:nrow(matrix_collabo)){
    print(j)
    if (rownames(matrix_collabo)[j]%in%collaborateurs){
      matrix_collabo[j,i] <- 1
      print('TRUE')
    }else{
      matrix_collabo[j,i] <- 0 
      print('FALSE')
    }
  }
}

#################### VISUALISATION
INS154 <- graph.adjacency(matrix_collabo)
plot(INS154, layout=layout_nicely, vertex.label.color = 'black', 
     edge.arrow.mode = 0, vertex.frame.color = NA, 
     vertex.size = 7, edge.width = 0.2,
     main='INS154')

            
################################################################################################################
####################### 2.3.16 POPULATION MCB101 ###############################################################
################################################################################################################

etudiantstotaux <- unique(c(as.character(Pop_MCB101$etudiant1),as.character(Pop_MCB101$etudiant2)))
matrix_collabo <- matrix(data =rep(NA, times=1764), nrow=length(etudiantstotaux),ncol=length(etudiantstotaux))
colnames(matrix_collabo) <- etudiantstotaux
rownames(matrix_collabo) <- etudiantstotaux

for (i in 1:ncol(matrix_collabo)){
  nom1 <- colnames(matrix_collabo)[i]
  collaborateurs <- subset(Pop_MCB101, etudiant1== nom1)$etudiant2
  for (j in 1:nrow(matrix_collabo)){
    print(j)
    if (rownames(matrix_collabo)[j]%in%collaborateurs){
      matrix_collabo[j,i] <- 1
      print('TRUE')
    }else{
      matrix_collabo[j,i] <- 0 
      print('FALSE')
    }
  }
}

#################### VISUALISATION
MCB101 <- graph.adjacency(matrix_collabo)
plot(MCB101, layout=layout_nicely, vertex.label.color = 'black', 
     edge.arrow.mode = 0, vertex.frame.color = NA, 
     vertex.size = 7, edge.width = 0.2,
     main='MCB101')

            
################################################################################################################
####################### 2.3.17 POPULATION TSB303 ###############################################################
################################################################################################################

etudiantstotaux <- unique(c(as.character(Pop_TSB303$etudiant1),as.character(Pop_TSB303$etudiant2)))
matrix_collabo <- matrix(data =rep(NA, times=1764), nrow=length(etudiantstotaux),ncol=length(etudiantstotaux))
colnames(matrix_collabo) <- etudiantstotaux
rownames(matrix_collabo) <- etudiantstotaux

for (i in 1:ncol(matrix_collabo)){
  nom1 <- colnames(matrix_collabo)[i]
  collaborateurs <- subset(Pop_TSB303, etudiant1== nom1)$etudiant2
  for (j in 1:nrow(matrix_collabo)){
    print(j)
    if (rownames(matrix_collabo)[j]%in%collaborateurs){
      matrix_collabo[j,i] <- 1
      print('TRUE')
    }else{
      matrix_collabo[j,i] <- 0 
      print('FALSE')
    }
  }
}

#################### VISUALISATION
TSB303 <- graph.adjacency(matrix_collabo)
plot(TSB303, layout=layout_nicely, vertex.label.color = 'black', 
     edge.arrow.mode = 0, vertex.frame.color = NA, 
     vertex.size = 7, edge.width = 0.2,
     main='TSB303')

            
################################################################################################################
####################### 2.3.18 POPULATION ZOO105 ###############################################################
################################################################################################################

etudiantstotaux <- unique(c(as.character(Pop_ZOO105$etudiant1),as.character(Pop_ZOO105$etudiant2)))
matrix_collabo <- matrix(data =rep(NA, times=1764), nrow=length(etudiantstotaux),ncol=length(etudiantstotaux))
colnames(matrix_collabo) <- etudiantstotaux
rownames(matrix_collabo) <- etudiantstotaux

for (i in 1:ncol(matrix_collabo)){
  nom1 <- colnames(matrix_collabo)[i]
  collaborateurs <- subset(Pop_ZOO105, etudiant1== nom1)$etudiant2
  for (j in 1:nrow(matrix_collabo)){
    print(j)
    if (rownames(matrix_collabo)[j]%in%collaborateurs){
      matrix_collabo[j,i] <- 1
      print('TRUE')
    }else{
      matrix_collabo[j,i] <- 0 
      print('FALSE')
    }
  }
}

#################### VISUALISATION
ZOO105 <- graph.adjacency(matrix_collabo)
plot(ZOO105, layout=layout_nicely, vertex.label.color = 'black', 
     edge.arrow.mode = 0, vertex.frame.color = NA, 
     vertex.size = 7, edge.width = 0.2,
     main='ZOO105')

            
################################################################################################################
####################### 2.3.19 POPULATION ZOO306 ###############################################################
################################################################################################################

etudiantstotaux <- unique(c(as.character(Pop_ZOO306$etudiant1),as.character(Pop_ZOO306$etudiant2)))
matrix_collabo <- matrix(data =rep(NA, times=1764), nrow=length(etudiantstotaux),ncol=length(etudiantstotaux))
colnames(matrix_collabo) <- etudiantstotaux
rownames(matrix_collabo) <- etudiantstotaux

for (i in 1:ncol(matrix_collabo)){
  nom1 <- colnames(matrix_collabo)[i]
  collaborateurs <- subset(Pop_ZOO306, etudiant1== nom1)$etudiant2
  for (j in 1:nrow(matrix_collabo)){
    print(j)
    if (rownames(matrix_collabo)[j]%in%collaborateurs){
      matrix_collabo[j,i] <- 1
      print('TRUE')
    }else{
      matrix_collabo[j,i] <- 0 
      print('FALSE')
    }
  }
}

#################### VISUALISATION
ZOO306 <- graph.adjacency(matrix_collabo)
plot(ZOO306, layout=layout_nicely, vertex.label.color = 'black', 
     edge.arrow.mode = 0, vertex.frame.color = NA, 
     vertex.size = 7, edge.width = 0.2,
     main='ZOO306')

            
################################################################################################################
####################### 2.3.20 POPULATION ECL616 ###############################################################
################################################################################################################

etudiantstotaux <- unique(c(as.character(Pop_ECL616$etudiant1),as.character(Pop_ECL616$etudiant2)))
matrix_collabo <- matrix(data =rep(NA, times=1764), nrow=length(etudiantstotaux),ncol=length(etudiantstotaux))
colnames(matrix_collabo) <- etudiantstotaux
rownames(matrix_collabo) <- etudiantstotaux

for (i in 1:ncol(matrix_collabo)){
  nom1 <- colnames(matrix_collabo)[i]
  collaborateurs <- subset(Pop_ECL616, etudiant1== nom1)$etudiant2
  for (j in 1:nrow(matrix_collabo)){
    print(j)
    if (rownames(matrix_collabo)[j]%in%collaborateurs){
      matrix_collabo[j,i] <- 1
      print('TRUE')
    }else{
      matrix_collabo[j,i] <- 0 
      print('FALSE')
    }
  }
}

#################### VISUALISATION
ECL616 <- graph.adjacency(matrix_collabo)
plot(ECL616, layout=layout_nicely, vertex.label.color = 'black', 
     edge.arrow.mode = 0, vertex.frame.color = NA, 
     vertex.size = 7, edge.width = 0.2,
     main='ECL616')

            
################################################################################################################
####################### 2.3.21 POPULATION ECL603 ###############################################################
################################################################################################################

etudiantstotaux <- unique(c(as.character(Pop_ECL603$etudiant1),as.character(Pop_ECL603$etudiant2)))
matrix_collabo <- matrix(data =rep(NA, times=1764), nrow=length(etudiantstotaux),ncol=length(etudiantstotaux))
colnames(matrix_collabo) <- etudiantstotaux
rownames(matrix_collabo) <- etudiantstotaux

for (i in 1:ncol(matrix_collabo)){
  nom1 <- colnames(matrix_collabo)[i]
  collaborateurs <- subset(Pop_ECL603, etudiant1== nom1)$etudiant2
  for (j in 1:nrow(matrix_collabo)){
    print(j)
    if (rownames(matrix_collabo)[j]%in%collaborateurs){
      matrix_collabo[j,i] <- 1
      print('TRUE')
    }else{
      matrix_collabo[j,i] <- 0 
      print('FALSE')
    }
  }
}

#################### VISUALISATION
ECL603 <- graph.adjacency(matrix_collabo)
plot(ECL603, layout=layout_nicely, vertex.label.color = 'black', 
     edge.arrow.mode = 0, vertex.frame.color = NA, 
     vertex.size = 7, edge.width = 0.2,
     main='ECL603')

            
################################################################################################################
####################### 2.3.22 POPULATION GMQ106 ###############################################################
################################################################################################################

etudiantstotaux <- unique(c(as.character(Pop_GMQ106$etudiant1),as.character(Pop_GMQ106$etudiant2)))
matrix_collabo <- matrix(data =rep(NA, times=1764), nrow=length(etudiantstotaux),ncol=length(etudiantstotaux))
colnames(matrix_collabo) <- etudiantstotaux
rownames(matrix_collabo) <- etudiantstotaux

for (i in 1:ncol(matrix_collabo)){
  nom1 <- colnames(matrix_collabo)[i]
  collaborateurs <- subset(Pop_GMQ106, etudiant1== nom1)$etudiant2
  for (j in 1:nrow(matrix_collabo)){
    print(j)
    if (rownames(matrix_collabo)[j]%in%collaborateurs){
      matrix_collabo[j,i] <- 1
      print('TRUE')
    }else{
      matrix_collabo[j,i] <- 0 
      print('FALSE')
    }
  }
}

#################### VISUALISATION
GMQ106 <- graph.adjacency(matrix_collabo)
plot(GMQ106, layout=layout_nicely, vertex.label.color = 'black', 
     edge.arrow.mode = 0, vertex.frame.color = NA, 
     vertex.size = 7, edge.width = 0.2,
     main='GMQ106')    

            
################################################################################################################
####################### 2.3.23 POPULATION ECL534 ###############################################################
################################################################################################################

etudiantstotaux <- unique(c(as.character(Pop_ECL534$etudiant1),as.character(Pop_ECL534$etudiant2)))
matrix_collabo <- matrix(data =rep(NA, times=1764), nrow=length(etudiantstotaux),ncol=length(etudiantstotaux))
colnames(matrix_collabo) <- etudiantstotaux
rownames(matrix_collabo) <- etudiantstotaux

for (i in 1:ncol(matrix_collabo)){
  nom1 <- colnames(matrix_collabo)[i]
  collaborateurs <- subset(Pop_ECL534, etudiant1== nom1)$etudiant2
  for (j in 1:nrow(matrix_collabo)){
    print(j)
    if (rownames(matrix_collabo)[j]%in%collaborateurs){
      matrix_collabo[j,i] <- 1
      print('TRUE')
    }else{
      matrix_collabo[j,i] <- 0 
      print('FALSE')
    }
  }
}

#################### VISUALISATION
ECL534 <- graph.adjacency(matrix_collabo)
plot(ECL534, layout=layout_nicely, vertex.label.color = 'black', 
     edge.arrow.mode = 0, vertex.frame.color = NA, 
     vertex.size = 7, edge.width = 0.2,
     main='ECL534')        
     
            
################################################################################################################
####################### 2.3.24 POPULATION GBI104 ###############################################################
################################################################################################################

etudiantstotaux <- unique(c(as.character(Pop_GBI104$etudiant1),as.character(Pop_GBI104$etudiant2)))
matrix_collabo <- matrix(data =rep(NA, times=1764), nrow=length(etudiantstotaux),ncol=length(etudiantstotaux))
colnames(matrix_collabo) <- etudiantstotaux
rownames(matrix_collabo) <- etudiantstotaux

for (i in 1:ncol(matrix_collabo)){
  nom1 <- colnames(matrix_collabo)[i]
  collaborateurs <- subset(Pop_GBI104, etudiant1== nom1)$etudiant2
  for (j in 1:nrow(matrix_collabo)){
    print(j)
    if (rownames(matrix_collabo)[j]%in%collaborateurs){
      matrix_collabo[j,i] <- 1
      print('TRUE')
    }else{
      matrix_collabo[j,i] <- 0 
      print('FALSE')
    }
  }
}

#################### VISUALISATION
GBI104 <- graph.adjacency(matrix_collabo)
plot(GBI104, layout=layout_nicely, vertex.label.color = 'black', 
     edge.arrow.mode = 0, vertex.frame.color = NA, 
     vertex.size = 7, edge.width = 0.2,
     main='GBI104')

            
################################################################################################################
####################### 2.3.25 POPULATION INS154 ###############################################################
################################################################################################################

etudiantstotaux <- unique(c(as.character(Pop_INS154$etudiant1),as.character(Pop_INS154$etudiant2)))
matrix_collabo <- matrix(data =rep(NA, times=1764), nrow=length(etudiantstotaux),ncol=length(etudiantstotaux))
colnames(matrix_collabo) <- etudiantstotaux
rownames(matrix_collabo) <- etudiantstotaux

for (i in 1:ncol(matrix_collabo)){
  nom1 <- colnames(matrix_collabo)[i]
  collaborateurs <- subset(Pop_INS154, etudiant1== nom1)$etudiant2
  for (j in 1:nrow(matrix_collabo)){
    print(j)
    if (rownames(matrix_collabo)[j]%in%collaborateurs){
      matrix_collabo[j,i] <- 1
      print('TRUE')
    }else{
      matrix_collabo[j,i] <- 0 
      print('FALSE')
    }
  }
}

#################### VISUALISATION
INS154 <- graph.adjacency(matrix_collabo)
plot(INS154, layout=layout_nicely, vertex.label.color = 'black', 
     edge.arrow.mode = 0, vertex.frame.color = NA, 
     vertex.size = 7, edge.width = 0.2,
     main='INS154')       
     
            
################################################################################################################
####################### 2.3.26 POPULATION ZOO307 ###############################################################
################################################################################################################

etudiantstotaux <- unique(c(as.character(Pop_ZOO307$etudiant1),as.character(Pop_ZOO307$etudiant2)))
matrix_collabo <- matrix(data =rep(NA, times=1764), nrow=length(etudiantstotaux),ncol=length(etudiantstotaux))
colnames(matrix_collabo) <- etudiantstotaux
rownames(matrix_collabo) <- etudiantstotaux

for (i in 1:ncol(matrix_collabo)){
  nom1 <- colnames(matrix_collabo)[i]
  collaborateurs <- subset(Pop_ZOO307, etudiant1== nom1)$etudiant2
  for (j in 1:nrow(matrix_collabo)){
    print(j)
    if (rownames(matrix_collabo)[j]%in%collaborateurs){
      matrix_collabo[j,i] <- 1
      print('TRUE')
    }else{
      matrix_collabo[j,i] <- 0 
      print('FALSE')
    }
  }
}

#################### VISUALISATION
ZOO307 <- graph.adjacency(matrix_collabo)
plot(ZOO307, layout=layout_nicely, vertex.label.color = 'black', 
     edge.arrow.mode = 0, vertex.frame.color = NA, 
     vertex.size = 7, edge.width = 0.2,
     main='ZOO307')

            
################################################################################################################
####################### 2.3.27 POPULATION BCM104 ###############################################################
################################################################################################################

etudiantstotaux <- unique(c(as.character(Pop_BCM104$etudiant1),as.character(Pop_BCM104$etudiant2)))
matrix_collabo <- matrix(data =rep(NA, times=1764), nrow=length(etudiantstotaux),ncol=length(etudiantstotaux))
colnames(matrix_collabo) <- etudiantstotaux
rownames(matrix_collabo) <- etudiantstotaux

for (i in 1:ncol(matrix_collabo)){
  nom1 <- colnames(matrix_collabo)[i]
  collaborateurs <- subset(Pop_BCM104, etudiant1== nom1)$etudiant2
  for (j in 1:nrow(matrix_collabo)){
    print(j)
    if (rownames(matrix_collabo)[j]%in%collaborateurs){
      matrix_collabo[j,i] <- 1
      print('TRUE')
    }else{
      matrix_collabo[j,i] <- 0 
      print('FALSE')
    }
  }
}

#################### VISUALISATION
BCM104 <- graph.adjacency(matrix_collabo)
plot(BCM104, layout=layout_nicely, vertex.label.color = 'black', 
     edge.arrow.mode = 0, vertex.frame.color = NA, 
     vertex.size = 7, edge.width = 0.2,
     main='BCM104')
     
            
################################################################################################################
####################### 2.3.28 POPULATION ECL522 ###############################################################
################################################################################################################

etudiantstotaux <- unique(c(as.character(Pop_ECL522$etudiant1),as.character(Pop_ECL522$etudiant2)))
matrix_collabo <- matrix(data =rep(NA, times=1764), nrow=length(etudiantstotaux),ncol=length(etudiantstotaux))
colnames(matrix_collabo) <- etudiantstotaux
rownames(matrix_collabo) <- etudiantstotaux

for (i in 1:ncol(matrix_collabo)){
  nom1 <- colnames(matrix_collabo)[i]
  collaborateurs <- subset(Pop_ECL522, etudiant1== nom1)$etudiant2
  for (j in 1:nrow(matrix_collabo)){
    print(j)
    if (rownames(matrix_collabo)[j]%in%collaborateurs){
      matrix_collabo[j,i] <- 1
      print('TRUE')
    }else{
      matrix_collabo[j,i] <- 0 
      print('FALSE')
    }
  }
}

#################### VISUALISATION
ECL522 <- graph.adjacency(matrix_collabo)
plot(ECL522, layout=layout_nicely, vertex.label.color = 'black', 
     edge.arrow.mode = 0, vertex.frame.color = NA, 
     vertex.size = 7, edge.width = 0.2,
     main='ECL522')
     
            
################################################################################################################
####################### 2.3.29 POPULATION ECL510 ###############################################################
################################################################################################################

etudiantstotaux <- unique(c(as.character(Pop_ECL510$etudiant1),as.character(Pop_ECL510$etudiant2)))
matrix_collabo <- matrix(data =rep(NA, times=1764), nrow=length(etudiantstotaux),ncol=length(etudiantstotaux))
colnames(matrix_collabo) <- etudiantstotaux
rownames(matrix_collabo) <- etudiantstotaux

for (i in 1:ncol(matrix_collabo)){
  nom1 <- colnames(matrix_collabo)[i]
  collaborateurs <- subset(Pop_ECL510, etudiant1== nom1)$etudiant2
  for (j in 1:nrow(matrix_collabo)){
    print(j)
    if (rownames(matrix_collabo)[j]%in%collaborateurs){
      matrix_collabo[j,i] <- 1
      print('TRUE')
    }else{
      matrix_collabo[j,i] <- 0 
      print('FALSE')
    }
  }
}

#################### VISUALISATION
ECL510 <- graph.adjacency(matrix_collabo)
plot(ECL510, layout=layout_nicely, vertex.label.color = 'black', 
     edge.arrow.mode = 0, vertex.frame.color = NA, 
     vertex.size = 7, edge.width = 0.2,
     main='ECL510')    

            
################################################################################################################
####################### 2.3.30 POPULATION CHM319 ###############################################################
################################################################################################################

etudiantstotaux <- unique(c(as.character(Pop_CHM319$etudiant1),as.character(Pop_CHM319$etudiant2)))
matrix_collabo <- matrix(data =rep(NA, times=1764), nrow=length(etudiantstotaux),ncol=length(etudiantstotaux))
colnames(matrix_collabo) <- etudiantstotaux
rownames(matrix_collabo) <- etudiantstotaux

for (i in 1:ncol(matrix_collabo)){
  nom1 <- colnames(matrix_collabo)[i]
  collaborateurs <- subset(Pop_CHM319, etudiant1== nom1)$etudiant2
  for (j in 1:nrow(matrix_collabo)){
    print(j)
    if (rownames(matrix_collabo)[j]%in%collaborateurs){
      matrix_collabo[j,i] <- 1
      print('TRUE')
    }else{
      matrix_collabo[j,i] <- 0 
      print('FALSE')
    }
  }
}

#################### VISUALISATION
CHM319 <- graph.adjacency(matrix_collabo)
plot(CHM319, layout=layout_nicely, vertex.label.color = 'black', 
     edge.arrow.mode = 0, vertex.frame.color = NA, 
     vertex.size = 7, edge.width = 0.2,
     main='CHM319')
     
            
################################################################################################################
####################### 2.3.31 POPULATION ECL301 ###############################################################
################################################################################################################

etudiantstotaux <- unique(c(as.character(Pop_ECL301$etudiant1),as.character(Pop_ECL301$etudiant2)))
matrix_collabo <- matrix(data =rep(NA, times=1764), nrow=length(etudiantstotaux),ncol=length(etudiantstotaux))
colnames(matrix_collabo) <- etudiantstotaux
rownames(matrix_collabo) <- etudiantstotaux

for (i in 1:ncol(matrix_collabo)){
  nom1 <- colnames(matrix_collabo)[i]
  collaborateurs <- subset(Pop_ECL301, etudiant1== nom1)$etudiant2
  for (j in 1:nrow(matrix_collabo)){
    print(j)
    if (rownames(matrix_collabo)[j]%in%collaborateurs){
      matrix_collabo[j,i] <- 1
      print('TRUE')
    }else{
      matrix_collabo[j,i] <- 0 
      print('FALSE')
    }
  }
}

#################### VISUALISATION
ECL301 <- graph.adjacency(matrix_collabo)
plot(ECL301, layout=layout_nicely, vertex.label.color = 'black', 
     edge.arrow.mode = 0, vertex.frame.color = NA, 
     vertex.size = 7, edge.width = 0.2,
     main='ECL301')



################################################################################################################
####################### 3. CALCUL DES VALEURS SUIVANT POISOT ###################################################
################################################################################################################

### Variables: M = realisation membership, B() = dissimilarite de ...,
## a = nb d'interactions qui sont dans A et dans B.
## b = nb d'interactions qui sont dans B, mais pas dans A.
## c = nb d'interactions qui sont dans A, mais pas dans B.
##  B(M) = [(a+b+c)/((2a+b+c)/2)]-1

library('dplyr')
library('stringr')

#Faire un vecteur contenant tous le nom des cours pour eviter de devoir les ecrire manuellement
enviro <- sort(ls())
enviro.list <- mget(enviro)
Pop.cours <- enviro.list[which(str_detect(names(enviro.list),'Pop_')==TRUE)]
Sigles <- sort(as.character(unique(bd_cours[,1])))

output <- matrix(nrow=length(Sigles), ncol=length(Sigles),dimnames=list(Sigles, Sigles))
for (i in 1:30){
  A <- Pop.cours[[i]]
  for (j in 1:30){
    B <- Pop.cours[[j]]
    c <- nrow(anti_join(A,B))
    b <- nrow(anti_join(B,A))
    a <- nrow(semi_join(A,B))
    Diss.Whittaker <- ((a+b+c)/(((2*a)+b+c)/2))-1
    print(Diss.Whittaker)
    output[j,i] <- Diss.Whittaker
  }
}
Matrice.Whittaker <- output


################################################################################################################
################################ 3.1 VISUALISATION #############################################################
################################################################################################################
install.packages("plot.matrix")
library(plot.matrix)

par(mar=c(5.1, 4.1, 5.1, 4.1))   # adapt margins
plot(Matrice.Whittaker,
     digits=2, text.cell=list(cex=0.5),
     axis.col=list(side=1, cex.axis=0.7,las=2),
     axis.row=list(side=2, cex.axis=0.7,las=2),
     ylab="",xlab="", main="Matrice de la dissimilarité entre chaque cours")
            


################################################################################################################
############################################################################
dbDisconnect(con)
####################################### FIN ###########################################


# NÉCESSAIRE CE QUI SUIT ?? 
# Si oui, faut garder la requete des cours (qui été supprimé)

#Diss.mean <- data.frame(Diss=rep(NA,30),cours=Sigles,nb_etudiants = resume_cours$nb_etudiants)
#for (i in 1:30){
#  Diss.mean[i,1] <- mean(Matrice.Whittaker[i,])
#}

#plot(Diss.mean$Diss~Diss.mean$nb_etudiants, main='Valeur de dissimilaritée de Whittaker',
#     xlab='Nombre d étudiants dans le cours', 
#     ylab= 'Dissimilaritée moyenne par rapport aux autres cours')
#abline(lm(Diss.mean$Diss~Diss.mean$nb_etudiants),col='red')
#with(Diss.mean, text(Diss~nb_etudiants, labels = cours, cex=0.5,pos = 2))
#dev.off()

#hist(D.mean$D) # pas vraiment distribuée normalement
#summary(lm(Diss.mean$Diss~Diss.mean$nb_etudiants))




