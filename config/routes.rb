Rails.application.routes.draw do
	root "cryptobot#index" 
	get "index" => "cryptobot#index"
	get "show" => "cryptobot#show", as: "show"
	get "poketvalue" => "portfolio#poketvalue", as: "poketvalue"
end
