-----------------------------------
-- Symphonic Curator (Moghouse)
-----------------------------------
require('scripts/globals/utils')
-----------------------------------
-- See documentation/songdata.txt or documentation/MusicIDs.txt for song data.
-----------------------------------

xi = xi or {}
xi.symphonic_curator = xi.symphonic_curator or {}

xi.symphonic_curator.onTrigger = function(player, npc)
    -- The first time you click, you'll always already be listening to Mog House
    if player:getLocalVar('Symphonic_Curator_Music') == 0 then
        player:setLocalVar('Symphonic_Curator_Music', 126)
    end

    local completedROVMissions = false

    -- All music type 6 (Moghouse)
    local songPacks = 0

    -- Default: Mog House (126), Vana'diel March (108)
    songPacks = utils.mask.setBit(songPacks, 0, 1)

    -- First Page
    songPacks = utils.mask.setBit(songPacks, 1, player:hasKeyItem(xi.ki.SHEET_OF_SAN_DORIAN_TUNES))   -- The Kingdom of San d'Oria (107), Chateau d'Oraguille (156), Ronfaure (109)
    songPacks = utils.mask.setBit(songPacks, 2, player:hasKeyItem(xi.ki.SHEET_OF_BASTOKAN_TUNES))     -- The Republic of Bastok (152), Metalworks (154), Gustaberg (116)
    songPacks = utils.mask.setBit(songPacks, 3, player:hasKeyItem(xi.ki.SHEET_OF_WINDURSTIAN_TUNES))  -- The Federation of Windurst (151), Heavens Tower (162), Sarutabaruta (113)
    songPacks = utils.mask.setBit(songPacks, 4, player:hasKeyItem(xi.ki.SHEET_OF_E_ADOULINIAN_TUNES)) -- The Sacred City of Adoulin (63)
    songPacks = utils.mask.setBit(songPacks, 5, player:hasKeyItem(xi.ki.SHEET_OF_W_ADOULINIAN_TUNES)) -- The Pioneers (59)
    songPacks = utils.mask.setBit(songPacks, 6, player:hasKeyItem(xi.ki.SHEET_OF_ZILART_TUNES))       -- Kazham (135), The Sanctuary of Zi'Tah (190), Tu'Lia (210)

    -- Next page
    songPacks = utils.mask.setBit(songPacks, 7, player:hasKeyItem(xi.ki.SHEET_OF_CONFLICT_TUNES))        -- Awakening (119), Belief (195), A Realm of Emptiness (137)
    songPacks = utils.mask.setBit(songPacks, 8, player:hasKeyItem(xi.ki.SHEET_OF_PROMATHIA_TUNES))       -- Distant Worlds (900)
    songPacks = utils.mask.setBit(songPacks, 9, player:hasKeyItem(xi.ki.SHEET_OF_ADOULINIAN_TUNES))      -- Forever Today (76)
    songPacks = utils.mask.setBit(songPacks, 10, completedROVMissions)                                   -- Rhapsodies of Vana'diel (83)
    songPacks = utils.mask.setBit(songPacks, 11, player:hasKeyItem(xi.ki.SHEET_OF_SHADOW_LORD_TUNES))    -- Awakening (The Shadow Lord Battle) (FFRK Ver.) (119)
    songPacks = utils.mask.setBit(songPacks, 12, player:hasKeyItem(xi.ki.SHEET_OF_MAPITOTO_TUNES))       -- Full Speed Ahead! (84)
    songPacks = utils.mask.setBit(songPacks, 13, player:hasKeyItem(xi.ki.SHEET_OF_ALTAIEU_TUNES))        -- The Celestial Capital - Al'Taieu (233)
    songPacks = utils.mask.setBit(songPacks, 14, player:hasKeyItem(xi.ki.SHEET_OF_JEUNO_TUNES))          -- The Grand Duchy of Jeuno (110), Ru'Lude Gardens (117)
    songPacks = utils.mask.setBit(songPacks, 15, player:hasKeyItem(xi.ki.SHEET_OF_HARVEST_TUNES))        -- Devils' Delight (29)
    songPacks = utils.mask.setBit(songPacks, 16, player:hasKeyItem(xi.ki.SHEET_OF_ANCIENT_TUNES))        -- Griffons Never Die (254), Thunder of the March (180), Stargazing (182)
    songPacks = utils.mask.setBit(songPacks, 17, player:hasKeyItem(xi.ki.SHEET_OF_ANCIENT_BATTLE_TUNES)) -- Autumn Footfalls (251), Echoes of a Zephyr (253), The Cosmic Wheel (141)

    -- Next page
    songPacks = utils.mask.setBit(songPacks, 18, player:hasKeyItem(xi.ki.SHEET_OF_DESTINY_DESTROYER_TUNES))   -- The Destiny Destroyers (28)
    songPacks = utils.mask.setBit(songPacks, 19, player:hasKeyItem(xi.ki.SHEET_OF_CHARACTER_SELECTION_TUNES)) -- Hume Male (133), Hume Female (168), Elvaan Male (132), Elvaan Female (131), Tarutaru Male (167), Tarutaru Female (130), Mithra (166), Galka (165)
    songPacks = utils.mask.setBit(songPacks, 20, player:hasKeyItem(xi.ki.SHEET_OF_STARLIGHT_TUNES))           -- Jeuno - Starlight Celebration (239)
    songPacks = utils.mask.setBit(songPacks, 21, player:hasKeyItem(xi.ki.SHEET_OF_CHOCOBO_TUNES))             -- Dash de Chocobo (181), Circuit de Chocobo (176), Run Chocobo Run! (177), Choc-a-bye Baby (188)
    songPacks = utils.mask.setBit(songPacks, 22, player:hasKeyItem(xi.ki.SHEET_OF_NEAR_EAST_TUNES))           -- Bustle of the Capital (178), Jeweled Boughs (149), Bandits' Market (175), Illusions in the Mist (173)
    songPacks = utils.mask.setBit(songPacks, 23, player:hasKeyItem(xi.ki.SHEET_OF_DIVINE_TUNES))              -- Fighters of the Crystal (196)

    -- 0000 = all instruments shown
    -- 1111 = all instruments hidden
    local instrumentsAvailable = 0x0F

    local orchestrion  = player:findItem(xi.item.ORCHESTRION)
    local spinet       = player:findItem(xi.item.SPINET)
    local nanaaStatue1 = player:findItem(xi.item.NANAA_MIHGO_STATUE)
    local nanaaStatue2 = player:findItem(xi.item.NANAA_MIHGO_STATUE_II)

    local hasOrchestrion  = orchestrion and orchestrion:isInstalled()
    local hasSpinet       = spinet and spinet:isInstalled()
    local hasNanaaStatue1 = nanaaStatue1 and nanaaStatue1:isInstalled()
    local hasNanaaStatue2 = nanaaStatue2 and nanaaStatue2:isInstalled()

    instrumentsAvailable = utils.mask.setBit(instrumentsAvailable, 0, not hasOrchestrion)  -- Orchestrion
    instrumentsAvailable = utils.mask.setBit(instrumentsAvailable, 1, not hasSpinet)       -- Spinet
    instrumentsAvailable = utils.mask.setBit(instrumentsAvailable, 2, not hasNanaaStatue1) -- Nanaa Statue I
    instrumentsAvailable = utils.mask.setBit(instrumentsAvailable, 3, not hasNanaaStatue2) -- Nanaa Statue II

    -- Toggled-on GMs get access to all music
    if player:getVisibleGMLevel() > 0 then
        songPacks            = 0xFFFFFFFF
        instrumentsAvailable = 0x00
    end

    -- Determines whether the songs are shown as ??? in the menu or not
    local songMask = 0xFFFF

    player:startEvent(30034, 0, songMask, songPacks, instrumentsAvailable)
