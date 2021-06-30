class CompetenceController < ApplicationController

    def create
        begin
            competence = Competence.create!(
                :donnee_id => params[:donnee_id],
                :contenu => params[:contenu]
            )


            result = {
                    :success => true,
                    :code => 200,
                    :competence_id => competence.id
                    
                    
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