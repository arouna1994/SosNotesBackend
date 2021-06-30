class DemandeController < ApplicationController

    def index
        begin
            

            

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


    def createByUser
        begin
            donnee =Donnee.where( :id => params[:donnee_id]).take

            piece_jointe = PieceJointe.create!(
                :demande_id => params[:demande_id],
                :fich_file_name => params[:name],
                :fich_content_type => params[:type],
                :fich_file_size => params[:size],
                :tag => params[:tag]
            )
            donnee.update(
            :type_document_id =>params[:type_document_id],
            :email =>params[:email],
            :nom => params[:nom],
            :prenom => params[:prenom],
            :date_naissance => params[:date_naiss],
            :telephone => params[:telephone],
            :structure_ciblee => params[:structure_ciblee],
            :adresse_phy => params[:adresse_phys],
            :etat_civil => params[:etat_civil])
            
            if(!params[:langue].blank?)
                expr = Expression.create!(
                  :oral => params[:oral],
                  :langue => params[:langue],
                  :ecrit => params[:ecrit],
                  :comprehension => params[:comprehension],
                  :donnee_id => donnee.id
                )
            end
            if (!params[:langue1].blank?)
                expr = Expression.create!(
                  :langue => params[:langue1],
                  :oral => params[:oral1],
                  :ecrit => params[:ecrit1],
                  :comprehension => params[:comprehension1],
                  :donnee_id => donnee.id
                )
            end
            if (!params[:langue2].blank?)
                expr = Expression.create!(
                  :langue => params[:langue2],
                  :oral => params[:oral2],
                  :ecrit => params[:ecrit2],
                  :comprehension => params[:comprehension2],
                  :donnee_id => donnee.id
                )
            end 
            
                result = {
                    :success => true,
                    :code => 200,
                    :admin_user_id => params[:admin_user_id]
                    
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