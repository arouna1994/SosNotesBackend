class ServiceController < ApplicationController

    def affecterUtilisateur
        begin
             type_document =TypeDocument.where( :libelle => params[:type_document]).take

            donnee = Donnee.create!(
                :type_document_id => type_document.id
            )
           service = Service.where(:type_document_id => type_document.id,:prestation => params[:service]).take
            demande = Demande.create!(
                :admin_user_id => params[:admin_user_id],
                :type_document_id => type_document.id,
                :etat => 'Nouvelle',
                :status => false
            )
            if(!params[:tag].blank?)
                piece_jointe = PieceJointe.create!(
                :demande_id => demande.id,
                :fich_file_name => params[:name],
                :fich_content_type => params[:type],
                :fich_file_size => params[:size],
                :tag => params[:tag]
            )
            end
            


            result = {
                    :success => true,
                    :code => 200,
                    :admin_user_id => params[:admin_user_id],
                    :type_document_id =>type_document.id,
                    :demande_id => demande.id,
                    :donnee_id => donnee.id,
                    :tag => params[:tag]
                    
                }
        rescue Exception => e 
            result = {
                :success => false,
                :code => "500",
                :message => e.to_s
            }
        end
        respond_to do |format|
            format.html
            format.json  { render :json => result.to_json }
        end
    end

end