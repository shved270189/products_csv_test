require 'rails_helper'

RSpec.describe ProductLoaderService do
  context '#call' do
    it 'should create products' do
      expect { ProductLoaderService.new.call }.to change { Product.count }.by(5)
    end
  end
end
