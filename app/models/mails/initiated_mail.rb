module Mails
  class InitiatedMail < ActiveRecord::Base
    include MailTemplateConcern

    DISPLAYED_NAME = 'Accusé de réception'
    DEFAULT_OBJECT = 'Votre dossier TPS N°--numero_dossier-- a été bien reçu'

  end
end
