-----------------------------------
-- Goblin Footprint NPCs
-----------------------------------
require('scripts/globals/quests')
require('scripts/globals/missions')
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.goblinfootprint = xi.goblinfootprint or {}

local gobCS = -- add the goblin cs to this table
{
    [xi.zone.LA_THEINE_PLATEAU]     = 126,
    [xi.zone.NORTH_GUSTABERG]       = 247,
    [xi.zone.SOUTH_GUSTABERG]       = 905,
    [xi.zone.MERIPHATAUD_MOUNTAINS] = 35,
    [xi.zone.ROMAEVE]               = 6,
    [xi.zone.CASTLE_ZVAHL_KEEP]     = 10,
    [xi.zone.BOSTAUNIEUX_OUBLIETTE] = 100,
    [xi.zone.MAZE_OF_SHAKHRAMI]     = 67,
    [xi.zone.GARLAIGE_CITADEL]      = 61,
}

local csReq = -- add checks to this table
{
    [xi.zone.LA_THEINE_PLATEAU] =
    {
        [1] = function(player)
            return player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.DARK_PUPPET)
        end,

        [2] = function(player)
            return player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.HITTING_THE_MARQUISATE)
        end,

        [3] = function(player)
            return player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.I_CAN_HEAR_A_RAINBOW)
        end,

        [4] = function(player)
            return player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_TIMELY_VISIT)
        end,

        [5] = function(player)
            return player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_TIMELY_VISIT)
        end,

        [6] = function(player)
            return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_MOTHERCRYSTALS)
        end,

        [7] = function(player)
            return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THREE_PATHS)
        end,

        [8] = function(player)
            return player:hasCompletedQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.WAKING_THE_BEAST)
        end,

        [9] = function(player)
            return player:hasCompletedQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.WAKING_THE_BEAST)
        end,

        [10] = function(player)
            return player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.CHOCOBO_ON_THE_LOOSE)
        end,

        [11] = function(player)
            return player:hasCompletedQuest(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.A_GOLDSTRUCK_GIGAS)
        end,

        [12] = function(player)
            return player:hasCompletedQuest(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.A_GOLDSTRUCK_GIGAS)
        end,

        [13] = function(player)
            return player:hasCompletedQuest(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.AN_OFFICER_AND_A_PIRATE)
        end,

        [14] = function(player)
            return player:hasCompletedQuest(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.TENUOUS_EXISTENCE)
        end,

        -- Not Implemented Below (ROV)
        [15] = function(player)
            return false
        end,

        [16] = function(player)
            return false
        end,

        [17] = function(player)
            return false
        end,

        [18] = function(player)
            return false
        end,

        [19] = function(player)
            return false
        end,

        [20] = function(player)
            return false
        end,

        [21] = function(player)
            return false
        end,

        [22] = function(player)
            return false
        end,

        [23] = function(player)
            return false
        end,

        [24] = function(player)
            return false
        end,

        [25] = function(player)
            return false
        end,

        [26] = function(player)
            return false
        end,
    },

    [xi.zone.NORTH_GUSTABERG] =
    {
        [1] = function(player)
            return player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.AS_THICK_AS_THIEVES)
        end,

        [2] = function(player)
            return player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_GUSTABERG_TOUR)
        end,

        [3] = function(player)
            -- RELIC: Apocalypse
            -- TODO: Table items and iterate over table for this check
            return player:hasItem(xi.item.APOCALYPSE) or
                player:hasItem(xi.item.APOCALYPSE_80) or
                player:hasItem(xi.item.APOCALYPSE_85) or
                player:hasItem(xi.item.APOCALYPSE_90) or
                player:hasItem(xi.item.APOCALYPSE_95) or
                player:hasItem(xi.item.APOCALYPSE_99) or
                player:hasItem(xi.item.APOCALYPSE_99_II) or
                player:hasItem(xi.item.APOCALYPSE_119) or
                player:hasItem(xi.item.APOCALYPSE_119_II) or
                player:hasItem(xi.item.APOCALYPSE_119_III)
        end,

        [4] = function(player)
            return player:hasCompletedQuest(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.AN_ULCEROUS_URAGNITE)
        end,

        [5] = function(player)
            return player:hasCompletedQuest(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.AN_ULCEROUS_URAGNITE)
        end,
    },

    [xi.zone.SOUTH_GUSTABERG] =
    {
        [1] = function(player)
            return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.A_TRANSIENT_DREAM)
        end,

        [2] = function(player)
            return player:hasCompletedQuest(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.A_BEAKED_BLUSTERER)
        end,

        [3] = function(player)
            return player:hasCompletedQuest(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.A_BEAKED_BLUSTERER)
        end,
    },

    [xi.zone.MERIPHATAUD_MOUNTAINS] =
    {
        [1] = function(player)
            return player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_HOLY_CREST)
        end,
    },

    [xi.zone.ROMAEVE] =
    {
        [1] = function(player)
            return player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.VAIN)
        end,

        [2] = function(player)
            return player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.MOON_READING)
        end,

        [3] = function(player)
            return player:hasCompletedQuest(xi.quest.log_id.ZILART, xi.quest.id.outlands.DIVINE_MIGHT)
        end,

        [4] = function(player)
            return player:hasCompletedMission(xi.mission.log_id.ASA, xi.mission.id.asa.FOUNTAIN_OF_TROUBLE)
        end,
    },

    [xi.zone.CASTLE_ZVAHL_KEEP] =
    {
        [1] = function(player)
            return player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.RECOLLECTIONS)
        end,
    },

    [xi.zone.BOSTAUNIEUX_OUBLIETTE] =
    {
        [1] = function(player)
            return player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_RUMOR)
        end,

        [2] = function(player)
            return player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_RUMOR)
        end,

        [3] = function(player)
            return player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TROUBLE_AT_THE_SLUICE)
        end,

        [4] = function(player)
            return player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_HOLY_CREST)
        end,

        [5] = function(player)
            return player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.SOULS_IN_SHADOW)
        end,

        [6] = function(player)
            return player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.SOULS_IN_SHADOW)
        end,

        [7] = function(player)
            return player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.SOULS_IN_SHADOW)
        end,
    },

    [xi.zone.MAZE_OF_SHAKHRAMI] =
    {
        [1] = function(player)
            return player:hasCompletedQuest(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.EQUIPPED_FOR_ALL_OCCASIONS)
        end,
    },

    [xi.zone.GARLAIGE_CITADEL] =
    {
        [1] = function(player)
            return player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ESCORT_FOR_HIRE)
        end,

        [2] = function(player)
            return player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.PEACE_FOR_THE_SPIRIT)
        end,
    },
}

