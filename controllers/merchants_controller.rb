require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('../models/transaction.rb')
require_relative('../models/tag.rb')
require_relative('../models/merchant.rb')
also_reload('../models/*')

get '/merchants' do
  merchants = Merchant.all()
  @merchants = merchants.sort_by {|merchant| merchant.id}
  erb(:"merchants/index")
end

get '/merchants/new' do
  erb(:"merchants/new")
end

post '/merchants' do
  merchant = Merchant.new(params)
  merchant.save()
  redirect to ("/merchants")
end

get '/merchants/:id/edit' do
  @merchant = Merchant.find_by_id(params['id'])
  erb(:"merchants/edit")
end

post '/merchants/:id' do
  Merchant.new(params).update()
  redirect to ("/merchants")
end

post '/merchants/:id/delete' do
  merchant = Merchant.find_by_id(params['id'])
  merchant.delete()
  redirect to ("/merchants")
end
