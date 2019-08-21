module Workarea
  module Catalog
    class Swatch
      include ApplicationDocument
      extend Dragonfly::Model

      field :_id, type: String, default: -> { name.optionize }
      field :name, type: String
      field :hex, type: String
      field :image_name, type: String
      field :image_uid, type: String

      validates :name, presence: true
      validates :hex, length: { is: 7, allow_blank: true }
      validates :id, uniqueness: true

      dragonfly_accessor :image, app: :workarea

      before_validation :normalize_hex

      def image?
        image.present?
      end

      def hex?
        hex.present?
      end

      private

      def normalize_hex
        return if hex.blank?
        self.hex = hex.starts_with?('#') ? hex : "##{hex}"
      end
    end
  end
end
