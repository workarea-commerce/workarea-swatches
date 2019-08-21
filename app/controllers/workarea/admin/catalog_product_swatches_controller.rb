module Workarea
  module Admin
    class CatalogProductSwatchesController < Admin::ApplicationController
      required_permissions :catalog
      before_action :find_product

      def index
      end

      def create
        @swatch = @product.swatches.build(params[:swatch])

        if @swatch.save
          flash[:success] = t('workarea.admin.catalog_product_swatches.flash_messages.saved')
          redirect_to catalog_product_swatches_path(@product)
        else
          render :index, status: :unprocessable_entity
        end
      end

      def update
        @swatch = @product.swatches.find(params[:id])

        if @swatch.update_attributes(params[:swatch])
          flash[:success] = t('workarea.admin.catalog_product_swatches.flash_messages.saved')
          redirect_to catalog_product_swatches_path(@product)
        else
          flash[:error] = t('workarea.admin.catalog_product_swatches.flash_messages.error')
          render :index
        end
      end

      def destroy
        @product.swatches.find(params[:id]).destroy
        flash[:success] = t('workarea.admin.catalog_product_swatches.flash_messages.removed')
        redirect_to catalog_product_swatches_path(@product)
      end

      private

      def find_product
        model = Catalog::Product.find_by(slug: params[:catalog_product_id])
        @product = ProductViewModel.wrap(model, view_model_options)
      end
    end
  end
end
