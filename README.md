# Projet UE-CLOUD Rory MAILLARD, Samuel FROSSARD

Le projet est séparé dans des branches differentes qui correspondent aux différents rendus du projet.
- La branche docker-compose pour la partie docker
- La branche Kubernetes pour la partie kubernetes
- La branche terraform-docker pour la partie terraform docker
- La branche terraform-kubernetes pour la partie terraform GKE Kubernetes (la même que la branche main)


# Kubernetes

## Prérequis

Il faut avoir installé Google Cloud CLI et Kubernetes CLI sur la machine.  
Il faut également posséder un compte google cloud avec un moyen de facturation associé (dans notre cas, des crédits GCP). 

### Création d'un cluster et authentification
Voici les étapes à suivre pour configurer un projet google cloud et s'authentifier via kubectl:

* Créez un nouveau projet google cloud (https://console.cloud.google.com/).
* Activez l'API Kubernetes Engine 
* Effectuez les commandes suivantes en remplaçant PROJECT-ID par l'id du projet que vous avez créé, et CLUSTER_NAME par le nom que vous voulez donner à votre cluster. La variable REGION peut également être retrouvée dans la sélection "se connecter" du cluster après l'avoir créé. 
    * <code> gcloud auth login </code> 
    * <code> gcloud config set project PROJECT-ID</code> 
    * <code> gcloud container clusters create NAME-CLUSTER --machine-type n1-standard-2 --num-nodes 3 --zone us-central1-c</code> 
    * <code> gcloud container clusters get-credentials CLUSTER-NAME --region us-central1 --project PROJECT-ID</code> 
Après cela, il devrait être possible d'exécuter des commandes kubectl sur le cluster GKE distant. 

### Push des images docker et authentification

Il faut également exporter les images dockers sur un artifact registry du projet.  

Après avoir créé l'artifact registry on doit authentifier notre machine à ce registry.  
La commande peut être trouvée dans les sections "Setup Instructions" du registry et devrait ressembler à:
<code> gcloud auth configure-docker europe-west9-docker.pkg.dev </code>  

Après avoir obtenu le chemin d'accès au registry, ajustez le lien des images docker dans le fichier ***docker-compose.yaml***.    
Construisez les images avec <code> docker compose build </code>  

Enfin push les images sur le registry: <code> docker compose push </code> 


    
## Déploiement du projet

Il suffit maintenant de lancer les déploiements des services un par un:

* <code> kubectl create -f /db/db-deployment.yml</code>
* <code> kubectl create -f /worker/worker-deployment.yml</code>
* <code> kubectl create -f /redis/redis-deployment.yml</code>
* <code> kubectl create -f /vote/vote-deployment.yml</code>
* <code> kubectl create -f /result/result-deployment.yml</code>
* <code> kubectl create -f /seed-data/seed-data-job.yml</code>
