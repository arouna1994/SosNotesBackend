Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "admin/dashboard#index"  

  #gestion des utilisateurs
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
  get 'api/v1/creer_demande' => 'demande#createByUser'
  get 'api/v1/demandeParUtilisateur' => 'demande#listeByUser'


  #gestion des apis des types de documents
  get 'api/v1/type_documents' => 'type_document#index'
end
