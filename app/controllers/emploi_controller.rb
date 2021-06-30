class EmploiController < ApplicationController

    def create
        begin
            emploi = Emploi.create!(
                :donnee_id => params[:donnee_id],
                :contenu => params[:contenu],
                :annee => params[:annee]
            )


            result = {
                    :success => true,
                    :code => 200,
                    :stage_id => emploi.id
                    
                    
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


    def modifier
        begin
            emploi = Emploi.where(:id => params[:emploi_id])
            emploi.update(:contenu => params[:contenu],:annee => params[:annee])
           
            result = {
                    :success => true,
                    :code => 200,
                    :etat=> 'ok'
                    
                    
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


    def getAllEmploi
        begin
            emplois = Emploi.all
            itemsArray = Array.new
            Emploi.find_each do |emploi|

                item = {
                    :emploi_id => emploi.id,
                    :contenu => emploi.contenu,
                    :annee => emploi.annee
                }
                itemsArray.push(item)
            end
            result = {
                    :success => true,
                    :code => 200,
                    :listeEmplois => itemsArray
                    
                    
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