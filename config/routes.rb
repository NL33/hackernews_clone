Rails.application.routes.draw do
  root :to => 'links#index'

  resources :links do
      resources :comments
  end

  resources :comments do
    resources :comments
  end #this is to add comments on comments. Polymorphic association.
end

#notes:



#if any not required:
   #resources :contacts, :except => [:new, :show]

#nested (eg, phones belong to contacts)
  #written out: match('contacts/:contact_id/phones/new', {:via => :get, :to => 'phones#new'}), etc.. becomes
  #   resources :contacts do
  #      resources :phones
  #    end
