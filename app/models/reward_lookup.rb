class RewardLookup
  @rewards_config = File.join(Rails.root, 'config', 'tariffs.yml')
  @rewards = YAML.load_file(@rewards_config)['tariffs'].with_indifferent_access

  # Return a reward based on a given tariff
  def self.find(tariff)
    @rewards[tariff] || []
  end
end
