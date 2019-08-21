module Workarea
  module Admin
    class CatalogSwatchesController < Admin::ApplicationController
      required_permissions :catalog
      before_action :find_swatches

      def index
      end

      def create
        @swatch = Catalog::Swatch.new(params[:swatch])

        if @swatch.save
          flash[:success] = t('workarea.admin.catalog_swatches.flash_messages.saved')
          redirect_to catalog_swatches_path
        else
          flash[:error] = @swatch.errors.full_messages
          render :index
        end
      end

      def update
        @swatch = Catalog::Swatch.find(params[:id])

        if @swatch.update_attributes(params[:swatch])
          flash[:success] = t('workarea.admin.catalog_swatches.flash_messages.saved')
          redirect_to catalog_swatches_path
        else
          flash[:error] = t('workarea.admin.catalog_swatches.flash_messages.error')
          render :index
        end
      end

      def destroy
        Catalog::Swatch.find(params[:id]).destroy
        flash[:success] = t('workarea.admin.catalog_swatches.flash_messages.removed')
        redirect_to catalog_swatches_path
      end

      private

      def find_swatches
        @swatches = Catalog::Swatch.all
        @search_settings = Search::Settings.current
      end
    end
  end
end
