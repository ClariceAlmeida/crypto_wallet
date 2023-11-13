module ApplicationHelper
    def locale
       I18n.locale == :en ? "Inglês, Estados Unidos" : "Português, Brasil"
    end

    def date_br(date_us)
        date_us.strftime("%d/%m/%Y")
    end

    def app_name
        "Crypto Wallet APP"
    end

    def ambiente_rails
        if Rails.env.development?
            "Desenvolvimento"
        elsif Rails.env.production?
            "Produção"
        else 
            "Teste"
        end
    end
end
