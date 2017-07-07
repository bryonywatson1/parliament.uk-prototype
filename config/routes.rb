Rails.application.routes.draw do
  mount ParliamentRoutingEngine::Engine => "/parliament_routing_engine"
end
