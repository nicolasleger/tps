module MailTemplateConcern
  extend ActiveSupport::Concern

  include Rails.application.routes.url_helpers
  include ActionView::Helpers::UrlHelper

  TAGS = {
      numero_dossier: {
         description: "Permet d'afficher le numéro de dossier de l'utilisateur."
      },
      lien_dossier: {
          description: "Permet d'afficher un lien vers le dossier de l'utilisateur."
      },
      libelle_procedure: {
         description: "Permet d'afficher le libellé de la procédure."
      }
   }

  def object_for_dossier dossier
    replace_tags(object, dossier)
  end

  def body_for_dossier dossier
    replace_tags(body, dossier)
  end

  def replace_tags string, dossier
    TAGS.inject(string) do |acc, tag|
      acc.gsub!("--#{tag.first}--", replace_tag(tag.first.to_sym, dossier)) || acc
    end
  end

  module ClassMethods
    def slug
      self.name.demodulize.underscore.parameterize
    end

    def default
      body = ActionController::Base.new.render_to_string(template: self.name.underscore)
      self.new(object: self.const_get(:DEFAULT_OBJECT), body: body)
    end
  end

  private

  def replace_tag tag, dossier
    case tag
    when :numero_dossier
      dossier.id.to_s
    when :lien_dossier
      link_to users_dossier_recapitulatif_url(dossier), users_dossier_recapitulatif_url(dossier), target: '_blank'
    when :libelle_procedure
      dossier.procedure.libelle
    else
      '--BALISE_NON_RECONNUE--'
    end
  end
end
