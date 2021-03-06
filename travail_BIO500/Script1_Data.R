###############################################################################################################
#                                                                                                             #
#   STANDARDISATION DES DONNEES                                                                               #     
#                                                                                                             # 
#   par Marika Caouette, Zachary Cloutier, Emma Couture, Joannie Gagnon, Marie Jacques et Marianne Mallette   #  
#                                                                                                             #  
###############################################################################################################

setwd('/cloud/project/travail_BIO500/rawdata') #Ce repertoire est un rstudiocloud accessible (? à tester)

# Vérifie si les packages requis sont installés, s'ils ne le sont pas, les installe et les charges dans la librarie.
if (!require("stringr")) install.packages("stringr"); library("stringr") # utilisé pour repèrer des mots/noms dans la base de données
if (!require("dplyr")) install.packages("dplyr"); library("dplyr")                    # pour la synthaxe
if (!require("plot.matrix")) install.packages("plot.matrix"); library("plot.matrix")  # pour la figure de matrice de dissimilarité



###################################################################################################
#######   1. COURS      ###########################################################################
###################################################################################################
###################################################################################################
###################   1.1 IMPORTATION   ###########################################################
###################################################################################################

Data.list.cours = list() # Creation de l'objet (une liste vide) qui entreposera les donnees 
        
{Data.list.cours[[1]] = read.csv("cours_Ax_Et_Jo_Va.csv", sep=';')
Data.list.cours[[2]] = read.csv("cours_beteille.csv", sep=';')
Data.list.cours[[3]] = read.csv("cours_gagnon.csv", sep=';')
Data.list.cours[[4]] = read.csv("cours_GT_AD_RB_ETC_KC.csv", sep=';')
Data.list.cours[[5]] = read.csv("cours_LP_TM_SPT_ELC_VM.csv")
Data.list.cours[[6]] = read.csv("cours_payette.csv")
Data.list.cours[[7]] = read.csv("cours_Thiffault.csv", sep=';')}

# nous pouvons regarder les donnees avec la fonction edit ou head
# edit(Data.list.cours[[1]])
# head(Data.list.cours[[1]])

###################################################################################################
####################   1.2 Uniformisation des noms des colonnes   #################################
###################################################################################################

# Rapport: apres observation des donnees je vois que tous les fichiers contiennent:
# Le Sigle
# Le nb de credit
# Le type de travail
# optionnel ou non
# Mais seulement quelque uns ont mis 'session', 'cours' et 'travail'


for (i in 1:length(Data.list.cours)){
  # Pour s'assurer qu'il n'y a pas d'accent, d'espaces, de charactères superflux.
  colnames(Data.list.cours[[i]])[str_which(colnames(Data.list.cours[[i]]),"sigle")] <- 'sigle' # si erreur
  colnames(Data.list.cours[[i]])[str_which(colnames(Data.list.cours[[i]]),"dit")] <- 'credit' #Pour retirer l'accent
  colnames(Data.list.cours[[i]])[str_which(colnames(Data.list.cours[[i]]),"type")] <- 'type' 
  colnames(Data.list.cours[[i]])[str_which(colnames(Data.list.cours[[i]]),"obl")] <- 'obligatoire'  #Pour les erreurs de frappe
  
  #Pour uniformiser l'ordre des colonnes
  Data.list.cours[[i]] <- data.frame(sigle=as.character(Data.list.cours[[i]][,'sigle']),
                                     credits=as.numeric(Data.list.cours[[i]][,'credit']),
                                     type=as.character(Data.list.cours[[i]][,'type']),
                                     obligatoire=as.numeric(Data.list.cours[[i]][,'obligatoire']))
}


