##############################################################################################
############################### CONNEXION SQL ##################################################
##############################################################################################

#Changer de répertoire selon où sont les données
#wd <- "C:/Users/Jo-Han'ny/Documents/Université/BIO500 - Méthode comput"
#setwd(wd)

#install.packages('RSQLite')
library(RSQLite)

con<-dbConnect(SQLite(),dbname="bd_reseau")

#############################################################################################
############################## CREATION DE LA BASE DE DONNEES ##################################
#############################################################################################

tbl_noms<-'
CREATE TABLE noms (
nom_prenom VARCHAR(50),
annee_debut DATE(4),
session_debut CHAR(1),
programme VARCHAR(20),
coop BOOLEAN(1),
PRIMARY KEY (nom_prenom)
);'

dbSendQuery(con, tbl_noms)

tbl_collaborations <-"
CREATE TABLE collaborations (
etudiant1 VARCHAR(50),
etudiant2 VARCHAR(50),
cours CHAR(6),
date DATE(4),
PRIMARY KEY (etudiant1,etudiant2,cours),
FOREIGN KEY (etudiant1) REFERENCES noms(nom_prenom),
FOREIGN KEY (etudiant2) REFERENCES noms(nom_prenom),
FOREIGN KEY (cours) REFERENCES cours(sigle)
);"

#V?rifier si on peut faire une cl? entre cours (tbl_collaborations) et sigle (tbl_cours)
dbSendQuery(con, tbl_collaborations)

#Nous avons retirer l'information pour la colonne travail car, il y avait trop de NA
tbl_cours<-"
CREATE TABLE cours (
sigle CHAR(6),
credits INTEGER(1),
travail CHAR(8),
type CHAR(8),
obligatoire BOOLEAN(1),
PRIMARY KEY (sigle),
FOREIGN KEY (sigle) REFERENCES collaborations(cours)
);"

dbSendQuery(con, tbl_cours)


############################################################################
dbDisconnect(con)
####################################### FIN ###########################################