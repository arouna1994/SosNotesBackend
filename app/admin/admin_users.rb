ActiveAdmin.register AdminUser do
  menu label: "Utilisateurs", priority: 1
  permit_params :email, :password, :password_confirmation, :nom, :prenom, :date_naiss, :pays, :profil, :telephone , :etat

  index do
    selectable_column
    id_column
    column :email
    column :nom 
    column :prenom 
    column :telephone
    column :profil
    column :created_at
    actions
  end

  filter :email
  filter :nom 
  filter :prenom
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password if controller.action_name == 'new'
      f.input :password_confirmation if controller.action_name == 'new'
      f.input :nom 
      f.input :prenom 
      f.input :date_naiss 
      f.input :pays 
      f.input :profil , :as => :select, :collection => ["Administrateur","Redacteur", "Superviseur","Utilisateur"]
      f.input :telephone 
      f.input :etat , :as => :select, :collection => ["actif","suspendu"] , :label => "Etat"
    end
    f.actions
  end

end
