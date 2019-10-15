Rails.application.routes.draw do
  get 'dashboards/index'
  root to: "dashboards#index"
end
