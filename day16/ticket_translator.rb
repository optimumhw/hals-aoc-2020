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
          my_ticket = note.split(',').map { |s| s.to_i }
        elsif step == PROCESSING_MY_TICKET && note.length == 0
          step = PROCESSING_TICKETS
          skip = 1
        else
          tickets << process_ticket(note) if note.length.positive?
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
      range_check = fields.reduce(0) do |sum, field|
        sum +
          (num_in_field_range?(tick_num, field[1]) ? 1 : 0)
      end
      (range_check.positive? ? 0 : tick_num)
    end

    def num_in_field_range?(tick_num, field_range)
      num_in_range?(tick_num, field_range[0]) ||
        num_in_range?(tick_num, field_range[1])
    end

    def num_in_range?(tick_num, range)
      tick_num >= range[0] && tick_num <= range[1]
    end

    #  ================ part 2 ============================

    def field_product(file_path, phrases)
      notes = IO.readlines(file_path, chomp: true).map(&:to_s)
      notes_fields = process_notes(notes)

      services = notes_fields[0]
      my_ticket = notes_fields[1]
      tickets = notes_fields[2].select { |ticket| ticket_error_sum(ticket, services).zero? }

      position_and_fields = map_fields_to_positions(services, my_ticket, tickets)

      field_names = phrases.map { |p| services.map { |f| f[0]}.select { |fn| fn.match?(p) } }

      ticket_positions = field_names.flatten.map do |fn|
        position_and_fields
          .select { |_k, v| v.include?(fn)}
      end .flatten(1).to_h.keys

      my_ticket_values_and_index =
        my_ticket.map.with_index { |ticket_value, index| [index, ticket_value]}
                 .to_h

      ticket_positions.map { |n| my_ticket_values_and_index[n]}
                      .reduce(1) { |prod, v| prod * v }
    end

    def map_fields_to_positions(fields, my_ticket, tickets)
      tickets_and_mine = tickets << my_ticket
      all_choices = fields.map { |f| f[0]}

      position_and_name = {}

      (0..my_ticket.length - 1).each do |position|
        nums_in_position = tickets_and_mine.map { |t| t[position]}
        pos_choices = all_choices
        nums_in_position.each do |tick_num|
          fields_for_ticknum = fields.select { |f| num_in_field_range?(tick_num, f[1]) }
                                     .map { |f| f[0]}
          pos_choices &= fields_for_ticknum
        end
        position_and_name[position] = pos_choices
      end
      compute_differences(position_and_name.sort_by { |_k, v| v.length})
    end

    def compute_differences(position_and_name)
      (0..(position_and_name.length - 2)).each do |a_index|
        next if position_and_name[a_index][1].length.zero?

        ((a_index + 1)..(position_and_name.length - 1)).each do |b_index|
          position_and_name[b_index][1] -= position_and_name[a_index][1]
        end
      end

      position_and_name
    end
  end
end
