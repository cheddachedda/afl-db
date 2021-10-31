module PagesHelper
  def get_all_models attributes=false
    Rails.application.eager_load!
    unless attributes
      ApplicationRecord.descendants.collect(&:name) # Returns only the model names
    else
      ActiveRecord::Base.descendants # Returns all models and their attributes.
    end
  end
end
