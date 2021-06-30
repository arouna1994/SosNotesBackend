class StageController < ApplicationController

    def create
        begin
            stage = Stage.create!(
                :donnee_id => params[:donnee_id],
                :contenu => params[:contenu],
                :annee => params[:annee]
            )


            result = {
                    :success => true,
                    :code => 200,
                    :stage_id => stage.id
                    
                    
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
            stage = Stage.where(:id => params[:stage_id])
            stage.update(:contenu => params[:contenu],:annee => params[:annee])
           
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


    def getAllStage
        begin
            stages = Stage.all
            itemsArray = Array.new
            Stage.find_each do |stage|

                item = {
                    :stage_id => stage.id,
                    :contenu => stage.contenu,
                    :annee => stage.annee
                }
                itemsArray.push(item)
            end
            result = {
                    :success => true,
                    :code => 200,
                    :listeStages => itemsArray
                    
                    
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