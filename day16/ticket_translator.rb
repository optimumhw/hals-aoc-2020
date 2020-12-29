# frozen_string_literal: false

require 'pry'
require 'benchmark'

module TicketTranslator
  class << self
    PROCESSING_RANGES = 0
    PROCESSING_MY_TICKET = 1
    PROCESSING_TICKETS = 2

    def scan_error_rate(file_path)
      notes = IO.readlines(file_path, chomp: true).map(&:to_s)
      ranges_and_tickets = process_notes(notes)
      count_errors(ranges_and_tickets[0], ranges_and_tickets[1])
    end

    def process_notes(notes)
      ranges = []
      tickets = []

      step = PROCESSING_RANGES
      skip = 0
      notes.each do |note|
        if skip.positive?
          skip -= 1
          next
        end

        if step == PROCESSING_RANGES && note.length > 0
          ranges << process_range(note)
        elsif step == PROCESSING_RANGES && note.length == 0
          step = PROCESSING_TICKETS
          skip = 4
        else
          tickets << process_ticket(note)
        end
      end

      [ranges.flatten(1), tickets]
    end

    def process_range(note)
      ranges = note.split(':')[1].split('or')
      range_a = ranges[0].split('-').map { |s| s.strip.to_i }
      range_b = ranges[1].split('-').map { |s| s.strip.to_i }
      [range_a, range_b]
    end

    def process_ticket(note)
      note.split(',').map { |s| s.to_i }
    end

    def count_errors(ranges, tickets)
      tickets.reduce(0) { |sum, ticket| sum + ticket_error_sum(ticket, ranges) }
    end

    def ticket_error_sum(ticket, ranges)
      ticket.reduce(0) { |sum, c| sum + class_error_sum(c, ranges) }
    end

    def class_error_sum(c, ranges)
      range_check = ranges.reduce(0) { |sum, r| sum + (c >= r[0] && c <= r[1] ? 1 : 0) }
      (range_check.positive? ? 0 : c)
    end
  end
end
