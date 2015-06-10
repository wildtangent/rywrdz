require 'rails_helper'

describe RewardsController, type: :controller do
  render_views

  context 'GET /index' do
    before :each do
      get(
        :index,
        format: :json,
        account_number: '23453453453',
        tariff: '3G100MB'
      )
    end

    it 'should return a valid response' do
      expect(response).to be_ok
    end

    it 'should not have any rewards' do
      expect(JSON.parse(response.body)['rewards']).to eq []
    end
  end

  context 'GET /index with stubbed API' do
    context 'user who is entited to rewards' do
      before :each do
        es = instance_double(
          EligibilityService,
          status: 'CUSTOMER_ELIGIBLE',
          valid?: true
        )
        allow_any_instance_of(RewardsService)
          .to receive(:eligibility_service).and_return es
      end

      it 'should have some rewards' do
        get(
          :index,
          format: :json,
          account_number: '12342423423',
          tariff: '3G100MB'
        )
        expect(JSON.parse(response.body)['rewards']).to eq ['EXTRA50MB']
      end
    end

    context 'user who is not entitled to rewards' do
      before :each do
        es = instance_double(
          EligibilityService,
          status: 'CUSTOMER_INELIGIBLE',
          valid?: true
        )
        allow_any_instance_of(RewardsService)
          .to receive(:eligibility_service).and_return es
      end

      it 'should not have any rewards' do
        get(
          :index,
          format: :json,
          account_number: '12342423423',
          tariff: '3G100MB'
        )
        expect(JSON.parse(response.body)['rewards']).to eq []
      end
    end

    context 'user who encounters an API failure' do
      it 'should not have any rewards' do
        es = instance_double(
          'EligibilityService',
          status: -> { fail EligibilityService::EligibilityServiceError },
          valid?: true
        )
        allow_any_instance_of(RewardsService)
          .to receive(:eligibility_service).and_return es

        get(
          :index,
          format: :json,
          account_number: '12342423423',
          tariff: '3G100MB'
        )
        expect(JSON.parse(response.body)['rewards']).to eq []
      end
    end

    context 'user who has an invalid account' do
      it 'should return an error message if the account number is not valid' do
        get(
          :index,
          format: :json,
          account_number: '12342423423',
          tariff: '3G100MB'
        )
        expect(JSON.parse(response.body)['errors'])
          .to include 'Account details are not valid'
      end
    end
  end
end
