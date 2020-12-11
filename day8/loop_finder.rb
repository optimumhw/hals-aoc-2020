# frozen_string_literal: true

require 'pry'
require 'benchmark'

module LoopFinder
  class << self
    def last_acc_value(file_path)
      strings = IO.readlines(file_path, chomp: true)

      commands = strings.map(&:split).map { |s| [s[0], s[1].to_i, 0] }

      index = 0
      acc = 0

      loop do
        return acc if commands[index][2] == 1

        commands[index][2] = 1

        case commands[index][0]
        when 'nop'
          index += 1
        when 'acc'
          acc += commands[index][1]
          index += 1
        when 'jmp'
          index += commands[index][1]
        else raise ArgumentError
        end
      end
    end

    def fix_loop(file_path)
      strings = IO.readlines(file_path, chomp: true)

      commands = strings.map(&:split).map { |s| [s[0], s[1].to_i, 0] }
      jump_nop_locals = commands.map.with_index { |w, index| [w[0], index] }.select { |c| c[0] == 'nop' || c[0] == 'jmp' }

      index = 0
      jnl_index = -1
      acc = 0

      loop do
        return acc if index >= commands.length

        if commands[index][2] == 1

          commands.each { |cmd| cmd[2] = 0 }

          if jnl_index >= 0
            commands[jump_nop_locals[jnl_index][1]][0] =
               commands[jump_nop_locals[jnl_index][1]][0] == 'nop' ? 'jmp' : 'nop'
          end
          jnl_index += 1
          commands[jump_nop_locals[jnl_index][1]][0] =
               commands[jump_nop_locals[jnl_index][1]][0] == 'nop' ? 'jmp' : 'nop'

          acc = 0
          index = 0
        else

          commands[index][2] = 1

          case commands[index][0]
          when 'nop'
            index += 1
          when 'acc'
            acc += commands[index][1]
            index += 1
          when 'jmp'
            index += commands[index][1]
          else raise ArgumentError
          end
        end
      end
    end
  end
end
