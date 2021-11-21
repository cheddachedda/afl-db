Club.destroy_all
Fixture.destroy_all
Player.destroy_all
GameLog.destroy_all

start_time = Time.new

# Runs all seed files in db/seeds/ in alphabetical order of filenames
Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each { |seed| load seed }

end_time = Time.new
run_time = (end_time - start_time).round
puts "Seeded in #{ run_time } seconds"

# rails db:drop
# rails db:create
# rails db:migrate
# rails db:seed

# 662/771 players' stats scraped
# Stats scrape failed for: 13 Fischer Mcasey, 17 James Borlase, 25 Luke Brown, 28 Mitchell Hinge, 31 Reilly O'Brien, 33 Ronin O'Connor, 38 Tariek Newchurch, 41 Tom Lynch, 44 Will Hamill, 45 Archie Smith, 46 Blake Coleman, 48 Brock Smith, 51 Cameron Ellis-Yolmen, 52 Carter Michael, 55 Connor McFadyen, 60 Deividas Uosis, 62 Ely Smith, 85 Thomas Berry, 108 Lochie O'Brien, 112 Matthew Kennedy, 121 Sam Ramsay, 138 Callum Brown, 143 Isaac Chugg, 148 Jamie Elliott, 152 Jordan De Goey, 157 Liam McMahon, 163 Reef McInnes, 175 Andrew Phillips, 180 Cian McBride, 181 Cody Brand, 188 Harrison Jones, 193 Joshua Eyre, 196 Lachlan Johnson, 207 Ross McQuillan, 210 Tom Hird, 236 Leno Thomas, 240 Luke Valente, 241 Matt Taberner, 246 Nathan O'Driscoll, 263 Cameron Taheny, 265 Cooper Stephens, 272 Jack Henry, 282 Mark O'Connor, 287 Oscar Brownless, 289 Paul Tsapatolis, 295 Shannon Neale, 297 Stefan Okunbor, 299 Tom Hawkins, 303 Aiden Fyfe, 314 Darcy MacPherson, 316 Elijah Hollands, 317 Hawego Paul Oea, 327 Jez McLennan, 333 Luke Towey, 335 Matt Conroy, 340 Patrick Murtagh, 341 Rhys Nicholls, 357 Callum Brown, 358 Cameron Fleeton, 367 Jacob Wehr, 383 Ryan Angwin, 384 Sam Reid, 393 Will Shaw, 394 Xavier O'Halloran, 408 Harry Pepper, 410 Jack Saunders, 413 Jaeger O'Meara, 430 Seamus Mitchell, 432 Tim O'Brien, 439 Aaron vandenBerg, 443 Austin Bradtke, 444 Bailey Laurie, 452 Fraser Rosman, 453 Harrison Petty, 461 Joel Smith, 466 Mitch Brown, 474 Aaron Nietschke, 507 Matt McGuinness, 509 Patrick Walker, 516 Tom Campbell, 529 Jackson Mead, 530 Jake Pasini, 535 Lachlan Jones, 539 Ollie Lord, 546 Sam Hayes, 551 Taj Schofield, 557 Trent Burgoyne, 566 Bigoa Nyuon, 584 Mate Colina, 589 Noah Cumberland, 597 Tom Lynch, 630 Matthew Allison, 636 Sam Alabakis, 639 Thomas Highmore, 645 Barry O'Connor, 651 Colin O'Riordan, 664 Josh Kennedy, 672 Malachy Carruthers, 673 Marc Sheather, 674 Matthew Ling, 679 Sam Gray, 681 Sam Reid, 683 Tom Hickey, 686 Will Gould, 695 Callum Jamieson, 711 Josh Kennedy, 727 Xavier O'Neill, 729 Zane Trew, 738 Dominic Bedendo
