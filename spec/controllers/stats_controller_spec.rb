require 'spec_helper'

describe StatsController, type: :controller do
  describe '#thirty_days_flow_hash' do
    before do
      FactoryGirl.create(:procedure, :published => , :create_at)
      FactoryGirl.create(:procedure, :published => , :create_at)
      FactoryGirl.create(:procedure, :published => , :create_at)
    end

    let (:association) { Procedure.where(:published => true) }

    subject { StatsController.new.send(:thirty_days_flow_hash, association) }

    it { expect(subject).to eq {} }
  end
end