#######################################################################################################
#####################   1.3 Uniformisation du type OBLIGATOIRE   ######################################
#######################################################################################################
#Certaine personne n'ont pas utiliser des 0 et des 1, mais plutôt des mots comme obl. ou obligatoire
for (i in 1:7){
  print(i) # un compteur
  Data <- Data.list.cours[[i]]
  Vecteur <- rep(NA,nrow(Data))
  # Dans le fond je cree un output puis je remplace la colonne plus tard
  Vecteur[str_which(Data$obligatoire, 'obl')] <- 1 
  Vecteur[str_which(Data$obligatoire, '1')] <- 1
  Vecteur[str_which(Data$obligatoire, 'opt')] <- 0
  Vecteur[str_which(Data$obligatoire, '0')] <- 0
  #Ici je remplace la colonne de characteres par celle numerique 
  Data.list.cours[[i]]$obligatoire <- as.factor(Vecteur)
}


#######################################################################################################
#####################   1.4 Unifromisation du type TRAVAIL    #########################################
#######################################################################################################

for (i in 1:7){
  print(i) # un compteur
  Data <- Data.list.cours[[i]]
  Vecteur <- rep(NA,nrow(Data))
  # creation d'un output puis je remplace la colonne plus tard
  Vecteur[str_which(Data$type, 'labo/oral')] <- 'laboratoire_oral'
  Vecteur[str_which(Data$type, 'ecrit (oral)')] <- 'ecrit_oral'
  Vecteur[str_which(Data$type, 'ecrit/oral')] <- 'ecrit_oral'
  Vecteur[str_which(Data$type, 'labo')] <- 'laboratoire'
  Vecteur[str_which(Data$type, 'labos')] <- 'laboratoire'
  Vecteur[str_which(Data$type, 'crit')] <- 'ecrit'
  Vecteur[str_which(Data$type, 'laboratoire')] <- 'laboratoire'
  Vecteur[str_which(Data$type, 'terrain')] <- 'terrain'
  Vecteur[str_which(Data$type, 'oral')] <-'oral'
  
  Data.list.cours[[i]]$type <- as.character(Vecteur)
}

#######################################################################################################
#####################   1.5 Mise en commun   ##########################################################
#######################################################################################################
#la fonction distinct permet de ne garder que les ranges qui sont unique et bind_rows permet de créer 
# UN dataframe avec tous les éléments d'une liste.
Data_cours <- distinct(bind_rows(Data.list.cours))

###################################################################################################
######################### 1.6 Nettoyage ###########################################################
###################################################################################################

# les noeuds devant etre uniques, il ne doit y avoir qu'un seul travail par cours
#Enlever les erreurs de cours et/ou les doublons 
#Apres verification, enlever les cours BOT512 et ZOO106 (puisqu'ils ne sont pas dans les collaborations)
#Et les cours ECL608 et ISN154 car aucun travail d'équipe n'a été fait dans ces cours.

# Ce petit tableau pourrait vous permettre d'observer les lignes que nous désirons garder :
#Correction_cours <- data.frame(sigle=c('ECL403','ECL406','ECL515','ECL516','ECL527','ECL611','ISN154','ZOO105','ECL616','ECL603','GMQ106','ECL510','ECL522'),
                                  #type=c('ecrit','ecrit','oral','ecrit','oral','ecrit','oral','oral','ecrit','ecrit','ecrit','oral','ecrit'),
                               #credits=c(1,1,2,3,2,1,3,1,3,1,3,3,3),
                               #obligatoire=c(1,1,1,1,1,1,0,1,1,0,0,1,0))
# Retrait des lignes problématiques
Data_cours <- Data_cours[-c(9,12,40,41,46,27,29,43,36,34,39,38, 42, 24, 31, 28, 47:49),]
#Nous voulons retenir les cours qui sont dans notre table COURS dans un vecteur en ordre alphabetique
Sigles <- sort(unique(Data_cours$sigle))

#C'est avec cette fonction que nous avons detecter les doublons et choisi ceux que nous voulions garder/enlever
# Faite cette operation jusqu'a ce qu'aucune lignes ne soit renvoyee
# for (i in 1:30){
   #output = subset(Data_cours,sigle==Sigles[i])
   #if (nrow(output)>1){
     #print(output)
      #Data_cours <- subset(Data_cours,sigle!=Sigles[i])
  # }else{
  #}
 #}
#Data_cours <- rbind(Data_cours,Correction_cours)


