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

    # def self.find(id)
    #     # Convertir l'id en entier pour s'assurer de la comparaison numérique
    #     id = id.to_i
    #     liste = Gossip.all
    #     liste.each_with_index do |element, index|
    #         # Adjust the index to match the ID starting from 1
    #         if index + 1 == id
    #             return element
    #             puts element
    #         end
    #     end
    #     return nil
    # end

    def self.find(id)
        id = id.to_i  # Convertir l'ID en entier pour la comparaison
        CSV.foreach("./db/gossip.csv", headers: true).with_index(1) do |row, index|
          if index == id
            return Gossip.new(row['author'], row['content'])
          end
        end
        return nil  # Retourne nil si aucun potin n'est trouvé avec cet ID
    end


end
