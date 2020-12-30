# frozen_string_literal: false

require 'pry'
require 'benchmark'

module TicketTranslator
  class << self
    PROCESSING_FIELDS = 0
    PROCESSING_MY_TICKET = 1
    PROCESSING_TICKETS = 2

    def scan_error_rate(file_path)
      notes = IO.readlines(file_path, chomp: true).map(&:to_s)
      frt = process_notes(notes)
      count_errors(frt[0], frt[2])
    end

    def process_notes(notes)
      fields = []
      my_ticket = []
      tickets = []

      step = PROCESSING_FIELDS
      skip = 0
      notes.each do |note|
        if skip.positive?
          skip -= 1
          next
        end

        if step == PROCESSING_FIELDS && note.length > 0
          fields << process_field(note)
        elsif step == PROCESSING_FIELDS && note.length == 0
          step = PROCESSING_MY_TICKET
          skip = 1
        elsif step == PROCESSING_MY_TICKET && note.length > 0
          my_ticket = note.split(",").map{|s| s.to_i }
        elsif step == PROCESSING_MY_TICKET && note.length == 0
          step = PROCESSING_TICKETS
          skip = 1
        else
          tickets << process_ticket(note)
        end
      end

      [fields, my_ticket, tickets]
    end

    def process_field(note)
      field_name = note.split(':')[0].strip
      fields = note.split(':')[1].split('or')
      field_a = fields[0].split('-').map { |s| s.strip.to_i }
      field_b = fields[1].split('-').map { |s| s.strip.to_i }
      [field_name, [field_a, field_b]]
    end

    def process_ticket(note)
      note.split(',').map { |s| s.to_i }
    end

    # ------------------------------------------
    def count_errors(fields, tickets)
      tickets.reduce(0) { |sum, ticket| sum + ticket_error_sum(ticket, fields) }
    end

    def ticket_error_sum(ticket, fields)
      ticket.reduce(0) { |sum, tick_num| sum + ticket_num_error_sum(tick_num, fields) }
    end

    def ticket_num_error_sum(tick_num, fields)
      range_check = fields.reduce(0) { |sum, field| sum +
      (num_in_field_range?( tick_num, field[1] ) ? 1 : 0) }
      (range_check.positive? ? 0 : tick_num)
    end

    def num_in_field_range?( tick_num, field_range )
      num_in_range?( tick_num, field_range[0] ) ||
      num_in_range?( tick_num, field_range[1] )
    end

    def num_in_range?( tick_num, range )
      tick_num >= range[0] && tick_num <= range[1]
    end

    #  ================ part 2 ============================

    def field_product(file_path, phrases)
        notes = IO.readlines(file_path, chomp: true).map(&:to_s)
        frt = process_notes(notes)

        fields = frt[0]
        my_ticket = frt[1]
        tickets = frt[2].select{ |ticket| ticket_error_sum( ticket, fields) == 0 }

        position_and_fields = map_fields_to_positions( fields, my_ticket, tickets )

        all_field_names = fields.map{ |f| f[0]}
        field_names = []
        phrases.each do |p|
          field_names <<  all_field_names.select{|fn| fn.match?(p) }
        end

        arr = field_names.flatten.map{ |fn| position_and_fields.select{|k,v| v.include?(fn)}.keys }
        ss = arr.flatten
        values = ss.map{ |n| my_ticket[n]}
        tt = values.reduce(1){|prod, v| prod * v }

        binding.pry

        tt
    end

    def map_fields_to_positions( fields, my_ticket, tickets )

      all_choices = fields.map{ |f| f[0]}
      choices_left = fields.map{ |f| f[0]}
      position_and_name = {}

      (0..my_ticket.length-1).each do |position|

        pp "THE POSTION IS #{position}"

        nums_in_position = (tickets << my_ticket).map{|t| t[position]}

        pp "numbers in this position: #{nums_in_position }"

        pos_choices = choices_left
        nums_in_position.each do |tick_num|
          fields_for_ticknum = fields.select{ |f| num_in_field_range?( tick_num, f[1] ) }.map{|f| f[0]}
          pos_choices =  pos_choices & fields_for_ticknum
          # pp "fields: #{fields_for_ticknum}"
          pp "pfields: #{pos_choices}"
        end

        position_and_name[position] = pos_choices
        choices_left = choices_left - pos_choices

        binding.pry

        # { name => position}
      end

      position_and_name

    end

    def possible_fields(fields, position)
      z = fields.select{ |f| position_in_field_range?( position, f[1])  }
      z.select{ |tick_num|  }
      binding.pry
      z
    end



    def possible_fields(fields, position)
      z = fields.select{ |f| position_in_field_range?( position, f[1])  }
      binding.pry
      z
    end
  end
end
