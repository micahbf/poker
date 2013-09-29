# encoding: utf-8
require 'colorize'

class Card
  attr_reader :value, :suit

  VALUES = (2..14).to_a
  SUITS = [:spades, :clubs, :hearts, :diamonds]
  FACE_CARDS = {
    11 => :jack,
    12 => :queen,
    13 => :king,
    14 => :ace
  }
  UNICODE_SUITS = {
    :spades => '♠',
    :clubs => '♣',
    :hearts => '♥',
    :diamonds => '♦'
  }

  def initialize(value, suit)
    @value = value
    @suit = suit
  end
  
  def color
    case @suit
    when :spades, :clubs
      return :black
    when :hearts, :diamonds
      return :red
    end
  end
  
  def face
    case @value
    when (2..10)
      return @value
    when (11..14)
      return FACE_CARDS[@value].to_s[0].upcase
    end
  end
  
  def render_fancy
    "#{face}#{UNICODE_SUITS[@suit]} ".colorize(:color => color, :background => :white)
  end
end