## On choisi d'enlever BOT512 et ZOO106 parce que selon nos connaissances, ces cours ne contenaient pas de travaux d'equipe ou c'était facultatif d'être en équipe
# Data_cours = subset(Data_cours, sigle !='BOT512')# A changer pour le nom du data.frame de ce fichier relier aux collabos
# Data_cours = subset(Data_cours, sigle !='ZOO106')
# Data_cours = subset(Data_cours, sigle !='ECL315')
# Data_cours = subset(Data_cours, sigle !='ECL608') #celui là n'est pas dans notre db de cours!?

# On ordone le data.frame en fonction du nom des cours
Data_cours <- Data_cours[order(Data_cours$sigle),]


################################################################################################################
#########   2. COLLABORATION   #################################################################################
################################################################################################################
################################################################################################################
###################   2.1 IMPORTATION   ########################################################################
################################################################################################################


Data.list.collabo <-list() # creer une liste vide
Data.list.collabo[[1]] <- read.csv("collaborations_Ax_Et_Jo_Va.csv" , sep=';', fileEncoding="latin1")
Data.list.collabo[[2]] <- read.csv("collaborations_beteille.csv" , sep=';',fileEncoding="latin1")
Data.list.collabo[[3]] <- read.csv('collaborations_gagnon.csv', sep=';',fileEncoding="latin1")
Data.list.collabo[[4]] <- read.csv("collaborations_GT_KAC_ETC_AD_RB.csv" , sep=';',fileEncoding="latin1")
Data.list.collabo[[5]] <- read.csv("collaborations_LP_TM_SPT_ELC_VM.csv" ,fileEncoding="latin1")
Data.list.collabo[[6]] <- read.csv("collaborations_payette.csv" ,fileEncoding="latin1")
Data.list.collabo[[7]] <- read.csv("collaborations_Thiffault.csv" , sep=';',fileEncoding="latin1")

# nous pouvons regarder les donnees avec la fonction edit ou head
# edit(Data.list.collabo[[1]])
# head(Data.list.collabo[[1]])

######################################################################################################
####################   2.2 Uniformisation des nom des colonnes   #####################################
######################################################################################################

# 4 colonnes sont necessaires dans ce DB: cours, etudiant1, etudiant2 et date
for (i in 1:length(Data.list.collabo)){
  print(i) # simplement un compteur
  colnames(Data.list.collabo[[i]])[str_which(colnames(Data.list.collabo[[i]]),'cours')] <- 'cours'
  
  colnames(Data.list.collabo[[i]])[str_which(colnames(Data.list.collabo[[i]]),'date')] <- 'date'
  colnames(Data.list.collabo[[i]])[str_which(colnames(Data.list.collabo[[i]]),'annee')] <- 'date'
  
  etudiant <- colnames(Data.list.collabo[[i]])[str_which(colnames(Data.list.collabo[[i]]),'udiant')]
  
  # Certaine manip furent necessaire car il y avait des coquilles dans le début des colonne 'etudiant' 
  # Ici on vérifie si la colonne etudiant1 se trouve en premier dans les colonne vis à vis d'etudiant2
  if(str_sub(etudiant[1],-9) < str_sub(etudiant[2],-9)){ # Parfois les noms de colonnes commençaient par de drôle de symboles
    colnames(Data.list.collabo[[i]])[str_which(colnames(Data.list.collabo[[i]]),'udiant')] <- c('etudiant1','etudiant2')
  }else{
    colnames(Data.list.collabo[[i]])[str_which(colnames(Data.list.collabo[[i]]),'udiant')] <- c('etudiant2','etudiant1')
  }
  Data.list.collabo[[i]] <- data.frame(etudiant1=Data.list.collabo[[i]][,'etudiant1'],etudiant2=Data.list.collabo[[i]][,'etudiant2'],
                                       cours=Data.list.collabo[[i]][,'cours'],date=Data.list.collabo[[i]][,'date'])
  print(colnames(Data.list.collabo[[i]]))
}

#######################################################################################################
#####################   2.3 Mise en commun   ##########################################################
#######################################################################################################