end

-- The options that comes through the event doesn't line up with the song request packet,
-- so link them using this table
-- TODO: There is some relationship between the instrument and the index, based around multiples of 16
-- The relationship (for Orchestrion) is: index = ((option - 2) / 16) + 1
-- One of the arguments from caps with the orchetron is -2
local optionToSongLookup =
{
    [1]   = 112, -- Selbina
    [2]   = 126, -- Mog House
    [3]   = 126, -- Mog House
    [4]   = 126, -- Mog House
    [17]  = 196, -- Fighters of the Crystal
    [18]  = 108, -- Vana'diel March
    [19]  = 69,  -- Distant Worlds (Nanaa Mihgo Version)
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
    [306] = 77,  -- Distant Worlds (Instrumental)
    [322] = 76,  -- Forever Today
    [338] = 83,  -- Unknown Item: Rhapsodies of Vana'diel
    [354] = 119, -- Awakening (The Shadow Lord Battle) (FFRK Ver.)
    [370] = 84,  -- Full Speed Ahead!
    [386] = 233, -- The Celestial Capital - Al'Taieu
    [402] = 110, -- The Grand Duchy of Jeuno
    [418] = 117, -- Ru'Lude Gardens
    [434] = 29,  -- Devils' Delight
    [450] = 254, -- Griffons Never Die
    [466] = 180, -- Thunder of the March
    [482] = 182, -- Stargazing
    [498] = 251, -- Autumn Footfalls

    -- Next Page
    [514] = 253, -- Echoes of a Zephyr
    [530] = 141, -- The Cosmic Wheel
    [546] = 28,  -- The Destiny Destroyers
    [562] = 133, -- Hume Male
    [578] = 168, -- Hume Female
    [594] = 132, -- Elvaan Male
    [610] = 131, -- Elvaan Female
    [626] = 167, -- Tarutaru Male
    [642] = 130, -- Tarutaru Female
    [558] = 166, -- Mithra
    [674] = 165, -- Galka
    [690] = 239, -- Jeuno - Starlight Celebration
    [706] = 181, -- Dash de Chocobo
    [722] = 176, -- Circuit de Chocobo
    [738] = 177, -- Run Chocobo Run!
    [754] = 188, -- Choc-a-bye Baby

    -- Next Page
    [770] = 178, -- Bustle of the Capital
    [786] = 149, -- Jeweled Boughs
    [802] = 175, -- Bandits' Market
    [818] = 173, -- Illusions in the Mist
    [834] = 196, -- Fighters of the Crystal
}

xi.symphonic_curator.onEventUpdate = function(player, csid, option, npc)
    player:changeMusic(6, optionToSongLookup[option])
end

xi.symphonic_curator.onEventFinish = function(player, csid, option, npc)
    if option == 0 then
        -- Reset
        player:changeMusic(6, player:getLocalVar('Symphonic_Curator_Music'))
    else
        -- Confirmed, set
        player:setLocalVar('Symphonic_Curator_Music', optionToSongLookup[option])
        player:changeMusic(6, optionToSongLookup[option])
    end
end
