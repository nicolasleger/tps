require 'spec_helper'

feature 'France Connect Connexion' do

  context 'when user is on login page' do

    before do
      visit new_user_session_path
    end

    scenario 'link to France Connect is present' do
      expect(page).to have_css('a#france_connect')
    end

    context 'and click on france connect link' do
      let(:code) { 'plop' }

      context 'when authentification is ok' do
        before do
          allow_any_instance_of(FranceConnectClient).to receive(:authorization_uri).and_return(france_connect_callback_path(code: code))
          allow(FranceConnectService).to receive(:retrieve_user_informations).and_return(Hashie::Mash.new(email: 'patator@cake.com'))
          page.find_by_id('france_connect').click
        end

        scenario 'he is redirected to france connect' do
          expect(page).to have_content('Vos dossiers')
        end
      end

      context 'when authentification is not ok' do
        before do
          allow_any_instance_of(FranceConnectClient).to receive(:authorization_uri).and_return(france_connect_callback_path(code: code))
          allow(FranceConnectService).to receive(:retrieve_user_informations) { raise Rack::OAuth2::Client::Error.new(500, error: 'Unknown') }
          page.find_by_id('france_connect').click
        end

        scenario 'he is redirected to login page' do
          expect(page).to have_css('a#france_connect')
        end

        scenario 'error message is displayed' do
          expect(page).to have_content(I18n.t('errors.messages.france_connect.connexion'))
        end
      end
    end
  end


  feature 'redirection' do
    before do
      visit initial_path
    end
    context 'when he use france connect' do
      let(:code) { 'my_code' }
      let(:email) { 'plop@plop.com' }
      let(:siret) { '00000000000000' }
      let(:user_infos) { Hashie::Mash.new(email: email, siret: siret) }
      before do
        allow_any_instance_of(FranceConnectClient).to receive(:authorization_uri).and_return(france_connect_callback_path(code: code))
        allow(FranceConnectService).to receive(:retrieve_user_informations).and_return(user_infos)
        page.find_by_id('france_connect').click
      end
      context 'when starting page is dossiers list' do
        let(:initial_path) { users_dossiers_path }
        scenario 'he is redirected to dossier list' do
          expect(page).to have_css('#users_dossiers_index')
        end
      end
      context 'when starting page is procedure' do
        let(:procedure) { create(:procedure) }
        let(:initial_path) { users_siret_path(procedure_id: procedure.id ) }
        scenario 'he is redirected to siret page' do
          expect(page).to have_css('#users_siret_index')
        end

        scenario 'the siret is already written in form' do
          expect(page.find_by_id('siret').value).to have_content(siret)
        end
      end
    end
  end
end