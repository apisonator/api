namespace :db do
  task clean: :environment do
    p Function.delete_all
    p Release.delete_all
    p Proxy.delete_all
    p User.delete_all
  end
end