local cutscene = -- add cutscenes to this table
{
    [xi.zone.LA_THEINE_PLATEAU] =
    {
        [1]  = { 122 },         -- Dark Puppet
        [2]  = { 119 },         -- Hitting the Marquisate
        [3]  = { 124 },         -- I Can Hear a Rainbow
        [4]  = { 0 },           -- A Timely Visit (pt.1)
        [5]  = { 1 },           -- A Timely Visit (pt.2)
        [6]  = { 201 },         -- The Mothercrystals
        [7]  = { 203 },         -- The Pursuit of Paradise
        [8]  = { 205 },         -- Waking the Beast (pt.1)
        [9]  = { 208 },         -- Waking the Beast (pt.2)
        [10] = { 209 },         -- Chocobo on the Loose!
        [11] = { 9 },           -- A Goldstruck Gigas (pt.1)
        [12] = { 10 },          -- A Goldstruck Gigas (pt.2)
        [13] = { 11 },          -- An Officer and a Pirate
        [14] = { 12 },          -- Tenuous Existence
        [15] = {},              -- QUEST NOT IMPLEMENTED (ROV)
        [16] = {},              -- QUEST NOT IMPLEMENTED (ROV)
        [17] = {},              -- QUEST NOT IMPLEMENTED (ROV)
        [18] = {},              -- QUEST NOT IMPLEMENTED (ROV)
        [19] = {},              -- QUEST NOT IMPLEMENTED (ROV)
        [20] = {},              -- QUEST NOT IMPLEMENTED (ROV)
        [21] = {},              -- QUEST NOT IMPLEMENTED (ROV)
        [22] = {},              -- QUEST NOT IMPLEMENTED (ROV)
        [23] = {},              -- QUEST NOT IMPLEMENTED (ROV)
        [24] = {},              -- QUEST NOT IMPLEMENTED (ROV)
        [25] = {},              -- QUEST NOT IMPLEMENTED (ROV)
        [26] = {},              -- QUEST NOT IMPLEMENTED (ROV)
    },
    [xi.zone.NORTH_GUSTABERG] =
    {
        [1] = { 200, 1092 },      -- As Thick as Thieves
        [2] = { 22 },             -- The Gustaberg Tour
        [3] = { 254 },            -- Apocalypse
        [4] = { 0 },              -- An Ulcerous Uragnite (pt.1)
        [5] = { 1 },              -- An Ulcerous Uragnite (pt.2)
    },
    [xi.zone.SOUTH_GUSTABERG] =
    {
        [1] = { 906 },            -- A Transient Dream
        [2] = { 0 },              -- A Beaked Blusterer (pt.1)
        [3] = { 1 },              -- A Beaked Blusterer (pt.2)
    },
    [xi.zone.MERIPHATAUD_MOUNTAINS] =
    {
        [1] = { 33 },              -- The Holy Crest
    },
    [xi.zone.ROMAEVE] =
    {
        [1] = { 2 },              -- Vain
        [2] = { 4 },              -- Moon Reading
        [3] = { 7, 917, 1408 },   -- Divine Might
        [4] = { 71 },             -- Fountain of Trouble
    },
    [xi.zone.CASTLE_ZVAHL_KEEP] =
    {
        [1] = { 8 },
    },
    [xi.zone.BOSTAUNIEUX_OUBLIETTE] =
    {
        [1] = { 13 },             -- The Rumor (pt. 1)
        [2] = { 12 },             -- The Rumor (pt. 2)
        [3] = { 17 },             -- Trouble at the Sluice
        [4] = { 6 },              -- The Holy Crest
        [5] = { 0 },              -- Souls in Shadows (pt. 1)
        [6] = { 1 },              -- Souls in Shadows (pt. 2)
        [7] = { 5 },              -- Souls in Shadows (pt. 3)
    },
    [xi.zone.MAZE_OF_SHAKHRAMI] =
    {
        [1] = { 66 }              -- Equipped for All Occasions
    },
    [xi.zone.GARLAIGE_CITADEL] =
    {
        [1] = { 60 },             -- Escort for Hire (Windurst)
        [2] = { 14 },             -- Peace for the Spirit
    },
}

function xi.goblinfootprint.rewatch(player, trigger)
    local zone = player:getZoneID()
    local ID = zones[zone]
    local options = 1

    for i, check in pairs(csReq[zone]) do
        if check(player) then
            options = bit.bor(options, bit.lshift(1, i))
            if trigger then
                player:messageSpecial(ID.text.ITEMS_ITEMS_LA_LA)
                return
            end
        end
    end

    if options > 1 then
        local arg = utils.MAX_UINT32 - 1
        player:startEvent(gobCS[zone], bit.bnot(options), arg, arg, arg)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function xi.goblinfootprint.startEvent(player, csid, option, npc)
    local zone = player:getZoneID()
    local ID = zones[zone]
    if csid == gobCS[zone] and cutscene[zone][option] ~= nil then
        player:startEvent(unpack(cutscene[zone][option]))
        return
    else
        player:messageSpecial(ID.text.GOBLIN_SLIPPED_AWAY)
    end
end
