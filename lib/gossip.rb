require 'csv'
require 'pry'
class Gossip
    attr_accessor :author, :content

    def initialize(author, content)
        @author = author
        @content = content
    end

    def save
        CSV.open("./db/gossip.csv", "ab") do |csv|
            csv << [@author, @content]
        end
    end

    def self.all
        all_gossips = []
        csv_data = CSV.read("./db/gossip.csv", headers: true)
        csv_data.each do |csv_line|
            all_gossips << Gossip.new(csv_line['gossip_author'], csv_line['gossip_content'])
        end
      
        return all_gossips
    end
    def self.find(id)
        id = id.to_i
        CSV.foreach("./db/gossip.csv", headers: true).with_index(1) do |row, index|
          return { 'author' => row['gossip_author'], 'content' => row['gossip_content'] } if index == id
        end
        nil
      end


end
