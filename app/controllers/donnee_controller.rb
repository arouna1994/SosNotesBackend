class DonneeController < ApplicationController

    def index
        begin
            stages = Stage.where(:donnee_id => params[:donnee_id])
            competences = Competence.where(:donnee_id => params[:donnee_id])
            emplois = Emploi.where(:donnee_id => params[:donnee_id])
            donnees = Donnee.where(:id => params[:donnee_id])
            demande = Demande.where(:admin_user_id => params[:admin_user_id],:type_document_id => donnees[0].type_document_id)
            expressions = Expression.where(:donnee_id => params[:donnee_id])
            parcours = ParcoursEtude.where(:donnee_id => params[:donnee_id])
            photo = PieceJointe.where(:demande_id => demande[0].id)
            user = AdminUser.where(:id => params[:admin_user_id])


            result = {
                :success => true,
                :code => "200",
                :stages => stages,
                :competences => competences,
                :emplois => emplois,
                :donnees => donnees,
                :expressions => expressions,
                :demande => demande,
                :parcours => parcours,
                :photo => photo[0],
                :donnees => donnees[0],
                :user => user
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