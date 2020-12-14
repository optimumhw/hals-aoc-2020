
require 'pry'
require 'benchmark'
require 'set'

module BagCounter
  class << self

    GOLD = "shiny gold"

    def count_bags(file_path)
      strings = IO.readlines(file_path, chomp: true)
      rule_list = process_rules(strings)

      bags = []
      rule_list.each do |rule|
          bags << build_tree(rule_list, [], rule)
      end

      # bags.map{ |bag| pp "bag: #{bag.color} sum: #{((bag.color == GOLD) ? 0 : count_paths_to_gold( bag ))}"}

      bags.reduce(0){|sum, bag| sum + ((bag.color == GOLD) ? 0 : count_paths_to_gold( bag ))}
    end

    def process_rules( info )

      rules = []
      info.map do |line|
        phrases = line.gsub('bags contain', ',')
          .gsub('bags', '').gsub('.','').split(',').map{|phrase| phrase.strip()}

        color = phrases[0]
        contents = []
        (1..(phrases.length-1)).each do |index|
          bag = phrases[index].scan(/.*(\d+)\s+(\w+\s+\w+)/).flatten
          contents << OpenStruct.new( color: bag[1], count: bag[0] ) unless bag[1].nil?
        end
        rules << OpenStruct.new( color: color, contents: contents )
      end

      rules

    end

    def build_tree( rule_list, colors, rule )

      colors << rule.color

      if rule.contents.nil? || rule.contents.empty?
        OpenStruct.new( color: rule.color, bags: [] )

      else
        bags = []
        rule.contents.each do |content|
          temp_rules = rule_list.select { |temp_rule|
             !colors.include?(temp_rule.color) && temp_rule.color == content.color
            }

          if temp_rules.length > 0
            bags << build_tree( rule_list, colors, temp_rules[0] )
          end
        end
        OpenStruct.new( color: rule.color, bags: bags )

      end

    end


    def count_paths_to_gold( bag )
      if bag.color == GOLD
        1
      elsif bag.bags == nil
        0
      else
        s = bag.bags.reduce(0){ |sum, temp_bag| sum + count_paths_to_gold( temp_bag ) }
        s = (s > 0)? 1 : 0
      end
    end


    # part 2 -------------------------
    def count_gold_contents(file_path)
      strings = IO.readlines(file_path, chomp: true)

      expand_contents( process_rules_v2(strings), [1, GOLD] ) - 1

    end


    def process_rules_v2( info )

      rules = []
      info.map do |line|
        phrases = line.gsub('bags contain', ',')
          .gsub('bags', '').gsub('.','').split(',').map{|phrase| phrase.strip()}

        color = phrases[0]
        contents = []
        (1..(phrases.length-1)).each.map do |index|
          bag = phrases[index].scan(/.*(\d+)\s+(\w+\s+\w+)/).flatten
          contents << [bag[0].to_i, bag[1]] unless bag[1].nil?
        end
       [ color, contents ]
      end
    end


    def expand_contents( rule_list, cn_color )

      contents = rule_list.select{|rule| rule[0] == cn_color[1]}[0][1]

      if contents.length == 0
        return cn_color[0]
      else
        cn_color[0] + contents.reduce(0) do | sum, next_cn_color |
          sum + (cn_color[0] * ( expand_contents( rule_list, next_cn_color )))
        end
      end
    end

  end
end
