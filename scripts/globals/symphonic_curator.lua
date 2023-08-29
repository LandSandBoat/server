-----------------------------------
-- Symphonic Curator (Moghouse)
-----------------------------------
require('scripts/globals/utils')
-----------------------------------
-- NOTE: You can force the Symphonic Curator to appear
--       by using !cs 30034 and exiting the menu
-----------------------------------

-- See documentation/songdata.txt for extracted table of data.

xi = xi or {}
xi.symphonic_curator = xi.symphonic_curator or {}

xi.symphonic_curator.onTrigger = function(player, npc)
    -- The first time you click, you'll always already be listening to Mog House
    if player:getLocalVar('Symphonic_Curator_Music') == 0 then
        player:setLocalVar('Symphonic_Curator_Music', 126)
    end

    -- All music type 6 (Moghouse)
    local songPacks = 0

    -- Default: Mog House (126), Vana'diel March (108)
    songPacks = utils.mask.setBit(songPacks, 0, 1)

    songPacks = utils.mask.setBit(songPacks, 1, player:hasKeyItem(xi.ki.SHEET_OF_SAN_DORIAN_TUNES))   -- The Kingdom of San d'Oria (107), Chateau d'Oraguille (156), Ronfaure (109)
    songPacks = utils.mask.setBit(songPacks, 2, player:hasKeyItem(xi.ki.SHEET_OF_BASTOKAN_TUNES))     -- The Republic of Bastok (152), Metalworks (154), Gustaberg (116)
    songPacks = utils.mask.setBit(songPacks, 3, player:hasKeyItem(xi.ki.SHEET_OF_WINDURSTIAN_TUNES))  -- The Federation of Windurst (151), Heavens Tower (162), Sarutabaruta (113)
    songPacks = utils.mask.setBit(songPacks, 4, player:hasKeyItem(xi.ki.SHEET_OF_E_ADOULINIAN_TUNES)) -- The Sacred City of Adoulin (63)
    songPacks = utils.mask.setBit(songPacks, 5, player:hasKeyItem(xi.ki.SHEET_OF_W_ADOULINIAN_TUNES)) -- The Pioneers (59)
    songPacks = utils.mask.setBit(songPacks, 6, player:hasKeyItem(xi.ki.SHEET_OF_ZILART_TUNES))       -- Kazham (135), The Sanctuary of Zi'Tah (190), Tu'Lia (210)
    -- Next page
    songPacks = utils.mask.setBit(songPacks, 7, player:hasKeyItem(xi.ki.SHEET_OF_CONFLICT_TUNES))     -- Awakening (119), Belief (195), A Realm of Emptiness (137)
    songPacks = utils.mask.setBit(songPacks, 8, player:hasKeyItem(xi.ki.SHEET_OF_PROMATHIA_TUNES))    -- Distant Worlds (900)
    songPacks = utils.mask.setBit(songPacks, 9, player:hasKeyItem(xi.ki.SHEET_OF_ADOULINIAN_TUNES))   -- Forever Today (76)
    songPacks = utils.mask.setBit(songPacks, 10, false)                                                -- Unknown Item: Rhapsodies of Vana'diel (83)
    songPacks = utils.mask.setBit(songPacks, 11, player:hasKeyItem(xi.ki.SHEET_OF_SHADOW_LORD_TUNES)) -- Awakening (The Shadow Lord Battle) (FFRK Ver.) (119)
    songPacks = utils.mask.setBit(songPacks, 12, player:hasKeyItem(xi.ki.SHEET_OF_MAPITOTO_TUNES))    -- Full Speed Ahead! (84)
    songPacks = utils.mask.setBit(songPacks, 13, player:hasKeyItem(xi.ki.SHEET_OF_ALTAIEU_TUNES))     -- The Celestial Capital - Al'Taieu (233)
    songPacks = utils.mask.setBit(songPacks, 14, player:hasKeyItem(xi.ki.SHEET_OF_JEUNO_TUNES))       -- The Grand Duchy of Jeuno (110), Ru'Lude Gardens (117)
    songPacks = utils.mask.setBit(songPacks, 15, player:hasKeyItem(xi.ki.SHEET_OF_HARVEST_TUNES))     -- Devils' Delight (29)

    -- 0000 = all instruments shown
    -- 1111 = all instruments hidden
    local instrumentsAvailable = 15

    local orchestrion  = player:findItem(426)
    local spinet       = player:findItem(3677)
    local nanaaStatue1 = player:findItem(286)
    local nanaaStatue2 = player:findItem(287)

    local hasOrchestrion  = orchestrion and orchestrion:isInstalled()
    local hasSpinet       = spinet and spinet:isInstalled()
    local hasNanaaStatue1 = nanaaStatue1 and nanaaStatue1:isInstalled()
    local hasNanaaStatue2 = nanaaStatue2 and nanaaStatue2:isInstalled()

    instrumentsAvailable = utils.mask.setBit(instrumentsAvailable, 0, not hasOrchestrion)  -- Orchestrion
    instrumentsAvailable = utils.mask.setBit(instrumentsAvailable, 1, not hasSpinet)       -- Spinet
    instrumentsAvailable = utils.mask.setBit(instrumentsAvailable, 2, not hasNanaaStatue1) -- Nanaa Statue I
    instrumentsAvailable = utils.mask.setBit(instrumentsAvailable, 3, not hasNanaaStatue2) -- Nanaa Statue II

    -- GMs get access to all music
    if player:getGMLevel() > 0 then
        songPacks = 65535
        instrumentsAvailable = 0
    end

    player:startEvent(30034, 0, 4095, songPacks, instrumentsAvailable)
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
