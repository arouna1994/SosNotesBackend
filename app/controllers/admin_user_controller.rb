class AdminUserController < ApplicationController
    include ActionView::Helpers::DateHelper
    before_action :set_default_locale

    def set_default_locale
        begin
            I18n.default_locale = :fr
            if(params[:lang].eql?("en")) 
                I18n.default_locale = :en
            end
        rescue Exception => e 
            I18n.default_locale = :fr
        end
    end

    #method to process login
    def login
        begin
            adminUser = AdminUser.find_for_authentication(:email => params[:email])
            if(adminUser!=nil && adminUser.valid_password?(params[:password]))
                if(adminUser.etat.eql?("actif"))#everything ok
                    result = {
                        :success => true,
                        :code => 200,
                        :email => adminUser.email,
                        :nom => adminUser.nom,
                        :prenom => adminUser.prenom,
                        :date_naissance => adminUser.date_naiss,
                        :pays => adminUser.pays,
                        :profil => adminUser.profil,
                        :telephone => adminUser.telephone
                    }
                    historique = Historique.new 
                    historique.admin_user = adminUser
                    historique.libelle = "Connexion à l'application"
                    historique.save
                else
                    result = {
                        :success => false,
                        :code => 403,
                        :message => "Votre compte n'est pas actif"
                    }
                end
            else 
                result = {
                    :success => false,
                    :code => 404,
                    :message => "Veuillez vérifier vos paramètres de connexion"
                }
            end
        rescue Exception => e 
            result = {
                :success => false,
                :code => 500,
                :message => e.to_s
            }
        end
        respond_to do |format|
            format.html
            format.json  { render :json => result.to_json }
        end
    end




    #method to process logout
    def logout
        begin
            adminUser = AdminUser.where(:email => params[:email]).take
            historique = Historique.new 
            historique.admin_user = adminUser
            historique.libelle = "Déconnexion de l'application"
            historique.save
            #set_historique("Déconnexion de l'application",adminUser.id)
            result = {
                :success => true,
                :code => 200
            }
        rescue Exception => e #something wrong
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




    # get user informations
    def infoUser
        begin 
            adminUser = AdminUser.where(:email => params[:email]).take
            historiques = Historique.where(:admin_user_id => adminUser.id).order(:id => :desc)
            historiqueArray = Array.new 
            from_time = Time.now
            historiques.each do |historique|
                item={
                    :libelle => historique.libelle,
                    :date_historique => distance_of_time_in_words(from_time, historique.created_at)
                }
                historiqueArray.push(item)
            end

            activiteItems = Array.new
            6.downto(0) do |i|
                item= {
                    :day => Date.today-i,
                    :nbre => Historique.where("admin_user_id="+adminUser.id.to_s+" and (created_at between '"+(Date.today-i).to_s+" 00:00:00' and '"+(Date.today-i).to_s+" 23:59:59')").count
                }
                activiteItems.push(item)
            end

            result = {
                :success => true,
                :email => adminUser.email,
                :nom => adminUser.nom,
                :prenom => adminUser.prenom,
                :date_naissance => adminUser.date_naiss,
                :pays => adminUser.pays,
                :profil => adminUser.profil,
                :telephone => adminUser.telephone,
                :etat => adminUser.etat,
                :historiques => historiqueArray,
                :demande_new => 2,
                :demande_en_cours => 2,
                :demande_cloturee => 1,
                :activites => activiteItems
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




    #change password
    def changePassword
        begin
            adminUser = AdminUser.find_for_authentication(:email => params[:email])
            if(adminUser!=nil && adminUser.valid_password?(params[:old_password]))
                adminUser.password = params[:new_password]
                if(adminUser.save)
                #set_historique("Modification de votre mot de passe",adminUser.id)
                result = {
                    :success => true,
                    :code => "200",
                    :message => "Votre mot de passe a été modifié avec succès"
                }
                else #if the account is disabled
                result = {
                    :success => false,
                    :code => "404",
                    :message => "La modification de votre mot de passe a échouée"
                }
                end
            else #wrong password or email
                result = {
                    :success => false,
                    :code => "404",
                    :message => "L'ancien mot de passe ne correspond pas"
                }
            end
        rescue Exception => e #something wrong
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





    #change contribuable info
    def changeInfo
        begin
        adminUser = AdminUser.where(:email => params[:user]).take

        old_naissance = adminUser.date_naiss
        old_tel = adminUser.telephone
        old_nom = adminUser.nom
        old_prenom = adminUser.prenom

        adminUser.date_naiss= params[:date_naiss]
        adminUser.telephone = params[:telephone]
        adminUser.nom = params[:nom]
        adminUser.prenom = params[:prenom]
        if(adminUser.save)
            if(!adminUser.date_naiss.eql?(old_naissance))
                #set_historique("Modification de l'email contribuable de '"+old_email+"' en '"+contribuable.email+"'",adminUser.id)
            end
            if(!adminUser.telephone.eql?(old_tel))
                #set_historique("Modification du téléphone mobile contribuable de '"+old_telmob+"' en '"+contribuable.telmob+"'",adminUser.id)
            end
            if(!adminUser.nom.eql?(old_nom))
                #set_historique("Modification du téléphone domicile contribuable de '"+old_teldom+"' en '"+contribuable.teldom+"'",adminUser.id)
            end
            if(!adminUser.prenom.eql?(old_prenom))
                #set_historique("Modification du téléphone de travail contribuable de '"+old_teltravail+"' en '"+contribuable.teltravail+"'",adminUser.id)
            end

            result = {
                :success => true,
                :code => "200",
                :message => "Vos informations ont été modifiées avec succès"
            }
        else #if the account is disabled
            result = {
                :success => false,
                :code => "404",
                :message => "La modification de vos informations a échouée"
            }
        end
        rescue Exception => e #something wrong
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




    #reinitialisation par one
    def reinitialisationPartOne
        begin
            adminUser = AdminUser.where(:email => params[:email]).take
            adminUser.code_reinitialisation=rand.to_s[2..10]
            adminUser.date_code = Time.now
            adminUser.url_verify_code = (0...50).map { (65 + rand(26)).chr }.join
            if(adminUser.save)
                if(adminUser.telephone!=nil && !adminUser.telephone.eql?(""))
                    SmsWorker.perform_async(adminUser.telephone, "Code de réinitialisation : "+adminUser.code_reinitialisation.to_s)
                end
                if(adminUser.courriel!=nil && !adminUser.courriel.eql?(""))
                    MailWorker.perform_async("contact@kaaribu.com", adminUser.courriel, "Code de réinitialisation","Code de réinitialisation : "+adminUser.code_reinitialisation.to_s)
                end
                result = {
                    :success => true,
                    :code => "200",
                    :url_verify_code => adminUser.url_verify_code,
                    :date_verify => adminUser.date_code,
                    :date_password => adminUser.date_password,
                    :url_password_code => adminUser.url_password_code
                }
            else
                result = {
                    :success => false,
                    :code => "404",
                    :message => "Une erreur est survenue"
                }
            end
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





    #reinitialisation par two
    def reinitialisationPartTwo
        begin
            adminUser = AdminUser.where(:email => params[:email]).take
            if(((Time.now - adminUser.date_code)/1.minute).round <= 2)
                if(adminUser.code_reinitialisation.eql?(params[:code]))
                adminUser.date_password = Time.now
                adminUser.url_password_code = (0...50).map { (65 + rand(26)).chr }.join
                if(adminUser.save)
                    result = {
                        :success => true,
                        :code => "200",
                        :url_verify_code => adminUser.url_verify_code,
                        :date_verify => adminUser.date_code,
                        :date_password => adminUser.date_password,
                        :url_password_code => adminUser.url_password_code
                    }
                else
                    result = {
                        :success => false,
                        :code => "404",
                        :message => "Une erreur est survenue"
                    }
                end
                else
                result = {
                    :success => false,
                    :code => "202",
                    :message => "Le code que vous avez saisi ne correspond pas"
                }
                end
            else
                result = {
                    :success => false,
                    :code => "202",
                    :message => "Votre code a expiré. Veuillez reprendre le processus"
                }
            end
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




    #reinitialisation par three
    def reinitialisationPartThree
        begin
            adminUser = AdminUser.where(:email => params[:email]).take
            adminUser.password = params[:password]
            adminUser.code_reinitialisation=""
            adminUser.date_code = ""
            adminUser.url_verify_code = ""
            adminUser.date_password = ""
            adminUser.url_password_code = ""
            if(adminUser.save)
                set_historique("Réinitialisation de votre mot de passe",adminUser.id)
                set_notification("Modificatoin mot de passe","Votre mot de passe a été réinitialisé avec succès",adminUser.id,"#")
                result = {
                    :success => true,
                    :code => "200",
                    :message => "Votre mot de passe a été réinitialisé avec succès"
                }
            else
                result = {
                    :success => false,
                    :code => "404",
                    :message => "Une erreur est survenue"
                }
            end
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




    #get reinitialisation information
    def getReinitialisationInfo
        begin
            if params[:key]
                adminUser = AdminUser.where(:email => params[:email],:url_verify_code => params[:key]).take
            end
            if params[:key_two]
                adminUser = AdminUser.where(:email => params[:email],:url_password_code => params[:key_two]).take
            end
            result = {
                :success => true,
                :code => "200",
                :key => adminUser.url_verify_code,
                :date_code => adminUser.date_code,
                :date_password => adminUser.date_password,
                :url_password_code => adminUser.url_password_code
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
