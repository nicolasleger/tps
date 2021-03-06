require 'spec_helper'

describe MailTemplateConcern do
  describe '.replace_tags' do
    let(:dossier) { create :dossier }
    let(:initiated_mail) { Mails::InitiatedMail.default }

    it 'works' do
        initiated_mail.object = '[TPS] --numero_dossier-- --libelle_procedure-- --lien_dossier--'
        expected =
          "[TPS] 1 Demande de subvention " +
          "<a target=\"_blank\" href=\"http://localhost:3000/users/dossiers/1/recapitulatif\">http://localhost:3000/users/dossiers/1/recapitulatif</a>"

        expect(initiated_mail.object_for_dossier(dossier)).to eq(expected)
    end
  end
end