Data_collabo = distinct(bind_rows(Data.list.collabo))


######################################################################################################
####################   2.4 CORRECTIONS DES ERREURS DANS LES SIGLES   #################################
######################################################################################################

# À faire jusqu'à ce que plus rien ne soit afficher
#for (i in 1:nrow(Data_collabo)){
  #if ((Data_collabo[,3]%in%Sigles)[i]==FALSE){ # Nous donne tous les sigles qui ne sont pas présent dans notre table cours
    #print(Data_collabo[i,3])
    #print(i) #un compteur
  #}
#}

Data_collabo[str_which(Data_collabo[,3], 'TSB300'),3] = 'TSB303'
Data_collabo[str_which(Data_collabo[,3], 'ECL603\n'),3] = 'ECL603'
Data_collabo[str_which(Data_collabo[,3], 'ELC527'),3] = 'ECL527'
Data_collabo[str_which(Data_collabo[,3], 'ZOO105\n'),3] = 'ZOO105'
Data_collabo[str_which(Data_collabo[,3], 'ZOO106\n'),3] = 'ZOO106'
Data_collabo[str_which(Data_collabo[,3], 'ZOO307\n'),3] = 'ZOO307'
Data_collabo[str_which(Data_collabo[,3], 'ECL 527'),3] = 'ECL527'
Data_collabo[str_which(Data_collabo[,3], 'BOT 400'),3] = 'BOT400'

Data_collabo = Data_collabo[1:2393,] # la fin contient de NAs

## On choisi d'enlever BOT512 et ZOO106 parce que selon nos connaissances, ces cours ne contenaient pas de travaux d'equipe ou c'était facultatif d'être en équipe
Data_collabo = subset(Data_collabo, cours !='BOT512')# A changer pour le nom du data.frame de ce fichier relier aux collabos
Data_collabo = subset(Data_collabo, cours !='ZOO106')
Data_collabo = subset(Data_collabo, cours !='ECL315')
Data_collabo = subset(Data_collabo, cours !='ECL608') #celui là n'est pas dans notre db de cours!?


######################################################################################################
####################   2.5 CORRECTIONS DES ERREURS DANS LES ETUDIANTS    #############################
######################################################################################################

# observation des erreurs liées au nom
#sort(unique(Data_collabo[,1]))

# à vérifier : Noura barro, ariane beaulac, beaupre_raphael, boisvertvignault_erika, alexandre carbonneau,
# desrochers_simon, duschenes_valerie, faurelevesque_julien, gagnon_anthony,frappierlecompte_juliette, mallette_marianne
# gagnon_joannie, hinse_pierandre, lacroixcarigan_etienne, laporte_simon, lariviere_charlotte = tessierlariviere_chalrotte,
#  M_leopold, nault_lauriane, rioux_jennyann, avoiecloutier_kellymaude, sthilaire_pascale, trottier_katiacatherine, villeneuve_clara 

