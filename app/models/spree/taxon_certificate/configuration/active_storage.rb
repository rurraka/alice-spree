module Spree
  class TaxonCertificate < Asset
    module Configuration
      module ActiveStorage
        extend ActiveSupport::Concern

        included do
          validate :check_attachment_presence
          validate :check_attachment_content_type

          has_one_attached :attachment

          def self.styles
            @styles ||= {
              mini: '48x48>',
              small: '100x100>',
              medium: '120x120>',
              product: '240x240>',
              large: '600x600>',
              extralarge: '860x860'
            }
          end

          def default_style
            :product
          end

          def accepted_image_types
            %w(image/jpeg image/jpg image/png image/gif application/pdf application/zip)
          end

          def check_attachment_presence
            unless attachment.attached?
              errors.add(:attachment, :attachment_must_be_present)
            end
          end

          def check_attachment_content_type
            if attachment.attached? && !attachment.content_type.in?(accepted_image_types)
              errors.add(:attachment, :not_allowed_content_type)
            end
          end
        end
      end
    end
  end
end
