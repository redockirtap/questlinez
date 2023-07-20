class AttachmentsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    attachment.purge if current_user&.author?(attachment.record)
  end

  private

  helper_method :attachment

  def attachment
    @attachment ||= ActiveStorage::Attachment.find(params[:id])
  end
end
