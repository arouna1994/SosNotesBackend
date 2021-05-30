class TypeDocumentController < ApplicationController
    #list of documents type
    def index
        begin
            type_documents = TypeDocument.where(:etat => "actif").order(:libelle => :asc)
            itemsArray = Array.new
            type_documents.each do |type_doc|
                services = Service.where(:type_document_id => type_doc.id)
                servicesArray = Array.new 
                services.each do |serv|
                    serviceItem = {
                        :id => serv.id,
                        :prestation => serv.prestation
                    }
                    servicesArray.push(serviceItem)
                end

                item = {
                    :id => type_doc.id,
                    :libelle => type_doc.libelle,
                    :prestations => servicesArray
                }
                itemsArray.push(item)
            end
            result = {
                :success => true,
                :code => 200,
                :total => TypeDocument.where(:etat => "actif").count,
                :items => itemsArray
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
