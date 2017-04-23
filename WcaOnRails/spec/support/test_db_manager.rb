# frozen_string_literal: true

class TestDbManager
  CONSTANT_TABLES = %w(Countries Continents Events RoundTypes Formats preferred_formats teams).freeze

  def self.fill_tables
    Dir["db/seeds/*.seeds.rb"].sort.each { |file| load file }
    Relations.compute_auxiliary_data # Ensure the 'linkings' and 'people_pairs_with_competition' tables are there.
  end
end

RSpec.describe TestDbManager do
  it "CONSTANT_TABLES includes all tables filled in the files inside /db/seeds/ directory" do
    expected_files = TestDbManager::CONSTANT_TABLES.map do |table_name|
      "db/seeds/#{table_name.underscore}.seeds.rb"
    end
    expect(Dir["db/seeds/*.seeds.rb"]).to match_array expected_files
  end
end
