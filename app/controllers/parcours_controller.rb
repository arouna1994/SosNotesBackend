class ParcoursController < ApplicationController

    def create
        begin
            parcours = ParcoursEtude.create!(
                :donnee_id => params[:donnee_id],
                :contenu => params[:contenu],
                :annee => params[:annee]
            )


            result = {
                    :success => true,
                    :code => 200,
                    :stage_id => parcours.id
                    
                    
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
            parcours = ParcoursEtude.where(:id => params[:parcours_id])
            parcours.update(:contenu => params[:contenu],:annee => params[:annee])
           
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


    def getAllParcours
        begin
            parcours = ParcoursEtude.all
            itemsArray = Array.new
            ParcoursEtude.find_each do |parcour|

                item = {
                    :parcour_id => parcour.id,
                    :contenu => parcour.contenu,
                    :annee => parcour.annee
                }
                itemsArray.push(item)
            end
            result = {
                    :success => true,
                    :code => 200,
                    :listeParcours => itemsArray
                    
                    
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