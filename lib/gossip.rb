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
        CSV.read("./db/gossip.csv").each do |csv_line|
          all_gossips << Gossip.new(csv_line[0], csv_line[1])
        end
        return all_gossips
    end

    def self.find(id)
        id = id.to_i
        all_gossips = Gossip.all
        if id >= 1 && id <= all_gossips.length
          return all_gossips[id - 1]  # Soustrayez 1 car les indices commencent généralement à 0
        else
          return nil  # Retourne nil si l'ID n'est pas valide
        end
      end


end
