module Mails
  class WithoutContinuationMail < ApplicationRecord
    include MailTemplateConcern

    DISPLAYED_NAME = 'Accusé de classement sans suite'
    DEFAULT_OBJECT = 'Votre dossier TPS N°--numero_dossier-- a été classé sans suite'

  end
end
