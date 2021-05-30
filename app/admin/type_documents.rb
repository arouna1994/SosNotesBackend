ActiveAdmin.register TypeDocument do
  menu label: "Type Document", priority: 2
  permit_params :libelle, :etat

  index do
    selectable_column
    id_column
    column :libelle
    column :etat
    column :created_at
    actions
  end

  filter :libelle

  form do |f|
    f.inputs do
      f.input :libelle
      f.input :etat , :as => :select, :collection => ["actif","inactif"] , :label => "Etat"
    end
    f.actions
  end
end
