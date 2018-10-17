require 'rails_helper'

describe 'routes for Products' do
  it 'routes /products to the products controller' do
    { get: '/products' }.should route_to(controller: 'products', action: 'index', format: 'json')
  end
end
