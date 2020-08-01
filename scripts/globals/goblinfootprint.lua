-----------------------------------
-- Goblin Footprint NPCs
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/missions")
require("scripts/globals/zone")

tpz = tpz or {}
tpz.goblinfootprint = tpz.goblinfootprint or {}

local gobCS = -- add the goblin cs to this table
{
    [tpz.zone.LA_THEINE_PLATEAU]     = 126,
    [tpz.zone.NORTH_GUSTABERG]       = 247,
    [tpz.zone.SOUTH_GUSTABERG]       = 905,
    [tpz.zone.MERIPHATAUD_MOUNTAINS] = 35,
    [tpz.zone.ROMAEVE]               = 6,
    [tpz.zone.CASTLE_ZVAHL_KEEP]     = 10,
    [tpz.zone.BOSTAUNIEUX_OUBLIETTE] = 100,
    [tpz.zone.MAZE_OF_SHAKHRAMI]     = 67,
    [tpz.zone.GARLAIGE_CITADEL]      = 61,
}

local csReq = -- add checks to this table
{
    [tpz.zone.LA_THEINE_PLATEAU] =
    {
        [1] = function(player) return (player:hasCompletedQuest(BASTOK, tpz.quest.id.bastok.DARK_PUPPET)) end,
        [2] = function(player) return (player:hasCompletedQuest(WINDURST, tpz.quest.id.windurst.HITTING_THE_MARQUISATE)) end,
        [3] = function(player) return (player:hasCompletedQuest(WINDURST, tpz.quest.id.windurst.I_CAN_HEAR_A_RAINBOW)) end,
        [4] = function(player) return (player:hasCompletedQuest(SANDORIA, tpz.quest.id.sandoria.A_TIMELY_VISIT)) end,
        [5] = function(player) return (player:hasCompletedQuest(SANDORIA, tpz.quest.id.sandoria.A_TIMELY_VISIT)) end,
        [6] = function(player) return (player:hasCompletedMission(COP, tpz.mission.id.cop.THE_MOTHERCRYSTALS)) end,
        [7] = function(player) return (player:hasCompletedMission(COP, tpz.mission.id.cop.THREE_PATHS)) end,
        [8] = function(player) return (player:hasCompletedQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.WAKING_THE_BEAST)) end,
        [9] = function(player) return (player:hasCompletedQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.WAKING_THE_BEAST)) end,
        [10] = function(player) return (player:hasCompletedQuest(JEUNO, tpz.quest.id.jeuno.CHOCOBO_ON_THE_LOOSE)) end,
        [11] = function(player) return (player:hasCompletedQuest(ABYSSEA, tpz.quest.id.abyssea.A_GOLDSTRUCK_GIGAS)) end,
        [12] = function(player) return (player:hasCompletedQuest(ABYSSEA, tpz.quest.id.abyssea.A_GOLDSTRUCK_GIGAS)) end,
        [13] = function(player) return (player:hasCompletedQuest(ABYSSEA, tpz.quest.id.abyssea.AN_OFFICER_AND_A_PIRATE)) end,
        [14] = function(player) return (player:hasCompletedQuest(ABYSSEA, tpz.quest.id.abyssea.TENUOUS_EXISTENCE)) end,
        [15] = function(player) return false end,               -- QUEST NOT IMPLEMENTED (ROV)
        [16] = function(player) return false end,               -- QUEST NOT IMPLEMENTED (ROV)
        [17] = function(player) return false end,               -- QUEST NOT IMPLEMENTED (ROV)
        [18] = function(player) return false end,               -- QUEST NOT IMPLEMENTED (ROV)
        [19] = function(player) return false end,               -- QUEST NOT IMPLEMENTED (ROV)
        [20] = function(player) return false end,               -- QUEST NOT IMPLEMENTED (ROV)
        [21] = function(player) return false end,               -- QUEST NOT IMPLEMENTED (ROV)
        [22] = function(player) return false end,               -- QUEST NOT IMPLEMENTED (ROV)
        [23] = function(player) return false end,               -- QUEST NOT IMPLEMENTED (ROV)
        [24] = function(player) return false end,               -- QUEST NOT IMPLEMENTED (ROV)
        [25] = function(player) return false end,               -- QUEST NOT IMPLEMENTED (ROV)
        [26] = function(player) return false end,               -- QUEST NOT IMPLEMENTED (ROV)
    },
    [tpz.zone.NORTH_GUSTABERG] =
    {
        [1] = function(player) return (player:hasCompletedQuest(WINDURST, tpz.quest.id.windurst.AS_THICK_AS_THIEVES)) end,
        [2] = function(player) return (player:hasCompletedQuest(BASTOK, tpz.quest.id.bastok.THE_GUSTABERG_TOUR)) end,
        [3] = function(player) return (player:hasItem(18306) or player:hasItem(18307) or player:hasItem(18644) or
        player:hasItem(18658) or player:hasItem(18672) or player:hasItem(19753) or player:hasItem(19846) or
        player:hasItem(20880) or player:hasItem(20881) or player:hasItem(21808)) end, -- RELIC: Apocalypse
        [4] = function(player) return (player:hasCompletedQuest(ABYSSEA, tpz.quest.id.abyssea.AN_ULCEROUS_URAGNITE)) end,
        [5] = function(player) return (player:hasCompletedQuest(ABYSSEA, tpz.quest.id.abyssea.AN_ULCEROUS_URAGNITE)) end,
    },
    [tpz.zone.SOUTH_GUSTABERG] =
    {
        [1] = function(player) return (player:hasCompletedMission(COP, tpz.mission.id.cop.A_TRANSIENT_DREAM)) end,
        [2] = function(player) return (player:hasCompletedQuest(ABYSSEA, tpz.quest.id.abyssea.A_BEAKED_BLUSTERER)) end,
        [3] = function(player) return (player:hasCompletedQuest(ABYSSEA, tpz.quest.id.abyssea.A_BEAKED_BLUSTERER)) end,
    },
    [tpz.zone.MERIPHATAUD_MOUNTAINS] =
    {
        [1] = function(player) return (player:hasCompletedQuest(SANDORIA, tpz.quest.id.sandoria.THE_HOLY_CREST)) end,
    },
    [tpz.zone.ROMAEVE] =
    {
        [1] = function(player) return (player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.VAIN)) end,
        [2] = function(player) return (player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.MOON_READING)) end,
        [3] = function(player) return (player:hasCompletedQuest(ZILART, tpz.quest.id.outlands.DIVINE_MIGHT)) end,
        [4] = function(player) return (player:hasCompletedMission(ASA, tpz.mission.id.asa.FOUNTAIN_OF_TROUBLE)) end,
    },
    [tpz.zone.CASTLE_ZVAHL_KEEP] =
    {
        [1] = function(player) return (player:hasCompletedQuest(WINDURST, tpz.quest.id.windurst.RECOLLECTIONS)) end,
    },
    [tpz.zone.BOSTAUNIEUX_OUBLIETTE] =
    {
        [1] = function(player) return (player:hasCompletedQuest(SANDORIA, tpz.quest.id.sandoria.THE_RUMOR)) end,
        [2] = function(player) return (player:hasCompletedQuest(SANDORIA, tpz.quest.id.sandoria.THE_RUMOR)) end,
        [3] = function(player) return (player:hasCompletedQuest(SANDORIA, tpz.quest.id.sandoria.TROUBLE_AT_THE_SLUICE)) end,
        [4] = function(player) return (player:hasCompletedQuest(SANDORIA, tpz.quest.id.sandoria.THE_HOLY_CREST)) end,
        [5] = function(player) return (player:hasCompletedQuest(SANDORIA, tpz.quest.id.sandoria.SOULS_IN_SHADOW)) end,
        [6] = function(player) return (player:hasCompletedQuest(SANDORIA, tpz.quest.id.sandoria.SOULS_IN_SHADOW)) end,
        [7] = function(player) return (player:hasCompletedQuest(SANDORIA, tpz.quest.id.sandoria.SOULS_IN_SHADOW)) end,
    },
    [tpz.zone.MAZE_OF_SHAKHRAMI] =
    {
        [1] = function(player) return (player:hasCompletedQuest(AHT_URHGAN, tpz.quest.id.ahtUrhgan.EQUIPPED_FOR_ALL_OCCASIONS)) end,
    },
    [tpz.zone.GARLAIGE_CITADEL] =
    {
        [1] = function(player) return (player:hasCompletedQuest(WINDURST, tpz.quest.id.windurst.ESCORT_FOR_HIRE)) end,
        [2] = function(player) return (player:hasCompletedQuest(SANDORIA, tpz.quest.id.sandoria.PEACE_FOR_THE_SPIRIT)) end,
    },
}

