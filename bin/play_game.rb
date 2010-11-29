# encoding: utf-8
$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
require 'pitch'

game = Pitch::Game.new
game.run

