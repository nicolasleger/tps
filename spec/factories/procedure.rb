FactoryGirl.define do
  factory :procedure do
    lien_demarche 'http://localhost'
    libelle 'Demande de subvention'
    description "Demande de subvention à l'intention des associations"

    trait :with_two_type_de_piece_justificative do
      after(:build) do |procedure, _evaluator|
        rib = create(:type_de_piece_justificative, :rib)
        msa = create(:type_de_piece_justificative, :msa)

        procedure.types_de_piece_justificative << rib
        procedure.types_de_piece_justificative << msa
      end
    end
  end
end