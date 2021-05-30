ActiveAdmin.register Historique do
  menu label: "Historique", priority: 5
  permit_params :admin_user_id, :libelle
  
  index do
    selectable_column
    id_column
    column "Utilisateur" do |post|
      post.admin_user.email if post.admin_user
    end
    column :libelle
    column :created_at
    actions
  end


  filter :libelle ,  :label => "Libelle"
  filter :created_at ,  :label => "Date Historique"
end
