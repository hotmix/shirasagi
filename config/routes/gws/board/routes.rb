SS::Application.routes.draw do
  Gws::Board::Initializer

  concern :deletion do
    get :delete, on: :member
    delete action: :destroy_all, :on => :collection
  end

  gws "board" do
    resources :topics, concerns: [:deletion] do
      namespace :parent, path: ":parent_id", parent_id: /\d+/ do
        resources :comments, controller: '/gws/board/comments', concerns: [:deletion]
      end
    end

    resource :setting, only: [:show, :edit, :update]
    resources :categories, concerns: [:deletion]
  end
end