{Data_collabo[which(str_detect(Data_collabo[,1],'barro')),1]='barro_noura'
Data_collabo[which(str_detect(Data_collabo[,2],'barro')),2]='barro_noura'
Data_collabo[which(str_detect(Data_collabo[,1],'beaulac')),1]='beaulac_arianne'
Data_collabo[which(str_detect(Data_collabo[,2],'beaulac')),2]='beaulac_arianne'
Data_collabo[which(str_detect(Data_collabo[,1],'beaupre')),1]='beaupre_raphaeljonathan'
Data_collabo[which(str_detect(Data_collabo[,2],'beaupre')),2]='beaupre_raphaeljonathan'
Data_collabo[which(str_detect(Data_collabo[,1],'boisvert_erika')),1]='boisvertvigneault_erika'
Data_collabo[which(str_detect(Data_collabo[,2],'boisvert_erika')),2]='boisvertvigneault_erika'
Data_collabo[which(str_detect(Data_collabo[,1],'carbonneau')),1]='carbonneau_alexandre'
Data_collabo[which(str_detect(Data_collabo[,2],'carbonneau')),2]='carbonneau_alexandre'
Data_collabo[which(str_detect(Data_collabo[,1],'desroschers')),1]='desrochers_simon'
Data_collabo[which(str_detect(Data_collabo[,2],'desroschers')),2]='desrochers_simon'
Data_collabo[which(str_detect(Data_collabo[,1],'duchenes_valerie')),1]='duchesne_valerie'
Data_collabo[which(str_detect(Data_collabo[,2],'duchenes_valerie')),2]='duchesne_valerie'
Data_collabo[which(str_detect(Data_collabo[,1],'faurelevesque')),1]='faurelevesque_julien'
Data_collabo[which(str_detect(Data_collabo[,2],'faurelevesque')),2]='faurelevesque_julien'
Data_collabo[which(str_detect(Data_collabo[,1],'frappierlecompte')),1]='frappierlecomte_juliette'
Data_collabo[which(str_detect(Data_collabo[,2],'frappierlecompte')),2]='frappierlecomte_juliette'
Data_collabo[which(str_detect(Data_collabo[,1],'gagon')),1]='gagnon_anthony'
Data_collabo[which(str_detect(Data_collabo[,2],'gagon')),2]='gagnon_anthony'
Data_collabo[which(str_detect(Data_collabo[,1],'gagnon_j')),1]='gagnon_joannie'
Data_collabo[which(str_detect(Data_collabo[,2],'gagnon_j')),2]='gagnon_joannie'
Data_collabo[which(str_detect(Data_collabo[,1],'hinse')),1]='hinse_pierandre'
Data_collabo[which(str_detect(Data_collabo[,2],'hinse')),2]='hinse_pierandre'
Data_collabo[which(str_detect(Data_collabo[,1],'lacroixcarigan')),1]='lacroixcarignan_etienne'
Data_collabo[which(str_detect(Data_collabo[,2],'lacroixcarigan')),2]='lacroixcarignan_etienne'
Data_collabo[which(str_detect(Data_collabo[,1],'laporte')),1]='laporte_simon'
Data_collabo[which(str_detect(Data_collabo[,2],'laporte')),2]='laporte_simon'
Data_collabo[which(str_detect(Data_collabo[,1],'lariviere_charlotte')),1]='tessierlariviere_charlotte'
Data_collabo[which(str_detect(Data_collabo[,2],'lariviere_charlotte')),2]='tessierlariviere_charlotte'
Data_collabo[which(str_detect(Data_collabo[,1],'leopold')),1]='martin_leopold'
Data_collabo[which(str_detect(Data_collabo[,2],'leopold')),2]='martin_leopold'
Data_collabo[which(str_detect(Data_collabo[,1],'nault_laurianne')),1]='nault_lauriane'
Data_collabo[which(str_detect(Data_collabo[,2],'nault_laurianne')),2]='nault_lauriane'
Data_collabo[which(str_detect(Data_collabo[,1],'rioux_j')),1]='rioux_jennyann'
Data_collabo[which(str_detect(Data_collabo[,2],'rioux_j')),2]='rioux_jennyann'
Data_collabo[which(str_detect(Data_collabo[,1],'savoiecloutier')),1]='savoiecloutier_kellymaude'
Data_collabo[which(str_detect(Data_collabo[,2],'savoiecloutier')),2]='savoiecloutier_kellymaude'
Data_collabo[which(str_detect(Data_collabo[,1],'st-hilaire')),1]='sthilaire_pascale'
Data_collabo[which(str_detect(Data_collabo[,2],'st-hilaire')),2]='sthilaire_pascale'
Data_collabo[which(str_detect(Data_collabo[,1],'trottier')),1]='trottier_katiacatherine'
Data_collabo[which(str_detect(Data_collabo[,2],'trottier')),2]='trottier_katiacatherine'
Data_collabo[which(str_detect(Data_collabo[,1],'villleneuve')),1]='villeneuve_clara'
Data_collabo[which(str_detect(Data_collabo[,2],'villleneuve')),2]='villeneuve_clara'
Data_collabo[which(str_detect(Data_collabo[,1],'malette_marianne')),1]='mallette_marianne'
Data_collabo[which(str_detect(Data_collabo[,2],'malette_marianne')),2]='mallette_marianne'
Data_collabo = distinct(Data_collabo)} # des nouveaux doublons peuvent s'être ajouté

