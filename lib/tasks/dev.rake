namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando DB...") {%x(rails db:drop) }
      show_spinner("Criando DB...") {%x(rails db:create)}
      show_spinner("Migrando DB...") {%x(rails db:migrate)}
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)
    else
      puts "Você não está num ambiente de desenvolvimento!"
    end
  end

  desc "Cadastra as moedas"
  task add_coins: :environment do

    show_spinner("Cadastrando Moedas...")do

      coins = [
        {
          description:"Bitcoin",
          acronym:"BTC",
          url_image:"https://logodownload.org/wp-content/uploads/2017/06/bitcoin-logo-1-1.png",
          mining_type: MiningType.find_by(acronym: "PoW")
        },
        {
          description:"Ethereum",
          acronym:"ETH",
          url_image:"https://seeklogo.com/images/E/ethereum-logo-EC6CDBA45B-seeklogo.com.png",
          mining_type: MiningType.all.sample
        },
        {
          description:"DASH",
          acronym:"DASH",
          url_image:"https://seeklogo.com/images/D/dash-logo-4A14989CF5-seeklogo.com.png",
          mining_type: MiningType.all.sample
        },
        {
          description:"Iota",
          acronym:"IOT",
          url_image:"https://s2.coinmarketcap.com/static/img/coins/200x200/1720.png",
          mining_type: MiningType.all.sample
        },
        {
          description:"Zcash",
          acronym:"ZEC",
          url_image:"https://cdn-icons-png.flaticon.com/512/1228/1228090.png?w=826&t=st=1689345935~exp=1689346535~hmac=4a6422869aac065ce2fd4651b65e4160b5ebc80da3ee0e46cf5295d5c775b9f5",
          mining_type: MiningType.all.sample
        }
      ]

      coins.each do |coin|
        Coin.find_or_create_by!(coin)
      end
    end
  end

  desc "Cadastra os tipos de mineração"
  task add_mining_types: :environment do
    show_spinner("Cadastrando tipos de mineração...") do
      mining_types= [
        {description: "Proof of Work", acronym:"PoW" },
        {description: "Proof of Stake", acronym:"PoS" },
        {description: "Proof of Capacity", acronym:"PoC" }
      ]
      mining_types.each do |mining_type|
        MiningType.find_or_create_by!(mining_type)
      end
    end
  end





  private
  def show_spinner(msg_start, msg_end = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}", format: :star)
    spinner.auto_spin 
    yield
    spinner.success("(#{msg_end})")
  end

end
