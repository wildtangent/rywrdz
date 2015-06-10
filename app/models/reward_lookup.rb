# Class to handle looking up rewards from tariffs
# Currently data is looked up from a YAML file but this could easily be changed
# to handle more advanced logic
class RewardLookup
  @rewards_config = File.join(Rails.root, 'config', 'rewards.yml')
  @rewards = YAML.load_file(@rewards_config)['rewards'].with_indifferent_access

  # Return a reward based on a given tariff
  def self.find(tariff)
    @rewards[tariff] || []
  end
end
