-----------------------------------
-- Cavernous Maw global functions
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/settings")
require("scripts/globals/teleports")
require("scripts/globals/titles")
require("scripts/globals/zone")
-----------------------------------

tpz.maws = tpz.maws or {}

local ZN = tpz.zone
local MAW = tpz.teleport.type.PAST_MAW

local pastMaws =
{ --[ZONE ID]                    = {Bit Slot in Array, Cutscenes{new to WoTg or add new, mission, warp}, Destination {Coordinates}}
    [ZN.BATALLIA_DOWNS]          = {bit = 0, cs = {new = 500, msn = 501, warp = 910}, dest = { -51.486,   0.371,  436.972, 128,  84}},
    [ZN.ROLANBERRY_FIELDS]       = {bit = 1, cs = {new = 500, msn = 501, warp = 904}, dest = {-196.500,   7.999,  361.192, 225,  91}},
    [ZN.SAUROMUGUE_CHAMPAIGN]    = {bit = 2, cs = {new = 500, msn = 501, warp = 904}, dest = { 366.858,   8.545, -228.861,  95,  98}},
    [ZN.JUGNER_FOREST]           = {bit = 3, cs = {add = nil, msn = nil, warp = 905}, dest = {-116.093,  -8.005, -520.041,   0,  82}},
    [ZN.PASHHOW_MARSHLANDS]      = {bit = 4, cs = {add = nil, msn = nil, warp = 905}, dest = { 415.945,  24.659,   25.611, 101,  90}},
    [ZN.MERIPHATAUD_MOUNTAINS]   = {bit = 5, cs = {add = nil, msn = nil, warp = 905}, dest = { 595.000, -32.000,  279.300,  93,  97}},
    [ZN.EAST_RONFAURE]           = {bit = 6, cs = {add = nil, msn = nil, warp = 904}, dest = { 322.057, -60.059,  503.712,  64,  81}},
    [ZN.NORTH_GUSTABERG]         = {bit = 7, cs = {add = nil, msn = nil, warp = 903}, dest = { 469.697,  -0.050,  478.949,   0,  88}},
    [ZN.WEST_SARUTABARUTA]       = {bit = 8, cs = {add = nil, msn = nil, warp = 904}, dest = {   2.628,  -0.150, -166.562,  32,  95}},
    [ZN.BATALLIA_DOWNS_S]        = {bit = 0, cs = {add = 100, msn = 701, warp = 101}, dest = { -51.486,   0.371,  436.972, 128, 105}},
    [ZN.ROLANBERRY_FIELDS_S]     = {bit = 1, cs = {add = 101, msn = 701, warp = 102}, dest = {-196.500,   7.999,  361.192, 225, 110}},
    [ZN.SAUROMUGUE_CHAMPAIGN_S]  = {bit = 2, cs = {add = 101, msn = 701, warp = 102}, dest = { 366.858,   8.545, -228.861,  95, 120}},
    [ZN.JUGNER_FOREST_S]         = {bit = 3, cs = {add = 101, msn = nil, warp = 102}, dest = {-116.093,  -8.005, -520.041,   0, 104}},
    [ZN.PASHHOW_MARSHLANDS_S]    = {bit = 4, cs = {add = 100, msn = nil, warp = 101}, dest = { 415.945,  24.659,   25.611, 101, 109}},
    [ZN.MERIPHATAUD_MOUNTAINS_S] = {bit = 5, cs = {add = 102, msn = nil, warp = 103}, dest = { 595.000, -32.000,  279.300,  93, 119}},
    [ZN.EAST_RONFAURE_S]         = {bit = 6, cs = {add = 100, msn = nil, warp = 101}, dest = { 322.057, -60.059,  503.712,  64, 101}},
    [ZN.NORTH_GUSTABERG_S]       = {bit = 7, cs = {add = 100, msn = nil, warp = 101}, dest = { 469.697,  -0.050,  478.949,   0, 106}},
    [ZN.WEST_SARUTABARUTA_S]     = {bit = 8, cs = {add = 100, msn = nil, warp = 101}, dest = {   2.628,  -0.150, -166.562,  32, 115}},
}

local function meetsMission2Reqs(player)

    if not player:getCurrentMission(WOTG) == tpz.mission.id.wotg.BACK_TO_THE_BEGINNING then
        return false
    end

    local Q  = tpz.quest.id.crystalWar
    local Q1 = player:getQuestStatus(CRYSTAL_WAR, Q.CLAWS_OF_THE_GRIFFON) == QUEST_COMPLETED
    local Q2 = player:getQuestStatus(CRYSTAL_WAR, Q.THE_TIGRESS_STRIKES)  == QUEST_COMPLETED
    local Q3 = player:getQuestStatus(CRYSTAL_WAR, Q.FIRES_OF_DISCONTENT)  == QUEST_COMPLETED

    return Q1 or Q2 or Q3

end

tpz.maws.onTrigger = function(player, npc)
    local ID = zones[player:getZoneID()]

    if ENABLE_WOTG == 0 then
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
        return
    end

    local maw = pastMaws[player:getZoneID()]
    local hasMaw = player:hasTeleport(MAW, maw.bit)
    local event = nil
    local event_params = nil

    if maw.cs.msn and meetsMission2Reqs(player) then
        event = maw.cs.msn
    elseif hasMaw then
        event = maw.cs.warp
    else
        local hasFeather = player:hasKeyItem(tpz.ki.PURE_WHITE_FEATHER)
        if maw.cs.new and not hasFeather then
            event = maw.cs.new
            event_params = {maw.bit}
        elseif maw.cs.add then
            event = maw.cs.add
        end
    end

    if event then
        if event_params then
            player:startEvent(event, unpack(event_params))
        else
            player:startEvent(event)
        end
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end

end

tpz.maws.onEventFinish = function(player, csid, option)

    local maw = pastMaws[player:getZoneID()]

    local goToMaw = function()
        player:setPos(unpack(maw.dest))
    end

    local addMaw = function()
        if not player:hasTeleport(MAW, maw.bit) then
            player:addTeleport(MAW, maw.bit)
        end
        goToMaw()
    end

    if csid == maw.cs.warp and option == 1 then
        goToMaw() -- Known to have maw, no need to check
    elseif maw.cs.add and csid == maw.cs.add and option == 1 then
        addMaw()
    elseif maw.cs.msn and csid == maw.cs.msn then
        player:completeMission(WOTG, tpz.mission.id.wotg.BACK_TO_THE_BEGINNING)
        player:addMission(WOTG, tpz.mission.id.wotg.CAIT_SITH)
        player:addTitle(tpz.title.CAIT_SITHS_ASSISTANT)
        addMaw() -- May not have yet, check
    elseif maw.cs.new and csid == maw.cs.new then
        local ID = zones[player:getZoneID()]
        player:completeMission(WOTG, tpz.mission.id.wotg.CAVERNOUS_MAWS)
        player:addMission(WOTG, tpz.mission.id.wotg.BACK_TO_THE_BEGINNING)
        player:addKeyItem(tpz.ki.PURE_WHITE_FEATHER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.PURE_WHITE_FEATHER)
        local x = math.random(1, 3)
        if x == 1 then
            maw = pastMaws[ZN.BATALLIA_DOWNS]
        elseif x == 2 then
            maw = pastMaws[ZN.ROLANBERRY_FIELDS]
        else
            maw = pastMaws[ZN.SAUROMUGUE_CHAMPAIGN]
        end
        addMaw()
    end

end