local cutscene = -- add cutscenes to this table
{
    [tpz.zone.LA_THEINE_PLATEAU] =
    {
        [1] = {122},            -- Dark Puppet
        [2] = {119},            -- Hitting the Marquisate
        [3] = {124},            -- I Can Hear a Rainbow
        [4] = {0},              -- A Timely Visit (pt.1)
        [5] = {1},              -- A Timely Visit (pt.2)
        [6] = {201},            -- The Mothercrystals
        [7] = {203},            -- The Pursuit of Paradise
        [8] = {205},            -- Waking the Beast (pt.1)
        [9] = {208},            -- Waking the Beast (pt.2)
        [10] = {209},           -- Chocobo on the Loose!
        [11] = {9},             -- A Goldstruck Gigas (pt.1)
        [12] = {10},            -- A Goldstruck Gigas (pt.2)
        [13] = {11},            -- An Officer and a Pirate
        [14] = {12},            -- Tenuous Existence
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
    [tpz.zone.NORTH_GUSTABERG] =
    {
        [1] = {200, 1092},      -- As Thick as Thieves
        [2] = {22},             -- The Gustaberg Tour
        [3] = {254},            -- Apocalypse
        [4] = {0},              -- An Ulcerous Uragnite (pt.1)
        [5] = {1},              -- An Ulcerous Uragnite (pt.2)
    },
    [tpz.zone.SOUTH_GUSTABERG] =
    {
        [1] = {906},            -- A Transient Dream
        [2] = {0},              -- A Beaked Blusterer (pt.1)
        [3] = {1},              -- A Beaked Blusterer (pt.2)
    },
    [tpz.zone.MERIPHATAUD_MOUNTAINS] =
    {
        [1] = {33},              -- The Holy Crest
    },
    [tpz.zone.ROMAEVE] =
    {
        [1] = {2},              -- Vain
        [2] = {4},              -- Moon Reading
        [3] = {7, 917, 1408},   -- Divine Might
        [4] = {71},             -- Fountain of Trouble
    },
    [tpz.zone.CASTLE_ZVAHL_KEEP] =
    {
        [1] = {8},
    },
    [tpz.zone.BOSTAUNIEUX_OUBLIETTE] =
    {
        [1] = {13},             -- The Rumor (pt. 1)
        [2] = {12},             -- The Rumor (pt. 2)
        [3] = {17},             -- Trouble at the Sluice
        [4] = {6},              -- The Holy Crest
        [5] = {0},              -- Souls in Shadows (pt. 1)
        [6] = {1},              -- Souls in Shadows (pt. 2)
        [7] = {5},              -- Souls in Shadows (pt. 3)
    },
    [tpz.zone.MAZE_OF_SHAKHRAMI] =
    {
        [1] = {66}              -- Equipped for All Occasions
    },
    [tpz.zone.GARLAIGE_CITADEL] =
    {
        [1] = {60},             -- Escort for Hire (Windurst)
        [2] = {14},             -- Peace for the Spirit
    },
}

function tpz.goblinfootprint.rewatch(player, trigger)
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
        player:startEvent(gobCS[zone], bit.bnot(options), -2, -2, -2)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function tpz.goblinfootprint.startEvent(player, csid, option)
    local zone = player:getZoneID()
    local ID = zones[zone]
    if csid == gobCS[zone] and cutscene[zone][option] ~= nil then
        player:startEvent(unpack(cutscene[zone][option]))
        return
    else
        player:messageSpecial(ID.text.GOBLIN_SLIPPED_AWAY)
    end
end
