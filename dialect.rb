#!/usr/bin/env ruby
#botstuff
require 'discordrb'
token = File.read("conf/token.txt")
bot = Discordrb::Commands::CommandBot.new token: token, prefix: '/'

#parsing text

@deck = Hash.new
@cleandeck = Hash.new

def parseAgeCards(file)
	return file.read.split("\n\n\n").map{|e| e.split("\n\n").map{|f| f.gsub("\n"," ")}}.map{|e|
		if e[0].match?(/[(]ACTION[)]/)
			{"title" => e[0],
				"desc" => e[1],
				"instructions" => e[2].
					gsub("Make a Connection:","**Make a Connection:**").
					gsub("Build a Word:","\n**Build a Word:**").
					gsub("Skip the Build a Word phase.","\n**Skip the Build a Word phase.**\n").
					gsub("In the conversation,","\n**In the conversation,**").
					gsub("Finally,","\n**Finally,**").
					gsub("Example:","\n**Example:**"),
				"blurb" => e[3]}
		else
			{"title" => e[0], "desc" => e[1], "blurb" => e[2]}
		end
	}
end

#archetypes
file = File.open("decks/archetypes.txt")
@cleandeck["archetypes"] = file.read.split("\n\n\n").map{|e| e.split("\n\n").map{|f| f.gsub("\n"," ")}}.map{|e|
	{"title" => e[0], "desc" => e[1], "aspects" => e[2]}
}
@deck["archetypes"] = @cleandeck["archetypes"].clone
pp @deck["archetypes"]
file.close

#age 1
file = File.open("decks/age-1.txt")
@cleandeck["age1"] = parseAgeCards(file)
@deck["age1"] = @cleandeck["age1"].clone
pp @deck["age1"]
file.close

#age 2
file = File.open("decks/age-2.txt")
@cleandeck["age2"] = parseAgeCards(file)
@deck["age2"] = @cleandeck["age2"].clone
pp @deck["age2"]
file.close

#age 3
file = File.open("decks/age-3.txt")
@cleandeck["age3"] = parseAgeCards(file)
@deck["age3"] = @cleandeck["age3"].clone
pp @deck["age3"]
file.close

#legacy
file = File.open("decks/legacy.txt")
@cleandeck["legacy"] = file.read.split("\n\n\n").map{|e| e.split("\n\n").map{|f| f.gsub("\n"," ")}}.map{|e|
		{"op1" => e[1], "op2" => e[3], "op3" => e[5]}
}
@deck["legacy"] = @cleandeck["legacy"].clone
pp @deck["legacy"]
file.close

#deal
bot.command :archetypes do |event|
	File.open("./card-backs/img76.jpg", "r") do |file|
		output = ""
		for ii in (0..2)
			unless @deck["archetypes"].empty?
				card = @deck["archetypes"].shuffle!.pop
				pp card
				output << "|| **" + card["title"] + "**\n"
				output << card["desc"] + "\n"
				output << "**" + card["aspects"] + "** ||\n\n"
			else
				output << "**No cards left**\n"
			end
		end
		embed = Discordrb::Webhooks::Embed.new
		embed.title = "Archetype"
		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: "https://media.discordapp.net/attachments/789161688221483038/793231604184252426/img76.jpg")
		embed.description = output
		event.send_embed(event.user.mention, embed)
	end
end

bot.command :age1 do |event|
	File.open("./card-backs/img210.jpg", "r") do |file|
		output = ""
		for ii in (0..2)
			unless @deck["age1"].empty?
				card = @deck["age1"].shuffle!.pop
				pp card
				output << "|| **" + card["title"] + "**\n"
				output << card["desc"] + "\n"
				if not card["instructions"].nil?
					output << "*" + card["instructions"] + "*\n"
				end
				output << "**" + card["blurb"] + "** ||\n\n"
			else
				output << "**No cards left**\n"
			end
		end
		embed = Discordrb::Webhooks::Embed.new
		embed.title = "Age 1"
		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: "https://media.discordapp.net/attachments/789161688221483038/793238643216351242/img210.jpg")
		embed.description = output
		event.send_embed(event.user.mention, embed)
	end
end

bot.command :age2 do |event|
	File.open("./card-backs/img409.jpg", "r") do |file|
		output = ""
		unless @deck["age2"].empty?
			card = @deck["age2"].shuffle!.pop
			pp card
			output << "|| **" + card["title"] + "**\n"
			output << card["desc"] + "\n"
			if not card["instructions"].nil?
				output << "*" + card["instructions"] + "*\n"
			end
			output << "**" + card["blurb"] + "** ||\n\n"
		else
			output << "**No cards left**\n"
		end
		embed = Discordrb::Webhooks::Embed.new
		embed.title = "Age 2"
		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: "https://media.discordapp.net/attachments/789161688221483038/793238746064879616/img409.jpg")
		embed.description = output
		event.send_embed(event.user.mention, embed)
	end
end

bot.command :age3 do |event|
	File.open("./card-backs/img696.jpg", "r") do |file|
		output = ""
		unless @deck["age3"].empty?
			card = @deck["age3"].shuffle!.pop
			pp card
			output << "|| **" + card["title"] + "**\n"
			output << card["desc"] + "\n"
			if not card["instructions"].nil?
				output << "*" + card["instructions"] + "*\n"
			end
			output << "**" + card["blurb"] + "** ||\n\n"
		else
			output << "**No cards left**\n"
		end
		embed = Discordrb::Webhooks::Embed.new
		embed.title = "Age 3"
		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: "https://media.discordapp.net/attachments/789161688221483038/793232127377670144/img696.jpg")
		embed.description = output
		event.send_embed(event.user.mention, embed)
	end
end

bot.command :legacy do |event|
	File.open("./card-backs/img834.jpg", "r") do |file|
		output = ""
		unless @deck["legacy"].empty?
			card = @deck["legacy"].shuffle!.pop
			output << "*Choose one option for your final narrated epilogue. It may be about your character or the Isolation as a whole. End your story.*\n||"
			output << card["op1"] + "\n**OR**\n"
			output << card["op2"] + "\n**OR**\n"
			output << card["op3"] + " ||"
		else
			output << "**No cards left**\n"
		end
		embed = Discordrb::Webhooks::Embed.new
		embed.title = "Legacy"
		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: "https://media.discordapp.net/attachments/789161688221483038/793232158944788530/img834.jpg")
		embed.description = output
		event.send_embed(event.user.mention, embed)
	end
end

bot.command :reset do |event, deckname|
	if deckname.nil?
		@deck["archetypes"] = @cleandeck["archetypes"].clone
		@deck["age1"] = @cleandeck["age1"].clone
		@deck["age2"] = @cleandeck["age2"].clone
		@deck["age3"] = @cleandeck["age3"].clone
		@deck["legacy"] = @cleandeck["legacy"].clone
		return "Decks reset!"
	elsif @deck.has_key?(deckname)
		@deck[deckname] = @cleandeck[deckname]
		return "#{deckname} reset!"
	else
		return "#{deckname} is an invalid key!"
	end
end

bot.run