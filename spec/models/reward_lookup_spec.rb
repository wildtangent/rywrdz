require 'rails_helper'

describe RewardLookup do
  it 'should find a reward' do
    expect(RewardLookup.find('3G1000MB')).to eq ['EXTRA500MB']
  end

  it 'should return an empty array' do
    expect(RewardLookup.find('ThreeAtHome')).to eq []
  end
end
