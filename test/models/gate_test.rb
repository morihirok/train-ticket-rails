require 'test_helper'

class GateTest < ActiveSupport::TestCase
  setup do
    @umeda = gates(:umeda)
    @juso = gates(:juso)
    @mikuni = gates(:mikuni)
  end

  test 'うめだで150円の切符を買って、じゅうそうで降りる' do
    ticket = Ticket.create!(fare: 150, entered_gate: @umeda)
    assert @juso.exit(ticket)
    assert_equal @juso, ticket.reload.exited_gate
  end

  test 'うめだで150円の切符を買って、みくにで降りる' do
    ticket = Ticket.create!(fare: 150, entered_gate: @umeda)
    refute @mikuni.exit(ticket)
    assert_nil ticket.reload.exited_gate
  end

  test 'うめだで190円の切符を買って、みくにで降りる' do
    ticket = Ticket.create!(fare: 190, entered_gate: @umeda)
    assert @mikuni.exit(ticket)
    assert_equal @mikuni, ticket.reload.exited_gate
  end
end
