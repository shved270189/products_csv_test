require 'rails_helper'

RSpec.describe ProductService do
  context '::update_or_create!' do
    let(:attributes) { attributes_for(:product) }

    context 'for create' do
      it 'should be created' do
        expect { ProductService.update_or_create!(attributes) }
          .to change { Product.count }.by(1)
      end
    end

    context 'for update' do
      let!(:product) { create(:product) }

      it 'should be updated' do
        expect { ProductService.update_or_create!(attributes.merge(sku: product.sku)) }
          .to change { Product.first.name }.from(product[:name]).to(attributes[:name])
      end

      it 'should not be create new product' do
        expect { ProductService.update_or_create!(attributes.merge(sku: product.sku)) }
          .to change { Product.count }.by(0)
      end
    end
  end

  context '::keep_only_ids' do
    let!(:product) { create(:product) }
    let!(:products_for_delete) { create_list(:product, 10) }

    it 'should be deleted' do
      expect(Product.count).to eq 11
      expect { ProductService.keep_only_ids([product.id]) }
        .to change { Product.count }.by(-10)
    end
  end
end
