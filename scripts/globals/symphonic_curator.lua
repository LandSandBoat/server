-----------------------------------
-- Symphonic Curator (Moghouse)
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/utils")
-----------------------------------

-- Song data, from Windower Addon: setbgm.lua
--[[
    [25]='Voracious Resurgence Unknown 1', [26]='Voracious Resurgence Unknown 2', [27]='Voracious Resurgence Unknown 3', [28]='Voracious Resurgence Unknown 4', [29]="Devils' Delight",
    [40]='Cloister of Time and Souls', [41]='Royal Wanderlust', [42]='Snowdrift Waltz', [43]='Troubled Shadows', [44]='Where Lords Rule Not', [45]='Summers Lost', [46]='Goddess Divine', [47]='Echoes of Creation', [48]='Main Theme', [49]='Luck of the Mog',
    [50]='Feast of the Ladies', [51]='Abyssea - Scarlet Skies, Shadowed Plains', [52]='Melodies Errant', [53]='Shinryu', [54]='Everlasting Bonds', [55]='Provenance Watcher', [56]='Where it All Begins', [57]='Steel Sings, Blades Dance', [58]='A New Direction', [59]='The Pioneers',
    [60]='Into Lands Primeval - Ulbuka', [61]="Water's Umbral Knell", [62]='Keepers of the Wild', [63]='The Sacred City of Adoulin', [64]='Breaking Ground', [65]='Hades', [66]='Arciela', [67]='Mog Resort', [68]='Worlds Away', [69]="Distant Worlds (Nanaa Mihgo's version)",
    [70]='Monstrosity', [71]="The Pioneers (Nanaa Mihgo's version)", [72]='The Serpentine Labyrinth', [73]='The Divine', [74]='Clouds Over Ulbuka', [75]='The Price', [76]='Forever Today', [77]='Distant Worlds (Instrumental)', [78]='Forever Today (Instrumental)', [79]='Iroha',
    [80]='The Boundless Black', [81]='Isle of the Gods', [82]='Wail of the Void', [83]="Rhapsodies of Vana'diel", [84]="Full Speed Ahead!", [85]="Times Grow Tense", [86]="Shadow Lord (Record Keeper Remix)", [87]="For a Friend", [88]="Between Dreams and Reality", [89]="Disjoined One", [90]="Winds of Change",
    [101]='Battle Theme', [102]='Battle in the Dungeon #2', [103]='Battle Theme #2', [104]='A Road Once Traveled', [105]='Mhaura', [106]='Voyager', [107]="The Kingdom of San d'Oria", [108]="Vana'diel March", [109]='Ronfaure',
    [110]='The Grand Duchy of Jeuno', [111]='Blackout', [112]='Selbina', [113]='Sarutabaruta', [114]='Batallia Downs', [115]='Battle in the Dungeon', [116]='Gustaberg', [117]="Ru'Lude Gardens", [118]='Rolanberry Fields', [119]='Awakening',
    [120]="Vana'diel March #2", [121]='Shadow Lord', [122]='One Last Time', [123]='Hopelessness', [124]='Recollection', [125]='Tough Battle', [126]='Mog House', [127]='Anxiety', [128]='Airship', [129]='Hook, Line and Sinker',
    [130]='Tarutaru Female', [131]='Elvaan Female', [132]='Elvaan Male', [133]='Hume Male', [134]='Yuhtunga Jungle', [135]='Kazham', [136]='The Big One', [137]='A Realm of Emptiness', [138]="Mercenaries' Delight", [139]='Delve',
    [140]='Wings of the Goddess', [141]='The Cosmic Wheel', [142]='Fated Strife -Besieged-', [143]='Hellriders', [144]='Rapid Onslaught -Assault-', [145]='Encampment Dreams', [146]='The Colosseum', [147]='Eastward Bound...', [148]='Forbidden Seal', [149]='Jeweled Boughs',
    [150]='Ululations from Beyond', [151]='The Federation of Windurst', [152]='The Republic of Bastok', [153]='Prelude', [154]='Metalworks', [155]='Castle Zvahl', [156]="Chateau d'Oraguille", [157]='Fury', [158]='Sauromugue Champaign', [159]='Sorrow',
    [160]='Repression (Memoro de la Stono)', [161]='Despair (Memoro de la Stono)', [162]='Heavens Tower', [163]='Sometime, Somewhere', [164]='Xarcabard', [165]='Galka', [166]='Mithra', [167]='Tarutaru Male', [168]='Hume Female', [169]='Regeneracy',
    [170]='Buccaneers', [171]='Altepa Desert', [172]='Black Coffin', [173]='Illusions in the Mist', [174]='Whispers of the Gods', [175]="Bandits' Market", [176]='Circuit de Chocobo', [177]='Run Chocobo, Run!', [178]='Bustle of the Capital', [179]="Vana'diel March #4",
    [180]='Thunder of the March', [181]='Dash de Chocobo (Low Quality)', [182]='Stargazing', [183]="A Puppet's Slumber", [184]='Eternal Gravestone', [185]='Ever-Turning Wheels', [186]='Iron Colossus', [187]='Ragnarok', [188]='Choc-a-bye Baby', [189]='An Invisible Crown',
    [190]="The Sanctuary of Zi'Tah", [191]='Battle Theme #3', [192]='Battle in the Dungeon #3', [193]='Tough Battle #2', [194]='Bloody Promises', [195]='Belief', [196]='Fighters of the Crystal', [197]='To the Heavens', [198]="Eald'narche", [199]="Grav'iton",
    [200]='Hidden Truths', [201]='End Theme', [202]='Moongate (Memoro de la Stono)', [203]='Ancient Verse of Uggalepih', [204]="Ancient Verse of Ro'Maeve", [205]='Ancient Verse of Altepa', [206]='Revenant Maiden', [207]="Ve'Lugannon Palace", [208]='Rabao', [209]='Norg',
    [210]="Tu'Lia", [211]="Ro'Maeve", [212]='Dash de Chocobo', [213]='Hall of the Gods', [214]='Eternal Oath', [215]='Clash of Standards', [216]='On this Blade', [217]='Kindred Cry', [218]='Depths of the Soul', [219]='Onslaught',
    [220]='Turmoil', [221]='Moblin Menagerie - Movalpolos', [222]='Faded Memories - Promyvion', [223]='Conflict: March of the Hero', [224]='Dusk and Dawn', [225]="Words Unspoken - Pso'Xja", [226]='Conflict: You Want to Live Forever?', [227]='Sunbreeze Shuffle', [228]="Gates of Paradise - The Garden of Ru'Hmet", [229]='Currents of Time',
    [230]='A New Horizon - Tavnazian Archipelago', [231]='Celestial Thunder', [232]='The Ruler of the Skies', [233]="The Celestial Capital - Al'Taieu", [234]='Happily Ever After', [235]='First Ode: Nocturne of the Gods', [236]='Fourth Ode: Clouded Dawn', [237]='Third Ode: Memoria de la Stona', [238]='A New Morning', [239]='Jeuno -Starlight Celebration-',
    [240]='Second Ode: Distant Promises', [241]='Fifth Ode: A Time for Prayer', [242]='Unity', [243]="Grav'iton", [244]='Revenant Maiden', [245]='The Forgotten City - Tavnazian Safehold', [246]='March of the Allied Forces', [247]='Roar of the Battle Drums', [248]='Young Griffons in Flight', [249]='Run Maggot, Run!',
    [250]='Under a Clouded Moon', [251]='Autumn Footfalls', [252]='Flowers on the Battlefield', [253]='Echoes of a Zypher', [254]='Griffons Never Die',
    [900]='Distant Worlds'
]]

