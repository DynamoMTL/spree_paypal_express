Rails.application.routes.draw do
  resources :orders do
    resource :checkout, :controller => 'checkout' do
      member do
        get :paypal_checkout
        get :paypal_payment
        get :paypal_callback
        get :paypal_delivery
        get :paypal_confirm
        post :paypal_confirm
        #match '/paypal_confirm' => 'checkout#paypal_confirm', :via => [:get, :post]
        post :paypal_finish
      end
    end
  end

  match '/paypal_notify' => 'paypal_express_callbacks#notify', :via => [:get, :post]

  namespace :admin do
    resources :orders do
      resources :paypal_payments do
        member do
          get :refund
          get :capture
        end
      end
    end
  end
end
