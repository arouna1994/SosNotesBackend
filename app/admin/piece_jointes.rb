ActiveAdmin.register PieceJointe do
  menu label: "Pièces Jointes", priority: 4
  permit_params :demande_id, :tag, :uuid , :fich_file_name, :fich_content_type,  :fich_file_size
  

  index do
    selectable_column
    id_column
    column "Type Document" do |post|
      post.demande.type_document.libelle if post.demande
    end
    column "Email Demandeur" do |post|
      post.demande.admin_user.email if post.demande
    end
    column "Nom Demandeur" do |post|
      post.demande.admin_user.nom if post.demande
    end
    column "Prénom Demandeur" do |post|
      post.demande.admin_user.prenom if post.demande
    end
    column :uuid
    column :fich_file_name , "Nom Fichier"
    column :fich_content_type, :label => "Type Fichier"
    column :fich_file_size, :label => "Taille Fichier"
    column :tag
    column :etat
    actions
  end
  


  form do |f|
    f.inputs do
      f.input :demande_id , :as => :select, :collection => Demande.all.collect {|rec| [rec.type_document.libelle.to_s+" - "+rec.id.to_s, rec.id]} , :label => "Demande"
      f.input :tag
      f.input :fich, :as => :file, :required => true
    end
    f.actions
  end
end