tpz = tpz or {}
tpz.symphonic_curator = tpz.symphonic_curator or {}

tpz.symphonic_curator.onTrigger = function(player, npc)

   -- All music type 6 (Moghouse)
    local song_packs = 0

    -- Default: Mog House (126), Vana'diel March (108)
    song_packs = utils.mask.setBit(song_packs, 0, 1)

    song_packs = utils.mask.setBit(song_packs, 1, player:hasKeyItem(tpz.ki.SHEET_OF_SAN_DORIAN_TUNES))   -- The Kingdom of San d'Oria (107), Chateau d'Oraguille (156), Ronfaure (109)
    song_packs = utils.mask.setBit(song_packs, 2, player:hasKeyItem(tpz.ki.SHEET_OF_BASTOKAN_TUNES))     -- The Republic of Bastok (152), Metalworks (154), Gustaberg (116)
    song_packs = utils.mask.setBit(song_packs, 3, player:hasKeyItem(tpz.ki.SHEET_OF_WINDURSTIAN_TUNES))  -- The Federation of Windurst (151), Heavens Tower (162), Sarutabaruta (113)
    song_packs = utils.mask.setBit(song_packs, 4, player:hasKeyItem(tpz.ki.SHEET_OF_E_ADOULINIAN_TUNES)) -- The Sacred City of Adoulin (63)
    song_packs = utils.mask.setBit(song_packs, 5, player:hasKeyItem(tpz.ki.SHEET_OF_W_ADOULINIAN_TUNES)) -- The Pioneers (59)
    song_packs = utils.mask.setBit(song_packs, 6, player:hasKeyItem(tpz.ki.SHEET_OF_ZILART_TUNES))       -- Kazham (135), The Sanctuary of Zi'Tah (190), Tu'Lia (210)
    -- Next page
    song_packs = utils.mask.setBit(song_packs, 7, player:hasKeyItem(tpz.ki.SHEET_OF_CONFLICT_TUNES))     -- Awakening (119), Belief (195), A Realm of Emptiness (137)
    song_packs = utils.mask.setBit(song_packs, 8, player:hasKeyItem(tpz.ki.SHEET_OF_PROMATHIA_TUNES))    -- Distant Worlds (900)
    song_packs = utils.mask.setBit(song_packs, 9, player:hasKeyItem(tpz.ki.SHEET_OF_ADOULINIAN_TUNES))   -- Forever Today (76)
    song_packs = utils.mask.setBit(song_packs, 10, false)                                                -- Unknown Item: Rhapsodies of Vana'diel (83)
    song_packs = utils.mask.setBit(song_packs, 11, player:hasKeyItem(tpz.ki.SHEET_OF_SHADOW_LORD_TUNES)) -- Awakening (The Shadow Lord Battle) (FFRK Ver.) (119)
    song_packs = utils.mask.setBit(song_packs, 12, player:hasKeyItem(tpz.ki.SHEET_OF_MAPITOTO_TUNES))    -- Full Speed Ahead! (84)
    song_packs = utils.mask.setBit(song_packs, 13, player:hasKeyItem(tpz.ki.SHEET_OF_ALTAIEU_TUNES))     -- The Celestial Capital - Al'Taieu (233)
    song_packs = utils.mask.setBit(song_packs, 14, player:hasKeyItem(tpz.ki.SHEET_OF_JEUNO_TUNES))       -- The Grand Duchy of Jeuno (110), Ru'Lude Gardens (117)
    song_packs = utils.mask.setBit(song_packs, 15, player:hasKeyItem(tpz.ki.SHEET_OF_HARVEST_TUNES))     -- Devils' Delight (29)

    -- 0000 = all instruments shown
    -- 1111 = all instruments hidden
    local instruments_available = 15

    -- TODO: Make binding to confirm that these are placed furnitures
    instruments_available = utils.mask.setBit(instruments_available, 0, not player:hasItem(426))  -- Orchestrion
    instruments_available = utils.mask.setBit(instruments_available, 1, not player:hasItem(3677)) -- Spinet
    instruments_available = utils.mask.setBit(instruments_available, 2, not player:hasItem(286))  -- Nanaa Statue I
    instruments_available = utils.mask.setBit(instruments_available, 3, not player:hasItem(287))  -- Nanaa Statue II

    local arg0 = 0 -- Junk
    local arg1 = 4095 -- Must be positive
    local arg2 = song_packs
    local arg3 = instruments_available

    player:startEvent(30034, arg0, arg1, arg2, arg3)
