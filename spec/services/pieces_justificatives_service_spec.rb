require 'spec_helper'

describe PiecesJustificativesService do
  let(:user) { create(:user) }
  let(:safe_file) { true }

  before :each do
    allow(ClamavService).to receive(:safe_file?).and_return(safe_file)
  end

  let(:hash) { {} }
  let!(:tpj_not_mandatory) do
    TypeDePieceJustificative.create(libelle: 'not mandatory', mandatory: false)
  end
  let!(:tpj_mandatory) do
    TypeDePieceJustificative.create(libelle: 'justificatif', mandatory: true)
  end
  let(:procedure) { Procedure.create(types_de_piece_justificative: tpjs) }
  let(:dossier) { Dossier.create(procedure: procedure) }
  let(:errors) { PiecesJustificativesService.upload!(dossier, user, hash) }
  let(:tpjs) { [tpj_not_mandatory] }

  describe 'self.upload!' do
    context 'when no params are given' do
      it { expect(errors).to eq([]) }
    end

    context 'when something wrong with file save' do
      let(:hash) do
        {
          "piece_justificative_#{tpj_not_mandatory.id}" =>
          double(path: '', original_filename: 'file')
        }
      end

      it { expect(errors).to match(["le fichier not mandatory n'a pas pu être sauvegardé"]) }
    end

    context 'when a virus is provided' do
      let(:safe_file) { false }
      let(:hash) do
        {
          "piece_justificative_#{tpj_not_mandatory.id}" =>
          double(path: '', original_filename: 'bad_file')
        }
      end

      it { expect(errors).to match(['bad_file: <b>Virus détecté !!</b>']) }
    end
  end

  describe 'missing_pj_error_messages' do
    let(:errors) { PiecesJustificativesService.missing_pj_error_messages(dossier) }
    let(:tpjs) { [tpj_mandatory] }

    context 'when no params are given' do
      it { expect(errors).to match(['Le document justificatif doit être fourni.']) }
    end

    context 'when the piece justificative is provided' do
      before :each do
        # we are messing around piece_justificative
        # because directly doubling carrierwave params seems complicated

        piece_justificative_double = double(type_de_piece_justificative: tpj_mandatory)
        expect(dossier).to receive(:pieces_justificatives).and_return([piece_justificative_double])
      end

      it { expect(errors).to match([]) }
    end
  end
end
