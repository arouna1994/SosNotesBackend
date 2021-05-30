ActiveAdmin.register Demande do
  menu label: "Demande", priority: 4
  permit_params :type_document_id, :admin_user_id, :modele, :etat

  index do
    selectable_column
    id_column
    column "Type Document" do |post|
      post.type_document.libelle if post.type_document
    end
    column "Email Demandeur" do |post|
      post.admin_user.email if post.admin_user_id
    end
    column "Nom Demandeur" do |post|
      post.admin_user.nom if post.admin_user_id
    end
    column "Prénom Demandeur" do |post|
      post.admin_user.prenom if post.admin_user_id
    end
    column "Tel Demandeur" do |post|
      post.admin_user.telephone if post.admin_user_id
    end
    column :etat
    actions
  end

  filter :type_document_id , :as => :select, :collection => TypeDocument.all.order(:libelle).collect {|rec| [rec.libelle.to_s, rec.id]} , :label => "Type Document"
  filter :etat , :as => :select, :collection => ["actif","inactif"] , :label => "Etat"

  form do |f|
    f.inputs do
      f.input :type_document_id , :as => :select, :collection => TypeDocument.all.order(:libelle).collect {|rec| [rec.libelle.to_s, rec.id]} , :label => "Type Document"
      f.input :admin_user_id , :as => :select, :collection => AdminUser.all.order(:email).collect {|rec| [rec.email.to_s, rec.id]} , :label => "Utilisateur"
      f.input :modele
      f.input :etat , :as => :select, :collection => ["Nouvelle","En cours de mise en relation","En cours de rédation","Validée"] , :label => "Etat"
    end
    f.actions
  end
end 
