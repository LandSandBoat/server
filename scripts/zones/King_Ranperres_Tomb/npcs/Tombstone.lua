-----------------------------------
-- Area: King Ranperre's Tomb
--  NPC: Tombstone
-- Involved in Quest: Grave Concerns
-- !pos 1 0.1 -101 190
-----------------------------------
local ID = require("scripts/zones/King_Ranperres_Tomb/IDs")
require("scripts/globals/items")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.GRAVE_CONCERNS) == QUEST_ACCEPTED and
        npcUtil.tradeHas(trade, xi.items.SKIN_OF_WELL_WATER) -- Well Water
    then
        player:startEvent(3)
    end
end

entity.onTrigger = function(player, npc)
    local currentMission = player:getCurrentMission(SANDORIA)
    local missionStatus = player:getMissionStatus(player:getNation())
    local X = npc:getXPos()
    local Z = npc:getZPos()

    if X >= -1 and X <= 1 and Z >= -106 and Z <= -102 then
        player:startEvent(2)
    elseif currentMission == xi.mission.id.sandoria.RANPERRE_S_FINAL_REST and missionStatus == 3 and not player:hasKeyItem(xi.ki.ANCIENT_SANDORIAN_BOOK) then
        player:startEvent(8)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if
        csid == 2 and
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.GRAVE_CONCERNS) == QUEST_ACCEPTED and
        not player:hasItem(xi.items.TOMB_GUARDS_WATERSKIN) and
        not player:hasItem(xi.items.SKIN_OF_WELL_WATER) and
        npcUtil.giveItem(player, xi.items.TOMB_GUARDS_WATERSKIN) -- Tomb Waterskin
    then
        -- no further action needed
    elseif csid == 3 and npcUtil.giveItem(player, xi.items.TOMB_GUARDS_WATERSKIN) then
        player:confirmTrade()
        player:setCharVar("OfferingWaterOK", 1)
    elseif csid == 8 then
        npcUtil.giveKeyItem(player, xi.ki.ANCIENT_SANDORIAN_BOOK)
    end
end

return entity