# Enlever des lignes en surplus (lignes vides) après vérification dans le SQLite
# Data_collabo <- Data_collabo[-c(375,2090),] # à revérifier? je pense que ce n'est pas necessaire

Data_collabo <- subset(Data_collabo,etudiant1!=etudiant2) # Ligne pour retirer les etudiants qui se sont mis ensemble avec eux même


####################################################################################################################
####################   2.6 CORRECTIONS DES ERREURS DANS LES DATES  #################################################
####################################################################################################################

# tous les uniques de la cle primaire de la table collaboration
# combinaison de trois variables
Key_collabo= distinct(Data_collabo[,1:3])

# certaine date sont errone, pour les identifier, trouvons les cours problématiques
cours_erreur = c(1,2)
index_erreur = c(1,2)
#Ce code nous renvoit les doublons de etudiant1_etudiant2_cours identique, mais dont la date est différente
for (i in 1:nrow(Key_collabo)){
  output = subset(Data_collabo,etudiant1==Key_collabo[i,1]&etudiant2==Key_collabo[i,2]&cours==Key_collabo[i,3])
  index = which(Data_collabo$etudiant1==Key_collabo[i,1] & 
                  Data_collabo$etudiant2==Key_collabo[i,2] & 
                  Data_collabo$cours==Key_collabo[i,3])
  if (nrow(output)>1){
    print(output)
    index_erreur = append(index_erreur,index)
    cours_erreur = append(cours_erreur,output[1,3])
  }else{
  }
}
cours_erreur = unique(cours_erreur[3:length(cours_erreur)])
index_erreur = unique(index_erreur[3:length(index_erreur)])

#Les erreures sont regardees une a une et comparer entre elles selon nos connaissances des cohortes et des gens.
# ECL522, ECL527, BIO109, ECL403, ECL404, ECL406, ECL515, ECL516, BIO500, MCB101
# ECL406 pour notre cohorte = 2019, ECL522 = 2019 (cours se donne à l'été), ECL527 = 2018, MCB101=2018,
# BIO500 = 2020, ECL516 = 2017 pour la cohorte avant nous, ECL515 = 2019,ECL404 = 2019, ECL403 = 2019, 
# BIO109 = NA car on ne connait pas l'information. Nous sommes chanceux aucune erreur se chevauchent

correction = data.frame(cours= c('ECL406','ECL522','ECL527','MCB101','BIO500',
                                 'ECL516','ECL515','ECL404','ECL403','BIO109'),
                        date= c(2019,2019,2018,2018,2020,2017,2019,2019,2019,NA))

for (i in 1:length(index_erreur)){
  j = index_erreur[i]
  cs = Data_collabo[j,]$cours
 Date = subset(correction,cours== cs)$date
 Data_collabo[j,]$date = Date
}

Data_collabo= distinct(Data_collabo)

# On ordone le data.frame en fonction du nom des cours
Data_collabo <- Data_cours[order(Data_collabo$cours),]

###################################################################################################
###############   3.ETUDIANT      #################################################################
###################################################################################################
###################################################################################################
###################   3.1 IMPORTATION   ###########################################################
###################################################################################################


Data.list.etudiant <-list() # cr?er une liste vide

Data.list.etudiant[[1]] <- read.csv("etudiants_Ax_Et_Jo_Va.csv" , sep=';',fileEncoding="latin1")
Data.list.etudiant[[2]] <- read.csv("etudiants_beteille.csv", sep=';',fileEncoding="latin1")
Data.list.etudiant[[3]] <- read.csv("etudiants_gagnon.csv", sep=';',fileEncoding="latin1")
Data.list.etudiant[[4]] <- read.csv("etudiants_GT_KAC_ETC_AD_RB.csv", sep=';',fileEncoding="latin1")
Data.list.etudiant[[5]] <- read.csv("etudiants_LP_TM_SPT_ELC_VM.csv",fileEncoding="latin1")
Data.list.etudiant[[6]] <- read.csv("etudiants_payette.csv",fileEncoding="latin1")
Data.list.etudiant[[7]] <- read.csv("etudiants_Thiffault.csv", sep=';',fileEncoding="latin1")


