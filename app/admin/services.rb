ActiveAdmin.register Service do
  menu label: "Service", priority: 3
  permit_params :type_document_id, :prestation, :etat

  index do
    selectable_column
    id_column
    column "Type Document" do |post|
      post.type_document.libelle if post.type_document
    end
    column :prestation
    column :etat
    actions
  end

  filter :type_document_id , :as => :select, :collection => TypeDocument.all.order(:libelle).collect {|rec| [rec.libelle.to_s, rec.id]} , :label => "Type Document"
  filter :etat , :as => :select, :collection => ["actif","inactif"] , :label => "Etat"

  form do |f|
    f.inputs do
      f.input :type_document_id , :as => :select, :collection => TypeDocument.all.order(:libelle).collect {|rec| [rec.libelle.to_s, rec.id]} , :label => "Type Document"
      f.input :prestation , :as => :select, :collection => ["Mise en forme","Rédaction","Rédaction et Mise en forme"] , :label => "Etat"
      f.input :etat , :as => :select, :collection => ["Actif","Inactif"] , :label => "Etat"
    end
    f.actions
  end
end
