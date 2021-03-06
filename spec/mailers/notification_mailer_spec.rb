require "spec_helper"

RSpec.describe NotificationMailer, type: :mailer do
  describe '.send_notification' do
    let(:user) { create(:user) }
    let(:dossier) { create(:dossier, user: user) }
    let(:email) { instance_double('email', object_for_dossier: 'object', body_for_dossier: 'body') }
    subject { described_class.send_notification(dossier, email) }

    it { expect(subject.subject).to eq(email.object_for_dossier) }
    it { expect(subject.body).to eq(email.body_for_dossier) }
  end

  describe ".new_answer" do
    let(:user) { create(:user) }
    let(:dossier) { create(:dossier, user: user) }

    subject(:subject) { described_class.new_answer(dossier) }

    it { expect(subject.body).to match('Un nouveau message est disponible dans votre espace TPS.') }
    it { expect(subject.body).to include("Pour le consulter, merci de vous rendre sur #{users_dossier_recapitulatif_url(dossier_id: dossier.id)}") }
    it { expect(subject.subject).to eq("Nouveau message pour votre dossier TPS N°#{dossier.id}") }
  end
end
