Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "admin/dashboard#index"  

  #gestion des utilisateurs
  post '/api/v1/create' => 'admin_user#create'
  post '/api/v1/login' => 'admin_user#login'
  post '/api/v1/logout' => 'admin_user#logout'
  get '/api/v1/infoUser' => 'admin_user#infoUser'
  post '/api/v1/changePassword' => 'admin_user#changePassword'
  post '/api/v1/changeInfo' => 'admin_user#changeInfo'
  post '/api/v1/reinitialisationPartOne' => 'admin_user#reinitialisationPartOne'
  post '/api/v1/reinitialisationPartTwo' => 'admin_user#reinitialisationPartTwo'
  post '/api/v1/reinitialisationPartThree' => 'admin_user#reinitialisationPartThree'
  post '/api/v1/getReinitialisationInfo' => 'admin_user#getReinitialisationInfo'


  #gestion des apis des demandes
  get 'api/v1/demandes' => 'demande#index'
  post 'api/v1/creer_demande' => 'demande#createByUser'
  get 'api/v1/demandeParUtilisateur' => 'demande#listeByUser'

  #gestion des emplois
  post 'api/v1/creer_emploi' => 'emploi#create'
  post 'api/v1/modifier_emploi' => 'emploi#modifier'
  get 'api/v1/emplois' => 'emploi#getAllEmploi'
 #gestion des parcours
 post 'api/v1/creer_parcours' => 'parcours#create'
 post 'api/v1/modifier_parcours' => 'parcours#modifier'
 get 'api/v1/parcours' => 'parcours#getAllParcours'

  #gestion des stages
   post 'api/v1/creer_stage' => 'stage#create'
   post 'api/v1/modifier_stage' => 'stage#modifier'
   get 'api/v1/stages' => 'stage#getAllStage'
  #gestion des competences
  post 'api/v1/creer_competence' => 'competence#create'
  #gestion des apis des types de documents
  get 'api/v1/type_documents' => 'type_document#index'

  #gestion des apis des donnees
  get 'api/v1/donnees' => 'donnee#index'

  #gestion des services
  post 'api/v1/affecterService' => 'service#affecterUtilisateur'
end
