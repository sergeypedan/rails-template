desc "Seeds social nets. Duplicates (by :name, :uid, :url) will be skipped."

namespace :seed do
  task social_nets: :environment do
    puts "Seeding social nets"

    Integral::SocialNet::DB.each do |hash|
      puts "• creating #{hash[:name]}"
      ::SocialNet.create do |sn|
        sn.color = hash[:color]
        sn.fa_id = hash[:fa_id]
        sn.name  = hash[:name]
        sn.uid   = hash[:uid]
        sn.url   = hash[:url]
        sn.user_page_by_username   = hash[:user_page][:by_username]
        sn.user_page_by_account_id = hash[:user_page][:by_account_id]
      end
    end

    puts "Finished"

  end
end