end

-- The options that comes through the event doesn't line up with the song request packet,
-- so link them using this table
-- TODO: There is some relationship between the instrument and the index, based around multiples of 16
-- The relationship (for Orchestrion) is: index = ((option - 2) / 16) + 1
-- One of the arguments from caps with the orchetron is -2
local optionToSongLookup = {
    [1]   = 112, -- Selbina
    [2]   = 126, -- Mog House
    [3]   = 126, -- Mog House
    [4]   = 126, -- Mog House
    [17]  = 196, -- Fighters of the Crystal
    [18]  = 108, -- Vana'diel March
    [19]  = 900, -- Distant Worlds
    [20]  = 59,  -- The Pioneers
    [33]  = 230, -- A New Horizon
    [34]  = 107, -- The Kingdom of San d'Oria
    [49]  = 187, -- Ragnarok
    [50]  = 156, -- Chateau d'Oraguille
    [65]  = 215, -- Clash of Standards
    [66]  = 109, -- Ronfaure
    [81]  = 47,  -- Echoes of Creation
    [82]  = 152, -- The Republic of Bastok
    [97]  = 49,  -- Luck of the Mog
    [98]  = 154, -- Metalworks
    [113] = 50,  -- Feast of the Ladies
    [114] = 116, -- Gustaberg
    [129] = 51,  -- Abyssea
    [130] = 151, -- The Federation of Windurst
    [145] = 52,  -- Melodies Errant
    [146] = 162, -- Heavens Tower
    [161] = 109, -- Ronfaure
    [162] = 113, -- Sarutabaruta
    [177] = 251, -- Autumn Footfalls
    [178] = 63,  -- The Sacred City of Adoulin
    [193] = 48,  -- Main Theme
    [194] = 59,  -- The Pioneers
    [209] = 126, -- Mog House
    [210] = 135, -- Kazham
    [226] = 190, -- The Sanctuary of Zi'Tah
    [242] = 210, -- Tu'Lia
    -- Next Page
    [258] = 119, -- Awakening
    [274] = 195, -- Belief
    [290] = 137, -- A Realm of Emptiness
    [306] = 900, -- Distant Worlds
    [322] = 76,  -- Forever Today
    [338] = 83,  -- Unknown Item: Rhapsodies of Vana'diel
    [354] = 119, -- Awakening (The Shadow Lord Battle) (FFRK Ver.)
    [370] = 84,  -- Full Speed Ahead!
    [386] = 233, -- The Celestial Capital - Al'Taieu
    [402] = 110, -- The Grand Duchy of Jeuno
    [418] = 117, -- Ru'Lude Gardens
    [434] = 29,  -- Devils' Delight
}

tpz.symphonic_curator.onEventUpdate = function(player, csid, option)
    -- Preview
    player:ChangeMusic(6, optionToSongLookup[option])
end

tpz.symphonic_curator.onEventFinish = function(player, csid, option)
    if option == 0 then
        -- Reset
        player:ChangeMusic(6, 126) -- Mog House
    else
        -- Confirmed, set
        player:ChangeMusic(6, optionToSongLookup[option])
    end
end