# nous pouvons regarder les donn?es avec la fonction edit
#edit(Data.list.etudiant[[7]])
#Data.list.etudiant[[1]]

###################################################################################################
####################   3.2 Uniformisation des noms des colonnes   #################################
###################################################################################################

#Les colonnes sont 
  # nom_prenom
  # annee_debut
  # session_debut
  # programme
  # coop
#Sont tous bien remplies ou presque!

for (i in 1:length(Data.list.etudiant)){
  print(i) # simplement un compteur
  colnames(Data.list.etudiant[[i]])[str_which(colnames(Data.list.etudiant[[i]]),'nom')] <- 'nom_prenom'
  colnames(Data.list.etudiant[[i]])[str_which(colnames(Data.list.etudiant[[i]]),'ann')] <- 'annee.debut'
  colnames(Data.list.etudiant[[i]])[str_which(colnames(Data.list.etudiant[[i]]),'session')] <- 'session'
  colnames(Data.list.etudiant[[i]])[str_which(colnames(Data.list.etudiant[[i]]),'prog')] <- 'programme'
  colnames(Data.list.etudiant[[i]])[str_which(colnames(Data.list.etudiant[[i]]),'regime')] <- 'coop'
  colnames(Data.list.etudiant[[i]])[str_which(colnames(Data.list.etudiant[[i]]),'coop')] <- 'coop'
  
  Data.list.etudiant[[i]] <- data.frame(nom_prenom=Data.list.etudiant[[i]][,'nom_prenom'],annee_debut=Data.list.etudiant[[i]][,'annee.debut'],
                                        session_debut=Data.list.etudiant[[i]][,'session'],programme=Data.list.etudiant[[i]][,'programme'],coop=Data.list.etudiant[[i]][,'coop'])
  print(colnames(Data.list.etudiant[[i]]))
}

#######################################################################################################
#####################   3.3 Mise en commun   ##########################################################
#######################################################################################################

Data_etudiant <- distinct(bind_rows(Data.list.etudiant))


######################################################################################################
############################ 3.4 Nettoyage ###########################################################
######################################################################################################

#Vérifier les noms dans la liste d'etudiant en ordre alphabetique
#attach(Data_etudiant)
#newData <- Data_etudiant[order(nom_prenom),]
#edit(newData)
#detach(Data_etudiant)

#Éliminer les rangées ayant 2 fois le même nom et/ou des erreurs
#191,131,78,199,62,79,229,83,173,202,203,230,175,176,87,205
#124,91,207,15,16,136,208,128,209,18,211,237,193*,94,167,212
#68,165*,140*,213,214,159,31,216,185*,32,195,168,219,116,70
#41,125,43,112,126,46,223,122,198,224,166,71,236


x <- c(191,131,78,199,62,79,229,83,173,202,203,230,175,176,87,205,
       124,91,207,15,16,136,208,128,209,18,211,237,193,94,167,212,
       68,165,140,213,214,159,31,216,185,32,195,168,219,116,70,
       41,125,43,112,126,46,223,122,198,224,166,71,236)

Data_etudiant <- Data_etudiant[-x, ]
length(unique(Data_etudiant$nom_prenom))
length(Data_etudiant$nom_prenom)

# On ordone le data.frame en fonction du nom des etudiants
Data_etudiant <- Data_cours[order(Data_etudiant$nom_prenom),]


################################################################################################################
####################################### 4. Enregistrement ######################################################
################################################################################################################


write.csv(Data_etudiant,'data_etudiant.csv',row.names=FALSE)
write.csv(Data_collabo, 'Data_collabo.csv',row.names=FALSE)
write.csv(Data_cours,file='Data_cours.csv',row.names=FALSE)




################################################## FIN ########################################################


